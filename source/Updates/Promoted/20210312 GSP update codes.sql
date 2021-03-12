-- GSP update codes, tmc, 12 Mar 21

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note)
SELECT        'CHAIREQUIP' AS GpsCode, GpsDescr, GpsRuleName, 'CHAIREQUP to CHAIREQUIP' AS Note
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsCode = 'CHAIREQUP')
GO

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note)
SELECT        'DIGLABEQUIP' AS GpsCode, GpsDescr, GpsRuleName, 'DIGLABEQUP to DIGLABEQUIP' AS Note
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsCode = 'DIGLABEQUP')
GO

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note)
SELECT        'LABEQUIPMILL' AS GpsCode, GpsDescr, GpsRuleName, 'LABEQUP to LABEQUIPMILL' AS Note
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsCode = 'LABEQUP')
GO

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note)
SELECT        'LABEQUIPSCAN' AS GpsCode, 'new' as GpsDescr, 'tbd' as GpsRuleName, 'New' AS Note
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsCode = 'CHAIREQUP')
GO

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName, Note)
SELECT        'LABEQUIP3D' AS GpsCode, 'new' as GpsDescr, 'tbd' as GpsRuleName, 'New' AS Note
FROM            hfm.gps_code AS gps_code_1
WHERE        (GpsCode = 'CHAIREQUP')
GO

-- update rules

UPDATE       hfm.gps_code_rule
SET                Gps_Code_TargKey = 'CHAIREQUIP'
WHERE        (Gps_Code_TargKey = 'CHAIREQUP')
GO

UPDATE       hfm.gps_code_rule
SET                Gps_Code_TargKey = 'DIGLABEQUIP'
WHERE        (Gps_Code_TargKey = 'DIGLABEQUP')
GO

UPDATE       hfm.gps_code_rule
SET                Gps_Code_TargKey = 'LABEQUIPMILL'
WHERE        (Gps_Code_TargKey = 'LABEQUP')
GO
