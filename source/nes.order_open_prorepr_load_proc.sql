

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [nes].[order_open_prorepr_load_proc]
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_BE_Transaction_DW_load_proc
**	Desc: Load DW Transactions, in prod 27 Jan 17 
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@bDebug - debug = rollback changes
**
**	Auth: tmc
**	Date: 16 Sep 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**  21 Aut 19	tmc		add auto [call_type_code] load 
*******************************************************************************/
BEGIN

	Declare @nErrorCode int, @nTranCount int
	Declare @nRowCount int
	Declare @sMessage varchar(255)

	Set @nErrorCode = @@Error
	Set @nTranCount = @@Trancount
	Set @nRowCount = 0

	if (@bDebug <> 0) 
	Begin
		Print '---------------------------------------------------------'
		Print 'Proc: [nes].[order_open_prorepr_load_proc]'
		Print 'Desc: Update prorepair snapshot'
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
			Print 'Add new workorder...'

			-- order
			INSERT INTO [nes].[order]
			([work_order_num], [note])
			SELECT 
			DISTINCT [work_order_num], ''
			FROM [Integration].[open_order_prorepr] s
			WHERE NOT EXISTS(
			  SELECT * FROM [nes].[order] o where o.work_order_num = s.work_order_num
			)
		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new user...'
		-- user
		INSERT INTO [nes].[user_login]
		SELECT 
		DISTINCT [d1_user_id], '', '', ''
		FROM [Integration].[open_order_prorepr] s
		WHERE NOT EXISTS(
		  SELECT * FROM [nes].user_login u where u.user_id = s.d1_user_id
		)

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new EST...'
		-- EST
		INSERT INTO [dbo].[BRS_FSC_Rollup]
		([TerritoryCd], [Branch],[group_type] )
		SELECT 
		DISTINCT [est_num], '', 'DEST'
		FROM [Integration].[open_order_prorepr] s
		WHERE NOT EXISTS(
		  SELECT * FROM [dbo].[BRS_FSC_Rollup] f where f.TerritoryCd = s.est_num
		)

 		Set @nErrorCode = @@Error
	End


	-- ESS
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new order_status...'

		-- order status
		INSERT INTO [nes].[order_status]
		([order_status_code], [order_status_descr] )
		SELECT 
		distinct [order_status], ''
		FROM Integration.open_order_prorepr s
		where not exists (
		select * from [nes].[order_status] c where s.[order_status] = c.[order_status_code]
		)

		Set @nErrorCode = @@Error
	End


	-- nes.call_type
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new call_type...'

		-- order status
		INSERT INTO [nes].[call_type]
		([call_type_code], [call_type_descr] )
		SELECT 
		distinct [call_type_code], ''
		FROM Integration.open_order_prorepr s
		where not exists (
		select * from [nes].[call_type] c where s.[call_type_code] = c.[call_type_code]
		)

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'LOAD nes.order_open_prorepr'

		INSERT INTO 
			nes.order_open_prorepr 
			(
				work_order_num
				,branch_code
				,rma_code
				,order_status_code
				,order_received_date
				,estimate_complete_date
				,approved_date
				,order_complete_date
				,shipto
				,privileges_code
				,model_number
				,est_code
				,call_type_code
				,problem_code
				,cause_code
				,user_id
				,approved_part_release_date
				,SalesDate
				,last_update_date
			)
		SELECT
			s.work_order_num
			,UPPER(s.d1_branch)				AS d1_branch
			,UPPER(CASE 
				WHEN s.[rma_code] <> '' 
				THEN s.[rma_code] 
				ELSE 'NO' 
			END)							AS rma_code
			,UPPER(s.order_status)			AS order_status
			,s.order_received_date
			,s.estimate_complete_date
			,s.approved_date
			,s.order_complete_date
			,s.shipto
			,s.priv_code
			,s.model_number
			,s.est_num
			,UPPER(s.call_type_code)		AS call_type_code
			,UPPER(s.problem_code)			AS problem_code
			,UPPER(s.cause_code)			AS cause_code
			,s.d1_user_id
			,s.approved_part_release_date
			,BRS_Config.SalesDate
			,COALESCE ( 
				s.order_complete_date, 
				s.approved_part_release_date,
				s.approved_date, 
				s.estimate_complete_date, 
				s.order_received_date
			)
		FROM
			Integration.open_order_prorepr AS s 
		CROSS JOIN 
			BRS_Config

		Select @nErrorCode = @@Error, @nRowCount = @@Rowcount
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Clear Integration.open_order_prorepr'	

		Delete FROM Integration.open_order_prorepr

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
		Set @sMessage = '[nes].[order_open_prorepr_load_proc]'
		Set @sMessage = @sMessage + ':  Return(' + Convert(varchar, @nErrorCode) + ')'

		Set @sMessage = @sMessage +  ', ' + convert(varchar, @bDebug)

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


-- Test logic
-- ensure date is last business day
-- SELECT SalesDateLastWeekly FROM BRS_Config


-- prod run 
-- [nes].[order_open_prorepr_load_proc] @bDebug=0

-- [nes].[order_open_prorepr_load_proc] @bDebug=1


