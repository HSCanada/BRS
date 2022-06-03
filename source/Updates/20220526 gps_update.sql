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

SELECT count(*) FROM [hfm].[gps_fix_temp]
-- 4916

-- XXX fix global as well 

-- test org gsp, must be Zero
SELECT        t.ID, t.GpsKey, new.GpsKey AS Expr1, t.GpsKeyORG, new.GpsKeyNew
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE t.GpsKey <> new.GpsKey 
GO

-- test new gsp, must be Zero (after update)
SELECT        t.ID, t.GpsKey, new.GpsKey AS Expr1, t.GpsKeyORG, new.GpsKeyNew
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE t.GpsKey <> new.GpsKeyNew

-- update
UPDATE       BRS_Transaction
SET                GpsKey = new.GpsKeyNew, GpsKeyORG = BRS_Transaction.GpsKey
FROM            BRS_Transaction INNER JOIN
                         hfm.gps_fix_temp AS new ON BRS_Transaction.ID = new.ID AND BRS_Transaction.GpsKey <> new.GpsKeyNew


-- test post
SELECT        t.ID, t.GpsKey,  t.GpsKeyORG
FROM            BRS_Transaction AS t INNER JOIN
                         hfm.gps_fix_temp AS new ON t.ID = new.ID
WHERE t.GpsKeyORG is not null
