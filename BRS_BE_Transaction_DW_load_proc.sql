

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BRS_BE_Transaction_DW_load_proc] 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_BE_Transaction_DW_load_proc
**	Desc: Load DW Transactions 
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
**	Date: 22 Sep 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	15 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place
--	23 Sep 16	tmc		Map Promo tagged TS to Order-level TS Code 

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
	Print 'Proc: BRS_BE_Transaction_DW_load_proc'
	Print 'Desc: Update DW Table with new transaction details'
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


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Sales Orders to BRS_TransactionDW_Ext...'

	INSERT INTO 
		BRS_TransactionDW_Ext (
			SalesOrderNumber, 
			DocType, 
			LineNumber, 
			CustomerPOText1
		)
	SELECT     
			JDEORNO as SalesOrderNumber, 
			ORDOTYCD, 
			ROUND(LNNO * 1000,0) AS LineNumber, 
--			Left((RF1TT), 25) AS CustomerPOText1
			Left(MIN(RF1TT), 25) AS CustomerPOText1
	FROM         
			STAGE_BRS_TransactionDW
	WHERE     NOT EXISTS
	(
		Select 
			* 
		From 
			BRS_TransactionDW_Ext s
		Where 
			JDEORNO = s.SalesOrderNumber And
			ORDOTYCD = s.DocType And
			ROUND(LNNO * 1000,0) = s.LineNumber
	)

	GROUP BY 
		JDEORNO, 
		ORDOTYCD, 
		LNNO

	Set @nErrorCode = @@Error
End

--	23 Sep 16	tmc		Map Promo tagged TS to Order-level TS Code 

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Map Promo tagged TS to Order-level TS Code...'

	UPDATE    
		BRS_TransactionDW_Ext
	SET              
		TsTerritoryOrgCd = BRS_TS_Rollup.TsTerritoryCd,
		TsTerritoryCd = BRS_TS_Rollup.TsTerritoryCd

	FROM         
		BRS_TransactionDW_Ext 

		INNER JOIN BRS_TS_Rollup 
		ON SUBSTRING(BRS_TransactionDW_Ext.CustomerPOText1, PATINDEX('%TS__%', BRS_TransactionDW_Ext.CustomerPOText1), 4) 
			= BRS_TS_Rollup.PoTag

	WHERE     
		(BRS_TransactionDW_Ext.CustomerPOText1 LIKE '%TS__%') AND
		EXISTS
		(
			Select 
				* 
			From 
				STAGE_BRS_TransactionDW s
			Where 
				SalesOrderNumber = s.JDEORNO And
				DocType = s.ORDOTYCD And
				LineNumber = ROUND(s.LNNO * 1000,0) 
		) AND
		(1 = 1)


	Set @nErrorCode = @@Error
End

--

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'LOAD BRS_TransactionDW'


	INSERT INTO BRS_TransactionDW
	(
		SalesOrderNumber, 
		DocType, 
		LineNumber, 
		CalMonth, 
		Date, 
		Shipto, 
		Item, 
		EnteredBy, 
		OrderTakenBy, 
		OrderSourceCode, 
		CustomerPOText1, 
		PriceMethod, 
		VPA, 
		LineTypeOrder, 
		SalesDivision, 
		MajorProductClass, 
		ChargebackContractNumber, 
		GLBusinessUnit, 
		OrderFirstShipDate, 
		InvoiceNumber, 
		ShippedQty, 
		NetSalesAmt, 
		GPAmt, 
		GPAtFileCostAmt, 
		GPAtCommCostAmt, 
		ExtChargebackAmt, 
		ExtDiscAmt, 
		UnitListPrice,
		PromotionCode,
		OrderPromotionCode,
		BackorderInd,
		FreeGoodsEstInd

		)
		SELECT     
		s.JDEORNO AS SalesOrderNumber, 
		s.ORDOTYCD AS DocType, 
		ROUND(s.LNNO * 1000,0) AS LineNumber, 
		s.CMID AS CalMonth, 
		s.PDDT AS Date, 
		s.ADNOID AS Shipto, 
		s.ITLONO AS Item, 
		s.ENBYNA AS EnteredBy, 
		s.ORTKBYID AS OrderTakenBy, 
		s.ORSCCD AS OrderSourceCode, 
		LEFT(s.RF1TT,25) AS CustomerPOText1, 
		s.PRMDCD AS PriceMethod, 
		ISNULL(s.SPCDID,'') AS VPA, 
		s.LNTY AS LineTypeOrder, 
		s.HSDCDID AS SalesDivision, 
		s.MJPRCLID AS MajorProductClass, 
		ISNULL(s.CBCONTRNO,0) AS ChargebackContractNumber, 
		ISNULL(s.GLBUNO,'') AS GLBusinessUnit, 
		ISNULL(s.ORFISHDT, '1 Jan 1980') AS OrderFirstShipDate, 
		s.IVNO AS InvoiceNumber, 
		s.WJXBFS1 AS ShippedQty, 
		s.WJXBFS2 AS NetSalesAmt, 
		s.WJXBFS3 AS GPAmt, 
		s.WJXBFS4 AS GPAtFileCostAmt, 
		s.WJXBFS5 AS GPAtCommCostAmt, 
		s.WJXBFS6 AS ExtChargebackAmt, 

		CASE WHEN s.LNTY = 'CP' THEN (0 - s.WJXBFS2) ELSE s.WJXBFS7 END  AS ExtDiscAmt, 

		s.WJXBFS8 AS UnitListPrice, 
		ISNULL(p1.PMCD, '') AS PromotionCode, 
		ISNULL(p2.PMCD, '') AS OrderPromotionCode,

		CASE WHEN s.PDDT = s.ORFISHDT THEN 0 ELSE 1 END as BackorderInd,		
	--	0 as BackorderInd,		
		CASE WHEN s.WJXBFS2 = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END AS FreeGoodsEstInd
	--	CASE WHEN NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END AS FreeGoodsEstInd


	FROM         
		STAGE_BRS_TransactionDW AS s 

	--	LEFT OUTER JOIN 
		LEFT OUTER JOIN STAGE_BRS_Promotion AS p2 
		ON s.OPMID = p2.PMID 

		LEFT OUTER JOIN STAGE_BRS_Promotion AS p1 
		ON s.PMID = p1.PMID

		LEFT OUTER JOIN BRS_DocType as dt
		ON s.ORDOTYCD = dt.DocType

		LEFT OUTER JOIN BRS_ItemMPC AS mpc 
		ON s.MJPRCLID = mpc.MajorProductClass

		LEFT OUTER JOIN BRS_BusinessUnit AS bu
		ON ISNULL(s.GLBUNO,'') = bu.BusinessUnit

		LEFT OUTER JOIN BRS_BusinessUnitClass as buc
		ON  bu.GLBU_Class = buc.GLBU_Class

	WHERE     NOT EXISTS
	(
		Select 
			* 
		From 
			BRS_TransactionDW s
		Where 
			JDEORNO = s.SalesOrderNumber And
			ORDOTYCD = s.DocType And
			ROUND(LNNO * 1000,0) = s.LineNumber
	)

	Set @nErrorCode = @@Error
End


--	15 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place

If (@bDebug <> 0)
Begin
	Print '------------------------------------------------------------------------------------------------------------'
	Print 'Free Goods P&G correction to remove free goods estimate for PROCGA >= 1 Sep 16'
	Print 'Once on the new sytem this will re revisited.  tmc, 13 Sep 16'
	Print '------------------------------------------------------------------------------------------------------------'
	Print ''
End


If (@nErrorCode = 0) 
Begin

	UPDATE    
		BRS_TransactionDW
	SET              
--		AdjCode = '', 
		FreeGoodsEstInd = 0
	FROM         
		BRS_TransactionDW 
		
		INNER JOIN BRS_Item AS i 
		ON BRS_TransactionDW.Item = i.Item

	WHERE     
		(i.Supplier = 'PROCGA') AND 
		(BRS_TransactionDW.Date > '1 Sep 2016') AND 
		(BRS_TransactionDW.FreeGoodsEstInd = 1) AND
		EXISTS
		(
			Select 
				* 
			From 
				STAGE_BRS_TransactionDW s
			Where 
				SalesOrderNumber = s.JDEORNO And
				DocType = s.ORDOTYCD And
				LineNumber = ROUND(s.LNNO * 1000,0) 
		) AND
		(1 = 1)


	Set @nErrorCode = @@Error

End
--SELECT     MIN(CMID) FROM STAGE_BRS_TransactionDW



If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Clear STAGE_BRS_TransactionDW'	

	Delete FROM STAGE_BRS_TransactionDW

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
	Set @sMessage = '[BRS_BE_Transaction_DW_load_proc]'
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

-- truncate table STAGE_BRS_Promotion 
-- truncate table STAGE_BRS_TransactionDW

-- Step 2:  load tables via "S:\Business Reporting\_BR_Sales\Upload\BRS_TransactionDW_Load.bat"

-- Step 3:  run below script

-- debug run
-- [BRS_BE_Transaction_DW_load_proc] 

-- prod run
-- Exec [BRS_BE_Transaction_DW_load_proc] 0





