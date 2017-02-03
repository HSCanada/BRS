﻿

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BRS_ItemBaseHistory_load_proc] 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_ItemBaseHistory_load_proc
**	Desc: Load ItemBaseHistory into a normalized format
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@bDebug
**
**	Auth: tmc
**	Date: 05 Oct 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
-- 14 Oct 16	tmc		Added Current Base Update logic
-- 20 Nov 16	tmc		Swap out JDE direct extract in place of broken NEO extract
**    
*******************************************************************************/
BEGIN

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: BRS_ItemBaseHistory_load_proc'
	Print 'Desc: Load ItemBaseHistory into a normalized format'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

SET NOCOUNT ON;

if (@bDebug <> 0)
	SET NOCOUNT OFF;

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran



------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

--
-- 20 Nov 16	tmc		Swap out JDE direct extract in place of broken NEO extract

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add Current Base and Supplier Cost to STAGE_BRS_ItemBaseHistory ...'

	INSERT INTO STAGE_BRS_ItemBaseHistory (
		Item,
		CalMonth,
		FamilySetLeader,
		Supplier,
		Currency,
		SupplierCost,
		CorporatePrice,
		SellPrcBrk2,
		SellQtyBrk2,
		SellPrcBrk3,
		SellQtyBrk3
	)

	SELECT 
		i.Item,																			-- Item
		0																				AS CalMonth,
		MIN(FamilySetLeader)															as FamilySetLeader, 
		MIN(Supplier)																	as Supplier, 
		MIN(CASE WHEN Currency = 'CAN' THEN 'CAD' ELSE Currency END)					as Currency, 
		MIN(SupplierCost)																as SupplierCost, 
		SUM(CASE WHEN (ROW_ID - ROW_ID_ITEM + 1) = 1 THEN CorporatePrice ELSE 0 END)	AS CorporatePrice,
		SUM(CASE WHEN (ROW_ID - ROW_ID_ITEM + 1) = 2 THEN CorporatePrice ELSE 0 END)	AS SellPrcBrk2,
		SUM(CASE WHEN (ROW_ID - ROW_ID_ITEM + 1) = 2 THEN SellQtyBreak ELSE 0 END)		AS SellQtyBrk2,
		SUM(CASE WHEN (ROW_ID - ROW_ID_ITEM + 1) = 3 THEN CorporatePrice ELSE 0 END)	AS SellPrcBrk3,
		SUM(CASE WHEN (ROW_ID - ROW_ID_ITEM + 1) = 3 THEN SellQtyBreak ELSE 0 END)		AS SellQtyBrk3
	 
	FROM         
		STAGE_BRS_ItemSellPrice i
		INNER JOIN (SELECT Item, MIN(ROW_ID) AS ROW_ID_BR FROM STAGE_BRS_ItemSellPrice GROUP BY Item, SellQtyBreak ) as subq_br
			ON i.ROW_ID = subq_br.ROW_ID_BR

		INNER JOIN (SELECT Item, MIN(ROW_ID) AS ROW_ID_ITEM FROM STAGE_BRS_ItemSellPrice GROUP BY Item ) as subq_item
			ON i.Item = subq_item.Item

		INNER JOIN (
			SELECT     ic.Item, FamilySetLeader, Supplier, Currency, SupplierCost, CostQtyBreak 
			FROM         
				STAGE_BRS_ItemSupplierCost ic
				
				INNER JOIN (SELECT Item, MIN(ROW_ID) AS ROW_ID_BR FROM STAGE_BRS_ItemSupplierCost GROUP BY Item) as ic_subq_br
				ON ic.ROW_ID = ic_subq_br.ROW_ID_BR
		) as subq_cost
			ON i.Item = subq_cost.Item

	WHERE
--		i.Item = '6008159' AND
		1=1
	GROUP BY 
		i.Item

	Set @nErrorCode = @@Error
End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new FX ...'

	INSERT INTO BRS_Currency (
		Currency
	)
	SELECT     
		Distinct c.Currency
	FROM         
		STAGE_BRS_ItemBaseHistory AS c 

	WHERE 
		NOT EXISTS (SELECT * FROM BRS_Currency WHERE Currency=c.Currency)
	
	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new FX History ...'

	INSERT INTO BRS_CurrencyHistory (
		Currency,
		FiscalMonth,
		FX_per_USD_bal_rt,
		FX_per_USD_pnl_rt,
		FX_per_USD_mrk_rt
	)
	SELECT     
		c.Currency, 
		f.FiscalMonth, 
		-1 AS FX_per_USD_bal_rt, 
		-1 AS FX_per_USD_pnl_rt, 
		-1 FX_per_USD_mrk_rt
	FROM         
		BRS_Currency AS c 
		CROSS JOIN BRS_FiscalMonth AS f

	WHERE 
		NOT EXISTS (SELECT * FROM BRS_CurrencyHistory WHERE Currency=c.Currency AND FiscalMonth = f.FiscalMonth)
	
	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Supplier (ItemFull) ...'

		INSERT INTO BRS_ItemSupplier
							  (Supplier)
		SELECT DISTINCT ISNULL(t.Supplier,'') AS dt
		FROM         STAGE_BRS_ItemBaseHistory AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          BRS_ItemSupplier AS BRS_ItemCategory_1
									WHERE       Supplier = ISNULL(t.Supplier,'') ))
	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Pricing to BRS_ItemBaseHistoryDAT...'

	INSERT INTO BRS_ItemBaseHistoryDAT (
		Supplier, 
		Currency, 
		SupplierCost, 
		CorporatePrice, 
		SellPrcBrk2, 
		SellPrcBrk3, 
		SellQtyBrk2, 
		SellQtyBrk3
	)
	SELECT     
		Supplier, 
		Currency, 
		SupplierCost, 
		CorporatePrice, 
		SellPrcBrk2, 
		SellPrcBrk3, 
		SellQtyBrk2, 
		SellQtyBrk3
	FROM         
		STAGE_BRS_ItemBaseHistory AS s 


	WHERE
		NOT EXISTS (
			SELECT 
				* 
			FROM 
				BRS_ItemBaseHistoryDAT d 
			WHERE 
				s.Supplier = d.Supplier AND 
				s.Currency = d.Currency AND 
				s.SupplierCost = d.SupplierCost AND 
				s.CorporatePrice = d.CorporatePrice AND 
				s.SellPrcBrk2 = d.SellPrcBrk2 AND 
				s.SellPrcBrk3 = d.SellPrcBrk3 AND 
				s.SellQtyBrk2 = d.SellQtyBrk2 AND 
				s.SellQtyBrk3 = d.SellQtyBrk3 
		)

	GROUP BY 
		CorporatePrice, 
		SupplierCost, 
		SellPrcBrk2, 
		SellPrcBrk3, 
		Supplier, 
		Currency, 
		SellQtyBrk2, 
		SellQtyBrk3


	Set @nErrorCode = @@Error
End

--
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'UPDATE BRS_ItemBaseHistoryLNK with changes ...'

	UPDATE 
		BRS_ItemBaseHistoryLNK 
	SET 
		FamilySetLeaderID	= ifs.ID,
		PriceID				= d.PriceID
/*
	SELECT     
		s.CalMonth, 
		i.ID					AS ItemID, 

		ilnk.FamilySetLeaderID	AS CUR_FamilySetLeaderID,
		ilnk.PriceID			AS CUR_PriceID,

		ifs.ID					AS NEW_FamilySetLeaderID,
		d.PriceID				AS NEW_PriceID
*/

	FROM         
		STAGE_BRS_ItemBaseHistory AS s 

		INNER JOIN BRS_ItemBaseHistoryDAT AS d 
		ON s.Supplier = d.Supplier AND 
			s.Currency = d.Currency AND 
			s.SupplierCost = d.SupplierCost AND 
			s.CorporatePrice = d.CorporatePrice AND 
			s.SellPrcBrk2 = d.SellPrcBrk2 AND 
			s.SellPrcBrk3 = d.SellPrcBrk3 AND 
			s.SellQtyBrk2 = d.SellQtyBrk2 AND 
			s.SellQtyBrk3 = d.SellQtyBrk3 

		INNER JOIN BRS_Item AS i 
		ON s.Item = i.Item

		INNER JOIN BRS_Item AS ifs 
		ON s.FamilySetLeader = ifs.Item

		INNER JOIN BRS_ItemBaseHistoryLNK AS ilnk 
		ON ilnk.CalMonth = s.CalMonth AND 
			ilnk.ItemID = i.ID

	WHERE
		-- only update current for performance reasons
		(s.CalMonth between 0 and 0) AND
		( 
			(ilnk.FamilySetLeaderID <> ifs.ID) OR 
			(ilnk.PriceID <> d.PriceID ) OR
			(1<>1)
		) AND
		(1=1)


	Set @nErrorCode = @@Error
End

--


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'LOAD NEW BRS_ItemBaseHistoryLNK ...'

	INSERT INTO BRS_ItemBaseHistoryLNK (
		CalMonth,
		ItemID,

		FamilySetLeaderID,
		PriceID
	)

	SELECT     
		s.CalMonth, 
		i.ID AS ItemID, 

		ifs.ID as FamilySetLeaderID,
		d.PriceID

	FROM         
		STAGE_BRS_ItemBaseHistory AS s 

		INNER JOIN BRS_ItemBaseHistoryDAT AS d 
	ON s.Supplier = d.Supplier AND 
		s.Currency = d.Currency AND 
		s.SupplierCost = d.SupplierCost AND 
		s.CorporatePrice = d.CorporatePrice AND 
		s.SellPrcBrk2 = d.SellPrcBrk2 AND 
		s.SellPrcBrk3 = d.SellPrcBrk3 AND 
		s.SellQtyBrk2 = d.SellQtyBrk2 AND 
		s.SellQtyBrk3 = d.SellQtyBrk3 

		INNER JOIN BRS_Item AS i 
		ON s.Item = i.Item

		INNER JOIN BRS_Item AS ifs 
		ON s.FamilySetLeader = ifs.Item
	WHERE
		NOT EXISTS (SELECT * FROM BRS_ItemBaseHistoryLNK WHERE CalMonth = s.CalMonth AND ItemID = I.ID) AND
--		s.CalMonth between 201601 and 201612 AND
		(1=1)


	Set @nErrorCode = @@Error
End



If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Clear STAGE_BRS_ItemBaseHistory'	

	Delete FROM STAGE_BRS_ItemBaseHistory

	Set @nErrorCode = @@Error
End



------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------


-- Monthend commit

if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = '[BRS_ItemBaseHistory_load_proc]'
	Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'

	Set @sMessage = @sMessage +  ', ' + convert(varchar, @bDebug)

	RAISERROR (50060, 9, 1, @sMessage )

	Rollback Tran mytran

	return @nErrorCode
End

-- Commit tran on Success
if (@nTranCount = 0)
Begin
	Commit Tran
End

Return @nErrorCode

END
GO

/*
-- TEST JDE vs DW

SELECT     i.Item, i.CurrentCorporatePrice, i.Label, h.CorporatePrice
FROM         BRS_ItemBaseHistory AS h INNER JOIN
                      BRS_Item AS i ON h.Item = i.Item
WHERE     
	(h.CalMonth = 0) AND
	ROUND(CorporatePrice,2) <> ROUND(CurrentCorporatePrice,2)


SELECT COUNT(*) FROM STAGE_BRS_ItemBaseHistory 

*/


-- Step 1:  clear tables (run below)
/*

-- Weekly / on demand

truncate table STAGE_BRS_ItemSupplierCost
truncate table STAGE_BRS_ItemSellPrice
-- Monthly / one-time
truncate table STAGE_BRS_ItemBaseHistory 

*/

-- Step 2a:  load tables via "S:\Business Reporting\_BR_Sales\Upload\BRS_ItemBaseCost_Load.bat"
-- Step 2b:  load tables via "S:\Business Reporting\_BR_Sales\Upload\BRS_ItemBaseHistory_Load.bat"

-- Step 3:  run below script

-- prod run
-- Exec [BRS_ItemBaseHistory_load_proc] 0





