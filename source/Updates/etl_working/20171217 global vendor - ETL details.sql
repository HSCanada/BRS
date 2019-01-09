-- Add the below logic to a post ETL load proc
-- 17 Dec 17, tmc
-- AFTER data flow doc, est *** 5m ***

-- RUN THIS MANUALY UNTIL in proc

--- update F0901 from ETL - run package to update F0901, F0909

--> START to STOP *** Manually ****

print 'add new [dbo].[BRS_BusinessUnit]'
INSERT INTO [dbo].[BRS_BusinessUnit]
(BusinessUnit)
SELECT        Distinct GMMCU__business_unit 
FROM            Integration.F0901_account_master AS s
WHERE NOT EXISTS 
(
	SELECT * FROM [dbo].[BRS_BusinessUnit] b
	WHERE s.GMMCU__business_unit = b.BusinessUnit
)

print 'add new [dbo].[BRS_Object]'
INSERT INTO [dbo].[BRS_Object]
([GLAcctNumberObj])
SELECT        Distinct GMOBJ__object_account 
FROM            Integration.F0901_account_master AS s
WHERE NOT EXISTS 
(
	SELECT * FROM [dbo].[BRS_Object] o
	WHERE s.GMOBJ__object_account = o.[GLAcctNumberObj]
)

print 'add new hfm.account_master_F0901'
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

print 'update bu map - hfm.account_master_F0901'
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


print 'update Obj map - hfm.account_master_F0901'
UPDATE       hfm.account_master_F0901
SET                HFM_Account = [HFM_Account_TargetKey]
FROM            hfm.account_master_F0901 INNER JOIN
                         hfm.object_to_account_map_rule AS m ON 
                         hfm.account_master_F0901.GMMCU__business_unit + hfm.account_master_F0901.GMOBJ__object_account + hfm.account_master_F0901.GMSUB__subsidiary LIKE
                          REPLACE(REPLACE(m.Rule_WhereClauseLike, '?', '_'), '*', '%')
WHERE        (m.ActiveInd = 1) AND ISNULL(HFM_Account, '') <> [HFM_Account_TargetKey]

--> STOP


-- GPS update 1 & 2

---

print 'test Excl_key - should be 0 null records'
select count(*)
FROM
	BRS_ItemHistory 
WHERE
	Excl_key is null AND
	FiscalMonth BETWEEN 201812 AND 201812
GO


print 'reset Excl_key (rough , working, clear all...)'
UPDATE
	BRS_ItemHistory
SET
	Excl_key = Null
FROM
	BRS_ItemHistory 
WHERE
	FiscalMonth BETWEEN 201812 AND 201812
GO

print 'set Exclusives - Excl_key, 1s, 1 OF 3'
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
	FiscalMonth BETWEEN 201812 AND 201812
GO


print 'set private - Excl_key, 2 OF 3'
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
	FiscalMonth BETWEEN 201812 AND 201812
GO


print 'set Branded - Excl_key, 3 of 3'
UPDATE
	BRS_ItemHistory
SET
	Excl_key = 2
FROM
	BRS_ItemHistory 
WHERE 
	Excl_key IS NULL and
	FiscalMonth BETWEEN 201812 AND 201812
GO

-- seq 0 of 2

print 'test GpsKey - should be > 0 records (30k-ish)'
SELECT COUNT(*)
FROM
	BRS_Transaction
WHERE
	GpsKey is NOT null AND
	FiscalMonth BETWEEN 201812 AND 201812
GO

print 'clear GpsKey, if needed'
UPDATE
	BRS_Transaction
SET
	GpsKey = NULL
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
	(BRS_Transaction.FiscalMonth between 201812 and 201812)
GO

-- 1 min
print 'set GpsKey 1 of 2'
UPDATE
	BRS_Transaction
SET
	GpsKey = g.GpsKey
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
-- retro
--	(r.Sequence in (110, 121)) AND 
--	(BRS_Transaction.FiscalMonth between 201701 and 201801)
-- live
	(r.Sequence in (110, 120)) AND 
	(BRS_Transaction.FiscalMonth between 201812 and 201812)
GO

-- 30s
print 'set GpsKey 2 of 2'
UPDATE
	BRS_Transaction
SET
	GpsKey = g.GpsKey
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
	(BRS_Transaction.FiscalMonth between 201812 and 201812)
GO

print 'test Excl_key - should be 0 null records'
select count(*)
FROM
	BRS_ItemHistory 
WHERE
	Excl_key is null AND
	FiscalMonth BETWEEN 201812 AND 201812
GO



--
-- set results to file, CSV format
-- a_CAN_Dec-18_RA.CSV

-- [hfm].global_cube_proc  201812, 201812
