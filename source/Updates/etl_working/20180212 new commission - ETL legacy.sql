-- LEGACY Prod comm LOAD
-- run manually, AFTER Dimension sync
-- S:\BR\zDev\BRS\source\Updates\etl_working\20171230 new commission - ETL sync

-- 6 minutes

------------------------------------------------------------------------------------------------------
-- DATA - Migrate legacy - pre
------------------------------------------------------------------------------------------------------

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

-- Sales order fix routines

print '21. Map missing comm doc_id to 0'
UPDATE       CommBE.dbo.comm_transaction
SET                doc_id = N'0', doc_type_cd = 'AA'
WHERE        (doc_id = 'NA') or (doc_id is null)
GO


print '21b. fix missing comm Adj doctype to AA'
UPDATE       CommBE.dbo.comm_transaction
SET                doc_type_cd = 'AA'
WHERE        source_cd <> 'JDE' AND (doc_type_cd = '')
GO


-- 30s
print '22. add missing DS actual SalesOrderNumber to ref list'
INSERT INTO 
	[dbo].[BRS_TransactionDW_Ext] 
	([SalesOrderNumber], DocType)
SELECT
	distinct SalesOrderNumber,DocType
FROM
	BRS_Transaction t 
where 
	SalesOrderNumber IS NOT NULL AND
	t.DocType <> 'AA' AND
	NOT exists 
	(
		select * from [dbo].[BRS_TransactionDW_Ext] ext where t.SalesOrderNumber = ext.[SalesOrderNumber] AND t.DocType = ext.DocType
	) 
GO

-- 30s
print '23. add missing Comm actual SalesOrderNumber to ref list'
INSERT INTO 
	[dbo].[BRS_TransactionDW_Ext] 
	([SalesOrderNumber], DocType)
SELECT
	distinct doc_id,doc_type_cd
FROM
	CommBE.dbo.comm_transaction t 
where
	(t.hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	doc_id IS NOT NULL AND
	source_cd = 'JDE' AND
	NOT exists 
	(
		select * from [dbo].[BRS_TransactionDW_Ext] ext where t.doc_id = ext.[SalesOrderNumber] AND t.doc_type_cd = ext.DocType
	) 
GO

--
print '24. ensure that there is an adjust SO for every actaul SO'
INSERT INTO 
	[dbo].[BRS_TransactionDW_Ext] 
	([SalesOrderNumber], DocType)
SELECT
	distinct SalesOrderNumber, 'AA' DocType
FROM
	[dbo].[BRS_TransactionDW_Ext]  t 
where
--	SALESORDERNUMBER = 12461107 AND
	NOT exists 
	(
		select * from [dbo].[BRS_TransactionDW_Ext]  ext where t.SalesOrderNumber = ext.[SalesOrderNumber] AND 'AA' = ext.DocType
	) 
ORDER BY 1
GO



print 'test SO RI'
SELECT
	distinct fiscal_yearmo_num, source_cd, doc_id,doc_type_cd
FROM
	CommBE.dbo.comm_transaction t 
where
	(t.hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
--	doc_id IS NOT NULL AND
--	source_cd = 'JDE' AND
	NOT exists 
	(
		select * from [dbo].[BRS_TransactionDW_Ext] ext where t.doc_id = ext.[SalesOrderNumber] AND t.doc_type_cd = ext.DocType
	) 
GO

print '25. Fix Comm adj SO=0 where actual trans SO not exist'
UPDATE
	CommBE.dbo.comm_transaction
SET
	doc_id = '0', doc_type_cd = 'AA'
WHERE
	(hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	(source_cd <> 'JDE') AND 
	(
		NOT EXISTS
		(
			SELECT *
			FROM   BRS_TransactionDW_Ext e
			WHERE 
			(
				CommBE.dbo.comm_transaction.doc_id = e.SalesOrderNumber
			)
		)
	)
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
	fiscal_yearmo_num >= '201901' and
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

/*

print 'delete month'
delete  from [comm].[transaction_F555115] where FiscalMonth = 201911

*/

------------------------------------------------------------------------------------------------------
-- DATA - Load LegacyPROD-to-New ( 1 of 3) OR...
------------------------------------------------------------------------------------------------------
-- truncate table comm.transaction_F555115

-- first set month below; 30s per month
print 'migrate legacy data AFTER Post adjustment'
INSERT INTO comm.transaction_F555115
(
	FiscalMonth,fsc_code,source_cd,WSDGL__gl_date,transaction_amt,WSLNID_line_number,WSDOCO_salesorder_number,WSVR01_reference,
	WS$OSC_order_source_code,WSLITM_item_number,WSSOQS_quantity_shipped,WSPROV_price_override_code,WSDSC1_description,
	fsc_salesperson_key_id,fsc_comm_plan_id,fsc_comm_amt,WS$UNC_sales_order_cost_markup,WSCYCL_cycle_count_category,
	fsc_comm_group_cd,fsc_comm_rt,ess_salesperson_key_id,gp_ext_amt,WSDCTO_order_type,ess_comm_plan_id,ess_comm_group_cd,
	ess_comm_rt,ess_comm_amt,WSSHAN_shipto,WSSRP1_major_product_class,WSSRP2_sub_major_product_class,WSSRP3_minor_product_class,
	WSSRP4_sub_minor_product_class,ess_code,WSCAG__cagess_code,WSAN8__billto,WSAC10_division_code,
	WSASN__adjustment_schedule,WSSRP6_manufacturer,WS$PMC_promotion_code_price_method,ID_legacy
)
SELECT
	-- test       
--	TOP (10) 
	fiscal_yearmo_num,LEFT(salesperson_cd,5),LEFT(source_cd,3),transaction_dt,transaction_amt,line_id,doc_id,
	ISNULL(reference_order_txt,''),order_source_cd,LEFT(item_id,10),shipped_qty,price_override_ind,transaction_txt,
	salesperson_key_id,comm_plan_id,comm_amt,cost_unit_amt,item_label_cd,item_comm_group_cd,item_comm_rt,ess_salesperson_key_id,
	gp_ext_amt,doc_type_cd,ess_comm_plan_id,ess_comm_group_cd,ess_comm_rt,ess_comm_amt,hsi_shipto_id,IMCLMJ,IMCLSJ,IMCLMC,IMCLSM,
	LEFT(ess_salesperson_cd,5),LEFT(pmts_salesperson_cd,5),hsi_billto_id,hsi_shipto_div_cd,vpa_cd,manufact_cd,price_method_cd,
	record_id
FROM            
	CommBE.dbo.comm_transaction
WHERE        
	(hsi_shipto_div_cd NOT IN ('AZA','AZE')) AND 
	(fiscal_yearmo_num between  '202001' and '202001') AND
--	(fiscal_yearmo_num = '201910') AND
	-- test
--	(salesperson_cd <> '') AND
--	(ess_salesperson_cd <> '') AND
--	(salesperson_cd like 'C%') AND
--	(ess_salesperson_cd like 'PMT%') AND
--	source_cd in('JDE') AND
--	source_cd in('IMPORT') AND
--	source_cd in('PAYROLL') AND
--	source_cd NOT in('IMPORT', 'PAYROLL') AND
	(1=1)
GO

------------------------------------------------------------------------------------------------------
-- DATA - set calc-key for prod sources
------------------------------------------------------------------------------------------------------
print 'Mark month as loaded'
Update [dbo].[BRS_FiscalMonth]
set [comm_status_cd] = 10
where [FiscalMonth] between 202001 and 202001
go


print 'FSC legacy - key Set'
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
	(t.fsc_code <> '') AND
	(t.fsc_comm_group_cd <> '') AND 
	(t.FiscalMonth between 202001 and 202001 ) AND
--	(t.FiscalMonth = 201910 ) AND
	(1 = 1)
GO

print 'FSC legacy - key Test'
Select 
	t.fsc_comm_plan_id,
	t.fsc_comm_group_cd,
	c.[HIST_cust_comm_group_cd],
	t.[source_cd],
	t.fsc_code,
	t.fsc_comm_group_cd, 
	r.[disp_comm_group_cd]
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
	(t.fsc_code <> '') AND
	(t.fsc_comm_group_cd <> '') AND 
	(t.FiscalMonth between 202001 and 202001 ) AND
--	(t.FiscalMonth = 201910 ) AND
	t.fsc_comm_group_cd <> r.[disp_comm_group_cd] AND
	(1 = 1)
GO

-- ESS
print 'ESS legacy - key Set'
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
	(t.ess_code <> '') AND
	(t.ess_comm_group_cd <> '') AND 
	(t.FiscalMonth between 202001 and 202001 ) AND
--	(t.FiscalMonth = 201910 ) AND
	(1 = 1)
GO

print 'ESS legacy - key Test'
Select 
	t.ess_comm_plan_id,
	t.ess_comm_group_cd,
	c.[HIST_cust_comm_group_cd],
	t.[source_cd],
	t.ess_code,
	t.ess_comm_group_cd, 
	r.[disp_comm_group_cd]
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
	(t.ess_code <> '') AND
	(t.ess_comm_group_cd <> '') AND 
	(t.FiscalMonth between 202001 and 202001 ) AND
--	(t.FiscalMonth = 201910 ) AND
	t.ess_comm_group_cd <> r.[disp_comm_group_cd] AND
	(1 = 1)
GO

-- END

-- CPS
print '12. CPS update plan & terr'
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
	-- must be valid customer, as postal code driven
	(comm.transaction_F555115.WSSHAN_shipto > 0) AND 
	(comm.transaction_F555115.FiscalMonth between 202001 and 202001) AND
	(1 = 1)
GO

print '13. update CPS item'
UPDATE       comm.transaction_F555115
SET                cps_comm_group_cd = i.comm_group_cps_cd
FROM            comm.transaction_F555115 t INNER JOIN
							BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(t.cps_code <> '') AND
	(i.comm_group_cps_cd <> '') AND 
	(t.FiscalMonth between 202001 and 202001) AND
	(1 = 1)
GO

print '14. CPS update comm - non-booking -new'
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
	(t.FiscalMonth between 202001 and 202001 ) AND
	(1 = 1)
GO

print '15. CPS update comm - booking - new'
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
	(t.FiscalMonth between 202001 and 202001 ) AND
	(1 = 1)
GO

print '16. EPS update plan & terr'
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
	(comm.transaction_F555115.FiscalMonth between 202001 and 202001) AND
	(1 = 1)
GO

print '17. update EPS item'
UPDATE       comm.transaction_F555115
SET                eps_comm_group_cd = i.comm_group_eps_cd
FROM            comm.transaction_F555115 t INNER JOIN
							BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        
	(t.eps_code <> '') AND
	(i.comm_group_eps_cd <> '') AND 
	(t.FiscalMonth between 202001 and 202001 ) AND
	(1 = 1)
GO

print '18. EPS update comm - non-booking -new'
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
	(g.booking_rt = 0) AND
	(t.FiscalMonth between 202001 and 202001 ) AND
	(1 = 1)
GO

print '19. EPS update comm - booking - new'
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
	(t.eps_comm_group_cd <> '') AND 
	(g.booking_rt <> 0) AND
	(t.FiscalMonth between 202001 and 202001 ) AND
	(1 = 1)
GO

--< END NEW
