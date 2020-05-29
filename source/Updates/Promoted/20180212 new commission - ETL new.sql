-- NEW load
-- updated 14 Nov 19


------------------------------------------------------------------------------------------------------
-- DATA - Load NEW - pre
------------------------------------------------------------------------------------------------------

/** START ***********************/

print '1. check - [SalesDate]'
SELECT     * 
FROM  [Integration].F555115_commission_sales_extract_Staging t
WHERE not exists
(
	select * from [dbo].[BRS_SalesDay] s
	where t.WSDGL__gl_date = s.SalesDate
)
GO

print '2. check - [WSDOCO_salesorder_number]'
--INSERT INTO [dbo].[BRS_TransactionDW_Ext] (
--SalesOrderNumber, DocType
--)
SELECT    distinct WSDOCO_salesorder_number, WSDCTO_order_type
FROM  [Integration].F555115_commission_sales_extract_Staging t
WHERE not exists
(
	select * from [dbo].[BRS_TransactionDW_Ext] s
	where t.WSDOCO_salesorder_number = s.SalesOrderNumber
) AND
[WSAC10_division_code] NOT IN ('AZA','AZE')
GO

print '3. check - [WSSHAN_shipto] - current'
SELECT     * 
FROM  [Integration].F555115_commission_sales_extract_Staging t
WHERE not exists
(
	select * from [dbo].[BRS_Customer] s
	where t.WSSHAN_shipto = s.ShipTo
)
GO


print '4. check - [WSSHAN_shipto] - history'
SELECT     * 
FROM  [Integration].F555115_commission_sales_extract_Staging t

	INNER JOIN BRS_SalesDay AS d 
	ON t.WSDGL__gl_date = d.SalesDate

WHERE not exists
(
	select * from [dbo].[BRS_CustomerFSC_History] s
	where 
		t.WSSHAN_shipto = s.ShipTo AND
		d.FiscalMonth = s.FiscalMonth 
)
GO

print '5. check - [WSLITM_item_number]'
SELECT     * 
FROM  [Integration].F555115_commission_sales_extract_Staging t
WHERE not exists
(
	select * from [dbo].[BRS_Item] s
	where t.WSLITM_item_number = s.Item
)
GO


print '6. check - [WS$ESS_equipment_specialist_code]'
SELECT     * 
FROM  [Integration].F555115_commission_sales_extract_Staging t
WHERE not exists
(
	select * from [dbo].[BRS_FSC_Rollup] s
	where t.WS$ESS_equipment_specialist_code = s.[TerritoryCd]
)
GO


print '7. check - [WSCAG__cagess_code]'
SELECT     * 
FROM  [Integration].F555115_commission_sales_extract_Staging t
WHERE not exists
(
	select * from [dbo].[BRS_FSC_Rollup] s
	where t.WSCAG__cagess_code = s.[TerritoryCd]
)
GO

print '8. check - [WSSIC__speciality]'
 /*
 INSERT INTO [dbo].[BRS_CustomerSpecialty] (
 Specialty
 )
 */
SELECT  distinct (WSSIC__speciality)
FROM  [Integration].F555115_commission_sales_extract_Staging t
WHERE not exists
(
	select * from [dbo].[BRS_CustomerSpecialty] s
	where t.WSSIC__speciality = s.Specialty
)
GO


print '9. check - [WS$SPC_supplier_code]'
-- INSERT INTO [dbo].[BRS_ItemSupplier] (
-- Supplier
-- )
SELECT  distinct (WS$SPC_supplier_code)
FROM  [Integration].F555115_commission_sales_extract_Staging t
WHERE not exists
(
	select * from [dbo].[BRS_ItemSupplier] s
	where t.WS$SPC_supplier_code = s.Supplier
)
GO

print '10. check - [WSLITM_item_number] - history'
SELECT     * 
FROM  [Integration].F555115_commission_sales_extract_Staging t

	INNER JOIN BRS_SalesDay AS d 
	ON t.WSDGL__gl_date = d.SalesDate

WHERE not exists
(
	select * from [dbo].[BRS_ItemHistory] s
	where 
		t.WSLITM_item_number = s.[Item] AND
		d.FiscalMonth = s.FiscalMonth 
)
GO

------------------------------------------------------------------------------------------------------
-- DATA - Load New-to-New (3 of 3)
------------------------------------------------------------------------------------------------------
-- truncate table [comm].[transaction_F555115]
-- delete  from [comm].[transaction_F555115] where FiscalMonth = 202004 and source_cd = 'JDE'

print 'load new data source'
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
--	TOP (10) 

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

	(t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount) 
		AS [transaction_amt],
	(
		(t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount) 
		- (t.WS$UNC_sales_order_cost_markup * t.WSSOQS_quantity_shipped)
	)	AS [gp_ext_amt],

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
	(WSAC10_division_code NOT IN ('AZA','AZE')) AND
--	(WSDOCO_salesorder_number = 11922085) AND
	(1=1)
GO

------------------------------------------------------------------------------------------------------
-- DATA - Booking Correction here (Do not move: after data, before adj)
------------------------------------------------------------------------------------------------------
UPDATE    
	comm.transaction_F555115
SET              
	[gp_ext_amt] = [transaction_amt] * (g.booking_rt / 100.0),
	[gp_ext_org_amt] = [gp_ext_amt]

-- SELECT 	[FiscalMonth], t.[WSLITM_item_number], i.comm_group_cd, t.WSSOQS_quantity_shipped, t.transaction_amt, [gp_ext_amt], [gp_ext_org_amt], g.booking_rt, t.[transaction_amt] * (g.booking_rt / 100.0) as new_gp
FROM         
	comm.transaction_F555115 as t

	INNER JOIN [dbo].[BRS_Item] as i
	ON i.[Item] = t.[WSLITM_item_number]

	INNER JOIN [comm].[group] AS g 
	ON i.comm_group_cd = g.comm_group_cd

WHERE 
	(t.source_cd = 'JDE') AND
	(t.[gp_ext_org_amt] is null) AND -- only run once
	(g.booking_rt > 0)  AND 
	(t.[FiscalMonth] = 202004 ) AND
	(1=1)

/*
--
-- Add Booking rate, 24 Feb 16
	if (@bDebug <> 0)
		Print 'Override:  FSC Booking Rate GP'

	If (@nErrorCode = 0) 
	Begin
		UPDATE    
			comm_transaction
		SET              
			gp_ext_amt = t.transaction_amt * (g.booking_rt / 100.0)
		FROM         
			comm_transaction as t
			
			INNER JOIN comm_group AS g 
			ON t.item_comm_group_cd = g.comm_group_cd

		WHERE     
			(g.booking_rt > 0)  AND 
			(t.fiscal_yearmo_num = @sCurrentFiscalYearmoNum )
	End
*/
--

------------------------------------------------------------------------------------------------------
-- DATA - Load NEW - post from Legacy, w/f new standard FSC, ESS, CCS, EPS, CPS
------------------------------------------------------------------------------------------------------

--- LOAD Adjustments and Payroll from Prod now, work-around

/*
1. WS$ESS_equipment_specialist_code (offical ESS code) - Do not touch
2. order_taken_by (backup, used for JDE Credit/Rebil fix) - Do not touch!
3. ess_code (fixed, final ESS/CCS code) - fix this, new

Set 3 = 1 (ETL)
Fix 3 where 2 <> 3 (Patch)
*/
-- patch DOCO vs DOC issue, one-time
/*
SELECT        TOP (10) WSDOCO_salesorder_number, WSDOC__document_number, WSDCTO_order_type
FROM            comm.transaction_F555115
WHERE 
WSDOCO_salesorder_number <> WSDOC__document_number AND
FiscalMonth = 202004

--
UPDATE      comm.transaction_F555115
SET                WSDOC__document_number = WSDOCO_salesorder_number
WHERE        (WSDOCO_salesorder_number <> WSDOC__document_number) AND (FiscalMonth = 202004)
--
*/

-- EPS / CPS post process, tmc, 3 Oct 19

-- CHANGE DATES!!  Yes, this is terrible.  automate!!

-- this is run for New2New only (manually fixed on Prod2New)
print '1. ESS fix missed code from download'
UPDATE       comm.transaction_F555115
SET                ess_code = WSTKBY_order_taken_by
FROM            comm.transaction_F555115 t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE     
	(t.source_cd = 'JDE') AND (
		(t.WSTKBY_order_taken_by like 'ESS%') OR
		(t.WSTKBY_order_taken_by like 'CCS%') 
	) AND
	ISNULL(ess_code,'') <> WSTKBY_order_taken_by AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

-- Fix CPS GP booking so not 100% GP, us processing options or in script?

---> Calc start here  COPY TO new proc

print '1. tranfer - directed (1 of 2)'
UPDATE
	comm.transaction_F555115
SET
	xfer_key = r.[xfer_key], 

	xfer_fsc_code_org = t.fsc_code, 
	xfer_ess_code_org = t.ess_code,

	fsc_code = CASE WHEN r.[new_fsc_code] = '' THEN t.fsc_code ELSE r.[new_fsc_code] END, 
	ess_code = CASE WHEN r.[new_ess_code] = '' THEN t.ess_code ELSE r.[new_ess_code] END
FROM
	comm.transfer_rule AS r 

	INNER JOIN comm.transaction_F555115 t 
	ON r.FiscalMonth = t.FiscalMonth AND 
		r.SalesOrderNumber = t.WSDOCO_salesorder_number
WHERE        
	(t.source_cd = 'JDE') AND 
	(t.xfer_key is null) AND -- only run once 
	(r.SalesOrderNumber > 0) AND 
	(t.FiscalMonth = 202004) AND
	(1=1)
GO

print '2. tranfer - rule-based (2 of 2)'
UPDATE
	comm.transaction_F555115
SET
	xfer_key = r.[xfer_key], 

	xfer_fsc_code_org = t.fsc_code, 
	xfer_ess_code_org = t.ess_code,

	fsc_code = CASE WHEN r.[new_fsc_code] = '' THEN t.fsc_code ELSE r.[new_fsc_code] END, 
	ess_code = CASE WHEN r.[new_ess_code] = '' THEN t.ess_code ELSE r.[new_ess_code] END
FROM
	comm.transfer_rule AS r 

	INNER JOIN comm.transaction_F555115 t 
	ON r.FiscalMonth = t.FiscalMonth AND 
		(t.fsc_code like (CASE WHEN r.[fsc_code] = '' THEN '%' ELSE r.[fsc_code] END)) AND
		(t.ess_code like (CASE WHEN r.[ess_code] = '' THEN '%' ELSE r.[ess_code] END)) AND
		(1=1)
WHERE        
	(t.source_cd = 'JDE') AND 
	-- only run once
	(t.xfer_key is null) AND 
	(r.SalesOrderNumber = 0) AND 
	(t.FiscalMonth = 202004) AND
	(1=1)
GO

/*
-- transfer test
SELECT
	t.ID, 
	r.[xfer_key],
	r.FiscalMonth, 
	r.SalesOrderNumber, 
	r.fsc_code, 
	CASE WHEN r.[fsc_code] = '' THEN '%' ELSE r.[fsc_code] END AS fsc_rule_from, 
	r.ess_code, 
	CASE WHEN r.[ess_code] = '' THEN '%' ELSE r.[ess_code] END AS ess_rule_from, 
	r.xfer_key, 
	r.xfer_type, 
	r.new_fsc_code, 
	CASE WHEN [new_fsc_code] = '' THEN t.fsc_code ELSE [new_fsc_code] END AS fsc_rule_to, 
	r.new_ess_code, 
	CASE WHEN [new_ess_code] = '' THEN t.WS$ESS_equipment_specialist_code ELSE [new_ess_code] END AS fsc_rule_to
FROM
	comm.transfer_rule AS r 
	INNER JOIN comm.transaction_F555115 AS t 
	ON r.FiscalMonth = t.FiscalMonth AND 
	r.SalesOrderNumber = t.WSDOCO_salesorder_number
WHERE
	(r.SalesOrderNumber > 0) AND (r.FiscalMonth = 201910)
*/

-- FSC
print '3. FSC update plan & terr'
UPDATE
	comm.transaction_F555115
SET
	fsc_salesperson_key_id = s.salesperson_key_id, 
	fsc_comm_plan_id = s.comm_plan_id
FROM
	comm.salesperson_master AS s 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON s.salesperson_key_id = f.comm_salesperson_key_id 
	
	INNER JOIN comm.transaction_F555115 ON 
	f.TerritoryCd = comm.transaction_F555115.[fsc_code]

WHERE
	(comm.transaction_F555115.FiscalMonth = 202004)
GO

-- OK to use Item comm live.  Business rule NOT update mid-month, 27 May 20
print '4. FSC update item commgroup - JDE'
UPDATE
	comm.transaction_F555115
SET
	fsc_comm_group_cd = i.comm_group_cd
FROM
	comm.transaction_F555115 t
	INNER JOIN BRS_Item AS i 
	ON t.WSLITM_item_number = i.Item
WHERE        
	(t.fsc_comm_plan_id <> '') AND
	(t.source_cd = 'JDE') AND
	(i.comm_group_cd <> '') AND

	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

print '5. FSC update commgroup - ITMPAR -> ITMFO3 promotion'
UPDATE
	comm.transaction_F555115
SET
	fsc_comm_group_cd = CASE 
							WHEN t.WSSRP6_manufacturer = 'PELTON' 
							THEN 'ITMFO1'
							ELSE 'ITMFO3'
						END
FROM
	comm.transaction_F555115 t 
WHERE        
	(t.fsc_comm_plan_id <> '') AND
	(t.source_cd = 'JDE') AND
	(t.WS$OSC_order_source_code IN ('A', 'L')) AND		-- Astea  EQ and Service
	(t.ess_code <> '') AND								-- Exclude Tech billing (No ESS code)
	(t.fsc_comm_group_cd = 'ITMPAR') AND				-- ONLY effect Parts 

	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

print '6. FSC update commgroup - IMP'
UPDATE
	comm.transaction_F555115
SET
	fsc_comm_group_cd = i.comm_group_cd
-- SELECT t.* 
FROM
	comm.transaction_F555115 t
	INNER JOIN BRS_Item AS i 
	ON t.WSLITM_item_number = i.Item
WHERE        
	(t.fsc_comm_plan_id <> '') AND
	(t.source_cd = 'IMP') AND
	(i.comm_group_cd <> '') AND

	-- If Source IMP, and the CommCode is supplied, do not override.
	(t.WSLITM_item_number <> '') AND
	(ISNULL(t.fsc_comm_group_cd,'') = '') AND

	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO


print '7. FSC update comm - non-booking -new'
UPDATE
	comm.transaction_F555115
SET
	[fsc_comm_rt] = r.comm_rt,
	[fsc_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
	[fsc_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.fsc_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.fsc_comm_plan_id = r.comm_plan_id AND
		t.fsc_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.fsc_comm_plan_id <> '') AND
	(t.fsc_comm_group_cd <> '') AND 
	(t.source_cd <> 'PAY') AND
	(g.booking_rt = 0) AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

/*
-- REMOVE this

--select distinct [HIST_cust_comm_group_cd] from [BRS_CustomerFSC_History] where FiscalMonth = 201812
-- XXX CPS booking fix here?
print '7. FSC update comm - booking - new'
UPDATE       comm.transaction_F555115
SET
	[fsc_comm_rt] = g.booking_rt,
	[fsc_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
	[fsc_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.fsc_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.fsc_comm_plan_id = r.comm_plan_id AND
		t.fsc_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.fsc_comm_plan_id <> '') AND
	(t.fsc_comm_group_cd <> '') AND 
	(t.source_cd <> 'PAY') AND
	(g.booking_rt <> 0) AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO
*/

print '8. FSC update comm - pay'
UPDATE
	comm.transaction_F555115
SET
	[fsc_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.fsc_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.fsc_comm_plan_id = r.comm_plan_id AND
		t.fsc_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.fsc_comm_plan_id <> '') AND
	(t.fsc_comm_group_cd <> '') AND 
	(t.source_cd = 'PAY') AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

-- ESS & CCS
print '9. ESS/CCS update plan & terr'
UPDATE
	comm.transaction_F555115
SET
	ess_salesperson_key_id = s.salesperson_key_id, 
	ess_comm_plan_id = s.comm_plan_id
FROM
	comm.salesperson_master AS s 

	INNER JOIN BRS_FSC_Rollup AS f ON 
	s.salesperson_key_id = f.comm_salesperson_key_id 

	INNER JOIN comm.transaction_F555115 
	ON f.TerritoryCd = comm.transaction_F555115.ess_code
WHERE
	(comm.transaction_F555115.FiscalMonth = 202004) AND
-- test
--	WSDOC__document_number In (13136178,13142137) AND
	(1=1)
GO

/*
-- test ESS/CCS map
SELECT 
	ess_salesperson_key_id,
	ess_comm_plan_id
FROM
comm.transaction_F555115
WHERE
	(comm.transaction_F555115.FiscalMonth = 202004) AND
	-- test
	WSDOC__document_number In (13136178,13142137) AND
	(1=1)
GO
*/

print '10. ESS/CCS update commgroup - JDE'
-- update from history for stability?
UPDATE
	comm.transaction_F555115
SET
	ess_comm_group_cd = i.comm_group_cd
FROM
	comm.transaction_F555115 t 
	INNER JOIN BRS_Item AS i 
	ON t.WSLITM_item_number = i.Item
WHERE        
	(t.ess_comm_plan_id <> '') AND
	(t.source_cd = 'JDE') AND
	(i.comm_group_cd <> '') AND 

	(t.FiscalMonth = 202004 ) AND
-- test
--	WSDOC__document_number In (13136178,13142137) AND
	(1 = 1)
GO

print '11. ESS/CCS update commgroup - ITMPAR -> ITMFO3 promotion'
UPDATE
	comm.transaction_F555115
SET
	ess_comm_group_cd = CASE 
							WHEN t.WSSRP6_manufacturer = 'PELTON' 
							THEN 'ITMFO1'
							ELSE 'ITMFO3'
						END
FROM
	comm.transaction_F555115 t 
WHERE        
	(t.ess_comm_plan_id <> '') AND
	(t.source_cd = 'JDE') AND
	(t.WS$OSC_order_source_code IN ('A', 'L')) AND		-- Astea  EQ and Service
	(t.ess_code <> '') AND								-- Exclude Tech billing (No ESS code)
	(t.ess_comm_group_cd = 'ITMPAR') AND				-- ONLY effect Parts 

	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

print '12. ESS/CCS update commgroup - IMP'
UPDATE
	comm.transaction_F555115
SET
	ess_comm_group_cd = i.comm_group_cd
-- SELECT t.* 
FROM
	comm.transaction_F555115 t
	INNER JOIN BRS_Item AS i 
	ON t.WSLITM_item_number = i.Item
WHERE        
	(t.ess_comm_plan_id <> '') AND
	(t.source_cd = 'IMP') AND
	(i.comm_group_cd <> '') AND

	-- If Source IMP, and the CommCode is supplied, do not override.
	(t.WSLITM_item_number <> '') AND
	(ISNULL(t.ess_comm_group_cd,'') = '') AND

	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

print '13. ESS/CCS update comm - non-booking -new'
UPDATE
	comm.transaction_F555115
SET
	[ess_comm_rt] = r.comm_rt,
	[ess_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
	[ess_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.ess_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.ess_comm_plan_id = r.comm_plan_id AND
		t.ess_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.ess_comm_plan_id <> '') AND
	(t.ess_comm_group_cd <> '') AND 
	(t.source_cd <> 'PAY') AND
	(g.booking_rt = 0) AND
	(t.FiscalMonth = 202004 ) AND
-- test
--	WSDOC__document_number In (13136178,13142137) AND
	(1 = 1)
GO
/*
-- REMOVE
print '11. ESS/CSS update comm - booking - new'
UPDATE       comm.transaction_F555115
SET
	[ess_comm_rt] = g.booking_rt,
	[ess_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
	[ess_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.ess_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.ess_comm_plan_id = r.comm_plan_id AND
		t.ess_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.ess_comm_plan_id <> '') AND
	(t.ess_comm_group_cd <> '') AND 
	(t.source_cd <> 'PAY') AND
	(g.booking_rt <> 0) AND
	(t.FiscalMonth = 202004 ) AND
-- test
--	WSDOC__document_number In (13136178,13142137) AND
	(1 = 1)
GO
*/

print '14. ESS/CSS update comm - pay'
UPDATE
	comm.transaction_F555115
SET
	[ess_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.ess_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.ess_comm_plan_id = r.comm_plan_id AND
		t.ess_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.ess_comm_plan_id <> '') AND
	(t.ess_comm_group_cd <> '') AND 
	(t.source_cd = 'PAY') AND
	(t.FiscalMonth = 202004 ) AND
-- test
--	WSDOC__document_number In (13136178,13142137) AND
	(1 = 1)
GO

print '15. CPS update plan & terr'
UPDATE
	comm.transaction_F555115
SET
	cps_salesperson_key_id = sales_key.comm_salesperson_key_id , 
	cps_comm_plan_id = m.comm_plan_id , 
	cps_code = m.TerritoryCd
FROM
	comm.transaction_F555115 

	INNER JOIN BRS_Customer AS c 
	ON comm.transaction_F555115.WSSHAN_shipto = c.ShipTo 

	INNER JOIN comm.plan_region_map AS m 
	ON m.comm_plan_id = 'CPSGP' AND 
		c.PostalCode LIKE m.postal_code_where_clause_like AND 
		1 = 1 

	INNER JOIN BRS_FSC_Rollup AS sales_key 
	ON sales_key.TerritoryCd = m.TerritoryCd

WHERE
	-- must be valid customer, as postal code driven based on Current address
	(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
	(comm.transaction_F555115.FiscalMonth between 202004 and 202004) AND
	(1 = 1)
GO

print '16. update CPS item'
UPDATE       comm.transaction_F555115
SET                cps_comm_group_cd = i.comm_group_cps_cd
FROM            comm.transaction_F555115 t INNER JOIN
							BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(t.cps_code <> '') AND
	(i.comm_group_cps_cd <> '') AND 
	(t.FiscalMonth between 202004 and 202004) AND
	(1 = 1)
GO

print '17. CPS update comm - non-booking -new'
UPDATE
	comm.transaction_F555115
SET
	[cps_comm_rt] = r.comm_rt,
	[cps_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
	[cps_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.cps_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.cps_comm_plan_id = r.comm_plan_id AND
		t.cps_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.cps_code <> '') AND
	(t.cps_comm_group_cd <> '') AND 
	(g.booking_rt = 0) AND
	(t.FiscalMonth between 202004 and 202004 ) AND
	(1 = 1)
GO

print '18. CPS update comm - booking - new'
UPDATE       comm.transaction_F555115
SET
	[cps_comm_rt] = g.booking_rt,
	[cps_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
	[cps_calc_key] = r.calc_key
FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.cps_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.cps_comm_plan_id = r.comm_plan_id AND
		t.ess_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.cps_code <> '') AND
	(t.cps_comm_group_cd <> '') AND 
	(g.booking_rt <> 0) AND
	(t.FiscalMonth between 202004 and 202004 ) AND
	(1 = 1)
GO

-- EPS
print '19. EPS update plan & terr'
UPDATE
	comm.transaction_F555115
SET
	eps_salesperson_key_id = sales_key.comm_salesperson_key_id , 
	eps_comm_plan_id = m.comm_plan_id , 
	eps_code = m.[master_salesperson_cd]
FROM
	comm.transaction_F555115 

	INNER JOIN [eps].[Customer] AS c 
	ON comm.transaction_F555115.WSSHAN_shipto = c.[Customer_Number]

	INNER JOIN BRS_FSC_Rollup AS sales_key 
	ON sales_key.TerritoryCd = c.Eps_Code

	INNER JOIN [comm].[salesperson_master] m
	ON m.[salesperson_key_id] = sales_key.comm_salesperson_key_id

WHERE
	(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
	(comm.transaction_F555115.FiscalMonth between 202004 and 202004) AND
	(1 = 1)
GO

-- ensure eps comm synch run CBE07b_Item_eps_fix
print '20. update EPS item'
UPDATE       comm.transaction_F555115
SET                eps_comm_group_cd = i.comm_group_eps_cd
FROM            comm.transaction_F555115 t INNER JOIN
							BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE   
	-- eps cutomer territory?
	(t.eps_code <> '') AND

	-- eps item different?
	(i.comm_group_eps_cd <> ISNULL(t.eps_comm_group_cd, '')) AND

	(t.FiscalMonth between 202004 and 202004 ) AND

	-- test
--	t.WSLITM_item_number In ('1074153','1076903','1070511') AND
	(1 = 1)
GO

print '21. EPS update comm - cleanup calc'
UPDATE
	comm.transaction_F555115
SET
	[eps_calc_key] = null 
FROM
	comm.transaction_F555115 t
WHERE        
	[eps_calc_key] is not null AND
	(t.FiscalMonth between 202004 and 202004 ) AND
	(1 = 1)
GO

print '22. EPS update comm - non-booking -new'
UPDATE
	comm.transaction_F555115
SET
	[eps_comm_rt] = r.comm_rt,
	[eps_comm_amt] = t.[gp_ext_amt]*(r.[comm_rt]/100),
	[eps_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.eps_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.eps_comm_plan_id = r.comm_plan_id AND
		t.eps_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.eps_code <> '') AND

	(t.eps_comm_group_cd <> '') AND 

	-- test
--	t.WSLITM_item_number In ('1074153','1076903','1070511') AND

	(g.booking_rt = 0) AND
	(t.FiscalMonth between 202004 and 202004 ) AND
	(1 = 1)
GO

print '23. EPS update comm - booking - new'
UPDATE       comm.transaction_F555115
SET
	[eps_comm_rt] = g.booking_rt,
	[eps_comm_amt] =  t.transaction_amt * (g.booking_rt / 100.0) * (r.comm_rt / 100.0),
	[eps_calc_key] = r.calc_key

FROM
	comm.transaction_F555115 t

	INNER JOIN [dbo].[BRS_CustomerFSC_History] c
	ON t.WSSHAN_shipto = c.ShipTo AND
		t.FiscalMonth = c.FiscalMonth

	INNER JOIN [comm].[group] g
	ON t.eps_comm_group_cd = g.comm_group_cd

	INNER JOIN [comm].[plan_group_rate] AS r 
	ON t.eps_comm_plan_id = r.comm_plan_id AND
		t.eps_comm_group_cd = r.item_comm_group_cd AND
		c.[HIST_cust_comm_group_cd] = r.cust_comm_group_cd AND
		t.[source_cd] = r.[source_cd]
WHERE        
	(t.eps_code <> '') AND

	-- test
--	t.WSLITM_item_number In ('1074153','1076903','1070511') AND

	(t.eps_comm_group_cd <> '') AND 

	(g.booking_rt <> 0) AND
	(t.FiscalMonth between 202004 and 202004 ) AND
	(1 = 1)
GO

/** STOP ***********************/

