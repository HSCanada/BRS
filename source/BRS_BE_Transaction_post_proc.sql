

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
--	21 Jun 22	tmc		Patch SM logic to fix ZahnSM and 123Dental priors
--  18 Jan 23	tmc		add Heartland VPA to logic
--  15 Sep 23	tmc		add new Segment logic
--	02 Mar26	tmc		add multisite rule tracking to help fix bugs
**    
*******************************************************************************/
BEGIN

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)
Declare @sMS_Rule varchar(255)



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
Set @sMS_Rule = ''

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
	Set @sMS_Rule = '01. clear'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = ''
		,SegCd_New = ''
		,adhoc_model_2_text = @sMS_Rule

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '02. Set non Dental based on Division'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = d.MarketClass_New
		,SegCd_New = '' 
		,adhoc_model_2_text = @sMS_Rule

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
	Set @sMS_Rule = '03. Set DCC based on BT=2613256 (Elite)'
	if (@bDebug <> 0)

		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'ELITE'
		,SegCd_New = 'NDSO'
		,adhoc_model_2_text = @sMS_Rule

	WHERE  
		[VPA] in ('DENCORP', '123DNST') AND
		(MarketClass_New = '')

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '04. Set DCC based on BT=2613256 (Zahn -> ZahnSM)'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'ZAHNSM'
		,SegCd_New = 'DSO'
		,adhoc_model_2_text = @sMS_Rule

	WHERE        
		[VPA] in ('DENCORP', '123DNST') AND
		(SalesDivision = 'AAL')

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '05. Set DCC based on VPA (history)'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = BRS_Customer.MarketClass
		,SegCd_New = BRS_Customer.SegCd
		,adhoc_model_2_text = @sMS_Rule

	FROM            
		BRS_Customer 
		INNER JOIN BRS_CustomerVPA s 
		ON BRS_Customer.VPA = s.VPA
	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(BRS_Customer.CustGrpWrk in('Dental Corp', '123 Dentist (Heartland)')) AND
		(BRS_Customer.VPA <> '0') AND 
--		(s.MarketClass <> '') 
		(1=1)

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '06. Set DCC based on Specialty (Various)'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = s.MarketClass_New
		,SegCd_New = s.SegCd_New
		,adhoc_model_2_text = @sMS_Rule

	FROM            
		BRS_Customer 
		INNER JOIN BRS_CustomerSpecialty AS s 
		ON BRS_Customer.Specialty = s.Specialty
	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(BRS_Customer.CustGrpWrk in('Dental Corp', '123 Dentist (Heartland)')) AND
		(s.MarketClass_New <> '') 

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '07. Set DCC based on DSO (Exception)'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'PVTPRC'
		,SegCd_New = ''
		,adhoc_model_2_text = @sMS_Rule

	FROM            
		BRS_Customer 
	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(BRS_Customer.CustGrpWrk in('Dental Corp', '123 Dentist (Heartland)')) AND
		(BRS_Customer.Specialty = 'DSO')

	Set @nErrorCode = @@Error
End
	

-- AO BT Set
If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '08. Set Alpha Omega based on BT=1765054'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'MIDMKT'
		,SegCd_New = 'RDSO'
		,adhoc_model_2_text = @sMS_Rule

	WHERE        
		(BillTo = 1765054) AND 
		(MarketClass_New = '')

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '09. Set Dental Students - Primary (INSTIT)'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'INSTIT'
		,SegCd_New = 'PDS'
		,adhoc_model_2_text = @sMS_Rule

	WHERE        
		(Specialty	= 'STUD') AND 
		(MarketClass_New = '')

	Set @nErrorCode = @@Error
End



If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '10. Set Dental Students (INSTIT)'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'INSTIT'
		,SegCd_New = 'DSH'
		,adhoc_model_2_text = @sMS_Rule

	WHERE        
		(Specialty	= 'STUA') AND 
		(MarketClass_New = '')

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '11. Zahn SM Exception'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'ZAHNSM'
		,SegCd_New = 'DSO'
		,adhoc_model_2_text = @sMS_Rule

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
	Set @sMS_Rule = '12. MM Groups with VPAs'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = g.MarketClass_New 
		,SegCd_New = g.SegCd_New
		,adhoc_model_2_text = @sMS_Rule

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
	Set @sMS_Rule = '13. MM Groups with no VPAs'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = g.MarketClass_New
		,SegCd_New = g.SegCd_New
		,adhoc_model_2_text = @sMS_Rule

	FROM            
		BRS_Customer 
	
		INNER JOIN BRS_CustomerGroup AS g 
		ON BRS_Customer.CustGrpWrk = g.CustGrp

	WHERE        
		(BRS_Customer.MarketClass_New = '') AND 
		(g.MarketClass_New <> '') AND
		(g.CustGrp <> '') 

	Set @nErrorCode = @@Error
End



If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '14. Set No Group based on Specialty'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = s.MarketClass_New 
		,SegCd_New = s.SegCd_New
		,adhoc_model_2_text = @sMS_Rule

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
	Set @sMS_Rule = '15. Zahn SM exception correction'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'MIDMKT'
		,SegCd_New = 'DSO'
		,adhoc_model_2_text = @sMS_Rule

	WHERE        
		(SalesDivision = 'AAD') AND 
		(MarketClass_New = 'ZAHNSM')

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '16. Dental Specialty exception correction'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'PVTPRC'
		,SegCd_New = ''
		,adhoc_model_2_text = @sMS_Rule

	WHERE        
		(SalesDivision = 'AAD') AND 
		(MarketClass_New In ('ANIMAL','MEDICL','ZAHN'))

	Set @nErrorCode = @@Error
End

If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '17. Patch Zahn SM for groups that span Den&Lab'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass_New = 'ZAHNSM' 
		,SegCd_New = 'DSO'
		,adhoc_model_2_text = @sMS_Rule

	-- SELECT *
	FROM            
		BRS_Customer 
		INNER JOIN BRS_CustomerGroup AS g 
		ON BRS_Customer.CustGrpWrk = g.CustGrp
	WHERE        
		(SalesDivision = 'AAL') AND 
		(BRS_Customer.MarketClass_New <> 'ZAHNSM') AND 
		(g.MarketClass_New in( 'ELITE', 'INSTIT', 'MIDMKT', 'ZAHNSM') )

	Set @nErrorCode = @@Error
End




If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		print '16b. Patch non-multisite segments'


	if (@bDebug <> 0)
		print 'PP'

	UPDATE [dbo].[BRS_Customer] SET [SegCd_New]='PP'  WHERE [MarketClass_New] in ('PVTPRC', 'PVTSPC')

	if (@bDebug <> 0)
		print 'PP-default'

	UPDATE [dbo].[BRS_Customer] SET [SegCd_New]='PP'  WHERE [MarketClass_New] = '' and [SalesDivision] = 'AAD'

	if (@bDebug <> 0)
		print 'LAB'

	UPDATE [dbo].[BRS_Customer] SET [SegCd_New]='LAB'  WHERE [MarketClass_New] = 'ZAHN'

	if (@bDebug <> 0)
		print 'ZDSO'

	UPDATE [dbo].[BRS_Customer] SET [SegCd_New]='ZDSO'  WHERE [MarketClass_New] = 'ZAHNSM'

	if (@bDebug <> 0)
		print 'VET'

	UPDATE [dbo].[BRS_Customer] SET [SegCd_New]='VET' WHERE [MarketClass_New] = 'ANIMAL'

	if (@bDebug <> 0)
		print 'MED'

	UPDATE [dbo].[BRS_Customer] SET [SegCd_New]='MED' WHERE [MarketClass_New] = 'MEDICL'

	if (@bDebug <> 0)
		print 'ZTA'

	UPDATE [dbo].[BRS_Customer] SET [SegCd_New]='ZTA'  WHERE [MarketClass_New] = 'ZZEXCL'


	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	Set @sMS_Rule = '18. merge new codes'
	if (@bDebug <> 0)
		print @sMS_Rule

	UPDATE       
		BRS_Customer
	SET                
		MarketClass = MarketClass_New
		,SegCd = SegCd_New
		,adhoc_model_2_text = @sMS_Rule

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

-- remove logic, 21 Jun 22, tmc, why is ID_source_ref removed?
/*
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
*/
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


-- select distinct adhoc_model_2_text from BRS_Customer