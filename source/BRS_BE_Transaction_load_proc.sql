﻿

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BRS_BE_Transaction_load_proc] 
	@nRunMode int = 0,
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_BE_Transaction_load_proc
**	Desc: Load Daily Transactions 
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@nRunMode int, {0 - Daily, <>0 to ME commit mode - run once.
**	@bDebug
**
**	Auth: tmc
**	Date: 14 Nov 14
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	8 Dec 14	tmc		Added ME update mode 	
**  12 Dec 14	tmc		Added Est Free Goods flag 
**	13 Dec 14	tmc		Added Special Markets Support 
**  06 Dec 15	tmc		Added ME post Terr, VPA update logic
**  24 Aug 15	tmc		Add new BT mapping logic
**  14 Dec 15	tmc		Remove Monthend mode (will handle separately)
**	08 Jan 16	tmc		renamed to BRS_BE* and moved to production
--  12 Feb 16	tmc		Clean up and Speed up load via sort & Truncate
--  22 Feb 16	tmc		Undo Truncate to to simplify rights for non-admins
--	24 Feb 16	tmc		Set Complete status to 15, indicating that a post process is required (20)
--	09 Mar 16	tmc		Fixed bug here changes to customer was locking the specialty update
--	06 May 16	tmc		Duplicate Free Good logic into Adjustment for simplification
--	12 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place 
--	13 Dec 16	tmc		Extend FG tag to adjust note (consistent reporting)
--  01 Nov 17	tmc		removed redundant GLaccounts (saved as BU & obj)
--						fix GLBU logic to use BU + Obj + Sub
--	30 Nov 17	tmc		Update TransExt Salesorder for RI
**	07 Feb 18	tmc		Bug fix (found by TS team).  RI fix broke PO update
**							Marking init PO for DWTrans process fix
**	04 Apr 24	tmc		Free Goods fix, remove Private Label from Est
**    
*******************************************************************************/
BEGIN

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @dtSalesDay datetime
Declare @nBatchStatus int
Declare @nFiscalMonth int

SET NOCOUNT ON;

if (@bDebug <> 0)
	SET NOCOUNT OFF;

Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran


if (@bDebug <> 0)
	Print 'DEBUG MODE.  Lookup Current Day & Month '

If (@nErrorCode = 0) 
Begin
	Select 	
		@dtSalesDay = SalesDate, @nFiscalMonth = FiscalMonth
	From 
		dbo.BRS_Config

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Objects...'

		INSERT INTO BRS_Object
							  (GLAcctNumberObj)
		SELECT DISTINCT SUBSTRING(GLANI, 14, 10) AS obj
		FROM         STAGE_BRS_Transaction AS t
		WHERE     (NOT EXISTS
								  (SELECT     GLAcctNumberObj, GLOBJ_Name, GLOBJ_Type, Note, StatusCd, AddedDt
									FROM          BRS_Object AS BRS_Object_1
									WHERE      (SUBSTRING(t.GLANI, 14, 10) = GLAcctNumberObj)))

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new BU...'

		INSERT INTO BRS_BusinessUnit
							  (BusinessUnit)
		SELECT DISTINCT LEFT(t.GLANI, 12) AS bu
		FROM         STAGE_BRS_Transaction AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          BRS_BusinessUnit AS BRS_BusinessUnit_1
									WHERE       BusinessUnit = LEFT(t.GLANI, 12) ))
	Set @nErrorCode = @@Error
End

-- added 12 Dec 14, tmc, to ensure that all DocTypes in table before INNER JOIN on final load
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new DocType...'

		INSERT INTO BRS_DocType
							  (DocType)
		SELECT DISTINCT t.SHDCTO AS dt
		FROM         STAGE_BRS_Transaction AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          BRS_DocType AS BRS_DocType_1
									WHERE       DocType = t.SHDCTO ))
	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new MPC...'

		INSERT INTO BRS_ItemMPC
							  (MajorProductClass)
		SELECT DISTINCT ISNULL(t.SDSRP1,'') AS dt
		FROM         STAGE_BRS_Transaction AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          BRS_ItemMPC AS BRS_ItemMPC_1
									WHERE       MajorProductClass = ISNULL(t.SDSRP1,'') ))
	Set @nErrorCode = @@Error
End

-- added 24 Aug 15, tmc
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new BT (from Stage)...'

		INSERT INTO BRS_CustomerBT
							  (BillTo, ShipToPrimary)
		SELECT     
			SDAN8 AS BillTo, 
			MIN(SDSHAN) AS ShipToPrimary
		FROM         
			STAGE_BRS_Transaction AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          BRS_CustomerBT AS BRS_Customer_1
									WHERE      (BillTo = t.SDAN8)))
		GROUP BY SDAN8	

	Set @nErrorCode = @@Error
End

-- added 25 Aug 15, tmc
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new BT (from Cust Stage)...'

		INSERT INTO BRS_CustomerBT
							  (BillTo, ShipToPrimary)
		SELECT     
			BTADNO AS BillTo, 
			MIN(ADNOID) AS ShipToPrimary
		FROM         
			STAGE_BRS_Customer AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          BRS_CustomerBT AS BRS_Customer_1
									WHERE      (BillTo = t.BTADNO)))
		GROUP BY BTADNO	

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Cust (from Stage)...'

		INSERT INTO BRS_Customer
							  (ShipTo)
		SELECT DISTINCT SDSHAN AS cust
		FROM         STAGE_BRS_Transaction AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          dbo.BRS_Customer AS BRS_Customer_1
									WHERE       ShipTo = SDSHAN ))
	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Item...'

		INSERT INTO BRS_Item
							  (Item)
		SELECT DISTINCT ISNULL(SDLITM,'') AS Item
		FROM         STAGE_BRS_Transaction AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          dbo.BRS_Item AS BRS_Item_1
									WHERE       Item = ISNULL(SDLITM,'') ))
	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Branch (from Cust)...'

		INSERT INTO dbo.BRS_Branch
							  (Branch)
		SELECT DISTINCT AFLV02CD AS br
		FROM         dbo.STAGE_BRS_Customer AS c
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          dbo.BRS_Branch AS BRS_Branch_1
									WHERE       AFLV02CD = Branch ))
	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new FSC (from Cust)...'

		INSERT INTO dbo.BRS_FSC_Rollup
							  (TerritoryCd, FSCRollup, Branch)
		SELECT DISTINCT AFTRCD, AFTRCD, AFLV02CD AS br
		FROM         dbo.STAGE_BRS_Customer AS c
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          dbo.BRS_FSC_Rollup AS BRS_FSC_Rollup_1
									WHERE       AFTRCD = TerritoryCd ))
	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Update FSC Branch (from Cust)...'

	UPDATE    BRS_FSC_Rollup
	SET              Branch = AFLV02CD, StatusCd = -1
	FROM         STAGE_BRS_Customer INNER JOIN
						  BRS_FSC_Rollup ON STAGE_BRS_Customer.AFTRCD = BRS_FSC_Rollup.TerritoryCd
	WHERE Branch <> AFLV02CD

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Cust (from Cust)...'

		INSERT INTO BRS_Customer
							  (ShipTo)
		SELECT DISTINCT ADNOID AS cust
		FROM         dbo.STAGE_BRS_Customer AS c
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          dbo.BRS_Customer AS BRS_Customer_1
									WHERE       ShipTo = ADNOID ))
	Set @nErrorCode = @@Error
End


-- Added by tmc, 13 Dec 14
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Specialty (from Cust)...'

		INSERT INTO BRS_CustomerSpecialty
							  (Specialty)
		SELECT DISTINCT ISNULL(SPCCDID,'') AS cust
		FROM         dbo.STAGE_BRS_Customer AS c
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          BRS_CustomerSpecialty AS BRS_CustomerSpecialty_1
									WHERE       Specialty = ISNULL(SPCCDID,'') ))
	Set @nErrorCode = @@Error
End

-- Added by tmc, 13 Dec 14
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new VPA (from Cust)...'

		INSERT INTO BRS_CustomerVPA
							  (VPA)
		SELECT DISTINCT ISNULL(SPCDID,'') AS cust
		FROM         dbo.STAGE_BRS_Customer AS c
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          BRS_CustomerVPA AS BRS_CustomerVPA_1
									WHERE       VPA = ISNULL(SPCDID,'') ))
	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Add new Salesorder...'

		INSERT INTO [dbo].[BRS_TransactionDW_Ext]
							  ([SalesOrderNumber], [DocType], [CustomerPOText1])
		SELECT DISTINCT t.SalesOrderNumber, t.DocType, '<TO BE UPDATED>'
		FROM         STAGE_BRS_Transaction_Load AS t
		WHERE     (NOT EXISTS
								  (SELECT     *
									FROM          [dbo].[BRS_TransactionDW_Ext] AS t2
									WHERE       t.SalesOrderNumber = t2.SalesOrderNumber))
	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Update Cust (from Cust)...'

	UPDATE    
		BRS_Customer
	SET              
		BillTo = BTADNO, 
		Specialty = ISNULL(SPCCDID,''), 
		VPA = ISNULL(SPCDID,''), 
		TerritoryCd = ISNULL(AFTRCD,'')
--	09 Mar 16	tmc		Fixed bug here changes to customer was locking the specialty update
--		StatusCd = 20


	FROM         
		STAGE_BRS_Customer 
			INNER JOIN BRS_Customer 
			ON STAGE_BRS_Customer.ADNOID = BRS_Customer.ShipTo

	WHERE
		BillTo <> BTADNO OR
		Specialty <> ISNULL(SPCCDID,'') OR
		VPA <> ISNULL(SPCDID,'') OR
		TerritoryCd <> ISNULL(AFTRCD,'') 

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Fix Dup Line#...'

	UPDATE    
		STAGE_BRS_Transaction
	SET              
		SDLNID = + 0.222
	FROM         
		STAGE_BRS_Transaction 
			INNER JOIN BRS_Transaction AS t 
			ON STAGE_BRS_Transaction.SHDOCO = t.SalesOrderNumberKEY AND 
				STAGE_BRS_Transaction.SHDCTO = t.DocType AND 
				ROUND(STAGE_BRS_Transaction.SDLNID * 1000, 0)  = t.LineNumber

		Set @nErrorCode = @@Error
End

-- Update Day 
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get Day Status for BRS'

	Select 	
		@nBatchStatus = StatusCd
	From 
		dbo.BRS_SalesDay
	Where
		SalesDate = @dtSalesDay
	
	Set @nErrorCode = @@Error
End
if (@bDebug <> 0)
	Print 'Batch Status =' + Convert(varchar, @nBatchStatus)


-- 999 = Locked
If (@nBatchStatus <>999)
Begin


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'LOAD NewDay into transaction'


	INSERT INTO BRS_Transaction (
		FiscalMonth, 
		SalesOrderNumberKEY, 
		DocType, 
		LineNumber, 
		SalesOrderNumber, 
		Branch, 
		BranchORG, 
		GLBU_Class, 
		NetSalesAmt, 
		ExtendedCostAmt, 
		Item, 
		Shipto, 
		SalesDivision, 
		TerritoryCd, 
		TerritoryORG, 
		InvoiceNumber, 
		SalesDate, 
		OrderSourceCode, 
		CustomerPOText1, 
		MajorProductClass, 
		SalesOrderBillTo, 
		ARInvoiceDocType, 
		MarketSegment, 
		PracticeType, 
		LineTypeOrder, 
		GLClass, 
		AdditionalWarehouse, 
		Warehouse, 
		GL_BusinessUnit, 
		GL_Object_Sales, 
		GL_Object_Cost,
		GL_Subsidiary_Sales, 
		GL_Subsidiary_Cost,

		FreeGoodsEstInd,

--	06 May 16	tmc		Duplicate Free Good logic into Adjustment for simplification
		AdjCode,
		--	13 Dec 16	tmc		Extend FG tag to adjust note (consistent reporting)
		AdjNote


	)
	SELECT     
		FiscalMonth, 
		SalesOrderNumberKEY, 
		l.DocType, 
		LineNumber, 
		SalesOrderNumber, 
		Branch, 
		BranchORG, 
		l.GLBUClass, 
		NetSalesAmt, 
		ExtendedCostAmt, 
		l.Item, 
		Shipto, 
		SalesDivision, 
		TerritoryCd, 
		TerritoryORG, 
		InvoiceNumber, 
		SalesDate, 
		OrderSourceCode, 
		CustomerPOText1, 
		l.MajorProductClass, 
		SalesOrderBillTo, 
		ARInvoiceDocType, 
		MarketSegment, 
		PracticeType, 
		LineTypeOrder, 
		GLClass, 
		AdditionalWarehouse, 
		Warehouse, 
		BusinessUnitSales, 
		LEFT(GLAcctNumberObjSales,4), 
		LEFT(GLAcctNumberObjCost,4),
		SUBSTRING(GLAcctNumberObjSales,6,4), 
		SUBSTRING(GLAcctNumberObjCost,6,4),

		-- exclude private label FG as of 4 Apr 24
		CASE WHEN NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 AND ISNULL(i.Label, '')<>'P' THEN 1 ELSE 0 END AS FreeGoodsEstInd,
		CASE WHEN NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 AND ISNULL(i.Label, '')<>'P' THEN 'XXXFGE' ELSE '' END AS AdjCode,
		--	13 Dec 16	tmc		Extend FG tag to adjust note (consistent reporting)
		CASE WHEN NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 AND ISNULL(i.Label, '')<>'P' THEN 'XXXFGE' ELSE '' END AS AdjNote


	FROM         
		STAGE_BRS_Transaction_Load as l

		INNER JOIN dbo.BRS_DocType as dt
		ON l.DocType = dt.DocType

		INNER JOIN dbo.BRS_BusinessUnitClass as buc
		ON l.GLBUClass = buc.GLBU_Class

		INNER JOIN BRS_ItemMPC AS mpc 
		ON l.MajorProductClass= mpc.MajorProductClass

		LEFT JOIN BRS_Item i
		ON l.Item = i.Item	

--  12 Feb 16	tmc		Clean up and Speed up load via sort & Truncate

	ORDER BY 
		FiscalMonth, 
		Branch, 
		l.GLBUClass, 
		SalesDate

		Set @nErrorCode = @@Error
	End



	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Clear Stage trans'	

		Delete FROM dbo.STAGE_BRS_Transaction

		Set @nErrorCode = @@Error
	End



	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Processed'	

		Update
			BRS_SalesDay
		Set 
			--	24 Feb 16	tmc		Set Complete status to 15, indicating that a post process is required (20)
			StatusCd = 15
		Where 
			SalesDate = @dtSalesDay
	
		Set @nErrorCode = @@Error
	End

End


-- Monthend commit

if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = '[BRS_BE_Transaction_load_proc]'
	Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'
	Set @sMessage = @sMessage +  ', ' + convert(varchar, @nRunMode)
	Set @sMessage = @sMessage +  ', ' + convert(varchar, @bDebug)

	RAISERROR ('%s', 9, 1, @sMessage )


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
-- Look for dups in case the load date and extract date were not set correctly
-- added 25 Jan 17 to trouble-shoot issue 

	SELECT SHDOCO as stageORD, t.SalesOrderNumberKEY,SalesDate as JDE_load_date
	FROM         
		STAGE_BRS_Transaction 
			INNER JOIN BRS_Transaction AS t 
			ON STAGE_BRS_Transaction.SHDOCO = t.SalesOrderNumberKEY AND 
				STAGE_BRS_Transaction.SHDCTO = t.DocType AND 
				ROUND(STAGE_BRS_Transaction.SDLNID * 1000, 0)  = t.LineNumber

-- check if the same data was loaded for two days.  380 test would catch this.

SELECT     SUM(NetSalesAmt) AS Expr1, COUNT(DocType) AS Expr2
FROM         BRS_Transaction
WHERE     (SalesDate >= CONVERT(DATETIME, '2017-01-23 00:00:00', 102))
GROUP BY SalesDate

*/


-- debug run
-- [BRS_BE_Transaction_load_proc] 

-- prod run
-- [BRS_BE_Transaction_load_proc] 0, 0

-- ORG 13 083

/*
-- fix FG Private label retro

SELECT        BRS_Transaction.FiscalMonth, BRS_Transaction.SalesOrderNumberKEY, BRS_Transaction.DocType, BRS_Transaction.LineNumber, BRS_Transaction.Item, BRS_Item.Label, BRS_Transaction.FreeGoodsEstInd
FROM            BRS_Transaction INNER JOIN
                         BRS_Item ON BRS_Transaction.Item = BRS_Item.Item
where FreeGoodsEstInd <> 0 and label = 'P' 

-- DEV
-- 108 690 org
-- 108 690 upd

-- PROD
-- 111 685 org

UPDATE       BRS_Transaction
SET                FreeGoodsEstInd = 0
FROM            BRS_Transaction INNER JOIN
                         BRS_Item ON BRS_Transaction.Item = BRS_Item.Item
WHERE        (BRS_Transaction.FreeGoodsEstInd <> 0) AND (BRS_Item.Label = 'P')
*/
