

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BRS_BE_Transaction_post_proc] 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_BE_Transaction_post_proc
**	Desc: Post Load daiy sales - fix segmentation, id errors
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
**	Date: 14 Nov 14
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	25 Feb 16	tmc		Fix Branch change bug
--	01 Mar 16	tmc		Fixed Customer Segment update bug
--	13 Sep 16	tmc		Fix SAIT. Proper fix once new VPA in place
--	13 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place
--	07 Jun 17	tmc		REVERSED - Fix SAIT. Proper fix once new VPA in place
--	04 Jun 18	tmc		Update special Market logic 
--	15 Mar 22	tmc		Link DS to DW to enable cross functional goodness
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
Declare @nExceptionCount int
Declare @nRowCount int


SET NOCOUNT ON;

if (@bDebug <> 0)
	SET NOCOUNT OFF;

Set @nBatchStatus = -1
Set @nExceptionCount = 0
Set @nRowCount = 0
Set @sMessage = ''

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

if (@bDebug <> 0)
	Print 'Lookup Current Day Status '

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
	Print 'Status =' + Convert(varchar, @nBatchStatus)

If (@bDebug <> 0)
Begin
	Print '------------------------------------------------------------------------------------------------------------'
	Print 'Assign customer segmentation based on business rules and external support tables.'
	Print 'Perfect world, this is simplified based on VPAs and specialty codes.  tmc, 22 Feb 16'
	Print '------------------------------------------------------------------------------------------------------------'
	Print ''
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '1. clear'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = '', 
		SegCd_New = ''

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print ' 2. Set non Dental based on Division'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = d.MarketClass_New, 
		SegCd_New = '' 
	FROM            
		BRS_Customer INNER JOIN

		BRS_SalesDivision AS d 
		ON BRS_Customer.SalesDivision = d.SalesDivision
	WHERE        
		(BRS_Customer.SalesDivision <> 'AAD') AND 
		(BRS_Customer.MarketClass_New = '') 

	Set @nErrorCode = @@Error
End



-- DCC BT set
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3. Set DCC based on BT=2613256 (Elite)'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'ELITE', 
		SegCd_New = 'NDSO'
	WHERE        
		(BillTo = 2613256) AND 
		(MarketClass_New = '')

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3b. Set DCC based on BT=2613256 (Zahn -> ZahnSM)'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'ZAHNSM', 
		SegCd_New = 'DSO'
	WHERE        
		(BillTo = 2613256) AND 
		(SalesDivision = 'AAL')

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3c. Set DCC based on Specialty (Various)'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = s.MarketClass_New,
		SegCd_New = s.SegCd_New
	FROM            
		BRS_Customer 
		INNER JOIN BRS_CustomerSpecialty AS s 
		ON BRS_Customer.Specialty = s.Specialty
	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(BRS_Customer.CustGrpWrk = 'Dental Corp') AND
		(s.MarketClass_New <> '') 

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '3d. Set DCC based on DSO (Exception)'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'PVTPRC', 
		SegCd_New = ''
	FROM            
		BRS_Customer 
	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(BRS_Customer.CustGrpWrk = 'Dental Corp') AND
		(BRS_Customer.Specialty = 'DSO')

	Set @nErrorCode = @@Error
End
	

-- AO BT Set
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '4. Set Alpha Omega based on BT=1765054 (MM / RDSO)'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'MIDMKT', 
		SegCd_New = 'RDSO'
	WHERE        
		(BillTo = 1765054) AND 
		(MarketClass_New = '')

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5a. Set Dental Students - Primary (INSTIT)'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'INSTIT', 
		SegCd_New = 'PDS'
	WHERE        
		(Specialty	= 'STUD') AND 
		(MarketClass_New = '')

	Set @nErrorCode = @@Error
End



If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '5b. Set Dental Students (INSTIT)'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'INSTIT', 
		SegCd_New = 'DSH'
	WHERE        
		(Specialty	= 'STUA') AND 
		(MarketClass_New = '')

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '6. Zahn SM Exception'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'ZAHNSM', 
		SegCd_New = 'DSO'
	FROM            
		BRS_Customer 
		INNER JOIN BRS_CustomerGroup AS g 
		ON BRS_Customer.CustGrpWrk = g.CustGrp
	WHERE        
		(BRS_Customer.MarketClass_New = 'ZAHN') AND 
		(g.MarketClass_New = 'ZAHNSM')

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '7. MM Groups with VPAs'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = g.MarketClass_New, 
		SegCd_New = g.SegCd_New
	FROM            
		BRS_Customer 

		INNER JOIN BRS_CustomerVPA AS v 
		ON BRS_Customer.VPA = v.VPA 

		INNER JOIN BRS_CustomerGroup AS g 
		ON v.CustGrp = g.CustGrp
	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(v.CustGrp <> '') AND 
		(g.MarketClass_New <> '')

	Set @nErrorCode = @@Error
End



If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '8. MM Groups with no VPAs'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = g.MarketClass_New, 
		SegCd_New = g.SegCd_New
	FROM            
		BRS_Customer 
	
		INNER JOIN BRS_CustomerGroup AS g 
		ON BRS_Customer.CustGrpWrk = g.CustGrp

	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(g.MarketClass_New <> '')

	Set @nErrorCode = @@Error
End



If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '9. Set No Group based on Specialty'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = s.MarketClass_New, 
		SegCd_New = s.SegCd_New
	FROM            
		BRS_Customer 
	
		INNER JOIN BRS_CustomerSpecialty AS s 
		ON BRS_Customer.Specialty = s.Specialty
	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(s.MarketClass_New <> '')

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '10. Zahn SM exception correction'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'MIDMKT', 
		SegCd_New = 'DSO'
	WHERE        
		(SalesDivision = 'AAD') AND 
		(MarketClass_New = 'ZAHNSM')

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '11. Dental Specialty exception correction'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'PVTPRC', 
		SegCd_New = ''
	WHERE        
		(SalesDivision = 'AAD') AND 
		(MarketClass_New In ('ANIMAL','MEDICL','ZAHN'))

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '12. merge new codes'

	UPDATE       
		BRS_Customer
	SET                
		MarketClass = MarketClass_New, 
		SegCd = SegCd_New
	WHERE        
		MarketClass = ''

	Set @nErrorCode = @@Error
End


--	12 Sep 16	tmc		Add P&G Free good work-aournd to exclude P&G Free Goods after 1 Sept 16;  Proper fix once new Free Goods in place
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
		BRS_Transaction
	SET              
		AdjCode = '', 
		FreeGoodsEstInd = 0
	FROM         
		BRS_Transaction 
		
		INNER JOIN BRS_Item AS i 
		ON BRS_Transaction.Item = i.Item

	WHERE     
		(i.Supplier = 'PROCGA') AND 
		(BRS_Transaction.SalesDate > '1 Sep 2016') AND 
		(BRS_Transaction.SalesDate = @dtSalesDay) AND 
		(BRS_Transaction.AdjCode = 'XXXFGE') AND
		(1 = 1)

	Set @nErrorCode = @@Error

End
--		CASE WHEN (NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1) and (buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1) AND NOT (l.SalesDate >= '1 Sep 2016' AND itm.Supplier = 'PROCGA' ) THEN 1 ELSE 0 END AS FreeGoodsEstInd,
--		CASE WHEN (NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1) and (buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1) AND NOT (l.SalesDate >= '1 Sep 2016' AND itm.Supplier = 'PROCGA' ) THEN 'XXXFGE' ELSE '' END AS AdjCode



If (@bDebug <> 0)
Begin
	Print '------------------------------------------------------------------------------------------------------------'
	PRINT 'Test for Missing or Changed critical fields in Current MTD and note exceptions .  tmc, 24 Feb 16'
	Print '------------------------------------------------------------------------------------------------------------'
	Print ''
End


-- Missing GLBU_Class
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Check for missing GLBU_Class'

	SELECT 
		@nRowCount = count(*)
	FROM         
		BRS_Transaction AS t 
	WHERE
		t.FiscalMonth = @nFiscalMonth AND
		t.GLBU_Class = '' 

	Set @nExceptionCount = @nExceptionCount + @nRowCount

	IF (@nRowCount > 0)
		Set @sMessage = @sMessage + ', Missing-GLBU_Class' 

	if (@bDebug <> 0)
		Print @nRowCount

End

-- Missing TerritoryCd
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Check for missing TerritoryCd'

	SELECT     
		@nRowCount = COUNT(*)     
	FROM         
		BRS_Transaction AS t 
	WHERE
		t.FiscalMonth = @nFiscalMonth AND
		t.TerritoryCd = ''

	Set @nExceptionCount = @nExceptionCount + @nRowCount

	IF (@nRowCount > 0)
		Set @sMessage = @sMessage + ', Missing-TerritoryCd' 

	if (@bDebug <> 0)
		Print @nRowCount

End


-- Missing Branch
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Check for Missing Branch'

	SELECT     
		@nRowCount = COUNT(*)     
	FROM         
		BRS_Transaction AS t 

	WHERE
		t.FiscalMonth = @nFiscalMonth AND
		t.Branch = ''

	Set @nExceptionCount = @nExceptionCount + @nRowCount

	IF (@nRowCount > 0)
		Set @sMessage = @sMessage + ', Missing-Branch' 

	if (@bDebug <> 0)
		Print @nRowCount

End

-- Changed Branch
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Check for Changed Branch'

	SELECT     
		@nRowCount = COUNT(*)     
	FROM         
		BRS_Transaction AS t 

		INNER JOIN BRS_Customer AS c 
		ON t.Shipto = c.ShipTo 

--	25 Feb 16	tmc		Fix Branch change bug
		INNER JOIN BRS_FSC_Rollup AS f 
		ON c.TerritoryCd = f.TerritoryCd
--		ON t.TerritoryCd = f.TerritoryCd AND 
--			t.TerritoryORG = f.TerritoryCd AND 
	WHERE
		t.FiscalMonth = @nFiscalMonth AND
		t.DocType <> 'AA' AND
		t.Branch <> f.Branch

	Set @nExceptionCount = @nExceptionCount + @nRowCount

	IF (@nRowCount > 0)
		Set @sMessage = @sMessage + ', Changed-Branch' 

	if (@bDebug <> 0)
		Print @nRowCount

End

--
-- Map DW to DS
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Map DW to DS'


	Set @nExceptionCount = @nExceptionCount + @nRowCount

	UPDATE
		BRS_Transaction
	SET
		ID_source_ref = dw.ID
	FROM
		BRS_Transaction 
		INNER JOIN BRS_TransactionDW AS dw 
		ON BRS_Transaction.LineNumber = dw.LineNumber AND BRS_Transaction.DocType = dw.DocType AND BRS_Transaction.SalesOrderNumber = dw.SalesOrderNumber
	WHERE
		(BRS_Transaction.DocType NOT IN ('AA', 'SX')) AND 
		(BRS_Transaction.GLBU_Class NOT IN ('FREIG', 'FRTEQ')) AND 
		(BRS_Transaction.ID_source_ref IS NULL) AND
		(BRS_Transaction.FiscalMonth = @nFiscalMonth) AND
		(1=1)
End

--
	if (@bDebug <> 0) 
	Begin
		Print @sMessage
		Print @nExceptionCount
	End



------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BRS_SalesDay.StatusCd'	

		Update
			BRS_SalesDay
		Set 
			StatusCd = CASE WHEN @nExceptionCount = 0 THEN 20 ELSE 15 END
		Where 
			SalesDate = @dtSalesDay
	
		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BRS_Config.StatusCd.Exception'	

		Update
			BRS_Config
		Set 
			ExceptionCd = @nExceptionCount,
			ExceptionNote = @sMessage
	
		Set @nErrorCode = @@Error
	End


	if (@bDebug <> 0)
		Set @nErrorCode = 512


-- Call error message on Error
	if (@nErrorCode <> 0)
	Begin
		Set @sMessage = '[BRS_BE_Transaction_post_proc]'
		Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'
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

-- Prod Run
-- [BRS_BE_Transaction_post_proc] @bDebug=0

-- Debug Run
-- [BRS_BE_Transaction_post_proc] @bDebug=1


