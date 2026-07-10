

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE BRS_BE_Transaction_stage_load_proc
	@nRunMode int = 0,
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_BE_Transaction_stage_load_proc
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
**	Date: 05 Jul 26
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
If (@nBatchStatus <15 )
--If (@nBatchStatus <>999)
Begin

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
			Print 'LOAD NewDay into transaction'


	INSERT INTO [dbo].[STAGE_BRS_Transaction] (
		[SHDOCO]
		,[SHDCTO]
		,[SDLNID]
		,[SDAN8]
		,[SDSHAN]
		,[SDLITM]
		,[SDDOC]
		,[SDDCT]
		,[QCAC10]
		,[QCAC08]
		,[QCAC04]
		,[QC$OSC]
		,[SDLNTY]
		,[SDSRP1]
		,[SDGLC]
		,[SHMCU]
		,[SHMCU01]
		,[SDMCU]
		,[SDMCU01]
		,[SDEMCU]
		,[SDEMCU01]
		,[GLANI]
		,[GMDL01]
		,[GLAA]

	)
	SELECT
		SHDOCO
		,SHDCTO
		,SDLNID
		,SDAN8
		,SDSHAN
		,left(SDLITM, 10)
		,SDDOC
		,SDDCT
		,QCAC10
		,QCAC08
		,QCAC04
		,QC$OSC
		,SDLNTY
		,SDSRP1
		,SDGLC
		,SHMCU
		,RTRIM(SHMCU01)
		,SDMCU
		,RTRIM(SDMCU01)
		,SDEMCU
		,RTRIM(SDEMCU01)
		,RTRIM(GLANI)
		,RTRIM(GMDL01)
		,GLAA

	FROM     OPENQUERY(ESYS_PROD, 
				 '	
		SELECT
			*
 		FROM
			HSIUSRFLE.QFMATRIXZ
		 WHERE 
			(1=1)
	')

		Set @nErrorCode = @@Error
	End



	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Processed'	

		Update
			BRS_SalesDay
		Set 
			--	24 Feb 16	tmc		Set Complete status to 1, indicating that a stage load process is required (15)
			StatusCd = 1
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
	Set @sMessage = '[BRS_BE_Transaction_stage_load_proc]'
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

GRANT EXECUTE ON [dbo].[BRS_BE_Transaction_stage_load_proc] TO [maint_role]
GO



-- debug run
-- [BRS_BE_Transaction_stage_load_proc] 

-- prod run
-- [BRS_BE_Transaction_stage_load_proc] 0, 0

-- ORG 13 083



