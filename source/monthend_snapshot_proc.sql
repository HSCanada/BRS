SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[monthend_snapshot_proc] 
	@bDebug as smallint = 1,
	@bClearStage as smallint = 0
AS
/******************************************************************************
**	File:	
**	Name: comm_transaction_load_proc
**	Desc: copy commission tranaction from stage to prod (port from legacy)
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
**	Date: 28 May 20
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
	Print 'Proc: monthend_snapshot_proc'
	Print 'Desc: copy key state for ME processing'
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
		@nBatchStatus = [me_status_cd]
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
	Print 'Checking steps 1 - xx'
End


If (@nBatchStatus <>999)
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
		FROM  [Integration].F555115_commission_sales_extract_Staging t
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
		FROM  [Integration].F555115_commission_sales_extract_Staging t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_TransactionDW_Ext] s
			WHERE t.WSDOCO_salesorder_number = s.SalesOrderNumber
		) AND
		[WSAC10_division_code] NOT IN ('AZA','AZE')

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 2

	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '3. check - [WSSHAN_shipto] - current'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].F555115_commission_sales_extract_Staging t
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
		FROM  [Integration].F555115_commission_sales_extract_Staging t

			INNER JOIN BRS_SalesDay AS d 
			ON t.WSDGL__gl_date = d.SalesDate

		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_CustomerFSC_History] s
			WHERE 
				t.WSSHAN_shipto = s.ShipTo AND
				d.FiscalMonth = s.FiscalMonth 
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
		FROM  [Integration].F555115_commission_sales_extract_Staging t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_Item] s
			WHERE t.WSLITM_item_number = s.Item
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 5
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '6. check - [WS$ESS_equipment_specialist_code]'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].F555115_commission_sales_extract_Staging t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_FSC_Rollup] s
			WHERE t.WS$ESS_equipment_specialist_code = s.[TerritoryCd]
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 6
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '7. check - [WSCAG__cagess_code]'

		SELECT @nRowCount = COUNT(*)
		-- select *
		FROM  [Integration].F555115_commission_sales_extract_Staging t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_FSC_Rollup] s
			WHERE t.WSCAG__cagess_code = s.[TerritoryCd]
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 7
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '8. check - [WSSIC__speciality]'

		SELECT @nRowCount = COUNT(*)
--		SELECT distinct t.WSSIC__speciality
		FROM  [Integration].F555115_commission_sales_extract_Staging t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_CustomerSpecialty] s
			WHERE t.WSSIC__speciality = s.Specialty
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 8
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '9. check - [WS$SPC_supplier_code]'

		SELECT 
			@nRowCount = COUNT(*)
--		SELECT	distinct t.WS$SPC_supplier_code
		FROM  [Integration].F555115_commission_sales_extract_Staging t
		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_ItemSupplier] s
			WHERE t.WS$SPC_supplier_code = s.Supplier
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 9
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '10. check - [WSLITM_item_number] - history'

		SELECT @nRowCount = COUNT(*)
--		SELECT	*
		FROM  [Integration].F555115_commission_sales_extract_Staging t

			INNER JOIN BRS_SalesDay AS d 
			ON t.WSDGL__gl_date = d.SalesDate

		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_ItemHistory] s
			WHERE 
				t.WSLITM_item_number = s.[Item] AND
				d.FiscalMonth = s.FiscalMonth 
		)

		Set @nErrorCode = @@Error
		If @nRowCount > 0 Set @nErrorCode = 10
	End

-----------------------------
-- DATA - Load New-to-New
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '11. load new data source'

--		sql
		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- DATA - Load NEW - post data cleanup 
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			print '12. fix missed ESS / CCS code from download'

		UPDATE
			comm.transaction_F555115
		SET
			ess_code = WSTKBY_order_taken_by
		FROM
			comm.transaction_F555115 t 
		WHERE     
			(t.source_cd = 'JDE') AND (
				(t.WSTKBY_order_taken_by like 'ESS%') OR
				(t.WSTKBY_order_taken_by like 'CCS%') 
			) AND
			ISNULL(ess_code,'') <> WSTKBY_order_taken_by AND
			(t.FiscalMonth = @nCurrentFiscalYearmoNum ) AND
			(1 = 1)

		Set @nErrorCode = @@Error
	End

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print '13. Booking GP Correction'

		UPDATE    
			comm.transaction_F555115
		SET              
			[gp_ext_amt] = ROUND([transaction_amt] * (g.booking_rt / 100.0), 2),
			[gp_ext_org_amt] = [gp_ext_amt]
		FROM         
			comm.transaction_F555115 as t

			INNER JOIN [dbo].[BRS_ItemHistory] as i
			ON i.[Item] = t.[WSLITM_item_number] AND
			i.FiscalMonth = t.FiscalMonth

			INNER JOIN [comm].[group] AS g 
			ON i.HIST_comm_group_cd = g.comm_group_cd

		WHERE 
			(t.source_cd = 'JDE') AND
			(t.[gp_ext_org_amt] IS NULL) AND -- only run once
			(g.booking_rt > 0)  AND 
			(t.[FiscalMonth] = @nCurrentFiscalYearmoNum ) AND
			(1=1)

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------
-- DATA - Load Success Cleanup - clear stage to avoid double loading
------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0 AND @bClearStage = 1) 
	Begin
		if (@bDebug <> 0)
			Print '14. Clear STAGE'
		-- warning, this will clear all stage if multi months used.
		-- default option is not clear, so leaving for now
		Delete FROM Integration.F555115_commission_sales_extract_Staging

		Set @nErrorCode = @@Error
	End

------------------------------------------------------------------------------------------------------------
-- Wrap-up routines.  
------------------------------------------------------------------------------------------------------------

	If (@nErrorCode = 0) 
	Begin
		if (@bDebug <> 0)
			Print 'Set BatchStatus to Snapshot'	

		Update
			[dbo].[BRS_FiscalMonth]
		Set 
			[me_status_cd] = 5
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
	Set @sMessage = 'monthend_snapshot_proc'
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

-- UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202006

-- Debug
-- EXEC dbo.monthend_snapshot_proc @bDebug=1

-- Prod
-- EXEC dbo.monthend_snapshot_proc @bDebug=0

