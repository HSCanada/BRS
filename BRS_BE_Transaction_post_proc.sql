

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
		Print 'Update FSC Branch (from Cust)...'

	UPDATE    BRS_FSC_Rollup
	SET              Branch = AFLV02CD, StatusCd = -1
	FROM         STAGE_BRS_Customer INNER JOIN
						  BRS_FSC_Rollup ON STAGE_BRS_Customer.AFTRCD = BRS_FSC_Rollup.TerritoryCd
	WHERE Branch <> AFLV02CD

	Set @nErrorCode = @@Error
End

-- Terr Terr

-- Test specialty (see access)


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

-- Do somthing here

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'LOAD NewDay into transaction'



	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Processed'	

		Update
			BRS_SalesDay
		Set 
			StatusCd = 20
		Where 
			SalesDate = @dtSalesDay
	
		Set @nErrorCode = @@Error
	End

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


