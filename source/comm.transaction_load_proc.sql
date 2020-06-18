SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [comm].[transaction_load_proc] 
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
	Print 'Proc: comm_transaction_load_proc'
	Print 'Desc: copy commission tranaction from stage to prod'
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
	Print 'Checking steps 1 - 10'
End


If (@nBatchStatus=0)
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
			ON t.WSDGL__gl_date = d.SalesDate AND
				(d.FiscalMonth = @nCurrentFiscalYearmoNum) AND
				(1=1)

		WHERE NOT EXISTS
		(
			SELECT * FROM [dbo].[BRS_ItemHistory] s
			WHERE 
				(s.[Item] = t.WSLITM_item_number) AND
				(s.FiscalMonth = @nCurrentFiscalYearmoNum)
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

		INSERT INTO comm.transaction_F555115
		(
			FiscalMonth,
			WSCO___company,
			WSDOCO_salesorder_number,
			WSDCTO_order_type,
			WSLNTY_line_type,
			WSLNID_line_number,
			WS$OSC_order_source_code,
			WSAN8__billto,
			WSSHAN_shipto,
			WSDGL__gl_date,
			WSLITM_item_number,
			WSDSC1_description,
			WSDSC2_description_2,
			WSSRP1_major_product_class,
			WSSRP2_sub_major_product_class,
			WSSRP3_minor_product_class,
			WSSRP6_manufacturer,
			WSUORG_quantity,
			WSSOQS_quantity_shipped,
			WSAEXP_extended_price,
			WSURAT_user_reserved_amount,
			WS$UNC_sales_order_cost_markup,
			WSOORN_original_order_number,
			WSOCTO_original_order_type,
			WSOGNO_original_line_number,
			WSTRDJ_order_date,
			WSVR01_reference,
			WSVR02_reference_2,
			WSITM__item_number_short,
			WSPROV_price_override_code,
			WSASN__adjustment_schedule,
			WSKCO__document_company,
			WSDOC__document_number,
			WSDCT__document_type,
			WSPSN__pick_slip_number,
			WSROUT_ship_method,
			WSZON__zone_number,
			WSFRTH_freight_handling_code,
			WSFRAT_rate_code_freightmisc,
			WSRATT_rate_type_freightmisc,
			WSGLC__gl_offset,
			WSSO08_price_adjustment_line_indicator,
			WSENTB_entered_by,
			WS$PMC_promotion_code_price_method,
			WSTKBY_order_taken_by,
			WSKTLN_kit_master_line_number,
			WSCOMM_committed_hs,
			WSEMCU_header_business_unit,
			WS$SPC_supplier_code,
			WS$VCD_vendor_code,
			WS$CLC_classification_code,
			WSCYCL_cycle_count_category,
			WSORD__equipment_order,
			WSORDT_order_type,
			WSCAG__cagess_code,
			WSEST__employment_status,
			WS$TSS_tech_specialist_code,
			WS$CCS_cadcam_specialist_code,
			WS$NM1__name_1,
			WS$NM3_researched_by,
			WS$NM4_completed_by,
			WS$NM5__name_5,
			WS$L01_level_code_01,
			WSSRP4_sub_minor_product_class,
			WSCITM_customersupplier_item_number,
			WSSIC__speciality,
			WSAC04_practice_type,
			WSAC10_division_code,
			WS$O01_number_equipment_serial_01,
			WS$O02_number_equipment_serial_02,
			WS$O03_number_equipment_serial_03,
			WS$O04_number_equipment_serial_04,
			WS$O05_number_equipment_serial_05,
			WS$O06_number_equipment_serial_06,
			WSDL03_description_03,
			WS$ODS_order_discount_amount,

			-- make a copy of the ESS official to working ess_code (see SOURCE below)
			[WS$ESS_equipment_specialist_code],
			ess_code,

			-- calculated fields
			[source_cd],
			[transaction_amt],
			[gp_ext_amt],
			[fsc_code],
			[FreeGoodsInvoicedInd],
			[FreeGoodsEstInd],

			[fsc_salesperson_key_id],
			[ess_salesperson_key_id],
			[cps_salesperson_key_id],
			[eps_salesperson_key_id],

			[fsc_comm_group_cd],
			[ess_comm_group_cd],
			[cps_comm_group_cd],
			[eps_comm_group_cd]
		)
		SELECT        
		--	SELECT TOP (10) 

			d.FiscalMonth,
			t.WSCO___company,
			t.WSDOCO_salesorder_number,
			t.WSDCTO_order_type,
			t.WSLNTY_line_type,
			ROUND(t.WSLNID_line_number * 1000,0) AS WSLNID_line_number,
			t.WS$OSC_order_source_code,
			t.WSAN8__billto,
			t.WSSHAN_shipto,
			t.WSDGL__gl_date,
			t.WSLITM_item_number,
			t.WSDSC1_description,
			t.WSDSC2_description_2,
			t.WSSRP1_major_product_class,
			t.WSSRP2_sub_major_product_class,
			t.WSSRP3_minor_product_class,
			t.WSSRP6_manufacturer,
			t.WSUORG_quantity,
			t.WSSOQS_quantity_shipped,
			t.WSAEXP_extended_price,
			t.WSURAT_user_reserved_amount,
			t.WS$UNC_sales_order_cost_markup,
			t.WSOORN_original_order_number,
			t.WSOCTO_original_order_type,
			t.WSOGNO_original_line_number,
			t.WSTRDJ_order_date,
			t.WSVR01_reference,
			t.WSVR02_reference_2,
			t.WSITM__item_number_short,
			t.WSPROV_price_override_code,
			t.WSASN__adjustment_schedule,
			t.WSKCO__document_company,
			t.WSDOCO_salesorder_number,
			t.WSDCT__document_type,
			t.WSPSN__pick_slip_number,
			t.WSROUT_ship_method,
			t.WSZON__zone_number,
			t.WSFRTH_freight_handling_code,
			t.WSFRAT_rate_code_freightmisc,
			t.WSRATT_rate_type_freightmisc,
			t.WSGLC__gl_offset,
			t.WSSO08_price_adjustment_line_indicator,
			t.WSENTB_entered_by,
			t.WS$PMC_promotion_code_price_method,
			t.WSTKBY_order_taken_by,
			t.WSKTLN_kit_master_line_number,
			t.WSCOMM_committed_hs,
			t.WSEMCU_header_business_unit,
			t.WS$SPC_supplier_code,
			t.WS$VCD_vendor_code,
			t.WS$CLC_classification_code,
			t.WSCYCL_cycle_count_category,
			t.WSORD__equipment_order,
			t.WSORDT_order_type,
			t.WSCAG__cagess_code,
			t.WSEST__employment_status,
			t.WS$TSS_tech_specialist_code,
			t.WS$CCS_cadcam_specialist_code,
			t.WS$NM1__name_1,
			t.WS$NM3_researched_by,
			t.WS$NM4_completed_by,
			t.WS$NM5__name_5,
			t.WS$L01_level_code_01,
			t.WSSRP4_sub_minor_product_class,
			t.WSCITM_customersupplier_item_number,
			t.WSSIC__speciality,
			t.WSAC04_practice_type,
			t.WSAC10_division_code,
			t.WS$O01_number_equipment_serial_01,
			t.WS$O02_number_equipment_serial_02,
			t.WS$O03_number_equipment_serial_03,
			t.WS$O04_number_equipment_serial_04,
			t.WS$O05_number_equipment_serial_05,
			t.WS$O06_number_equipment_serial_06,
			t.WSDL03_description_03,
			t.WS$ODS_order_discount_amount,

			-- make a copy of the ESS official to working ess_code - SOURCE
			[WS$ESS_equipment_specialist_code] ,
			[WS$ESS_equipment_specialist_code] as WS$ESS_equipment_specialist_code2,


			-- calculated fields
			'JDE' AS source_cd,

			ROUND((t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount), 2)
				AS [transaction_amt],
			ROUND((
				(t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount) 
				- (t.WS$UNC_sales_order_cost_markup * t.WSSOQS_quantity_shipped)
			), 2)	AS [gp_ext_amt],

			-- FSC Lookup (assumed monthly pull)
			f.HIST_TerritoryCd AS [fsc_code],

			-- Free Goods invoiced
			CASE 
				WHEN ([WSSOQS_quantity_shipped] <> 0) AND 
					((t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount) = 0) 
				THEN 1 
				ELSE 0 
			END AS [FreeGoodsInvoicedInd],

			-- TBD
			0 AS [FreeGoodsEstInd],

			-- calculated fields2
			''									AS [fsc_salesperson_key_id],
			''									AS [ess_salesperson_key_id],
			''									AS [cps_salesperson_key_id],
			''									AS [eps_salesperson_key_id],

			''									AS [fsc_comm_group_cd],
			''									AS [ess_comm_group_cd],
			''									AS [cps_comm_group_cd],
			''									AS [eps_comm_group_cd]
		FROM
			Integration.F555115_commission_sales_extract_Staging AS t 

			INNER JOIN BRS_SalesDay AS d 
			ON t.WSDGL__gl_date = d.SalesDate

			-- FSC code
			JOIN [dbo].[BRS_CustomerFSC_History] AS f
			ON t.WSSHAN_shipto = f.Shipto AND
				d.FiscalMonth = f.FiscalMonth
		WHERE 
			-- load max fiscal month for status checking
			-- BUT, all stage to have multiple months for speed
			-- allows full year to be reloaded
			(WSAC10_division_code NOT IN ('AZA','AZE')) AND
--			(d.FiscalMonth  = 202001) AND
			(d.FiscalMonth = @nCurrentFiscalYearmoNum) AND
			(1=1)

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
	Set @sMessage = 'comm_transaction_load_proc'
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
-- UPDATE BRS_FiscalMonth SET comm_status_cd =0 where FiscalMonth = 202001

-- delete from comm.transaction_F555115 where FiscalMonth = 202006

-- Prod
-- EXEC comm.transaction_load_proc @bDebug=0

-- Debug
-- EXEC comm.transaction_load_proc @bDebug=1
