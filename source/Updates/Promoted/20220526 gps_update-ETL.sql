--gsp_update, tmc, 26 May 22
-- keep this until JDE codes fixed

-- add holding spot for rule-based code which will be replace with the manual corrections
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	GpsKeyORG int NULL
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- create holding area for corrections
BEGIN TRANSACTION
GO
CREATE TABLE hfm.gps_fix_temp
	(
	ID int NOT NULL,
	GpsKey int NOT NULL,
	GpsDescr nvarchar(50) NOT NULL,
	GpsDescrNew nvarchar(50) NOT NULL,
	GpsKeyNew int NULL
	)  ON USERDATA
GO
ALTER TABLE hfm.gps_fix_temp ADD CONSTRAINT
	hfm_gps_fix_temp_c_pk PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE hfm.gps_fix_temp ADD CONSTRAINT
	FK_gps_fix_temp_BRS_Transaction FOREIGN KEY
	(
	ID
	) REFERENCES dbo.BRS_Transaction
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.gps_fix_temp ADD CONSTRAINT
	FK_gps_fix_temp_gps_code FOREIGN KEY
	(
	GpsKeyNew
	) REFERENCES hfm.gps_code
	(
	GpsKey
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.gps_fix_temp SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add 2 new merch codes

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note, GLBU_Class_map)
SELECT        '3DPRINTINGMERCH' AS GpsCode, 'Chairside Merchandise-3D Printing' AS GpsDescr, '<<--3D Merch' AS GpsRuleName, 'new' AS Note, GLBU_Class_map
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsKey = 11)

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note, GLBU_Class_map)
SELECT        'LABMERCH3D' AS GpsCode, 'Digital Lab Merchandise-3D Printing' AS GpsDescr, '<<--3D Merch' AS GpsRuleName, 'new' AS Note, GLBU_Class_map
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsKey = 11)


SELECT *
  FROM [hfm].[gps_code] order by gpskey

  -- add global fix support
  BEGIN TRANSACTION
GO
ALTER TABLE hfm.gps_fix_temp ADD
	global_product_class char(12) NULL,
	global_product_class_key_New int NULL
GO
ALTER TABLE hfm.gps_fix_temp ADD CONSTRAINT
	FK_gps_fix_temp_global_product FOREIGN KEY
	(
	global_product_class_key_New
	) REFERENCES hfm.global_product
	(
	global_product_class_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.gps_fix_temp SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add global fix audit history

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	global_product_class_keyORG int NULL
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

--> fix start here
-- populate hfm.gps_fix_temp from excel

-- truncate table [hfm].[gps_fix_temp]

SELECT count(*) FROM [hfm].[gps_fix_temp]
-- 9710, eq
-- 1859, merch

-- test org gsp, must be Zero PRE update
SELECT        t.ID, t.GpsKey, new.GpsKey AS Expr1, t.GpsKeyORG, new.GpsKeyNew
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE t.GpsKey <> new.GpsKey 
GO

-- test new gsp, must be Zero (after update)
SELECT        t.FiscalMonth,  t.DocType, t.GLBU_Class, t.ID, t.GpsKey, new.GpsKey AS GpsKeyOLD, t.GpsKeyORG, new.GpsKeyNew
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE ISNULL(t.GpsKey,0) <> new.GpsKeyNew
ORDER BY 1


-- test new global, must be Zero (after update)
SELECT        t.FiscalMonth, t.DocType, t.Item, t.GLBU_Class, t.ID, t.[global_product_class_key], new.[global_product_class] AS global_product_classOLD, t.[global_product_class_keyORG], new.[global_product_class_key_New]
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE 
	ISNULL(t.[global_product_class_key],0) <> new.[global_product_class_key_New] AND
--	(t.id = 24571755) AND
--	(t.DocType = 'AA') AND
	(t.Item <> '') AND
	(1=1)
ORDER BY 1
GO

-- update GPS (only change existing gps mapping, to ensure tie-out)
UPDATE       BRS_Transaction
SET                GpsKey = new.GpsKeyNew, GpsKeyORG = BRS_Transaction.GpsKey
FROM            BRS_Transaction INNER JOIN
                         hfm.gps_fix_temp AS new ON BRS_Transaction.ID = new.ID AND ISNULL(BRS_Transaction.GpsKey,0) <> new.GpsKeyNew
GO

-- test post (all diff)
SELECT        t.ID, t.GpsKey,  t.GpsKeyORG
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE t.GpsKeyORG is not null
GO

-- update Global (only change existing gps mapping, to ensure tie-out)
UPDATE       BRS_Transaction
SET
	global_product_class_key = new.global_product_class_key_New, 
	global_product_class_keyORG = global_product_class_key
FROM            BRS_Transaction INNER JOIN
                         hfm.gps_fix_temp AS new 
						 ON BRS_Transaction.ID = new.ID AND 
						 BRS_Transaction.global_product_class_key <> new.global_product_class_key_New
WHERE        (BRS_Transaction.Item <> '') AND (1 = 1)
GO


-- test post (all diff)
SELECT        t.ID, t.global_product_class_key,  t.global_product_class_keyORG
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE t.global_product_class_keyORG is not null
GO

--------------------------------------------------------------------------------------
--add xref, tmc, 8 Mar 23
-- Move to Prod, tmc, 13 Mar 23

BEGIN TRANSACTION
GO
ALTER TABLE hfm.global_product ADD
	GpsCode_Den nchar(30) NOT NULL CONSTRAINT DF_global_product_GpsCode_Den DEFAULT '',
	GpsCode_Lab nchar(30) NOT NULL CONSTRAINT DF_global_product_GpsCode_Lab DEFAULT '',
	GpsCode_note nchar(50) NULL
GO
ALTER TABLE hfm.global_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE hfm.global_product ADD CONSTRAINT
	FK_global_product_gps_code FOREIGN KEY
	(
	GpsCode_Den
	) REFERENCES hfm.gps_code
	(
	GpsCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.global_product ADD CONSTRAINT
	FK_global_product_gps_code1 FOREIGN KEY
	(
	GpsCode_Lab
	) REFERENCES hfm.gps_code
	(
	GpsCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.global_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note)
SELECT        'NonGPS' AS GpsCode, GpsDescr, GpsRuleName, 'NonGPS' AS Note
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsCode = '')
GO

delete from hfm.gps_code where  GpsCode = 'GPS'

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note)
SELECT        'ENDODONTICS' AS GpsCode, GpsDescr, GpsRuleName, 'Endodontics' AS Note
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsCode = 'PORCELAIN')
GO


INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note)
SELECT        'ORTHODONTICS' AS GpsCode, GpsDescr, GpsRuleName, 'Orthodontics' AS Note
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsCode = 'PORCELAIN')
GO

-------------------
-- manual copy from dev to prod here

-- level 1 - 4
SELECT        [global_product_class_key], [level_num], zzzItem.Item, RTRIM(SUBSTRING(zzzItem.Item, 2, 255)) + '%' AS glb, zzzItem.Note1, zzzItem.Note2 
FROM            zzzItem INNER JOIN hfm.global_product 
	ON hfm.global_product.global_product_class like RTRIM(SUBSTRING(zzzItem.Item, 2, 255)) + '%' 
where zzzItem.Item = 'P850-10-40'

SELECT        distinct len(zzzItem.Item)
FROM            zzzItem 
-- 10, 7, 4
-- clear
UPDATE       hfm.global_product
SET                GpsCode_Den = '', GpsCode_Lab = '', GpsCode_note = NULL


-- level 3
UPDATE       hfm.global_product
SET                GpsCode_Den = RTRIM(zzzItem.Note1), GpsCode_Lab = RTRIM(zzzItem.Note2), GpsCode_note = N'tc20230309, 3'
-- SELECT zzzItem.Item, zzzItem.Note1, zzzItem.Note2, s.global_product_class, len(zzzItem.Item), s.GpsCode_note
FROM            zzzItem INNER JOIN
                         hfm.global_product s ON s.global_product_class LIKE RTRIM(SUBSTRING(zzzItem.Item, 2, 255)) + '%'
WHERE
	(len(zzzItem.Item) = 10) AND 
	(s.GpsCode_note IS NULL) AND
--	s.global_product_class = '850-10-40' AND
	(1=1)
GO

-- level 2
UPDATE       hfm.global_product
SET                GpsCode_Den = RTRIM(zzzItem.Note1), GpsCode_Lab = RTRIM(zzzItem.Note2), GpsCode_note = N'tc20230309, 2'
-- SELECT zzzItem.Item, zzzItem.Note1, zzzItem.Note2, s.global_product_class, len(zzzItem.Item), s.GpsCode_note
FROM            zzzItem INNER JOIN
                         hfm.global_product s ON s.global_product_class LIKE RTRIM(SUBSTRING(zzzItem.Item, 2, 255)) + '%'
WHERE
	(len(zzzItem.Item) = 7) AND 
	(s.GpsCode_note IS NULL) AND
--	s.global_product_class = '850-10-40' AND
	(1=1)
GO

-- level 1
UPDATE       hfm.global_product
SET                GpsCode_Den = RTRIM(zzzItem.Note1), GpsCode_Lab = RTRIM(zzzItem.Note2), GpsCode_note = N'tc20230309, 1'
-- SELECT zzzItem.Item, zzzItem.Note1, zzzItem.Note2, s.global_product_class, len(zzzItem.Item), s.GpsCode_note
FROM            zzzItem INNER JOIN
                         hfm.global_product s ON s.global_product_class LIKE RTRIM(SUBSTRING(zzzItem.Item, 2, 255)) + '%'
WHERE
	(len(zzzItem.Item) = 4) AND 
	(s.GpsCode_note IS NULL) AND
--	s.global_product_class = '850-10-40' AND
	(1=1)
GO


-- level 0, default
UPDATE       hfm.global_product
SET                GpsCode_Den = 'NonGPS', GpsCode_Lab = 'NonGPS', GpsCode_note = N'tc20230309, na'
WHERE        (hfm.global_product.GpsCode_note IS NULL)
GO

--

-- model, do update in 3 phases
SELECT        [global_product_class_key], zzzItem.Item, zzzItem.Note1, zzzItem.Note2 
FROM            zzzItem INNER JOIN hfm.global_product 
	ON hfm.global_product.global_product_class like RTRIM(SUBSTRING(zzzItem.Item, 2, 255)) + '%' 
GROUP BY [global_product_class_key], Item, zzzItem.Note1, zzzItem.Note2 



/*
SELECT        *
FROM            hfm.gps_code_rule
WHERE        RuleName = '17a'

SELECT * 
FROM hfm.gps_code
WHERE GpsCode = 'DIGIIMPRES'
GO

INSERT INTO hfm.gps_code_rule
                         (GLBU_Class_WhereClauseLike, BusinessUnit_WhereClauseLike, MinorProductClass_WhereClauseLike, Supplier_WhereClauseLike, SalesDivision_WhereClauseLike, Gps_Code_TargKey, Sequence, RuleName, 
                         LastReviewed, Note, StatusCd)
SELECT        GLBU_Class_WhereClauseLike, BusinessUnit_WhereClauseLike, MinorProductClass_WhereClauseLike, Supplier_WhereClauseLike, 'AAM' AS div, Gps_Code_TargKey, Sequence, '17a2' AS RuleName, 
                         LastReviewed, Note, StatusCd
FROM            hfm.gps_code_rule AS gps_code_rule_1
WHERE        (RuleName = '17a')
GO
*/

-- copy prod to dev, NOT for PROD
-- update GPS
UPDATE       BRS_Transaction
SET                GpsKey = s.GpsKey
-- SELECT d.ID, d.GpsKey, s.GpsKey
FROM
	BRS_Transaction d INNER JOIN

    BRSales.dbo.BRS_Transaction AS s 
	ON s.ID = d.ID AND ISNULL(s.GpsKey,0) <> ISNULL(d.GpsKey,0)
WHERE d.FiscalMonth between 202101 and 202302
GO

-- update global
UPDATE       BRS_Transaction
SET                global_product_class_key = s.global_product_class_key
-- SELECT d.ID, d.global_product_class_key, s.global_product_class_key
FROM
	BRS_Transaction d INNER JOIN

    BRSales.dbo.BRS_Transaction AS s 
	ON s.ID = d.ID AND ISNULL(s.global_product_class_key,0) <> ISNULL(d.global_product_class_key,0)
WHERE d.FiscalMonth between 202101 and 202302
GO

-- archive dev to archive
-- update GPS
UPDATE       BRS_Transaction
SET                GpsKeyORG = GpsKey
-- SELECT ID, GpsKeyORG, GpsKey from BRS_Transaction
	
WHERE FiscalMonth between 202101 and 202302 AND
ISNULL(GpsKeyORG,0) <> ISNULL(GpsKey,0)
GO

-- update global
UPDATE       BRS_Transaction
SET                global_product_class_keyORG = global_product_class_key
-- SELECT ID, global_product_class_keyORG, global_product_class_key from BRS_Transaction
	
WHERE FiscalMonth between 202101 and 202302 AND
ISNULL(global_product_class_keyORG,0) <> ISNULL(global_product_class_key,0)
GO

-- xref for testing

SELECT  RTRIM([global_product_class]) [global_product_class]
      ,RTRIM([GpsCode_Den]) [GpsCode_Den]
      ,RTRIM([GpsCode_Lab]) [GpsCode_Lab]
      ,[GpsCode_note]
	  ,level_num
  FROM [hfm].[global_product]
  where [global_product_class] = '850-10-40'

SELECT * from zzzItem where item like 'P850-10-40%'

-- create script to update GPS based on minor


print ('Fix GPS to match Global - Lab')
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
	(s.FiscalMonth BETWEEN 202101 AND 202212) AND 
	(1 = 1)
-- stop here for update
Order by 1

-- ORG 3546
GO

print ('Fix GPS to match Global - Den')
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
	(s.FiscalMonth BETWEEN 202101 AND 202212) AND 
	(1 = 1)
-- stop here for update
Order by 7

-- ORG 3546
GO


-- Item codes to FIX the system

CREATE TABLE [hfm].[gps_fix_item_jde_temp](
	[Item] [char](10) NOT NULL,
	[global_product_class_new] [char](12) NOT NULL,
	[MinorProductClass] [char](9) NULL,
	[note] [varchar](50) NULL
	
 CONSTRAINT [gps_fix_item_jde_temp_c_pk] PRIMARY KEY CLUSTERED 
(
	[Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


BEGIN TRANSACTION
GO
ALTER TABLE hfm.gps_fix_item_jde_temp ADD CONSTRAINT
	FK_gps_fix_item_jde_temp_BRS_Item FOREIGN KEY
	(
	Item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.gps_fix_item_jde_temp ADD CONSTRAINT
	FK_gps_fix_item_jde_temp_BRS_ItemCategory FOREIGN KEY
	(
	MinorProductClass
	) REFERENCES dbo.BRS_ItemCategory
	(
	MinorProductClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.gps_fix_item_jde_temp ADD CONSTRAINT
	FK_gps_fix_item_jde_temp_global_product FOREIGN KEY
	(
	global_product_class_new
	) REFERENCES hfm.global_product
	(
	global_product_class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.gps_fix_item_jde_temp SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
