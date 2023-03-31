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

-- moved to weekly proc
-- Prod
-- EXECUTE pricing.order_note_post_proc @bDebug=0

--> Part 1: STOP

-------------------------------------------------------------------------------
-- Part 2 - HSB update, run after ME snapshot (comm, Monday tasks)
-- http://wiki.br.hsa.ca/wiki/Commission_Backend_BR_Docs_384#Monthend_snapshot
-------------------------------------------------------------------------------

-- moved to monthly proc
-- Prod
-- EXEC dbo.monthend_snapshot_proc @bDebug=0

--> STOP (part 2)

-------------------------------------------------------------------------------
-- Part 3 - Global update that is consistent with finacial
--				run after ME adjustment loaded (day 7+)
-------------------------------------------------------------------------------

-- moved to monthly proc
-- Prod
-- EXEC dbo.monthend_finalize_proc @bDebug=0



-- make new GSP proc here  (may be temp until codes fixed in JDE) TBD
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
	FiscalMonth BETWEEN 202301 AND 202302
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
	(BRS_Transaction.FiscalMonth between 202301 AND 202302)
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
	(BRS_Transaction.FiscalMonth between 202301 AND 202302)
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
	(BRS_Transaction.FiscalMonth between 202301 AND 202302)
GO

--
/*
-- test script tbd - Use Acess "qupd_hfm_gps_fix_item_jde_temp"
print ('15. GPS crosswalk pre-fix - Item Global override')
print ('global JDE - fix')
UPDATE
	BRS_Transaction
SET
	global_product_class_key = iglob_def.global_product_class_key
FROM
	BRS_Transaction s

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
	-- exclude internal
	(s.SalesDivision < 'AZA') AND 
	-- exclude GL based lines
	(s.GLBU_Class NOT IN('ZZZZZ', 'PROMX', 'PROMC', 'PROMM', 'ALLOE', 'ALLOM', 'ALLOT', 'CAMLG', 'FREIG', 'REBAT', 'EXNSW', 'BSOLN'  )) AND
	-- include item base global (these set by prior rules)
	(iglob.[global_product_class] <> '') AND

	-- Lab select
	(LEFT(ch.HIST_MarketClass,1)='Z') AND
	(ISNULL(gps.[GpsCode],'') <> ISNULL([GpsCode_Lab],'')) AND

	-- Update Time Select
	(s.FiscalMonth BETWEEN 202101 AND 202212) AND 
	(1 = 1)
-- stop here for update
Order by 1
*/


print ('16. GPS crosswalk fix - Lab')
UPDATE
	BRS_Transaction
SET
	GpsKey = gps_new.[GpsKey]
-- SELECT  s.[FiscalMonth] ID, s.GLBU_Class, s.[DocType], s.item, iglob.[global_product_class], RTRIM(ch.HIST_MarketClass) HIST_MarketClass, [GpsCode_Den], [GpsCode_Lab], gps.[GpsCode] GpsCodeCURR, gps_new.[GpsCode]
FROM
	BRS_Transaction s

	-- customer history
	INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
	ON s.Shipto = ch.[Shipto] AND
		s.[FiscalMonth] = ch.[FiscalMonth]

	-- Current Global
	INNER JOIN [hfm].[global_product] as iglob
	ON s.[global_product_class_key] = iglob.global_product_class_key

	-- GPS Current
	LEFT JOIN [hfm].[gps_code] gps
	ON s.GpsKey = gps.[GpsKey]

	-- GPS Lab New
	INNER JOIN [hfm].[gps_code] gps_new
	ON iglob.GpsCode_Lab = gps_new.[GpsCode]

WHERE
	-- exclude internal
	(s.SalesDivision < 'AZA') AND 
	-- exclude GL based lines
	(s.GLBU_Class NOT IN('ZZZZZ', 'PROMX', 'PROMC', 'PROMM', 'ALLOE', 'ALLOM', 'ALLOT', 'CAMLG', 'FREIG', 'REBAT', 'EXNSW', 'BSOLN'  )) AND
	-- include item base global (these set by prior rules)
	(iglob.[global_product_class] <> '') AND

	-- Lab select
	(LEFT(ch.HIST_MarketClass,1)='Z') AND
	(ISNULL(gps.[GpsCode],'') <> ISNULL([GpsCode_Lab],'')) AND

	-- Update Time Select
	(s.FiscalMonth BETWEEN 202301 AND 202302) AND 
	(1 = 1)
-- stop here for update
Order by 1

-- ORG 3546
GO

print ('17. GPS crosswalk fix - Den')
UPDATE
	BRS_Transaction
SET
	GpsKey = gps_new.[GpsKey]
-- SELECT  s.[FiscalMonth] ID, s.GLBU_Class, s.[DocType], s.item, iglob.[global_product_class], RTRIM(ch.HIST_MarketClass) HIST_MarketClass, [GpsCode_Den], [GpsCode_Lab], gps.[GpsCode] GpsCodeCURR, gps_new.[GpsCode]
FROM
	BRS_Transaction s

	-- customer history
	INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
	ON s.Shipto = ch.[Shipto] AND
		s.[FiscalMonth] = ch.[FiscalMonth]

	-- Current Global
	INNER JOIN [hfm].[global_product] as iglob
	ON s.[global_product_class_key] = iglob.global_product_class_key

	-- GPS Current
	LEFT JOIN [hfm].[gps_code] gps
	ON s.GpsKey = gps.[GpsKey]

	-- GPS Den New
	INNER JOIN [hfm].[gps_code] gps_new
	ON iglob.GpsCode_Den = gps_new.[GpsCode]

WHERE
	-- exclude internal
	(s.SalesDivision < 'AZA') AND 
	-- exclude GL based lines
	(s.GLBU_Class NOT IN('ZZZZZ', 'PROMX', 'PROMC', 'PROMM', 'ALLOE', 'ALLOM', 'ALLOT', 'CAMLG', 'FREIG', 'REBAT', 'EXNSW', 'BSOLN'  )) AND
	-- include item base global (these set by prior rules)
	(iglob.[global_product_class] <> '') AND

	-- Den select
	(LEFT(ch.HIST_MarketClass,1)<>'Z') AND
	(ISNULL(gps.[GpsCode],'') <> ISNULL([GpsCode_Den],'')) AND

	-- Update Time Select
	(s.FiscalMonth BETWEEN 202301 AND 202302) AND 
	(1 = 1)
-- stop here for update
Order by 7

-- ORG 3546
GO

--
print '15. test GpsKey - should be > 0 records'
SELECT COUNT(*)
FROM
	BRS_Transaction
WHERE
	GpsKey is null AND
	FiscalMonth BETWEEN 202301 AND 202302
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
-- [hfm].global_cube_new_proc  202212

-------------------------------------------------------------------------------

