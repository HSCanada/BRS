

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [nes].[open_order_opordrpt_proc]
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: open_order_opordrpt_proc
**	Desc: Load open EQ 
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
**	Date: 27 Feb 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
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
		Print 'Proc: [nes].[open_order_opordrpt_proc]'
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
			Print 'Add new order_ets...'

			-- order
			INSERT INTO [nes].[order_ets] 
			(
				[ets_num]
				,[note]
			)
			SELECT
				distinct est_num, '' as note
			FROM
				Integration.open_order_opordrpt s
			WHERE NOT EXISTS (SELECT * FROM [nes].[order_ets] d where d.ets_num = s.est_num)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new order_status...'

			-- order
			INSERT INTO [nes].[order_status]
			(
				[order_status_code]
				,[order_status_descr]
			)
			SELECT
				distinct order_status, '' as note
			FROM
				Integration.open_order_opordrpt s
			WHERE NOT EXISTS (SELECT * FROM [nes].[order_status] d where d.[order_status_code] = s.[order_status])

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new order...'

			-- order
			INSERT INTO [nes].[order]
			(
				[work_order_num]
				,[note]
			)
			SELECT
				distinct work_order_num, '' as note
			FROM
				Integration.open_order_opordrpt s
			WHERE NOT EXISTS (SELECT * FROM [nes].[order] d where d.[work_order_num] = s.[work_order_num])

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Add new item_status...'

			-- order
			INSERT INTO [nes].[item_status]
			(
				[item_status]
				,[note]
			)
			SELECT
				distinct item_status, '' as note
			FROM
				Integration.open_order_opordrpt s
			WHERE NOT EXISTS (SELECT * FROM [nes].[item_status] d where d.[item_status] = s.[item_status])

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'LOAD nes.open_order_opordrpt'

		INSERT INTO nes.open_order_opordrpt 
		(
			SalesDate,
			ets_num, 
			line_number, 
			d1_branch, 
			order_status, 
			work_order_num, 
			work_order_date, 
			shipto, 
			install_date, 
			item_status, 
			item, 
			supplier, 
			order_qty, 
			received_qty, 
			received_date, 
			net_sales_amount, 
			extended_cost_amount, 
			ess_code, 
			dts_code, 
			cps_code, 
			fsc_code
		)

		SELECT
			c.SalesDateLastWeekly,
			est_num, 
			line_number, 
			d1_branch, 
			order_status, 
			work_order_num, 
			work_order_date, 
			shipto, 
			install_date, 
			item_status, 
			item, supplier, 
			order_qty, 
			received_qty, 
			received_date, 
			net_sales_amount, 
			extended_cost_amount, 
			ess_code, 
			dts_code, 
			cps_code, 
			fsc_code
		FROM
			Integration.open_order_opordrpt s

			CROSS JOIN
			[dbo].[BRS_Config] c

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
-- SELECT CAST(SalesDateLastWeekly AS Date) FROM BRS_Config


-- prod run 
-- [nes].[open_order_opordrpt_proc] @bDebug=0

-- dev
-- [nes].[open_order_opordrpt_proc] @bDebug=1


