SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [comm].[adjustment_load_proc] 
	@bDebug as smallint = 1,
	@bClearStage as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: comm_transaction_load_proc
**	Desc: load adjustment from stage to prod, 
**			based on comm_transaction_load_proc
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
**	Date: 31 Jan 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int, @nRowCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount
Set @nRowCount	= @@ROWCOUNT

Declare @nCurrentFiscalYearmoNum int
Declare @nBatchStatus int

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: comm_adjustment_load_proc'
	Print 'Desc: load adjustment from stage to prod'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

Set @nCurrentFiscalYearmoNum = -1
Set @nBatchStatus = -1

-- Start transaction
if (@nTranCount = 0)
	Begin Tran mytran
Else
	Save Tran mytran

If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get Current Fiscal Month'

	Select 	
		@nCurrentFiscalYearmoNum = [PriorFiscalMonth]
	From 
		[dbo].[BRS_Config]

	Set @nErrorCode = @@Error
End

	
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get BatchStatus'

	Select 	
		@nBatchStatus = [comm_status_cd]
	From 
		[dbo].[BRS_FiscalMonth]
	Where
		[FiscalMonth] = @nCurrentFiscalYearmoNum
	
	Set @nErrorCode = @@Error
End

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

if (@bDebug <> 0)
Begin
	Print 'Confirm BatchStatus NOT locked'
	Print @nCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
	Print 'Checking steps 1 - 8'
End

-- only run once
If (@nBatchStatus < 10 or @nBatchStatus = 999)
Begin
	print 'Exiting:  cannot run load more than once!'
	Set @nErrorCode = 999
End
Else
Begin


------------------------------------------------------------------------------------------------------
-- DATA - Load NEW - pre.  Fail if missing RI data
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '1. check - [SalesDate]'

		SELECT    @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].[comm_adjustment_Staging] t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_SalesDay] s
			WHERE t.WSDGL__gl_date = s.SalesDate
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 1
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '2. check - [WSDOCO_salesorder_number]'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].[comm_adjustment_Staging] t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_TransactionDW_Ext] s
			WHERE t.WSDOCO_salesorder_number = s.SalesOrderNumber
		) AND
		-- [WSAC10_division_code] NOT IN ('AZA','AZE') AND
		(1=1)

		Set @nErrorCode = @@Error
		If @nRowCount > 0
		Begin
			Set @nErrorCode = 2
			if (@bDebug <> 0)
				print 'bad row count='  + CONVERT(varchar(10),@nRowCount) +	'rows'
		End

	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '3. check - [WSSHAN_shipto] - current'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].[comm_adjustment_Staging] t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_Customer] s
			WHERE t.WSSHAN_shipto = s.ShipTo
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 3
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '4. check - [WSSHAN_shipto] - history'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].[comm_adjustment_Staging] t

			INNER JOIN BRS_SalesDay AS d 
			ON (t.WSDGL__gl_date = d.SalesDate) AND
				(d.FiscalMonth = @nCurrentFiscalYearmoNum) AND
				(1=1)

		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_CustomerFSC_History] s
			WHERE 
				(t.WSSHAN_shipto = s.ShipTo) AND
				(d.FiscalMonth = s.FiscalMonth) AND
				(1=1)
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 4
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '5. check - [WSLITM_item_number]'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].[comm_adjustment_Staging] t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_Item] s
			WHERE ISNULL(NULLIF(t.[WSLITM_item_number],'.'),'') = s.Item
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 5
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '6. check - [fsc_code]'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].[comm_adjustment_Staging] t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_FSC_Rollup] s
			WHERE ISNULL(NULLIF(t.[fsc_code],'.'),'') = s.[TerritoryCd]
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 6
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '7. check - [ess_code]'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].[comm_adjustment_Staging] t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_FSC_Rollup] s
			WHERE ISNULL(NULLIF(t.[ess_code],'.'),'') = s.[TerritoryCd]
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 7
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '8. check - [WSLITM_item_number] - history'

		SELECT @nRowCount = COUNT(*)
--		SELECT	*
		FROM  [Integration].[comm_adjustment_Staging] t

			INNER JOIN BRS_SalesDay AS d 
			ON t.WSDGL__gl_date = d.SalesDate AND
				(d.FiscalMonth = @nCurrentFiscalYearmoNum) AND
				(1=1)

		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_ItemHistory] s
			WHERE 
				(s.[Item] = ISNULL(NULLIF(t.[WSLITM_item_number],'.'),'')) AND
				(s.FiscalMonth = @nCurrentFiscalYearmoNum)
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 8
	End

-----------------------------
-- DATA - Load New-to-New
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '11. load new data source'

			-- handle FTA

		INSERT INTO comm.transaction_F555115
		(
			[FiscalMonth]
			,[WSVR01_reference]				-- [owner_code]
			,WSLNID_line_number
			,[WSOGNO_original_line_number]	-- [original_line_number]
			,[fsc_code]
			,[fsc_comm_group_cd]
			,[fsc_salesperson_key_id]
			,[ess_code]
			,[ess_comm_group_cd]
			,[ess_salesperson_key_id]
			,[WSSHAN_shipto]				-- [ShipTo]
			,[WSVR02_reference_2]			-- [customer_name]
			,[WSDOC__document_number]		-- [salesorder_num]
			,[WSDCTO_order_type]			-- [order_type]
			,[WSLITM_item_number]			-- [item_id]
			,[WSDSC1_description]			-- [details]
			,WSDGL__gl_date					-- [transaction_date]
			,[transaction_amt]
			,[gp_ext_amt]
			,[WS$UNC_sales_order_cost_markup]	-- [file_cost_amt]
			,[fsc_comm_amt]
			,ID_legacy						-- [ID]
			,[source_cd]
			,[WSSRP6_manufacturer]			-- [adj_type_code]
			,[cust_comm_group_cd]
			,[item_comm_group_cd]
			,WSCYCL_cycle_count_category	-- [gp_code]
			,[WSURAT_user_reserved_amount]	-- [ma_estimate_factor]
			,[WS$NM3_researched_by]			-- [comm_note_txt]
			,[isr_code]
			,[isr_comm_group_cd]
			,[isr_salesperson_key_id]
			,[eps_code]
			,[eps_comm_group_cd]
			,[eps_salesperson_key_id]
			,[est_code]
			,[est_comm_group_cd]
			,[est_salesperson_key_id]
			,[cps_code]
			,[cps_comm_group_cd]
			,[cps_salesperson_key_id]
			,[WSDOCO_salesorder_number]
			-- add plans
			,[fsc_comm_plan_id]
			,[ess_comm_plan_id]
			,[isr_comm_plan_id]
			,[eps_comm_plan_id]
			,[est_comm_plan_id]
			,[cps_comm_plan_id]
		)
		SELECT        
			-- TOP (10) 

			[FiscalMonth]
			,[owner_code]
			,[ID] + 2000000000
			,[original_line_number]
			,[fsc_code]
			,[fsc_comm_group_cd]
			,[fsc_salesperson_key_id]
			,[ess_code]
			,[ess_comm_group_cd]
			,[ess_salesperson_key_id]
			,[ShipTo]
			,[customer_name]
			,[salesorder_num]
			,[order_type]
			,[item_id]
			,[details]
			,[transaction_date]
			,[transaction_amt]
			,[gp_ext_amt]
			,[file_cost_amt]
			,[fsc_comm_amt]
			,ID_legacy
			,[source_cd]
			,[adj_type_code]
			,[cust_comm_group_cd]
			,[item_comm_group_cd]
			,[gp_code]
			,[ma_estimate_factor]
			,LEFT([comm_note_txt],30)
			,[isr_code]
			,[isr_comm_group_cd]
			,[isr_salesperson_key_id]
			,[eps_code]
			,[eps_comm_group_cd]
			,[eps_salesperson_key_id]
			,[est_code]
			,[est_comm_group_cd]
			,[est_salesperson_key_id]
			,[cps_code]
			,[cps_comm_group_cd]
			,[cps_salesperson_key_id]
			,[WSDOCO_salesorder_number]

			-- add plans
			,[fsc_comm_plan_id]
			,[ess_comm_plan_id]
			,[isr_comm_plan_id]
			,[eps_comm_plan_id]
			,[est_comm_plan_id]
			,[cps_comm_plan_id]

		FROM
			[comm].[adjustment_export] s 
--		WHERE [gp_ext_amt] is null
			

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- DATA - Load NEW - post data cleanup 
------------------------------------------------------------------------------------------------------

-- update adjustment support table
	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '14. load adjustments into lookup table'

		INSERT INTO [comm].[adjustment]
		(
			[adj_comment_org]
			,[adj_source_org]
			,[source_cd]
		)
		SELECT DISTINCT  
			  ISNULL(s.[WSDSC1_description],'') adj_comment_org
			  ,UPPER(ISNULL(s.[WSVR01_reference],'')) adj_source_org
			  ,source_cd
		FROM [comm].[transaction_F555115] s
		WHERE 
			(s.source_cd <> 'JDE') AND
			(s.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			NOT EXISTS
			(
				SELECT * FROM [comm].[adjustment] d 
				WHERE
					(d.[adj_comment_org] = ISNULL(s.[WSDSC1_description],'')) AND
					(d.[adj_source_org] = UPPER(ISNULL(s.[WSVR01_reference],'')))
			) 

		Set @nErrorCode = @@Error
	End

--

------------------------------------------------------------------------------------------------------
-- DATA - Load Success Cleanup - clear stage to avoid double loading
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0 AND @bClearStage = 1) 
	Begin
		if (@bDebug <> 0)
			Print 'Clear STAGE'
		-- warning, this will clear all stage if multi months used.
		-- default option is not clear, so leaving for now
		Delete FROM [Integration].[comm_adjustment_Staging] where FiscalMonth = @nCurrentFiscalYearmoNum

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Processed'	

		Update
			[dbo].[BRS_FiscalMonth]
		Set 
			[comm_status_cd] = 10
		Where 
			[FiscalMonth] = @nCurrentFiscalYearmoNum
	
		Set @nErrorCode = @@Error
	End

End


-- force error in debug
if (@bDebug <> 0 AND @nErrorCode = 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'comm_adjustment_load_proc'
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
GO

-- Prod
-- EXEC comm.adjustment_load_proc @bDebug=0, @bClearStage=0
-- EXEC comm.adjustment_load_proc @bDebug=0, @bClearStage=1

-- Debug, 6m
-- EXEC comm.adjustment_load_proc @bDebug=1, @bClearStage=0

