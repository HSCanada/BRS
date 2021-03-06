-- LEGACY Prod comm LOAD
-- run manually, AFTER Dimension sync
-- S:\BR\zDev\BRS\source\Updates\etl_working\20171230 new commission - ETL sync

------------------------------------------------------------------------------------------------------
-- scrub Prod
------------------------------------------------------------------------------------------------------

-- ensure compare prod CommBE vs prod BRSales
use BRSales
GO

print '1. fix item_id NULL -> {blank}'
UPDATE
	CommBE.dbo.comm_transaction
SET
	item_id = ''
WHERE
	(item_id IS NULL)
GO

print '2. fix order_source_cd NULL -> {blank}'
UPDATE
	CommBE.dbo.comm_transaction
SET
	order_source_cd = ''
WHERE
	(order_source_cd IS NULL)
GO

print '3. fix vpa_cd *ERROR* -> {blank}'
UPDATE
	CommBE.dbo.comm_transaction
SET
	vpa_cd = N''
WHERE NOT EXISTS
(
	SELECT	*
	FROM    BRS_CustomerVPA
	WHERE   (CommBE.dbo.comm_transaction.vpa_cd = VPA)
)
GO

print '4. fix transaction_dt - datetime -> date'
UPDATE
	CommBE.dbo.comm_transaction
SET
	transaction_dt = CAST(transaction_dt as date)
WHERE NOT EXISTS
(
	SELECT	*
	FROM	BRS_SalesDay
	WHERE	(CommBE.dbo.comm_transaction.transaction_dt = SalesDate)
)
GO

print '5. fix price_method_cd - size 2 -> 1'
UPDATE
	CommBE.dbo.comm_transaction
SET
	price_method_cd = LEFT(price_method_cd,1)
WHERE NOT EXISTS
(
	SELECT	*
	FROM	BRS_PriceMethod
	WHERE	(CommBE.dbo.comm_transaction.price_method_cd = PriceMethod)
)
GO

-- Sales order fix routines
print '6. fix vpa_cd - missing -> 0'
UPDATE
	CommBE.dbo.comm_transaction
SET
	doc_id = N'0', 
	doc_type_cd = 'AA'
WHERE
	(doc_id = 'NA') OR
	(doc_id is null)
GO


print '7. fix doc_type_cd - missing -> AA'
UPDATE
	CommBE.dbo.comm_transaction
SET
	doc_type_cd = 'AA'
WHERE
	(source_cd <> 'JDE') AND 
	(doc_type_cd = '')
GO
---
INSERT INTO 
	[dbo].[BRS_TransactionDW_Ext] 
	(
		[SalesOrderNumber], 
		DocType
	)
SELECT DISTINCT 
	s.SalesOrderNumber, 
	'AA' DocType
FROM
	[dbo].[BRS_TransactionDW_Ext]  s 
WHERE
	NOT EXISTS 
	(
		SELECT * 
		FROM [dbo].[BRS_TransactionDW_Ext]  d
		WHERE d.SalesOrderNumber = s.[SalesOrderNumber] AND 
		d.DocType = 'AA'
	) 

---
print '8. test SO RI - stop if > 0'
SELECT
	DISTINCT fiscal_yearmo_num, source_cd, doc_id,doc_type_cd
FROM
	CommBE.dbo.comm_transaction d 
where
	(d.hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	NOT EXISTS 
	(
		SELECT * 
		FROM [dbo].[BRS_TransactionDW_Ext] s 
		WHERE d.doc_id = s.[SalesOrderNumber] AND 
			d.doc_type_cd = s.DocType
	) 
GO

------------------------------------------------------------------------------------------------------
-- stop
------------------------------------------------------------------------------------------------------

-- ensure step 8 succeeds for JDE, only IMP should be "fixed"
print '9. Fix doc_id - set to 0 if RI fails'
UPDATE
	CommBE.dbo.comm_transaction
SET
	doc_id = '0', doc_type_cd = 'AA'
WHERE
	(hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	(source_cd <> 'JDE') AND 
	NOT EXISTS
	(
		SELECT *
		FROM   BRS_TransactionDW_Ext e
		WHERE CommBE.dbo.comm_transaction.doc_id = e.SalesOrderNumber
	)
GO

-- set line = recode_id where doc = 0
print '10. fix line_id where no salesorder'
UPDATE       
	CommBE.dbo.comm_transaction
SET                
	line_id = [record_id],
	[audit_id]=line_id 
WHERE
	[fiscal_yearmo_num]	>= '202001' AND
	(doc_id = 0) AND
	(line_id <> record_id) AND
	(1=1)
GO

print '11. fix duplicate line_id - set to ID if dup'
UPDATE       
	CommBE.dbo.comm_transaction
SET                
	line_id = [record_id],
	[audit_id]=line_id 
WHERE EXISTS
(
	SELECT
		doc_id,
		doc_type_cd,
		line_id,
		COUNT(*) AS Expr1
	FROM            
		CommBE.dbo.comm_transaction t
	WHERE 
		CommBE.dbo.comm_transaction.doc_id =t.doc_id and 
		CommBE.dbo.comm_transaction.doc_type_cd=t.doc_type_cd and 
		CommBE.dbo.comm_transaction.line_id = t.line_id
	GROUP BY 
		doc_id,
		doc_type_cd,
		line_id
	HAVING 
		COUNT(*) >1
)
GO

print '12. fix missing FSC comm_plan_id - use existing sales as source'
UPDATE
	CommBE.[dbo].[comm_transaction]
SET
	comm_plan_id = s.comm_plan_id
FROM
	CommBE.[dbo].[comm_transaction] d 
	INNER JOIN
	(
		SELECT DISTINCT 
			fiscal_yearmo_num, salesperson_key_id, comm_plan_id
        FROM            
			CommBE.[dbo].[comm_transaction] AS t
        WHERE        
			([fiscal_yearmo_num] >= '202001') AND 
			(source_cd = 'JDE') AND 
			(salesperson_key_id <> '') AND 
			(comm_plan_id <> '') AND 
			(1 = 1)
	) AS s 
	ON d.[fiscal_yearmo_num] = s.[fiscal_yearmo_num] AND 
		d.salesperson_key_id = s.salesperson_key_id
WHERE
	(d.[fiscal_yearmo_num] >= 201901) AND 
	(d.source_cd = 'IMPORT') AND 
	(d.salesperson_key_id <> '') AND 
	(d.comm_plan_id = '') AND 
	(1 = 1)
GO

print '13. test missing FSC - stop if > 0, manual fix'
SELECT        
--	TOP (1000) 
	distinct
	[fiscal_yearmo_num],
	salesperson_key_id,
	comm_plan_id,
	[record_id]

FROM
	CommBE.[dbo].[comm_transaction] AS t
WHERE
	([fiscal_yearmo_num] >= 201901) AND 
	(source_cd = 'IMPORT') AND 
	-- fsc or ess
	(salesperson_key_id <> '') AND 
	(comm_plan_id = '') AND
	(1=1)
GO

------------------------------------------------------------------------------------------------------
-- stop, if prior report > 0
------------------------------------------------------------------------------------------------------

-- this fails when no JDE trans for the month -- CCS.  
-- Use current?  Active vs non logic...
print '14. fix missing ESS comm_plan_id - use existing'
UPDATE
	CommBE.[dbo].[comm_transaction]
SET
	ess_comm_plan_id = s.ess_comm_plan_id
FROM
	CommBE.[dbo].[comm_transaction] d 
	INNER JOIN
	(
		SELECT DISTINCT 
			[fiscal_yearmo_num], ess_salesperson_key_id, ess_comm_plan_id
        FROM            
			CommBE.[dbo].[comm_transaction] AS t
        WHERE        
			([fiscal_yearmo_num] >= '202001') AND 
			(source_cd = 'JDE') AND 
			(ess_salesperson_key_id <> '') AND 
			(ess_comm_plan_id <> '') AND 
			(1 = 1)
	) AS s 
	ON d.[fiscal_yearmo_num] = s.[fiscal_yearmo_num] AND 
		d.ess_salesperson_key_id = s.ess_salesperson_key_id
WHERE
	(d.[fiscal_yearmo_num] >= '202001') AND 
	(d.source_cd = 'IMPORT') AND 
	(d.ess_salesperson_key_id <> '') AND 
	(d.ess_comm_plan_id = '') AND 
	(1 = 1)
GO

print '15. test missing ESS - stop if > 0'
SELECT        
--	TOP (1000) 
	distinct
	[fiscal_yearmo_num],
	ess_salesperson_key_id,
	ess_comm_plan_id

FROM
	CommBE.[dbo].[comm_transaction] AS t
WHERE
	([fiscal_yearmo_num] >= 202001) AND 
	(source_cd = 'IMPORT') AND 
	-- fsc or ess
	(ess_salesperson_key_id <> '') AND 
	(ess_comm_plan_id = '') AND
	(1=1)
------------------------------------------------------------------------------------------------------
-- stop, if prior > 0
------------------------------------------------------------------------------------------------------


-- XXX TDB Add IMPORT fix so that :  IF FSC sales KEY then NOT ESS ess_comm_plan_id	ess_salesperson_key_id	ess_code
/*
print '16. Fix duplicate FSC ESS assignments on IMPORTS'
SELECT        
	TOP (1000) 
	[fiscal_yearmo_num],
	doc_id,
	line_id,
	source_cd,
	order_source_cd,
	salesperson_cd,
	salesperson_key_id,

	ess_comm_plan_id,
	ess_salesperson_key_id,
	ess_salesperson_cd,

	transaction_amt,
	gp_ext_amt

FROM
	CommBE.[dbo].[comm_transaction] AS t
WHERE
	([fiscal_yearmo_num] >= 201901) AND 
	(source_cd = 'IMPORT') AND 
	-- fsc or ess
	(salesperson_key_id <> '') AND 
	(salesperson_cd <>'') AND
	(ess_salesperson_key_id <> '') AND 
	(1=1)
ORDER BY 1


-- XXX TDB Add IMPORT fix so that :  IF FSC sales KEY then NOT ESS ess_comm_plan_id	ess_salesperson_key_id	ess_code
print '16. Fix duplicate FSC ESS assignments on IMPORTS'
UPDATE       CommBE.dbo.comm_transaction
SET
ess_comm_plan_id ='', 
ess_salesperson_key_id ='', 
ess_salesperson_cd = ''
WHERE        
(fiscal_yearmo_num >= 201901) AND (source_cd = 'IMPORT') AND (salesperson_key_id <> '') AND (salesperson_cd <> '') AND (ess_salesperson_key_id <> '') AND (1 = 1)
*/
/*
print '17. Fix bad FSC IMPORTS '
SELECT        
	TOP (1000) 
	[fiscal_yearmo_num],
	doc_id,
	line_id,
	source_cd,
	order_source_cd,
	ess_salesperson_cd,
	ess_salesperson_key_id,
	ess_comm_plan_id,

	comm_plan_id,
	salesperson_key_id,
	salesperson_cd,

	transaction_amt,
	gp_ext_amt

FROM
	CommBE.[dbo].[comm_transaction] AS t
WHERE
	([fiscal_yearmo_num] >= 201901) AND 
	(source_cd = 'IMPORT') AND 
	-- fsc or ess
	(salesperson_key_id <> '') AND 
	(salesperson_cd ='') AND
--	(ess_salesperson_key_id <> '') AND 
	(1=1)
ORDER BY 1


UPDATE        CommBE.dbo.comm_transaction
SET
	comm_plan_id ='', 
	salesperson_key_id =''
WHERE
(fiscal_yearmo_num >= 201901) AND (source_cd = 'IMPORT') AND (salesperson_key_id <> '') AND (salesperson_cd = '') AND (1 = 1)
*/
------------------------------------------------------------------------------------------------------
-- load Prod
------------------------------------------------------------------------------------------------------

print 'manual check src linecount'
SELECT
	count(*) src_count 
FROM            
	CommBE.dbo.comm_transaction
WHERE        
	(hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	(fiscal_yearmo_num ='202002') AND
	(1=1)
GO

print 'manual check dst linecount'
SELECT
	count(*) dst_count
FROM            
	comm.transaction_F555115
WHERE        
	(WSAC10_division_code NOT IN ('AZA','AZE')) AND 
	(FiscalMonth =  '202002') AND
	(1=1)
GO

-- Set to DEV?  (assuming DEV in synch with PROD)
-- truncate table comm.transaction_F555115
-- delete from comm.transaction_F555115 where FiscalMonth = '202012' AND source_cd NOT in('JDE')
-- delete from comm.transaction_F555115 where FiscalMonth between 202001 and 202012 AND source_cd NOT in('JDE')

-- first set month below; 2m per month
print '100. load prod data'
INSERT INTO comm.transaction_F555115
(
	FiscalMonth
	,fsc_code
	,source_cd
	,WSDGL__gl_date
	,transaction_amt
	,WSLNID_line_number
	,WSDOCO_salesorder_number
	,WSDOC__document_number
	,WSVR01_reference
	,WS$OSC_order_source_code
	,WSLITM_item_number
	,WSSOQS_quantity_shipped
	,WSPROV_price_override_code
	,WSDSC1_description
	,fsc_salesperson_key_id
	,fsc_comm_plan_id
	,fsc_comm_amt
	,WS$UNC_sales_order_cost_markup
	,WSCYCL_cycle_count_category
	,fsc_comm_group_cd
	,fsc_comm_rt
	,ess_salesperson_key_id
	,gp_ext_amt
	,WSDCTO_order_type
	,ess_comm_plan_id
	,ess_comm_group_cd
	,ess_comm_rt
	,ess_comm_amt
	,WSSHAN_shipto
	,WSSRP1_major_product_class
	,WSSRP2_sub_major_product_class
	,WSSRP3_minor_product_class
	,WSSRP4_sub_minor_product_class
	,ess_code
	,[WS$ESS_equipment_specialist_code]
	,WSCAG__cagess_code
	,WSAN8__billto
	,WSAC10_division_code
	,WSASN__adjustment_schedule
	,WSSRP6_manufacturer
	,WS$PMC_promotion_code_price_method
	,ID_legacy
)
SELECT
	-- test       
--	TOP (10) 
	-- temp Dec -> Jan
	202101 as fiscal_yearmo_num
	,LEFT(salesperson_cd,5) salesperson_cd
	,LEFT(source_cd,3) source_cd
	,transaction_dt
	,transaction_amt
	-- temp Dec -> Jan
	,record_id*2 as line_id
--	,line_id
	,doc_id as salesorder
	,doc_id
	,ISNULL(reference_order_txt,'') reference_order_txt
	,order_source_cd
	,LEFT(item_id,10) item_id
	,shipped_qty
	,price_override_ind
	,transaction_txt
	,salesperson_key_id
	,comm_plan_id
	,comm_amt
	,cost_unit_amt
	,item_label_cd
	,item_comm_group_cd
	,item_comm_rt
	,ess_salesperson_key_id
	,gp_ext_amt
	,doc_type_cd
	,ess_comm_plan_id
	,ess_comm_group_cd
	,ess_comm_rt
	,ess_comm_amt
	,hsi_shipto_id
	,IMCLMJ
	,IMCLSJ
	,IMCLMC
	,IMCLSM
	,LEFT(ess_salesperson_cd,5) ess_salesperson_cd
	-- dup ESS ok
	,LEFT(ess_salesperson_cd,5) ess_salesperson_cd
	,LEFT(pmts_salesperson_cd,5) pmts_salesperson_cd
	,hsi_billto_id
	,hsi_shipto_div_cd
	,vpa_cd
	,manufact_cd
	,price_method_cd
	,record_id
FROM            
	CommBE.dbo.comm_transaction
WHERE        
	(hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	(fiscal_yearmo_num between  '202012' and '202012') AND
--	load only adj? (comment out next line for all)
	source_cd NOT in('JDE') AND
--	test
--	(doc_id = 13182717 ) AND
	(1=1)
GO

print 'update adjustment support table'
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
--	(s.FiscalMonth = @nCurrentFiscalYearmoNum) AND
	NOT EXISTS
	(
		SELECT * FROM [comm].[adjustment] d 
		WHERE
			(d.[adj_comment_org] = ISNULL(s.[WSDSC1_description],'')) AND
			(d.[adj_source_org] = UPPER(ISNULL(s.[WSVR01_reference],'')))
	) 

/*
-- Fix ESS 
-- reset ESS based on load 1
UPDATE       comm.transaction_F555115
SET                ess_code =WS$ESS_equipment_specialist_code
WHERE        (FiscalMonth >= 201901) AND (xfer_ess_code_org = ess_code) AND (ess_code <> WS$ESS_equipment_specialist_code) AND (source_cd = 'JDE') AND (1 = 1)

-- reset ESS based on transfer capture 2
UPDATE       comm.transaction_F555115
SET                ess_code = xfer_ess_code_org
WHERE        (FiscalMonth >= 201901) AND (xfer_ess_code_org <> ess_code) AND (WS$ESS_equipment_specialist_code = xfer_ess_code_org) AND (source_cd = 'JDE') AND (1 = 1)

-- reset ESS based on transfer 3
UPDATE       comm.transaction_F555115
SET                xfer_ess_code_org = '', xfer_fsc_code_org = '', xfer_key = NULL
WHERE        (FiscalMonth >= 201901) AND (xfer_key > 1) AND (source_cd = 'JDE') AND (1 = 1)

-- fix ESS default  4
UPDATE       comm.transaction_F555115
SET                WS$ESS_equipment_specialist_code = ess_code
WHERE        (FiscalMonth >= 201901) AND (WSORD__equipment_order <> '') AND (WSTKBY_order_taken_by LIKE 'ESS%' OR
                         WSTKBY_order_taken_by LIKE 'CCS%' OR
                         WSTKBY_order_taken_by LIKE 'PMT%' OR
                         WSTKBY_order_taken_by LIKE 'DTS%' OR
                         WSTKBY_order_taken_by LIKE 'DSS%') AND (ess_code <> WS$ESS_equipment_specialist_code) AND (source_cd = 'JDE') AND (1 = 1)
*/
/*
select
-- top 10
[FiscalMonth]
,ess_code
,[WS$ESS_equipment_specialist_code]
,WSORD__equipment_order
,WSTKBY_order_taken_by
,[xfer_ess_code_org]
,xfer_fsc_code_org
,xfer_key 
FROM [comm].[transaction_F555115] 
WHERE 
	([FiscalMonth] >= 201901) AND
	(xfer_key>1) AND
--	[xfer_ess_code_org]<>[ess_code] AND
--	[WS$ESS_equipment_specialist_code] = [xfer_ess_code_org] AND
	(source_cd = 'JDE') AND
	(1=1)

select
--	top 10
	[FiscalMonth]
	,ess_code
	,[WS$ESS_equipment_specialist_code]
	,WSORD__equipment_order
	,WSTKBY_order_taken_by
	,[xfer_ess_code_org]
FROM 
	[comm].[transaction_F555115] 
WHERE 
	([FiscalMonth] >= 201901) AND
	(WSORD__equipment_order <>'') AND
	(
		(WSTKBY_order_taken_by like 'ESS%') OR
		(WSTKBY_order_taken_by like 'CCS%') OR
		(WSTKBY_order_taken_by like 'PMT%') OR
		-- EQ legacy
		(WSTKBY_order_taken_by like 'DTS%') OR
		(WSTKBY_order_taken_by like 'DSS%') 
	) AND
	(ess_code <> [WS$ESS_equipment_specialist_code]) AND
	(source_cd = 'JDE') AND
	(1=1)
*/

-- rebuild for legacy calc, 2019+
-- First ensure procs and support tables updated 
/*
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202006
Exec comm.transaction_commission_calc_proc @bDebug=0, @bLegacy=1
GO

-- test
select distinct FiscalMonth from comm.transaction_F555115

-- Prod
Exec comm.transaction_commission_calc_proc @bDebug=0, @bLegacy=1

-- Debug
Exec comm.transaction_commission_calc_proc @bDebug=1, @bLegacy=1

*/

-- UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202012
-- Exec comm.transaction_commission_calc_proc @bDebug=0
