
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [comm].[transaction_load_proc] 
	@bDebug as smallint = 1
AS
/******************************************************************************
**	File:	
**	Name: comm_transaction_load_proc
**	Desc: copy commission tranaction from stage to prod
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
**	Date: 11 Nov 10
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
** 	4 Aug 09	tmc		Added new fields, 
** 	1 Dec 09	tmc		Added Commit reminder
** 	28 Oct 10	tmc		Added item null map to ''
**	16 Nov 10	tmc		Fixed bug where load only worked first time
--  30 Jan 16	tmc		Update for new comm codes
--	24 Feb 16	tmc		Finalize Automation, remove legacy, and set Debug to default
--	27 Dec 17	tmc		port to new backend

**    
*******************************************************************************/

Declare @nErrorCode int, @nTranCount int
Declare @sMessage varchar(255)

Set @nErrorCode = @@Error
Set @nTranCount = @@Trancount

Declare @sCurrentFiscalYearmoNum char(6)
Declare @nBatchStatus int

SET NOCOUNT ON;
if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0) 
Begin
	Print '---------------------------------------------------------'
	Print 'Proc: comm_transaction_load_proc'
	Print 'Desc: copy commission tranaction from stage to prod'
	Print 'Mode: DEBUG'
	Print '---------------------------------------------------------'
End

------------------------------------------------------------------------------------------------------------
-- Init routines.  
------------------------------------------------------------------------------------------------------------

Set @sCurrentFiscalYearmoNum = ''
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
		@sCurrentFiscalYearmoNum = current_fiscal_yearmo_num
	From 
		comm_configure

	Set @nErrorCode = @@Error
End

	
If (@nErrorCode = 0) 
Begin
	if (@bDebug <> 0)
		Print 'Get BatchStatus'

	Select 	
		@nBatchStatus = status_cd
	From 
		comm_batch_control
	Where
		fiscal_yearmo_num = @sCurrentFiscalYearmoNum
	
	Set @nErrorCode = @@Error
End

------------------------------------------------------------------------------------------------------------
-- Update routines.  
------------------------------------------------------------------------------------------------------------

if (@bDebug <> 0)
Begin
	Print 'Confirm BatchStatus NOT locked'
	Print @sCurrentFiscalYearmoNum
	Print Convert(varchar, @nBatchStatus)
End


If (@nBatchStatus <>999)
Begin

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Copy STAGE to PROD'

		INSERT INTO comm_transaction
		(
			transaction_dt, 
			salesperson_cd, 
			source_cd, 
			transaction_amt, 
			doc_key_id, 
			line_id, 
			doc_id, 
			order_id, 
			reference_order_txt, 
			order_source_cd, 
			customer_nm, 
			item_id, 
			shipped_qty, 
			price_override_ind, 
			transaction_txt, 
			audit_id, 
			fiscal_yearmo_num,
			comm_amt,
			salesperson_key_id,
			item_comm_group_cd,
			status_cd,

			-- Added for ESS plan, 26 Feb 07, tmc
			gp_ext_amt,
			tax_gst_amt,
			tax_pst_amt,
			doc_type_cd,

			hsi_shipto_id,

			-- Added for ESS adjustments, 2 May 08
			ess_salesperson_key_id,
			ess_comm_group_cd

			-- Added new fields, 4 Aug 09 tmc
			,[cost_unit_amt]
			,[item_label_cd]
			,[cost_ext_amt]
			,[IMCLMJ]
			,[IMCLSJ]
			,[IMCLMC]
			,[IMCLSM]
			,[file_cost_ext_amt]
			,[ess_salesperson_cd]
			,[pmts_salesperson_cd]
			,[hsi_billto_id]
			,[hsi_billto_nm]
			,[hsi_billto_div_cd]
			,[hsi_shipto_div_cd]
			,[hsi_shipto_nm]
			,[file_cost_unit_amt]
			,[land_cost_unit_amt]
			,[avg_cost_unit_amt]
			,[comm_cost_unit_amt]
			,[vpa_cd]
			,[vpa_desc]
			,[manufact_cd]
			,[sales_category_cd]
			,[privileges_cd]
			,[price_method_cd]
			,[customer_po_num]

		)
		SELECT     
			transaction_dt, 
			IsNull(salesperson_cd, '') as salesperson_cd, 
			source_cd, 
			transaction_amt, 
			doc_key_id, 
			line_id, 
			doc_id, 
			order_id, 
			reference_order_txt, 
			IsNull(order_source_cd, '') AS order_source_cd, 
			customer_nm, 
			IsNull(item_id,'') as item_id, 
			shipped_qty, 
			price_override_ind, 
			Left(transaction_txt,40) as transaction_txt, 
			isNull(audit_id, 0) as audit_id, 
			fiscal_yearmo_num,
			IsNull(comm_amt, 0) as comm_amt,

			IsNull(salesperson_key_id, '') as salesperson_key_id,
			IsNull(comm_group_cd, '') as item_comm_group_cd,
			status_cd,

			-- Added for ESS plan, 26 Feb 07, tmc
			IsNull(gp_ext_amt, 0) as gp_ext_amt,
			IsNull(tax_gst_amt, 0) as tax_gst_amt,
			IsNull(tax_pst_amt, 0) as tax_pst_amt,
			IsNull(doc_type_cd, '')as doc_type_cd,

			IsNull(hsi_shipto_id, 0) as hsi_shipto_id,

			-- Added for ESS adjustments, 2 May 08 
			IsNull(salesperson_ess_key_id, '') as salesperson_ess_key_id,
			IsNull(ess_comm_group_cd, '') as ess_comm_group_cd

			-- Added new fields, 4 Aug 09 tmc
			,IsNull([cost_unit_amt],0) AS cost_unit_amt
			,IsNull([item_label_cd], '') as item_label_cd
			,IsNull([cost_ext_amt], 0) as cost_ext_amt
			,IsNull([IMCLMJ], '') as IMCLMJ
			,IsNull([IMCLSJ], '') as IMCLSJ
			,IsNull([IMCLMC], '') as IMCLMC
			,IsNull([IMCLSM], '') as IMCLSM
			,IsNull([file_cost_ext_amt], 0) as file_cost_ext_amt
			,IsNull([ess_salesperson_cd], '') as ess_salesperson_cd
			,IsNull([pmts_salesperson_cd], '') as pmts_salesperson_cd
			,IsNull([hsi_billto_id], 0) as hsi_billto_id
			,IsNull([hsi_billto_nm], '') as hsi_billto_nm
			,IsNull([hsi_billto_div_cd], '') as hsi_billto_div_cd
			,IsNull([hsi_shipto_div_cd], '') as hsi_shipto_div_cd
			,IsNull([hsi_shipto_nm], '') as hsi_shipto_nm
			,IsNull([file_cost_unit_amt], 0) as file_cost_unit_amt
			,IsNull([land_cost_unit_amt], 0) as land_cost_unit_amt
			,IsNull([avg_cost_unit_amt], 0) as avg_cost_unit_amt
			,IsNull([comm_cost_unit_amt], 0) as comm_cost_unit_amt
			,IsNull([vpa_cd], '') as vpa_cd
			,IsNull([vpa_desc], '') as vpa_desc
			,IsNull([manufact_cd], '') as manufact_cd
			,IsNull([sales_category_cd], '') as sales_category_cd
			,IsNull([privileges_cd], '') as privileges_cd
			,IsNull([price_method_cd], '') as price_method_cd
			,IsNull([customer_po_num], '') as customer_po_num
		FROM         
			comm_transaction_stage
		WHERE     
			(1=1)

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Clear STAGE'
		
		Delete FROM comm_transaction_stage

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
			comm_batch_control
		Set 
			status_cd = 10
		Where 
			fiscal_yearmo_num = @sCurrentFiscalYearmoNum
	
		Set @nErrorCode = @@Error
	End

End


if (@bDebug <> 0)
	Set @nErrorCode = 512

-- Call error message on Error
if (@nErrorCode <> 0)
Begin
	Set @sMessage = 'comm_transaction_load_proc'
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
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Debug
-- EXEC comm_transaction_load_proc