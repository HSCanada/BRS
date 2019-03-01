-- LEGACY Prod comm LOAD
-- run manually, AFTER Dimension sync
-- S:\BR\zDev\BRS\source\Updates\etl_working\20171230 new commission - ETL sync

-- 2 minutes
/** START ***********************/


-- ok
print '1. check fiscal_yearmo_num'
SELECT
	TOP 10
	fiscal_yearmo_num

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_FiscalMonth] WHERE fiscal_yearmo_num = [FiscalMonth]
)

--ok
print '2. check salesperson_cd'
SELECT 
	TOP 10
	salesperson_cd

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE salesperson_cd = [TerritoryCd]
)


--ok
print '3. check pmts_salesperson_cd'
SELECT 
	TOP 10
	pmts_salesperson_cd

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE pmts_salesperson_cd = [TerritoryCd]
)

--ok
print '4. check salesperson_key_id'
SELECT 
	TOP 10
	salesperson_key_id

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[salesperson_master] WHERE salesperson_key_id = [salesperson_key_id]
)

--ok
print '5. check ess_salesperson_key_id'
SELECT 
	TOP 10
	ess_salesperson_key_id

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[salesperson_master] WHERE ess_salesperson_key_id = [salesperson_key_id]
)

--ok
print '6. check comm_plan_id'
SELECT 
	TOP 10
	comm_plan_id

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[plan] WHERE CommBE.[dbo].[comm_transaction].comm_plan_id = [comm_plan_id]
)

--ok
print '7. check ess_comm_plan_id'
SELECT 
	TOP 10
	ess_comm_plan_id

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[plan] WHERE ess_comm_plan_id = [comm_plan_id]
)

--ok
print '8. check item_comm_group_cd'
SELECT 
	TOP 10
	item_comm_group_cd

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[group] WHERE item_comm_group_cd = [comm_group_cd]
)

--ok
print '9. check ess_comm_group_cd'
SELECT 
	TOP 10
	ess_comm_group_cd

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [comm].[group] WHERE ess_comm_group_cd = [comm_group_cd]
)

-- ok
print '10. check ess_comm_group_cd'
SELECT 
	TOP 10
	doc_type_cd

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_DocType] WHERE doc_type_cd = [DocType]
)

--ok
print '11. check hsi_shipto_id'
SELECT 
	TOP 10
	hsi_shipto_id

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_Customer] WHERE hsi_shipto_id = [ShipTo]
)

--ok
print '12. check hsi_billto_id'
SELECT 
	TOP 10
	hsi_billto_id

FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_CustomerBT] WHERE hsi_billto_id = [BillTo]
)
GO

print '13. check item_id'

SELECT 
	distinct	item_id
FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_Item] WHERE Item = item_id
)
GO


-- manually add RESTOCK         

-- ok
print '14. check IMCLMJ'
SELECT 
	TOP 10
	IMCLMJ
FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_ItemMPC] WHERE IMCLMJ = [MajorProductClass]
)
GO

--ok
print '15. check hsi_shipto_div_cd'
SELECT 
	TOP 10
	hsi_shipto_div_cd
FROM CommBE.[dbo].[comm_transaction]
WHERE NOT EXISTS (
	SELECT * FROM [dbo].[BRS_SalesDivision] WHERE hsi_shipto_div_cd = [SalesDivision]
)


print '16. fix null item'

UPDATE       CommBE.dbo.comm_transaction
SET                item_id = ''
WHERE        (item_id IS NULL)

print '17. fix null order_source_cd'
UPDATE       CommBE.dbo.comm_transaction
SET                order_source_cd = ''
WHERE        (order_source_cd IS NULL)
GO

print '18. fix vpa *ERROR* -> {blank}'
UPDATE       CommBE.dbo.comm_transaction
SET                vpa_cd = N''
WHERE        (NOT EXISTS
                             (SELECT        *
                               FROM            BRS_CustomerVPA
                               WHERE        (CommBE.dbo.comm_transaction.vpa_cd = VPA)))
GO

print '19. fix datetime to date'
UPDATE       CommBE.dbo.comm_transaction
SET                transaction_dt = CAST(transaction_dt as date)
WHERE        (NOT EXISTS
                             (SELECT        *
                               FROM            BRS_SalesDay
                               WHERE        (CommBE.dbo.comm_transaction.transaction_dt = SalesDate)))
GO

print '20. fix pricemethod sized 2 to 1'
UPDATE       CommBE.dbo.comm_transaction
SET                price_method_cd = LEFT(price_method_cd,1)
WHERE        (NOT EXISTS
                             (SELECT        *
                               FROM            BRS_PriceMethod
                               WHERE        (CommBE.dbo.comm_transaction.price_method_cd = PriceMethod)))
GO

print '21. fix NA doc_id'
UPDATE       CommBE.dbo.comm_transaction
SET                doc_id = N'0'
WHERE        (doc_id = 'NA')
GO

print '22. fix null SalesOrderNumber'
UPDATE       BRS_Transaction
SET                SalesOrderNumber = 0
WHERE        (DocType = 'aa')  AND (NOT EXISTS
                             (SELECT        * 
                               FROM            BRS_TransactionDW_Ext AS ext
                               WHERE        (BRS_Transaction.SalesOrderNumber = SalesOrderNumber)))
GO

print '23. fix null doc_id'
UPDATE       CommBE.dbo.comm_transaction
SET                doc_id = N'0'
WHERE        (doc_id is null)
GO



-- 30s
print '24. add missing SalesOrderNumber'

INSERT INTO [dbo].[BRS_TransactionDW_Ext] ([SalesOrderNumber],
DocType)
SELECT         distinct SalesOrderNumber,
DocType
FROM            BRS_Transaction t 
where 
	SalesOrderNumber IS NOT NULL AND  
	NOT exists 
	(
		select * from [dbo].[BRS_TransactionDW_Ext] ext where t.SalesOrderNumber = ext.[SalesOrderNumber]
	) 
GO

print '25. fix bad doc_id'
UPDATE       CommBE.dbo.comm_transaction
SET                doc_id = '0'
WHERE        (source_cd <> 'JDE') AND (NOT EXISTS
                             (SELECT        *
                               FROM            BRS_TransactionDW_Ext
                               WHERE        (ISNULL(CommBE.dbo.comm_transaction.doc_id,0) = SalesOrderNumber)))
GO


-- 1m40s
print '26. fix duplicate linenumbers by setting to ID (all imports)'
UPDATE       
	CommBE.dbo.comm_transaction
SET                
	line_id = [record_id],
	[audit_id]=line_id 
where exists(
	SELECT         doc_id,
		doc_type_cd,
		line_id,
		COUNT(*) AS Expr1
	FROM            
		CommBE.dbo.comm_transaction t
	WHERE 
		CommBE.dbo.comm_transaction.doc_id =t.doc_id and CommBE.dbo.comm_transaction.doc_type_cd=t.doc_type_cd and CommBE.dbo.comm_transaction.line_id = t.line_id
	GROUP BY 
		doc_id,
		doc_type_cd,
		line_id
	HAVING 
		COUNT(*) >1
)
GO

print '27. fix remove overlapping line'
UPDATE       CommBE.dbo.comm_transaction
SET                
	line_id = [record_id],
	[audit_id]=line_id 
where 
	fiscal_yearmo_num >= '201801' and
	exists(
		SELECT         
			doc_id,
			doc_type_cd,
			line_id
		FROM            
			comm.transaction_F555115 t
		WHERE 
			CAST(CommBE.dbo.comm_transaction.doc_id as int) =t.WSDOCO_salesorder_number and 
			CommBE.dbo.comm_transaction.doc_type_cd =t.WSDCTO_order_type and 
			CommBE.dbo.comm_transaction.line_id = t.WSLNID_line_number
	) and
	line_id <> [record_id]
GO

/** STOP ***********************/

------------------------------------------------------------------------------------------------------
-- DATA - Migrate legacy
------------------------------------------------------------------------------------------------------

-- first set month below; 1m15s per month'
print 'migrate legacy data AFTER Post adjustment'
INSERT INTO comm.transaction_F555115
(
	FiscalMonth,
	fsc_code,
	source_cd,
	WSDGL__gl_date,
	transaction_amt,
	WSLNID_line_number,
	WSDOCO_salesorder_number,
	WSVR01_reference,
	WS$OSC_order_source_code,
	WSLITM_item_number,
	WSSOQS_quantity_shipped,
	WSPROV_price_override_code,
	WSDSC1_description,
	fsc_salesperson_key_id,
	fsc_comm_plan_id,
	fsc_comm_amt,
	WS$UNC_sales_order_cost_markup,
	WSCYCL_cycle_count_category,
	fsc_comm_group_cd,
	fsc_comm_rt,
	ess_salesperson_key_id,
	gp_ext_amt,
	WSDCTO_order_type,
	ess_comm_plan_id,
	ess_comm_group_cd,
	ess_comm_rt,
	ess_comm_amt,
	WSSHAN_shipto,
	WSSRP1_major_product_class,
	WSSRP2_sub_major_product_class,
	WSSRP3_minor_product_class,
	WSSRP4_sub_minor_product_class,
	WS$ESS_equipment_specialist_code,
	WSCAG__cagess_code,
	WSAN8__billto,
	WSAC10_division_code,
	WSASN__adjustment_schedule,
	WSSRP6_manufacturer,
	WS$PMC_promotion_code_price_method)

SELECT        
--	TOP (10) 
	fiscal_yearmo_num,
	LEFT(salesperson_cd,5),
	LEFT(source_cd,3),
	transaction_dt,
	transaction_amt,
	line_id,
	doc_id,
	ISNULL(reference_order_txt,''),
	order_source_cd,
	LEFT(item_id,10),
	shipped_qty,
	price_override_ind,
	transaction_txt,
	salesperson_key_id,
	comm_plan_id,
	comm_amt,
	cost_unit_amt,
	item_label_cd,
	item_comm_group_cd,
	item_comm_rt,
	ess_salesperson_key_id,
	gp_ext_amt,
	doc_type_cd,
	ess_comm_plan_id,
	ess_comm_group_cd,
	ess_comm_rt,
	ess_comm_amt,
	hsi_shipto_id,
	IMCLMJ,
	IMCLSJ,
	IMCLMC,
	IMCLSM,
	LEFT(ess_salesperson_cd,5),
	LEFT(pmts_salesperson_cd,5),
	hsi_billto_id,
	hsi_shipto_div_cd,
	vpa_cd,
	manufact_cd,
	price_method_cd

FROM            
	CommBE.dbo.comm_transaction
WHERE        
	(hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	(fiscal_yearmo_num = '201901')
GO

-- import to SSAS next

/*
print 'source trans'
SELECT        
count (*) source_count
FROM            
	CommBE.dbo.comm_transaction
WHERE        
	(hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	(fiscal_yearmo_num = '201901')
GO

print 'dest trans'
SELECT        
count (*) dest_count
FROM            
	comm.transaction_F555115
WHERE        
	(FiscalMonth = '201901')
GO

DELETE FROM            
	comm.transaction_F555115
WHERE        
	(FiscalMonth = '201901')
GO

*/

--201601 - 201711; 201712 NEW format
-- check load
Select distinct  FiscalMonth from comm.transaction_F555115


/** STOP ***********************/

--- NEW -- w/f Minnie

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


-- delete  from [comm].[transaction_F555115] where FiscalMonth = 201712

-- load new data source
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
