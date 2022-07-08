--gsp_update, tmc, 26 May 22

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

--truncate table [hfm].[gps_fix_temp]

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

-- update GPS (only change existing gps mapping, to ensure tie-out)
UPDATE       BRS_Transaction
SET                GpsKey = new.GpsKeyNew, GpsKeyORG = BRS_Transaction.GpsKey
FROM            BRS_Transaction INNER JOIN
                         hfm.gps_fix_temp AS new ON BRS_Transaction.ID = new.ID AND BRS_Transaction.GpsKey <> new.GpsKeyNew

-- test post (all diff)
SELECT        t.ID, t.GpsKey,  t.GpsKeyORG
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE t.GpsKeyORG is not null

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

-- test post (all diff)
SELECT        t.ID, t.global_product_class_key,  t.global_product_class_keyORG
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE t.global_product_class_keyORG is not null
