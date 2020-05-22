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
[WSAC10_division_code] <> 'AZA'
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

/*
print '11. Allign FSC Territory with Commission'
UPDATE       BRS_CustomerFSC_History
SET                HIST_TerritoryCd = s.fsc_min
FROM            BRS_CustomerFSC_History INNER JOIN
                             (SELECT        CAST(fiscal_yearmo_num AS int) AS FiscalMonth, hsi_shipto_id, MIN(salesperson_cd) AS fsc_min
                               FROM            CommBE.dbo.comm_transaction
                               WHERE        (source_cd = 'jde') AND (fiscal_yearmo_num BETWEEN '201801' AND '201912') AND (record_id NOT IN (54108565, 55191867, 55976312, 55976313, 
                                                         57216489, 57216490, 57216491, 57815920)) AND (1 = 1)
                               GROUP BY fiscal_yearmo_num, hsi_shipto_id) AS s ON BRS_CustomerFSC_History.FiscalMonth = s.FiscalMonth AND 
                         BRS_CustomerFSC_History.Shipto = s.hsi_shipto_id AND BRS_CustomerFSC_History.HIST_TerritoryCd <> s.fsc_min AND 
                         BRS_CustomerFSC_History.HIST_SalesDivision <> 'AZA' AND s.fsc_min <> '' AND 1 = 1
GO
*/
---

------------------------------------------------------------------------------------------------------
-- DATA - Load NewPRE-to-New (3 of 3)
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
	[WS$ESS_equipment_specialist_code],

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
	t.WSDOC__document_number,
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

	[WS$ESS_equipment_specialist_code],
--	t.WSTKBY_order_taken_by,

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

-- EPS / CPS post process, tmc, 3 Oct 19

-- CHANGE DATES!!  Yes, this is terrible.  automate!!

print '1. ESS fix missed code from download'
UPDATE       comm.transaction_F555115
SET                WS$ESS_equipment_specialist_code = WSTKBY_order_taken_by
FROM            comm.transaction_F555115 t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE     
	(t.source_cd = 'JDE') AND (
		(t.WSTKBY_order_taken_by like 'ESS%') OR
		(t.WSTKBY_order_taken_by like 'CCS%') 
	) AND
	WS$ESS_equipment_specialist_code <> WSTKBY_order_taken_by AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

-- Fix CPS GP booking so not 100% GP?

---> Calc start here

print '2. tranfer - directed (1 of 2)'
UPDATE
	comm.transaction_F555115
SET
	xfer_key = r.[xfer_key], 

	xfer_fsc_code_org = t.fsc_code, 
	xfer_ess_code_org = t.WS$ESS_equipment_specialist_code,

	fsc_code = CASE WHEN r.[new_fsc_code] = '' THEN t.fsc_code ELSE r.[new_fsc_code] END, 
	[WS$ESS_equipment_specialist_code] = CASE WHEN r.[new_ess_code] = '' THEN t.WS$ESS_equipment_specialist_code ELSE r.[new_ess_code] END
FROM
	comm.transfer_rule AS r 

	INNER JOIN comm.transaction_F555115 t 
	ON r.FiscalMonth = t.FiscalMonth AND 
		r.SalesOrderNumber = t.WSDOCO_salesorder_number
WHERE        
	(t.source_cd = 'JDE') AND 
	-- only run once
	(t.xfer_key is null) AND 
	(r.SalesOrderNumber > 0) AND 
	(t.FiscalMonth = 202004) AND
	(1=1)
GO

print '3. tranfer - rule-based (2 of 2)'
UPDATE
	comm.transaction_F555115
SET
	xfer_key = r.[xfer_key], 

	xfer_fsc_code_org = t.fsc_code, 
	xfer_ess_code_org = t.WS$ESS_equipment_specialist_code,

	fsc_code = CASE WHEN r.[new_fsc_code] = '' THEN t.fsc_code ELSE r.[new_fsc_code] END, 
	[WS$ESS_equipment_specialist_code] = CASE WHEN r.[new_ess_code] = '' THEN t.WS$ESS_equipment_specialist_code ELSE r.[new_ess_code] END
FROM
	comm.transfer_rule AS r 

	INNER JOIN comm.transaction_F555115 t 
	ON r.FiscalMonth = t.FiscalMonth AND 
		(t.fsc_code like (CASE WHEN r.[fsc_code] = '' THEN '%' ELSE r.[fsc_code] END)) AND
		(t.[WS$ESS_equipment_specialist_code] like (CASE WHEN r.[ess_code] = '' THEN '%' ELSE r.[ess_code] END)) AND
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
print '4. FSC update plan & terr'
UPDATE       comm.transaction_F555115
SET
	fsc_salesperson_key_id = s.salesperson_key_id, 
	fsc_comm_plan_id = s.comm_plan_id
FROM
            comm.salesperson_master AS s INNER JOIN
                         BRS_FSC_Rollup AS f ON s.salesperson_key_id = f.comm_salesperson_key_id INNER JOIN
                         comm.transaction_F555115 ON f.TerritoryCd = comm.transaction_F555115.[fsc_code]
WHERE        (comm.transaction_F555115.FiscalMonth = 202004)
GO

-- use item history for stability?
print '5. FSC update item'
UPDATE       comm.transaction_F555115
SET                fsc_comm_group_cd = i.comm_group_cd
FROM            comm.transaction_F555115 t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(i.comm_group_cd <> '') AND 
	(t.fsc_comm_plan_id <> '') AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

print '6. FSC update comm - non-booking -new'
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
	(t.fsc_comm_group_cd <> '') AND 
	(t.fsc_comm_plan_id <> '') AND
	(g.booking_rt = 0) AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

--select distinct [HIST_cust_comm_group_cd] from [BRS_CustomerFSC_History] where FiscalMonth = 201812

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
	(t.fsc_comm_group_cd <> '') AND 
	(t.fsc_comm_plan_id <> '') AND
	(g.booking_rt <> 0) AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

-- ESS
print '8. ESS update plan & terr'
UPDATE       comm.transaction_F555115
SET
	ess_salesperson_key_id = s.salesperson_key_id, 
	ess_comm_plan_id = s.comm_plan_id
FROM            comm.salesperson_master AS s INNER JOIN
                         BRS_FSC_Rollup AS f ON s.salesperson_key_id = f.comm_salesperson_key_id INNER JOIN
                         comm.transaction_F555115 ON f.TerritoryCd = comm.transaction_F555115.WS$ESS_equipment_specialist_code
WHERE        (comm.transaction_F555115.FiscalMonth = 202004)
go

-- update from history for stability
print '9. ESS update item'
UPDATE       comm.transaction_F555115
SET                ess_comm_group_cd = i.comm_group_cd
FROM            comm.transaction_F555115 t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(i.comm_group_cd <> '') AND 
	(t.ess_comm_plan_id <> '') AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

print '10. ESS update comm - non-booking -new'
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
	(t.ess_comm_group_cd <> '') AND 
	(t.ess_comm_plan_id <> '') AND
	(g.booking_rt = 0) AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

print '11. ESS update comm - booking - new'
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
	(t.ess_comm_group_cd <> '') AND 
	(t.ess_comm_plan_id <> '') AND
	(g.booking_rt <> 0) AND
	(t.FiscalMonth = 202004 ) AND
	(1 = 1)
GO

-- CPS, run new
print '106. CPS update plan & terr'
print '107. update CPS item'
print '108. CPS update comm - non-booking -new'
print '109. CPS update comm - booking - new'

-- EPS
print '110. EPS update plan & terr'
print '111. update EPS item'
print '112. EPS update comm - non-booking -new'
print '113. EPS update comm - booking - new'

--

-- RI pref indexes, break out to new script
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX F555115_commission_sales_extract_Staging_idx_03 ON Integration.F555115_commission_sales_extract_Staging
	(
	WSLITM_item_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX F555115_commission_sales_extract_Staging_idx_04 ON Integration.F555115_commission_sales_extract_Staging
	(
	WS$ESS_equipment_specialist_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX F555115_commission_sales_extract_Staging_idx_05 ON Integration.F555115_commission_sales_extract_Staging
	(
	WSCAG__cagess_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



/** STOP ***********************/


-- clean from here to end

--- NEW / TBD / here be dragons..., 14 Nov 19

-- add adj check / load logic
-- test doc, line match

/*
-- Item
UPDATE       BRS_Item
SET                comm_group_cd = s.comm_group_cd, comm_note_txt = s.comm_note_txt
FROM            BRS_Item INNER JOIN
                         Integration.Item s ON BRS_Item.Item = s.Item
*/


-- DW - success
SELECT 
	[FiscalMonth]
	,[WSDOCO_salesorder_number]
	,[WSDCTO_order_type]
	,[WSLNID_line_number]
	,[WS$ESS_equipment_specialist_code]
	,[WSCAG__cagess_code]
FROM 
	[comm].[transaction_F555115] s
WHERE
	[FiscalMonth] = 201712 AND
	NOT EXISTS
	(
		SELECT * FROM [dbo].[BRS_TransactionDW] t
		WHERE 
			s.[WSDOCO_salesorder_number] = t.SalesOrderNumber AND
			s.[WSDCTO_order_type] = t.DocType AND
			s.[WSLNID_line_number] = t.LineNumber
	)

-- DW - test ess fields
SELECT 
	[FiscalMonth]
	,[WSDOCO_salesorder_number]
	,[WSDCTO_order_type]
	,[WSLNID_line_number]
	,[WS$ESS_equipment_specialist_code]
	,[WSTKBY_order_taken_by]
	,t.OrderTakenBy
	,[WSCAG__cagess_code]
FROM 
	[comm].[transaction_F555115] s
	INNER JOIN [dbo].[BRS_TransactionDW] t
	ON 
		s.[WSDOCO_salesorder_number] = t.SalesOrderNumber AND
		s.[WSDCTO_order_type] = t.DocType AND
		s.[WSLNID_line_number] = t.LineNumber

WHERE
	[FiscalMonth] = 201712 and
--	t.OrderTakenBy like 'CCS%' AND
	[WS$ESS_equipment_specialist_code] <> t.OrderTakenBy


--DS - failed
SELECT 
	[FiscalMonth]
	,[WSDOCO_salesorder_number]
	,[WSDCTO_order_type]
	,[WSLNID_line_number]
	,[WSDGL__gl_date]
	,[WS$ESS_equipment_specialist_code]
	,[WSCAG__cagess_code]
FROM 
	[comm].[transaction_F555115] s
WHERE
	[FiscalMonth] = 201711 AND
	NOT EXISTS
	(
		SELECT * FROM [dbo].[BRS_Transaction] t
		WHERE 
			s.[WSDOCO_salesorder_number] = t.SalesOrderNumber AND
			s.[WSDCTO_order_type] = t.DocType AND
			s.[WSLNID_line_number] = t.LineNumber
	)

GO
 

-- DW - test ess fields
SELECT 
	[FiscalMonth]
	,[WSDOCO_salesorder_number]
	,[WSDCTO_order_type]
	,[WSLNID_line_number]
	,[WS$ESS_equipment_specialist_code]
	,[WSTKBY_order_taken_by]
	,t.OrderTakenBy
	,[WSCAG__cagess_code]
FROM 
	[comm].[transaction_F555115] s
	INNER JOIN [dbo].[BRS_TransactionDW] t
	ON 
		s.[WSDOCO_salesorder_number] = t.SalesOrderNumber AND
		s.[WSDCTO_order_type] = t.DocType AND
		s.[WSLNID_line_number] = t.LineNumber

WHERE
	[FiscalMonth] = 201711 and
--	t.OrderTakenBy like 'CCS%' AND
	[WS$ESS_equipment_specialist_code] <> t.OrderTakenBy


--DS - failed
SELECT 
	[FiscalMonth]
	,[WSDOCO_salesorder_number]
	,[WSDCTO_order_type]
	,[WSLNID_line_number]
	,[WSDGL__gl_date]
	,[WS$ESS_equipment_specialist_code]
	,[WSCAG__cagess_code]
FROM 
	[comm].[transaction_F555115] s
WHERE
	[FiscalMonth] = 201711 AND
	NOT EXISTS
	(
		SELECT * FROM [dbo].[BRS_Transaction] t
		WHERE 
			s.[WSDOCO_salesorder_number] = t.SalesOrderNumber AND
			s.[WSDCTO_order_type] = t.DocType AND
			s.[WSLNID_line_number] = t.LineNumber
	)


GO


-- set transfer.  Needed?
UPDATE
	BRS_TransactionDW_Ext
SET
	FSC_code = CASE WHEN t.FSC_code<>'' THEN t.FSC_code ELSE BRS_TransactionDW_Ext.FSC_code END,
	ESS_code = CASE WHEN t.ESS_code<>'' THEN t.ESS_code ELSE BRS_TransactionDW_Ext.ESS_code END,
	CPS_code = CASE WHEN t.CPS_code<>'' THEN t.CPS_code ELSE BRS_TransactionDW_Ext.CPS_code END,
	TsTerritoryCd = CASE WHEN t.TsTerritoryCd<>'' THEN t.TsTerritoryCd ELSE BRS_TransactionDW_Ext.TsTerritoryCd END,
	TSS_code = CASE WHEN t.TSS_code<>'' THEN t.TSS_code ELSE BRS_TransactionDW_Ext.TSS_code END,
	CCS_code = CASE WHEN t.CCS_code<>'' THEN t.CCS_code ELSE BRS_TransactionDW_Ext.CCS_code END,
	comm_note= t.comm_note
FROM
	Integration.transaction_transfer AS t 
	INNER JOIN BRS_TransactionDW_Ext ON 
	t.SalesOrderNumber = BRS_TransactionDW_Ext.SalesOrderNumber

SELECT        BRS_TransactionDW_Ext.SalesOrderNumber, BRS_TransactionDW_Ext.TsTerritoryCd, BRS_TransactionDW_Ext.ESS_code, BRS_TransactionDW_Ext.CCS_code, 
                         BRS_TransactionDW_Ext.CPS_code, BRS_TransactionDW_Ext.TSS_code, BRS_TransactionDW_Ext.FSC_code, BRS_TransactionDW_Ext.comm_note
FROM            Integration.transaction_transfer AS t INNER JOIN
                         BRS_TransactionDW_Ext ON t.SalesOrderNumber = BRS_TransactionDW_Ext.SalesOrderNumber



