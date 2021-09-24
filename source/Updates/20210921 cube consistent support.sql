-- cube consistent support, tmc, 15 Sept 21

--
-- create support

-- add gl map to GPS

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnitClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE hfm.gps_code ADD
	GLBU_Class_map char(5) NOT NULL CONSTRAINT DF_gps_code_GLBU_Class_map DEFAULT ('')
GO
ALTER TABLE hfm.gps_code ADD CONSTRAINT
	FK_gps_code_BRS_BusinessUnitClass FOREIGN KEY
	(
	GLBU_Class_map
	) REFERENCES dbo.BRS_BusinessUnitClass
	(
	GLBU_Class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.gps_code SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- create consistency rollup for cube

-- set unuzed map to ZZZ

--
-- populate support

insert into 
[hfm].[gps_code]
(
	[GpsCode]
	,[GpsDescr]
	,[GpsRuleName]
	,[Note]

)
SELECT  
	'LABEQUIP' AS [GpsCode]
	,[GpsDescr]
	,[GpsRuleName]
	,'LABEQUP to LABEQUIP' AS [Note]
  FROM [hfm].[gps_code]
  where GpsCode = 'LABEQUP'
GO

SELECT  *
  FROM [hfm].[gps_code]
  where GpsCode = 'LABEQUIP'
GO

insert into 
[hfm].[gps_code]
(
	[GpsCode]
	,[GpsDescr]
	,[GpsRuleName]
	,[Note]

)
VALUES 
('3DPRINTING', 'new', 'na','new'),
('DDXGRP', 'new', 'na','new'),
('USDENT_LABMERCH', 'new', 'na','new')
GO

-- setup GSP vs GL mapping 

UPDATE [hfm].[gps_code]
SET [GLBU_Class_map] = 'EQDIG'
WHERE [GpsCode] in ('3DPRINTING', 'DIGIIMPRES', 'DIGLABEQUIP', 'DIGLABEQUP', 'LABEQUIP3D', 'LABEQUIPMILL', 'LABEQUIPSCAN')
GO

UPDATE [hfm].[gps_code]
SET [GLBU_Class_map] = 'EQUIP'
WHERE [GpsCode] in ('LABEQUP', 'LABEQUIP')
GO

UPDATE [hfm].[gps_code]
SET [GLBU_Class_map] = 'HICAD'
WHERE [GpsCode] in ('CHAIREQUIP', 'CHAIREQUP')
GO

UPDATE [hfm].[gps_code]
SET [GLBU_Class_map] = 'MECAD'
WHERE [GpsCode] in ('CHAIRMERCH')
GO

UPDATE [hfm].[gps_code]
SET [GLBU_Class_map] = 'MERCH'
WHERE [GpsCode] in ('ALLOY', 'DIGLABMERCH', 'LABMERCH', 'OTHERMERCH', 'PORCELAIN')
GO

UPDATE [hfm].[gps_code]
SET [GLBU_Class_map] = 'TEETH'
WHERE [GpsCode] in ('TEETH')
GO

UPDATE [hfm].[gps_code]
SET [GLBU_Class_map] = 'ZZZZZ'
WHERE [GpsCode] in ('BONEREGE_GPS', 'BONEREGE_OTHER', 'CUSTMILL', 'DDXGRP', 'DIGLABSVCS', 'IMPLANTS_GPS', 'USDENT_LABMERCH')
GO


--
-- fix data

-- merge DIGLABEQUP -> DIGLABEQUIP & DIGLABEQUP -> DIGLABEQUIP, 

-- CHAIREQUIP (4 -> 18)
UPDATE       BRS_Transaction
SET                GpsKey = 18
WHERE        (GpsKey = 4)
GO

-- DIGLABEQUIP (12 -> 19)
UPDATE       BRS_Transaction
SET                GpsKey = 19
WHERE        (GpsKey = 12)
GO

-- LABEQUIP (10 -> 23)
UPDATE       BRS_Transaction
SET                GpsKey = 23
WHERE        (GpsKey = 10)
GO

--
-- add new rules 3