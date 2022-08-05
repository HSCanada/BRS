-- Add the below logic to a post ETL load proc
-- 17 Dec 17, tmc
-- AFTER data flow doc, est *** 5m ***

-- RUN THIS MANUALY UNTIL in proc


-------------------------------------------------------------------------------
-- Part 1 - HFM update, run any time
-------------------------------------------------------------------------------

--- update F0901 from ETL - run package to update F0901, F0909
-- Doc this in Wiki -- DO IT! 31 May 22

--> START to STOP *** Manually ****

print '1. add new [dbo].[BRS_BusinessUnit]'
INSERT INTO [dbo].[BRS_BusinessUnit]
(BusinessUnit)
SELECT        Distinct GMMCU__business_unit 
FROM            Integration.F0901_account_master AS s
WHERE NOT EXISTS 
(
	SELECT * FROM [dbo].[BRS_BusinessUnit] b
	WHERE s.GMMCU__business_unit = b.BusinessUnit
)

print '2. add new [dbo].[BRS_Object]'
INSERT INTO [dbo].[BRS_Object]
([GLAcctNumberObj])
SELECT        Distinct GMOBJ__object_account 
FROM            Integration.F0901_account_master AS s
WHERE NOT EXISTS 
(
	SELECT * FROM [dbo].[BRS_Object] o
	WHERE s.GMOBJ__object_account = o.[GLAcctNumberObj]
)

print '3. add new hfm.account_master_F0901'
INSERT INTO hfm.account_master_F0901
                         (GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, 
                         GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, 
                         GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated)
SELECT        GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, 
                         GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, 
                         GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated
FROM            Integration.F0901_account_master AS s
WHERE NOT EXISTS 
(
	SELECT * FROM hfm.account_master_F0901 d
	WHERE 
		s.[GMMCU__business_unit]=d.[GMMCU__business_unit] AND 
		s.[GMOBJ__object_account] = d.[GMOBJ__object_account] AND
		s.[GMSUB__subsidiary] = d.[GMSUB__subsidiary]
)

print '4. update bu map - hfm.account_master_F0901'
UPDATE       
	hfm.account_master_F0901
SET                
	HFM_CostCenter = b.CostCenter, 
	[LastUpdated]  = getdate()
FROM            
	[dbo].[BRS_BusinessUnit] b 
	INNER JOIN hfm.account_master_F0901 m
ON 
	m.[GMMCU__business_unit] = b.BusinessUnit 
WHERE 
	b.CostCenter <>'' AND
	ISNULL(HFM_CostCenter,'') <> b.CostCenter


print '5. update Obj map - hfm.account_master_F0901'
UPDATE       hfm.account_master_F0901
SET                HFM_Account = [HFM_Account_TargetKey]
FROM            hfm.account_master_F0901 INNER JOIN
                         hfm.object_to_account_map_rule AS m ON 
                         hfm.account_master_F0901.GMMCU__business_unit + hfm.account_master_F0901.GMOBJ__object_account + hfm.account_master_F0901.GMSUB__subsidiary LIKE
                          REPLACE(REPLACE(m.Rule_WhereClauseLike, '?', '_'), '*', '%')
WHERE        (m.ActiveInd = 1) AND ISNULL(HFM_Account, '') <> [HFM_Account_TargetKey]

--> Part 1: STOP

-------------------------------------------------------------------------------
-- Part 2 - HSB update, run after ME snapshot (comm, Monday tasks)
-- http://wiki.br.hsa.ca/wiki/Commission_Backend_BR_Docs_384#Monthend_snapshot
-------------------------------------------------------------------------------

print '6. test Excl_key - should be 0 null records'
select count(*)
FROM
	BRS_ItemHistory 
WHERE
	Excl_key is null AND
	FiscalMonth BETWEEN 202207 AND 202207
GO


print '7. OPTIONAL reset Excl_key (only needed for re-run, working, clear all...)'
UPDATE
	BRS_ItemHistory
SET
	Excl_key = Null
FROM
	BRS_ItemHistory 
WHERE
	FiscalMonth BETWEEN 202207 AND 202207
GO

/*

-- restate rules 201901 - 2021; 
SELECT Excl_Code, BrandEquityCategory,[EffectivePeriod],[ExpiredPeriod]
FROM [hfm].[exclusive_product]
WHERE        [Excl_Code] in ('CAO_LASER', 'COMPUDENT', 'MILESTONE', 'ZIRLUX', 'ZYRISI', 'DENMAT')
GO

-- move from Excl to Brand after 202103
UPDATE       [hfm].[exclusive_product]
--SET                [BrandEquityCategory] = 'Exclusive'
SET                [BrandEquityCategory] = 'Branded'
WHERE        (Excl_Code in('MILESTONE' ))

-- move from Excl to Brand after 202007
UPDATE       [hfm].[exclusive_product]
--SET                [BrandEquityCategory] = 'Exclusive'
SET                [BrandEquityCategory] = 'Branded'
WHERE        ([Excl_Code] = 'CAO_LASER')

-- move from Brand to from Exclafter 202001
UPDATE       [hfm].[exclusive_product]
--SET                [BrandEquityCategory] = 'Exclusive'
SET                [BrandEquityCategory] = 'Branded'
WHERE        ([Excl_Code] = 'DENMAT')


*/

print '8. set Exclusives - Excl_key, 1s, 1 OF 3'
UPDATE       
	BRS_ItemHistory
SET
	Excl_key = p.[Excl_Key]
FROM
	BRS_ItemHistory 
	INNER JOIN hfm.exclusive_product_rule AS r 
	ON BRS_ItemHistory.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		BRS_ItemHistory.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		BRS_ItemHistory.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		BRS_ItemHistory.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		1 = 1 
	INNER JOIN hfm.exclusive_product AS p 
	ON r.Excl_Code_TargKey = p.Excl_Code  
WHERE        
	(r.StatusCd = 1) AND 
	FiscalMonth BETWEEN 202207 AND 202207
GO


print '9. set private - Excl_key, 2 OF 3'
UPDATE
	BRS_ItemHistory
SET
	Excl_key = 1
FROM
	BRS_ItemHistory 

	INNER JOIN BRS_ItemMPC AS mpc 
	ON mpc.MajorProductClass = LEFT(BRS_ItemHistory.MinorProductClass, 3)

WHERE
	(BRS_ItemHistory.Label = 'P') AND 
	(mpc.PrivateLabelScopeInd = 1) AND 
	(BRS_ItemHistory.Excl_key IS NULL) AND
	FiscalMonth BETWEEN 202207 AND 202207
GO


print '10. set Branded - Excl_key, 3 of 3'
UPDATE
	BRS_ItemHistory
SET
	Excl_key = 2
FROM
	BRS_ItemHistory 
WHERE 
	Excl_key IS NULL and
	FiscalMonth BETWEEN 202207 AND 202207
GO

--> STOP (part 2)

-------------------------------------------------------------------------------
-- Part 3 - Global update that is consistent with finacial
--				run after ME adjustment loaded (day 7+)
-------------------------------------------------------------------------------

-- Global 

--> tests here - manual 
-- (see print ('T01: missing ENTITY_sales'), etc)

SELECT
GLBU_Class, GL_BusinessUnit, GL_Object_Sales, GL_Object_Cost, GL_Subsidiary_Sales, GL_Subsidiary_Cost, GL_Subsidiary_ChargeBack, GL_Object_ChargeBack
FROM            BRS_Transaction
where 
	GLBU_Class = 'LEASE' AND
	GL_BusinessUnit ='' AND
	(1=1)
GO

UPDATE       BRS_Transaction
SET
	GL_BusinessUnit = '020019000000'
	,GL_Object_Sales = '4130'
	,GL_Subsidiary_Sales = ''
	,GL_Object_Cost = ''
	,GL_Subsidiary_Cost = ''
	,GL_Subsidiary_ChargeBack = ''
	,GL_Object_ChargeBack = ''
WHERE
	(GLBU_Class = 'LEASE') AND 
	(GL_BusinessUnit = '')
GO


-- SetGLBU 

print ('sales update')
UPDATE
	BRS_Transaction
SET
	[gl_account_sales_key] = a.[gl_account_key]
FROM
	hfm.account_master_F0901 AS a 
	INNER JOIN BRS_Transaction 
	ON a.GMMCU__business_unit = BRS_Transaction.GL_BusinessUnit AND 
		a.GMOBJ__object_account = BRS_Transaction.GL_Object_Sales AND 
		a.GMSUB__subsidiary = BRS_Transaction.GL_Subsidiary_Sales
WHERE
	ISNULL([gl_account_sales_key],0) <> a.[gl_account_key] AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206)
GO

print('sales test')
SELECT
[FiscalMonth], [SalesOrderNumberKEY], [DocType], GLBU_Class, [NetSalesAmt], GL_BusinessUnit, GL_Object_Sales, GL_Object_Cost, GL_Subsidiary_Sales, GL_Subsidiary_Cost, GL_Subsidiary_ChargeBack, GL_Object_ChargeBack
FROM            BRS_Transaction
where 
	([gl_account_sales_key] is null) AND
	([NetSalesAmt] <> 0.0) AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206) AND
	(1=1)
GO

print ('cost update')
UPDATE
	BRS_Transaction
SET
	[gl_account_cost_key] = a.[gl_account_key]
FROM
	hfm.account_master_F0901 AS a 
	INNER JOIN BRS_Transaction 
	ON a.GMMCU__business_unit = BRS_Transaction.GL_BusinessUnit AND 
		a.GMOBJ__object_account = BRS_Transaction.GL_Object_Cost AND 
		a.GMSUB__subsidiary = BRS_Transaction.GL_Subsidiary_Cost
WHERE
	ISNULL([gl_account_cost_key],0) <> a.[gl_account_key] AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206)
GO

print ('cost test')
SELECT
[FiscalMonth], [SalesOrderNumberKEY], [DocType], GLBU_Class, [ExtendedCostAmt], GL_BusinessUnit, GL_Object_Sales, GL_Object_Cost, GL_Subsidiary_Sales, GL_Subsidiary_Cost, GL_Subsidiary_ChargeBack, GL_Object_ChargeBack
FROM            BRS_Transaction
where 
	([gl_account_cost_key] is null) AND
	([ExtendedCostAmt] <> 0.0) AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206) AND
	(1=1)
GO

print ('chargeback update')
UPDATE
	BRS_Transaction
SET
	[gl_account_chargeback_key] = a.[gl_account_key]
FROM
	hfm.account_master_F0901 AS a 
	INNER JOIN BRS_Transaction 
	ON a.GMMCU__business_unit = BRS_Transaction.GL_BusinessUnit AND 
		a.GMOBJ__object_account = BRS_Transaction.GL_Object_ChargeBack AND 
		a.GMSUB__subsidiary = BRS_Transaction.GL_Subsidiary_ChargeBack
WHERE
	ISNULL([gl_account_chargeback_key],0) <> a.[gl_account_key] AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206)
GO

print ('chargeback test')
SELECT
[FiscalMonth], [SalesDivision], [SalesOrderNumberKEY], [DocType], GLBU_Class, [ExtChargebackAmt], GL_BusinessUnit, GL_Object_Sales, GL_Object_Cost, GL_Object_ChargeBack, GL_Subsidiary_Sales, GL_Subsidiary_Cost, GL_Subsidiary_ChargeBack 
FROM            BRS_Transaction
where 
	([gl_account_chargeback_key] is null) AND
	([ExtChargebackAmt] <> 0.0) AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206) AND
	(1=1)
order by GL_BusinessUnit
GO

-- update BRS_ItemCategory!global for new codes first

print ('leasing fix')
print '15b. set Global Item Group - except'
UPDATE       BRS_ItemHistory
	SET [MinorProductClass] = '701-**-**'
WHERE
	(BRS_ItemHistory.Item = '105ZZZZ') AND 
	FiscalMonth BETWEEN 202206 AND 202206
GO

UPDATE       [dbo].[BRS_Transaction]
	SET Item = '105ZZZZ'
-- SELECT *
FROM
    [dbo].[BRS_Transaction]
WHERE
	([GLBU_Class]=  'LEASE') AND 
	-- ([GL_BusinessUnit] ='020019000000') AND
	FiscalMonth BETWEEN 202206 AND 202206 AND
	(1=1)
GO


print '17. set Financial services dummy code - Transaction'
UPDATE       [dbo].[BRS_Transaction]
	SET Item = '105ZZZZ'
-- SELECT *
FROM
    [dbo].[BRS_Transaction]
WHERE
	([GLBU_Class]=  'LEASE') AND 
	-- ([GL_BusinessUnit] ='020019000000') AND
	FiscalMonth BETWEEN 202206 AND 202206 AND
	(1=1)
GO

-------------------------------------------------------------------------------
-- xxx fix 3D printer new mapping, 10 Nov 21
-- update BRS_ItemCategory!global for new codes first
print '16. set Global Item Group - AFTER manual maint'
UPDATE       BRS_ItemHistory
	SET global_product_class = BRS_ItemCategory.global_product_class
FROM
	BRS_ItemHistory  INNER JOIN
    BRS_ItemCategory  ON BRS_ItemHistory.MinorProductClass = BRS_ItemCategory.MinorProductClass
WHERE
	(BRS_ItemHistory.Item > '') AND 
	-- null filter not needed below
	BRS_ItemHistory.global_product_class <> BRS_ItemCategory.global_product_class  AND
	FiscalMonth BETWEEN 202206 AND 202206
GO

-- add the GL vs Global consistence rules corections here...
-- TBD

print '17b. set global - Transaction level'

print ('global JDE - set')
UPDATE
	BRS_Transaction
SET
	global_product_class_key = ig.global_product_class_key
FROM
	BRS_Transaction 

	INNER JOIN 	BRS_ItemHistory AS ih 
	ON BRS_Transaction.Item = ih.Item AND 
		BRS_Transaction.FiscalMonth = ih.FiscalMonth 
		
	INNER JOIN hfm.global_product AS ig 
	ON ih.global_product_class = ig.global_product_class
WHERE
	(BRS_Transaction.Item > '') AND 
	(ISNULL(BRS_Transaction.global_product_class_key,0) <> ig.global_product_class_key) AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206)
GO

-- 50s in dev
print ('global JDE - fix')
UPDATE
	BRS_Transaction
SET
	global_product_class_key = iglob_def.global_product_class_key
FROM
	BRS_Transaction 

	INNER JOIN BRS_BusinessUnitClass AS bu_trans 
	ON BRS_Transaction.GLBU_Class = bu_trans.GLBU_Class 

	INNER JOIN hfm.global_product AS iglob 
	ON BRS_Transaction.global_product_class_key = iglob.global_product_class_key 

	INNER JOIN BRS_BusinessUnitClass AS iglob_bu 
	ON iglob.GLBU_Class_map = iglob_bu.GLBU_Class AND 
	bu_trans.GLBU_Class_map <> iglob_bu.GLBU_Class_map 

	INNER JOIN hfm.global_product AS iglob_def 
	ON bu_trans.global_product_class_default = iglob_def.global_product_class

WHERE
--	(BRS_Transaction.DocType <> 'AA') AND 
	(BRS_Transaction.SalesDivision < 'AZA') AND 
	(bu_trans.GLBU_ClassUS_L1 < 'ZZZZZ') AND 
	(bu_trans.global_product_class_default <> '') AND 
	(BRS_Transaction.global_product_class_key <> iglob_def.global_product_class_key) AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206) AND 
	(1 = 1)
GO

-- set HiCAD to 850-99, if missing
print ('global - set HiCAD to 850-99, if missing')

UPDATE       BRS_Transaction
SET                global_product_class_key = 3310
FROM            BRS_Transaction INNER JOIN
                         BRS_BusinessUnitClass AS bu_trans ON BRS_Transaction.GLBU_Class = bu_trans.GLBU_Class
WHERE
	(BRS_Transaction.SalesDivision < 'AZA') AND 
	(BRS_Transaction.GLBU_Class IN ('EQDIG', 'HICAD')) AND 
	(bu_trans.GLBU_ClassUS_L1 < 'ZZZZZ') AND 
	(BRS_Transaction.global_product_class_key IS NULL) AND 
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206) AND 
	(1 = 1)
GO

-- set BSOLN to 930-99, if missing
print ('global - set BSOLN to 930-99, if missing')
UPDATE       BRS_Transaction
SET                global_product_class_key = 3311
-- SELECT * 
FROM            BRS_Transaction INNER JOIN
                         BRS_BusinessUnitClass AS bu_trans ON BRS_Transaction.GLBU_Class = bu_trans.GLBU_Class
WHERE
	(BRS_Transaction.SalesDivision < 'AZA') AND 
	(BRS_Transaction.GLBU_Class IN ('BSOLN')) AND 
	(bu_trans.GLBU_ClassUS_L1 < 'ZZZZZ') AND 
	(BRS_Transaction.global_product_class_key IS NULL) AND 
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206) AND 
	(1 = 1)
GO



/*
SELECT
	t.FiscalMonth
	, t.SalesOrderNumberKEY
	, t.DocType
	, t.LineNumber
	, t.GLBU_Class
	, t.Item
	, t.global_product_class_key
	, bu_trans.GLBU_Class_map
	, bu_trans.global_product_class_default
	, bu_trans.GLBU_Class_map AS trans_map

FROM
	BRS_Transaction AS t 

	INNER JOIN BRS_BusinessUnitClass AS bu_trans 
	ON t.GLBU_Class = bu_trans.GLBU_Class 
	
WHERE
--	(t.DocType <> 'AA') AND 
	(t.SalesDivision < 'AZA') AND 
	(t.GLBU_Class in ('EQDIG', 'HICAD')) AND
	(bu_trans.GLBU_ClassUS_L1 < 'ZZZZZ') AND 
	(t.global_product_class_key is null) AND
--	(t.id = 21950555) AND
	(t.FiscalMonth BETWEEN 201901 AND 202109) AND 
	(1 = 1)
GO

-- test
SELECT
	t.FiscalMonth
	, t.SalesOrderNumberKEY
	, t.DocType
	, t.LineNumber
	, t.GLBU_Class
	, t.Item
	, t.global_product_class_key
	, bu_trans.GLBU_Class_map
	, bu_trans.global_product_class_default
	, bu_trans.GLBU_Class_map AS trans_map
	, iglob_bu.GLBU_Class_map AS global_map
	, iglob_def.global_product_class_key AS global_product_class_key_def

FROM
	BRS_Transaction AS t 

	INNER JOIN BRS_BusinessUnitClass AS bu_trans 
	ON t.GLBU_Class = bu_trans.GLBU_Class 
	
	INNER JOIN hfm.global_product AS iglob 
	ON t.global_product_class_key = iglob.global_product_class_key 
	
	INNER JOIN BRS_BusinessUnitClass AS iglob_bu 
	ON iglob.GLBU_Class_map = iglob_bu.GLBU_Class AND 
		bu_trans.GLBU_Class_map <> iglob_bu.GLBU_Class_map 
		
	INNER JOIN hfm.global_product AS iglob_def 
	ON bu_trans.global_product_class_default = iglob_def.global_product_class

WHERE
	(t.DocType <> 'AA') AND 
	(t.SalesDivision < 'AZA') AND 
	(bu_trans.GLBU_ClassUS_L1 < 'ZZZZZ') AND 
	(bu_trans.global_product_class_default <> '') AND 
	(t.FiscalMonth BETWEEN 201901 AND 202109) AND 
	(1 = 1)
ORDER BY bu_trans.global_product_class_default
*/

-------------------------------------------------------------------------------
print ('global JDE - test')
SELECT 
	GLBU_Class, MajorProductClass, global_product_class_key, NetSalesAmt 
FROM
	BRS_Transaction 
WHERE
	(BRS_Transaction.Item > '') AND 
	(GLBU_Class <> 'FREIG') AND
	(BRS_Transaction.global_product_class_key =1) AND
	(BRS_Transaction.FiscalMonth BETWEEN 202206 AND 202206)
ORDER BY NetSalesAmt desc
GO



-------------------------------------------------------------------------------
-- Part 4 - GPS update, run after ME adjustment loaded
-------------------------------------------------------------------------------

-- Set GPS rules at the BRS_Transaction.GpsKey level

-- seq 0 of 2

print '11. test GpsKey init - should be 0 records to start, clear if not (below)'
SELECT COUNT(*)
FROM
	BRS_Transaction
WHERE
	GpsKey is NOT null AND
	FiscalMonth BETWEEN 202206 AND 202206
GO

--2 min
/*
print '12. OPTIONAL clear GpsKey, if needed'
UPDATE
	BRS_Transaction
SET
	GpsKey = NULL
WHERE
	(not GpsKey is NULL) AND
	(BRS_Transaction.FiscalMonth between 202205 AND 202205)
GO
*/

-- 1 min
print '13. set GpsKey 1 of 2'
UPDATE
	BRS_Transaction
SET
	GpsKey = g.GpsKey
	-- SELECT count(*) 
FROM
	BRS_ItemHistory AS h 

	INNER JOIN BRS_Transaction 
	ON h.Item = BRS_Transaction.Item AND 
		h.FiscalMonth = BRS_Transaction.FiscalMonth 

	INNER JOIN hfm.gps_code_rule AS r 
	ON BRS_Transaction.GLBU_Class LIKE RTRIM(r.GLBU_Class_WhereClauseLike) AND 
		BRS_Transaction.GL_BusinessUnit LIKE RTRIM(r.BusinessUnit_WhereClauseLike) AND 
		h.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		h.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		BRS_Transaction.SalesDivision LIKE RTRIM(r.SalesDivision_WhereClauseLike) AND
		1 = 1 

	INNER JOIN hfm.gps_code AS g 
	ON r.Gps_Code_TargKey = g.GpsCode
WHERE
	--
	--(BRS_Transaction.GpsKey IS NULL) AND
	--

-- retro
--	(r.Sequence in (110, 121)) AND 
--	(BRS_Transaction.FiscalMonth between 201701 and 201801)
-- live
	(r.Sequence in (110, 120)) AND 
	(BRS_Transaction.FiscalMonth between 202206 AND 202206)
GO

-- 30s
print '14. set GpsKey 2 of 2'
UPDATE
	BRS_Transaction
SET
	GpsKey = g.GpsKey
	-- SELECT count(*)
FROM
	BRS_ItemHistory AS h 
	INNER JOIN BRS_Transaction 
	ON h.Item = BRS_Transaction.Item AND 
	h.FiscalMonth = BRS_Transaction.FiscalMonth 

	INNER JOIN hfm.gps_code_rule AS r 
	ON BRS_Transaction.GLBU_Class LIKE RTRIM(r.GLBU_Class_WhereClauseLike) AND 
	BRS_Transaction.GL_BusinessUnit LIKE RTRIM(r.BusinessUnit_WhereClauseLike) AND 
	h.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
	h.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
	BRS_Transaction.SalesDivision LIKE RTRIM(r.SalesDivision_WhereClauseLike) AND
	1 = 1 

	INNER JOIN hfm.gps_code AS g 
	ON r.Gps_Code_TargKey = g.GpsCode
WHERE
	(BRS_Transaction.GpsKey IS NULL) AND
-- retro
--	(r.Sequence in (230, 241)) AND 
--	(BRS_Transaction.FiscalMonth between 201701 and 201801)
-- live
	(r.Sequence in (230, 240)) AND 
	(BRS_Transaction.FiscalMonth between 202206 AND 202206)
GO

print '15. test GpsKey - should be > 0 records'
SELECT COUNT(*)
FROM
	BRS_Transaction
WHERE
	GpsKey is null AND
	FiscalMonth BETWEEN 202206 AND 202206
GO

-------------------------------------------------------------------------------
-- Part 5 - export file
-------------------------------------------------------------------------------

--
-- 1. set results to file, CSV format
-- 2. copy below
-- a_CAN_May-22_RA.csv
-- TEMP use Access to fix source
-- 3. select & run below
-- [hfm].global_cube_new_proc  202205

-------------------------------------------------------------------------------

