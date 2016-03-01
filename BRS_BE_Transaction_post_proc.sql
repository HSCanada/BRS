

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
		Print 'Customer Update Step 1 - BRS20_qrySpec01a-VPA'

	UPDATE    
		BRS_Customer
	SET              
		SpecialtyWrk = v.Specialty, 
		StatusCd = 10
	FROM         
		BRS_Customer c 

		INNER JOIN BRS_CustomerVPA AS v 
		ON c.VPA = v.VPA AND 
			c.Specialty <> v.Specialty
	WHERE     
		(c.VPA <> '') AND 
		(c.CustGrpWrk = '') AND 
		(v.Specialty <> '')

	Set @nErrorCode = @@Error
End


If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Customer Update Step 2 - BRS21_qrySpec01b-Group update via VPA'

	UPDATE    
		BRS_Customer
	SET              
		CustGrpWrk = g.CustGrp
	FROM         
		BRS_Customer c 

		INNER JOIN BRS_CustomerGroup AS g 
		ON c.VPA = g.VPA AND
			c.CustGrpWrk <> g.CustGrp
	WHERE     
		(c.CustGrpWrk = '') AND 
		(g.VPA <> '') 

	Set @nErrorCode = @@Error
End

-- BRS22_qrySpec02-Group & BRS23_qrySpec03-GroupDSO

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Customer Update Step 3 - BRS22_qrySpec02-Group'

	UPDATE    
		BRS_Customer
	SET              
		SpecialtyWrk = g.Specialty, 
		StatusCd = 10
	FROM         
		BRS_Customer c 

		INNER JOIN BRS_CustomerGroup AS g 
		ON c.CustGrpWrk = g.CustGrp AND
			c.Specialty <> g.Specialty AND
			c.SpecialtyWrk <> g.Specialty 

	WHERE     
		c.CustGrpWrk <> '' AND
		c.Specialty <> 'STUD' 

	Set @nErrorCode = @@Error
End


-- BRS24_qrySpec04-GroupDCCfix (Dental Corp, Fix legacy private practice accounts)
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Customer Update Step 4 - BRS24_qrySpec04-GroupDCCfix'

	UPDATE    
		BRS_Customer
	SET              
		SpecialtyWrk = '',
		StatusCd = 20

	FROM         
		BRS_Customer c 

		INNER JOIN BRS_CustomerGroup AS g 
		ON c.CustGrpWrk = g.CustGrp

	WHERE     
		(c.CustGrpWrk = 'DENTAL CORP') AND 
		(c.BillTo <> 2613256 ) 

	Set @nErrorCode = @@Error
End

-- BRS25_qrySpec05-GroupAOfix (Alpha Omega, Fix legacy private practice accounts)
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Customer Update Step 5 - BRS25_qrySpec05-GroupAOfix'

	UPDATE    
		BRS_Customer
	SET              
		SpecialtyWrk = '',
		StatusCd = 20

	FROM         
		BRS_Customer c 

		INNER JOIN BRS_CustomerGroup AS g 
		ON c.CustGrpWrk = g.CustGrp

	WHERE     
		(c.CustGrpWrk = 'Alpha Omega') AND 
		(c.BillTo <> 1765054 ) 

	Set @nErrorCode = @@Error
End

-- BRS27_qrySpec06-UpdateSpec
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Customer Update Step 6 - BRS27_qrySpec06-UpdateSpec'

	UPDATE    
		BRS_Customer
	SET              
		Specialty = SpecialtyWrk,
		UserAreaTxt = Specialty
	WHERE     
		(SpecialtyWrk <> '') AND 
		(StatusCd = 10) AND
		(Specialty <> SpecialtyWrk)
		

	Set @nErrorCode = @@Error
End

----
-- BRS23_qrySpec09-UpdateCustSeg
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Customer Update Step 7 - BRS23_qrySpec09-UpdateCustSeg'

	UPDATE    
		BRS_Customer
	SET              
		SegCd = s.SegCd
	FROM         
		BRS_Customer c 

		INNER JOIN BRS_CustomerSpecialty AS s 
		ON c.Specialty = s.Specialty AND
			c.SegCd <> s.SegCd
	WHERE     
--	01 Mar 16	tmc		Fixed Customer Segment update bug
		(s.Specialty <> '') 
--		(s.Specialty = '') 

	Set @nErrorCode = @@Error
End

----

-- BRS28_qrySpec07-UpdateMarketGrp
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Customer Update Step 8 - BRS28_qrySpec07-UpdateMarketGrp'

	UPDATE    
		BRS_Customer
	SET              
		MarketClass = g.MarketClass
	FROM         
		BRS_Customer c 

		INNER JOIN BRS_CustomerGroup AS g
		ON c.CustGrpWrk = g.CustGrp AND
			c.MarketClass <> g.MarketClass
	WHERE     
		(c.Specialty <> 'STUD') AND
		(c.CustGrpWrk <> '') 


	Set @nErrorCode = @@Error
End

-- BRS29_qrySpec08-UpdateMarketGrpNON
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Customer Update Step 9 - BRS29_qrySpec08-UpdateMarketGrpNON'

	UPDATE    
		BRS_Customer
	SET              
		MarketClass = s.MarketClass
	FROM         
		BRS_Customer c 

		INNER JOIN BRS_CustomerSpecialty AS s 
		ON c.Specialty = s.Specialty AND
			c.MarketClass <> s.MarketClass
	WHERE 
		((c.Specialty <> 'STUD') AND (c.CustGrpWrk = 'DENTAL CORP') AND (c.BillTo <> 2613256 )) OR
		((c.Specialty <> 'STUD') AND (c.CustGrpWrk = 'Alpha Omega') AND (c.BillTo <> 1765054 )) OR
		((c.Specialty =  'STUD') AND (c.CustGrpWrk <> '')) OR
		((c.CustGrpWrk = '' )) 

	Set @nErrorCode = @@Error
End


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

-- Debug Run
-- [BRS_BE_Transaction_post_proc] 

-- Prod Run
-- [BRS_BE_Transaction_post_proc] 0



