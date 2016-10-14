

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

-- pull current

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new items (STAGE_BRS_ItemBase) ...'

	INSERT INTO STAGE_BRS_ItemBaseHistory (
		Item,
		CalMonth,
		FamilySetLeader,
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
		b.QILITM AS Item, 
		0 AS CalMonth, 
		b.QIRPRC as FamilySetLeader, 
		b.QI$SPC as Supplier, 
		CASE WHEN b.QI$FEC = '' THEN 'CAD' ELSE b.QI$FEC END as Currency, 
		ISNULL(b2.QI$CP1,0) SupplierCost, 
		ISNULL(b2.QI$PR1,0) CorporatePrice, 
		ISNULL(b2.QI$PR2,0) SellPrcBrk2, 
		ISNULL(b2.QI$PR3,0) SellPrcBrk3, 
		ISNULL(b2.QI$QB2,0) SellQtyBrk2, 
		ISNULL(b2.QI$QB3,0) SellQtyBrk3

	FROM         
		STAGE_BRS_ItemBase b

		INNER JOIN STAGE_BRS_ItemBase b2
		ON b.QIRPRC = b2.QILITM 

		

	WHERE     
	--	(QI$SPC like 'DENT%') AND
		(1=1)
		


	Set @nErrorCode = @@Error
End

-- update FX for RI

-- Update Current Base where diff


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



If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'LOAD BRS_ItemBaseHistoryLNK ...'

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
	--	s.CalMonth between 201601 and 201612 AND
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


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Clear STAGE_BRS_ItemBase'	

	Delete FROM STAGE_BRS_ItemBase

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



-- Step 1:  clear tables (run below)

-- truncate table dbo.STAGE_BRS_ItemBase
-- truncate table STAGE_BRS_ItemBaseHistory 

-- Step 2a:  load tables via "S:\Business Reporting\_BR_Sales\Upload\BRS_ItemBase_Load.bat"
-- Step 2b:  load tables via "S:\Business Reporting\_BR_Sales\Upload\BRS_ItemBaseHistory_Load.bat"

-- Step 3:  run below script

-- prod run
-- Exec [BRS_ItemBaseHistory_load_proc] 0

-- debug run
-- [BRS_ItemBaseHistory_load_proc] 





