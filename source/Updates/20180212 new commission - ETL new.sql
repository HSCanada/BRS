-- NEW load
-- this needs a full review

-- check adjustment RI

/** START ***********************/

-- [FiscalMonth]
SELECT     * 
FROM  [Integration].[F555115_commission_sales_adjustment_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_FiscalMonth] s
	where t.FiscalMonth = s.FiscalMonth
)

-- [WSDOCO_salesorder_number]
SELECT     * 
FROM  [Integration].[F555115_commission_sales_adjustment_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_TransactionDW_Ext] s
	where t.WSDOCO_salesorder_number = s.SalesOrderNumber
)

-- [WSSHAN_shipto]
SELECT     * 
FROM  [Integration].[F555115_commission_sales_adjustment_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_Customer] s
	where t.WSSHAN_shipto = s.ShipTo
)

-- [WSLITM_item_number]
SELECT     * 
FROM  [Integration].[F555115_commission_sales_adjustment_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_Item] s
	where t.WSLITM_item_number = s.Item
)

-- [comm_group_cd]
SELECT     * 
FROM  [Integration].[F555115_commission_sales_adjustment_Staging] t
WHERE not exists
(
	select * from [comm].[group] s
	where t.comm_group_cd = s.comm_group_cd
)

-- [fsc_code]
SELECT     * 
FROM  [Integration].[F555115_commission_sales_adjustment_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_FSC_Rollup] s
	where t.fsc_code = s.[TerritoryCd]
)

-- [WS$ESS_equipment_specialist_code]
SELECT     * 
FROM  [Integration].[F555115_commission_sales_adjustment_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_FSC_Rollup] s
	where t.WS$ESS_equipment_specialist_code = s.[TerritoryCd]
)

-- [WSCAG__cagess_code]
SELECT     * 
FROM  [Integration].[F555115_commission_sales_adjustment_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_FSC_Rollup] s
	where t.WSCAG__cagess_code = s.[TerritoryCd]
)

-- review trans

-- select * from [comm].[transaction_F555115] where FiscalMonth = 201701

SELECT DISTINCT [WSTKBY_order_taken_by], [WS$ESS_equipment_specialist_code], [WSCAG__cagess_code], [WS$OSC_order_source_code]
FROM [Integration].[F555115_commission_sales_extract_Staging]

SELECT DISTINCT [WSTKBY_order_taken_by], f.TerritoryCd, [WS$ESS_equipment_specialist_code], [WS$OSC_order_source_code]
FROM 
	[Integration].[F555115_commission_sales_extract_Staging] t
	INNER JOIN [dbo].[BRS_FSC_Rollup] f 
	ON t.[WSTKBY_order_taken_by] = f.TerritoryCd
WHERE f.TerritoryCd <> [WS$ESS_equipment_specialist_code]

SELECT        WSDCTO_order_type,
source_cd,
COUNT(*) AS Expr1
FROM            comm.transaction_F555115
GROUP BY WSDCTO_order_type,
source_cd

select distinct [FiscalMonth]	 from comm.transaction_F555115
-- 
---

-- delete  from [comm].[transaction_F555115] where FiscalMonth = 201910

print 'load new data source from legacy source'
INSERT INTO comm.transaction_F555115
(
	FiscalMonth,
	WSDOCO_salesorder_number,
	WSDCTO_order_type,
	WSLNID_line_number,
	WS$OSC_order_source_code,
	WSAN8__billto,
	WSSHAN_shipto,
	WSDGL__gl_date,
	WSLITM_item_number,
	WSDSC1_description,
	WSSRP1_major_product_class,
	WSSRP2_sub_major_product_class,
	WSSRP3_minor_product_class,
	WSSRP6_manufacturer,
	WSSOQS_quantity_shipped,
	WSAEXP_extended_price,
	WSURAT_user_reserved_amount,
	WS$UNC_sales_order_cost_markup,
	WSVR01_reference,
	WSPROV_price_override_code,
	WSASN__adjustment_schedule,
	WS$PMC_promotion_code_price_method,
	WSCYCL_cycle_count_category,
	WSCAG__cagess_code,
	WS$L01_level_code_01,
	WS$ESS_equipment_specialist_code,
	WSSRP4_sub_minor_product_class,
	WSAC10_division_code,

	-- calculated fields
	[source_cd],
	[transaction_amt],
	[gp_ext_amt],

	-- set defaults
	[fsc_code],
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
--	TOP (10000) 
	d.FiscalMonth,
	t.WSDOCO_salesorder_number,
	t.WSDCTO_order_type,
	ROUND(t.WSLNID_line_number * 1000,0) AS WSLNID_line_number,
	t.WS$OSC_order_source_code,
	t.WSAN8__billto,
	t.WSSHAN_shipto,
	t.WSDGL__gl_date,
	t.WSLITM_item_number,
	t.WSDSC1_description,
	t.WSSRP1_major_product_class,
	t.WSSRP2_sub_major_product_class,
	t.WSSRP3_minor_product_class,
	t.WSSRP6_manufacturer,
	t.WSSOQS_quantity_shipped,
	t.WSAEXP_extended_price,
	t.WSURAT_user_reserved_amount,
	t.WS$UNC_sales_order_cost_markup,
	t.WSVR01_reference,
	t.WSPROV_price_override_code,
	t.WSASN__adjustment_schedule,
	t.WS$PMC_promotion_code_price_method,
	t.WSCYCL_cycle_count_category,
	t.WSCAG__cagess_code,
	t.WS$L01_level_code_01,
	t.WS$ESS_equipment_specialist_code,
	t.WSSRP4_sub_minor_product_class,
	t.WSAC10_division_code,

	-- calculated fields
	'JDE' AS source_cd,
	t.WSAEXP_extended_price				AS [transaction_amt],
	t.WS$UNC_sales_order_cost_markup	AS [gp_ext_amt],

	t.WS$L01_level_code_01				AS [fsc_code],
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

	-- pre check date valid?
	INNER JOIN BRS_SalesDay AS d 
	ON t.WSDGL__gl_date = d.SalesDate

WHERE 
	(WSAC10_division_code NOT IN ('AZA','AZE')) 
go
---

-- delete  from [comm].[transaction_F555115] where FiscalMonth = 201910
/*
SELECT        t.fsc_salesperson_key_id, s.salesperson_key_id, t.fsc_comm_plan_id, s.comm_plan_id, t.fsc_code, f.TerritoryCd, t.fsc_comm_group_cd, t.ess_salesperson_key_id, 
                         t.cps_salesperson_key_id, t.eps_salesperson_key_id, t.ess_comm_group_cd, t.cps_comm_group_cd, t.eps_comm_group_cd
FROM            comm.salesperson_master AS s INNER JOIN
                         BRS_FSC_Rollup AS f ON s.salesperson_key_id = f.comm_salesperson_key_id INNER JOIN
                         comm.transaction_F555115 AS t ON f.TerritoryCd = t.[fsc_code]
WHERE        (t.FiscalMonth = 201910)
go
*/

print 'FSC update plan & terr'
UPDATE       comm.transaction_F555115
SET
	fsc_salesperson_key_id = s.salesperson_key_id, 
	fsc_comm_plan_id = s.comm_plan_id
FROM            comm.salesperson_master AS s INNER JOIN
                         BRS_FSC_Rollup AS f ON s.salesperson_key_id = f.comm_salesperson_key_id INNER JOIN
                         comm.transaction_F555115 ON f.TerritoryCd = comm.transaction_F555115.[fsc_code]
WHERE        (comm.transaction_F555115.FiscalMonth = 201910)
go


print 'ESS update plan & terr'
UPDATE       comm.transaction_F555115
SET
	ess_salesperson_key_id = s.salesperson_key_id, 
	ess_comm_plan_id = s.comm_plan_id
FROM            comm.salesperson_master AS s INNER JOIN
                         BRS_FSC_Rollup AS f ON s.salesperson_key_id = f.comm_salesperson_key_id INNER JOIN
                         comm.transaction_F555115 ON f.TerritoryCd = comm.transaction_F555115.WS$ESS_equipment_specialist_code
WHERE        (comm.transaction_F555115.FiscalMonth = 201910)
go


print 'CPS update plan & terr'
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

	INNER JOIN BRS_FSC_Rollup AS f 
	ON comm.transaction_F555115.fsc_code = f.TerritoryCd 

	INNER JOIN comm.plan_region_map AS m 
	ON m.comm_plan_id = 'CPSGP' AND 
		c.PostalCode LIKE m.postal_code_where_clause_like AND 
		1 = 1 
	INNER JOIN BRS_FSC_Rollup AS sales_key 
	ON sales_key.TerritoryCd = m.TerritoryCd

WHERE
	(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
	(comm.transaction_F555115.FiscalMonth = 201910) AND
	(1 = 1)
go

print 'EPS update plan & terr'
UPDATE
	comm.transaction_F555115
SET
	eps_salesperson_key_id = sales_key.comm_salesperson_key_id , 
	eps_comm_plan_id = m.comm_plan_id , 
	eps_code = m.TerritoryCd
FROM
	comm.transaction_F555115 

	INNER JOIN BRS_Customer AS c 
	ON comm.transaction_F555115.WSSHAN_shipto = c.ShipTo 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON comm.transaction_F555115.fsc_code = f.TerritoryCd 
	INNER JOIN comm.plan_region_map AS m 
	ON m.comm_plan_id = 'EPSGP' AND 
		f.[Branch] = m.[branch_code_where_clause_like] AND 
		1 = 1 
	INNER JOIN BRS_FSC_Rollup AS sales_key 
	ON sales_key.TerritoryCd = m.TerritoryCd

WHERE
	(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
	(comm.transaction_F555115.FiscalMonth = 201910 ) AND
	(1 = 1)
go
--

print 'FSC update item'
UPDATE       comm.transaction_F555115
SET                fsc_comm_group_cd = i.comm_group_cd
FROM            comm.transaction_F555115 t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(i.comm_group_cd <> '') AND 
	(t.FiscalMonth = 201910 ) AND
	(t.fsc_comm_plan_id <> '') AND
	(1 = 1)
GO

print 'ESS update item'
UPDATE       comm.transaction_F555115
SET                ess_comm_group_cd = i.comm_group_cd
FROM            comm.transaction_F555115 t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(i.comm_group_cd <> '') AND 
	(t.FiscalMonth = 201910 ) AND
	(t.ess_comm_plan_id <> '') AND
	(1 = 1)
GO


print 'update CPS item'
UPDATE       comm.transaction_F555115
SET                cps_comm_group_cd = i.comm_group_cps_cd
FROM            comm.transaction_F555115 t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(i.comm_group_cps_cd <> '') AND 
	(t.FiscalMonth = 201910 ) AND
	(t.cps_comm_plan_id <> '') AND
	(1 = 1)
GO

print 'update EPS item'
UPDATE       comm.transaction_F555115
SET                eps_comm_group_cd = i.comm_group_eps_cd
FROM            comm.transaction_F555115 t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(i.comm_group_eps_cd <> '') AND 
	(t.FiscalMonth = 201910 ) AND
	(t.eps_comm_plan_id <> '') AND
	(1 = 1)
GO

/** STOP ***********************/

-- set FSC info -- rough



-- load new data source - TBD
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

	-- calculated fields
	[source_cd],
	[transaction_amt],
	[gp_ext_amt],
	[fsc_code],
	[WS$ESS_equipment_specialist_code],
	[FreeGoodsInvoicedInd],
	[FreeGoodsEstInd]
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

	-- calculated fields
	'JDE' AS source_cd,
	(t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount) 
		AS [transaction_amt],
	(
		(t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount) 
		- (t.WS$UNC_sales_order_cost_markup * t.WSSOQS_quantity_shipped)
	)	AS [gp_ext_amt],

	-- FSC Lookup (assumed monthly pull)
	ISNULL(c.WR$TER_territory_code, '') AS [fsc_code],

	-- ESS correction, clobbered ESS in ordertakenby
	CASE 
		WHEN (t.[WS$ESS_equipment_specialist_code] <> ISNULL(eqfix.TerritoryCd, ''))
		THEN ISNULL(eqfix.TerritoryCd, '')
		ELSE t.[WS$ESS_equipment_specialist_code]
	END AS WS$ESS_equipment_specialist_code,

	-- Free Goods invoiced
	CASE 
		WHEN ([WSSOQS_quantity_shipped] <> 0) AND 
			((t.WSAEXP_extended_price - t.WS$ODS_order_discount_amount) = 0) 
		THEN 1 
		ELSE 0 
	END AS [FreeGoodsInvoicedInd],

	-- TBD
	0 AS [FreeGoodsEstInd]

FROM
	Integration.F555115_commission_sales_extract_Staging AS t 

	-- pre check date valid?
	INNER JOIN BRS_SalesDay AS d 
	ON t.WSDGL__gl_date = d.SalesDate

	-- FSC code
	LEFT JOIN [Integration].[F55510_customer_territory_Staging] AS c
	ON t.WSSHAN_shipto = c.WRSHAN_shipto AND
		c.WR$GTY_group_type = 'AAFS'

	-- Find missed equipment codes due to credit rebill.  RI via rollup...
	LEFT JOIN [dbo].[BRS_FSC_Rollup] eqfix 
	ON t.[WSTKBY_order_taken_by] = eqfix.TerritoryCd AND
		t.[WSTKBY_order_taken_by] <> '' 

WHERE 
	(WSAC10_division_code NOT IN ('AZA','AZE')) 


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

--

Update [dbo].[BRS_FiscalMonth]
	set [comm_status_cd] = 10
WHERE [FiscalMonth] = 201711

Update [dbo].BRS_Config
	set comm_LastWeekly = (SELECT MAX(WSDGL__gl_date) FROM Integration.F555115_commission_sales_extract_Staging)




-- Free Goods Redeem update

TRUNCATE TABLE [Integration].[free_goods_redeem]

-- ADD From Tony excel.

-- check sales order RI
SELECT     count(*)
FROM  [Integration].[free_goods_redeem] t

-- [SalesOrderNumber]
SELECT     *  
FROM  [Integration].[free_goods_redeem] t
WHERE not exists
(
	select * from [dbo].[BRS_TransactionDW_Ext] s
	where t.SalesOrderNumber = s.SalesOrderNumber
)

-- [FiscalMonth]
SELECT     *  
FROM  [Integration].[free_goods_redeem] t
WHERE not exists
(
	select * from [dbo].[BRS_FiscalMonth] s
	where t.FiscalMonth = s.FiscalMonth
)

-- [Supplier]
SELECT     *  
FROM  [Integration].[free_goods_redeem] t
WHERE  not exists
(
	select * from [dbo].[BRS_ItemSupplier] s
	where t.Supplier = s.Supplier
)

-- [ShipTo]
SELECT     *  
FROM  [Integration].[free_goods_redeem] t
WHERE not exists
(
	select * from [dbo].[BRS_Customer] s
	where t.ShipTo = s.ShipTo
)

-- [Item]
SELECT     *  
FROM  [Integration].[free_goods_redeem] t
WHERE not exists
(
	select * from [dbo].[BRS_Item] s
	where t.Item = s.Item
)

-- [Currency]
SELECT     *  
FROM  [Integration].[free_goods_redeem] t
WHERE not exists
(
	select * from [dbo].[BRS_Currency] s
	where t.Currency = s.Currency
)


-- add group by & fx calc

INSERT INTO comm.free_goods_redeem 
(
	[FiscalMonth]
	,[Item]
	,[SalesOrderNumber]
	,[ShipTo]
	,[Supplier]
	,[ExtFileCostCadAmt]
	,[SourceCode]
	,[Currency]
	,[ExtFileCostAmt]
	,[PromoNote]
)

SELECT 
	--top 10

	d.FiscalMonth
	,Item
	,SalesOrderNumber
	,MAX(ShipTo)
	,MAX(Supplier)
	,SUM(d.[ExtFileCostAmt] * (fxcad.FX_per_USD_pnl_rt / fx.FX_per_USD_pnl_rt)) AS ExtFileCostCadAmt
	,MAX(d.[SourceCode])
	,MAX(d.[Currency])
	,SUM(d.[ExtFileCostAmt])
	,MAX(d.[PromoNote])

FROM
	Integration.free_goods_redeem d

	INNER JOIN BRS_CurrencyHistory AS fx 
	ON d.Currency = fx.Currency AND 
		d.FiscalMonth = fx.FiscalMonth 

	INNER JOIN BRS_CurrencyHistory AS fxcad 
	ON d.FiscalMonth = fxcad.FiscalMonth AND 
		fxcad.Currency = 'CAD'
GROUP BY 
	d.FiscalMonth
	,Item
	,SalesOrderNumber



-- Update FreeGoodsRedeemedInd - DW 
UPDATE    BRS_TransactionDW
SET               FreeGoodsRedeemedInd = 1
FROM         comm.free_goods_redeem s INNER JOIN
                      BRS_TransactionDW ON s.SalesOrderNumber = BRS_TransactionDW.SalesOrderNumber AND 
                      s.Item = BRS_TransactionDW.Item
WHERE     (s.FiscalMonth BETWEEN 201701 AND 201712) AND (BRS_TransactionDW.ShippedQty <> 0) AND (BRS_TransactionDW.NetSalesAmt = 0) AND 
                      (BRS_TransactionDW.FreeGoodsRedeemedInd <> 1)

					  
-- Check flag - FreeGoodsRedeemedInd
SELECT     CalMonth, COUNT( CalMonth), sum(GPAtFileCostAmt)
FROM         BRS_TransactionDW
WHERE     (FreeGoodsRedeemedInd = 1)
AND    (CalMonth >= 201701)
GROUP BY CalMonth

-- Update [FreeGoodsInvoicedInd] - Comm

UPDATE    [comm].[transaction_F555115]
SET               [FreeGoodsInvoicedInd] = 1
WHERE     (FiscalMonth BETWEEN 201701 AND 201712) AND ([WSSOQS_quantity_shipped] <> 0) AND ([transaction_amt] = 0) AND 
                      ([FreeGoodsInvoicedInd] <> 1)
-- Update FreeGoodsRedeemedInd - Comm

-- FREE GOODS END

-- [salesperson_master_Staging] BEGIN

--[FiscalMonth]
SELECT     *  
FROM  [Integration].[salesperson_master_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_FiscalMonth] s
	where t.FiscalMonth = s.FiscalMonth
)

--[master_salesperson_cd]
SELECT     *  
FROM  [Integration].[salesperson_master_Staging] t
WHERE not exists
(
	select * from [dbo].[BRS_FSC_Rollup] s
	where t.master_salesperson_cd = s.[TerritoryCd]
)

--[comm_plan_id]
SELECT     *  
FROM  [Integration].[salesperson_master_Staging] t
WHERE not exists
(
	select * from [comm].[plan] s
	where t.comm_plan_id = s.comm_plan_id
)

--[CostCenter]
SELECT     *  
FROM  [Integration].[salesperson_master_Staging] t
WHERE not exists
(
	select * from [hfm].[cost_center] s
	where t.CostCenter = s.CostCenter
)

-- UPDATE [Integration].[salesperson_master_Staging] SET CostCenter = ''

select distinct [comm_status_cd] from [dbo].[BRS_Customer] order by 1

select distinct [comm_status_cd] from [comm].[group] order by 1

select * from [comm].[transaction_F555115] where source_cd =''

---

-- nb rerun comm update restock...


INSERT INTO comm.free_goods_redeem
                         (FiscalMonth, Item, SalesOrderNumber, ExtFileCostCadAmt, ShipTo, Supplier, Note)
SELECT        FiscalMonth, Item, SalesOrderNumber, ExtFileCostAmt, ShipTo, Supplier, NoteTxt
FROM            BRS_FreeGoodsRedeem

drop table [dbo].[STAGE_BRS_FreeGoodsRedeem], [dbo].[BRS_FreeGoodsRedeem]

drop view STAGE_BRS_FreeGoodsRedeem_Load


-- test doc, line match

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
	[FiscalMonth] = 201711 AND
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



--- NEW 

-- Transfer check

-- TBD
-- [SalesOrderNumber]
SELECT     *  
FROM  [Integration].[transaction_transfer] t
WHERE not exists
(
	select * from [dbo].[BRS_TransactionDW_Ext] s
	where t.SalesOrderNumber = s.SalesOrderNumber
)

--[FSC_code]
SELECT     *  
FROM  [Integration].[transaction_transfer] t
WHERE not exists
(
	select * from [dbo].[BRS_FSC_Rollup] s
	where t.[FSC_code] = s.[TerritoryCd]
)

--[ESS_code]
SELECT     *  
FROM  [Integration].[transaction_transfer] t
WHERE not exists
(
	select * from [dbo].[BRS_FSC_Rollup] s
	where t.[ESS_code] = s.[TerritoryCd]
)

-- set transfer
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



--- POST new Trans Stage
INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd],[Branch])
select distinct [WSCAG__cagess_code],
'' from [Integration].[F555115_commission_sales_extract_Staging] 
where not exists (select * from [dbo].[BRS_FSC_Rollup] where [WSCAG__cagess_code] =  [TerritoryCd])
GO

INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd],[Branch])
select distinct [WS$ESS_equipment_specialist_code],
'' from [Integration].[F555115_commission_sales_extract_Staging] 
where not exists (select * from [dbo].[BRS_FSC_Rollup] where [WS$ESS_equipment_specialist_code] =  [TerritoryCd])
GO

INSERT INTO [dbo].[BRS_Item] ([Item])
select distinct [WSLITM_item_number] from [Integration].[F555115_commission_sales_extract_Staging] 
where not exists (select * from [dbo].[BRS_Item] where [WSLITM_item_number] =  [Item])
GO

INSERT INTO [dbo].[BRS_TransactionDW_Ext] ([SalesOrderNumber],[DocType] )
select distinct [WSDOCO_salesorder_number],[WSDCTO_order_type] from [Integration].[F555115_commission_sales_extract_Staging] 
where 
not exists (select * from [dbo].[BRS_TransactionDW_Ext] where [WSDOCO_salesorder_number] =  [SalesOrderNumber]) AND
	(WSAC10_division_code NOT IN ('AZA','AZE')) 



INSERT INTO [dbo].[BRS_Customer] ([ShipTo])
SELECT        
	DISTINCT t.[WSSHAN_shipto]
FROM            Integration.F555115_commission_sales_extract_Staging AS t 
WHERE 
	(WSAC10_division_code NOT IN ('AZA','AZE')) AND 
	NOT EXISTS ( SELECT * FROM [dbo].[BRS_Customer] WHERE ShipTo =t.[WSSHAN_shipto])

