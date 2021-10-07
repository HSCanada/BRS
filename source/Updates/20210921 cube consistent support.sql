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

select distinct [SourceCd] from dbo.BRS_DocType

insert into [comm].[source]
(source_cd, source_desc)
VALUES ('ADJ', 'Adjustments')

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_DocType ADD CONSTRAINT
	FK_BRS_DocType_source FOREIGN KEY
	(
	SourceCd
	) REFERENCES comm.source
	(
	source_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_DocType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- speed-up index?

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX BRS_Transaction_idx_06 ON dbo.BRS_Transaction
	(
	GL_BusinessUnit
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- add field for global name WHEN doct.SourceCd = 'JDE' THEN 'GL_Input' ELSE 'Manual_Entry' 

BEGIN TRANSACTION
GO
ALTER TABLE comm.source ADD
	source_global_desc varchar(40) NOT NULL CONSTRAINT DF_source_source_global_desc DEFAULT ''
GO
ALTER TABLE comm.source SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE comm.source
set source_global_desc = 'GL_Input'
WHERE source_cd = 'JDE'

UPDATE comm.source
set source_global_desc = 'Manual_Entry'
WHERE source_cd = 'ADJ'

-- specialty 

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerSpecialty ADD
	specialty_key int IDENTITY(1,1) NOT NULL
GO
ALTER TABLE dbo.BRS_CustomerSpecialty SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE [hfm].[account_master_F0901] ADD
	gl_account_key int IDENTITY(1,1) NOT NULL
GO
ALTER TABLE [hfm].[account_master_F0901] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX account_master_F0901_u_idx_02 ON hfm.account_master_F0901
	(
	gl_account_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE hfm.account_master_F0901 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- GL and excl data 

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	gl_account_sales_key int NULL,
	gl_account_cost_key int NULL,
	gl_account_chargeback_key int NULL,
	Excl_Key int NULL
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	global_product_class_key int NULL
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX global_product_u_idx_01 ON hfm.global_product
	(
	global_product_class_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE hfm.global_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- GL and excl RI

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_account_master_F0901 FOREIGN KEY
	(
	gl_account_sales_key
	) REFERENCES hfm.account_master_F0901
	(
	gl_account_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_account_master_F09011 FOREIGN KEY
	(
	gl_account_cost_key
	) REFERENCES hfm.account_master_F0901
	(
	gl_account_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_account_master_F09012 FOREIGN KEY
	(
	gl_account_chargeback_key
	) REFERENCES hfm.account_master_F0901
	(
	gl_account_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_exclusive_product FOREIGN KEY
	(
	Excl_Key
	) REFERENCES hfm.exclusive_product
	(
	Excl_Key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_global_product FOREIGN KEY
	(
	global_product_class_key
	) REFERENCES hfm.global_product
	(
	global_product_class_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- cb fix.  weird stuff


INSERT INTO hfm.account_master_F0901
                         (GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, GMDL01_description, GMLDA__account_level_of_detail, 
                         GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated, HFM_CostCenter, HFM_Account, 
                         LastUpdated, HFM_SourceCode)
SELECT        GMCO___company, 'tc1' AS Expr1, '020020000000' AS Expr2, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, 
                         GMPEC__posting_edit, 'TC' AS Expr3, GMPID__program_id, GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated, HFM_CostCenter, HFM_Account, LastUpdated, HFM_SourceCode
FROM            hfm.account_master_F0901 AS account_master_F0901_1
WHERE        (GMOBJ__object_account = '4730') AND ([GMMCU__business_unit] = '020020001008')
go

INSERT INTO hfm.account_master_F0901
                         (GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, GMDL01_description, GMLDA__account_level_of_detail, 
                         GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated, HFM_CostCenter, HFM_Account, 
                         LastUpdated, HFM_SourceCode)
SELECT        GMCO___company, 'tc2' AS Expr1, '020017000700' AS Expr2, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, 
                         GMPEC__posting_edit, 'TC' AS Expr3, GMPID__program_id, GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated, HFM_CostCenter, HFM_Account, LastUpdated, HFM_SourceCode
FROM            hfm.account_master_F0901 AS account_master_F0901_1
WHERE        (GMOBJ__object_account = '4730') AND ([GMMCU__business_unit] = '020017000000')
go

INSERT INTO hfm.account_master_F0901
                         (GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, GMDL01_description, GMLDA__account_level_of_detail, 
                         GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated, HFM_CostCenter, HFM_Account, 
                         LastUpdated, HFM_SourceCode)
SELECT        GMCO___company, 'tc3' AS Expr1, '020051000000' AS Expr2, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, 
                         GMPEC__posting_edit, 'TC' AS Expr3, GMPID__program_id, GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated, HFM_CostCenter, HFM_Account, LastUpdated, HFM_SourceCode
FROM            hfm.account_master_F0901 AS account_master_F0901_1
WHERE        (GMOBJ__object_account = '4730') AND ([GMMCU__business_unit] = '020020001008')
go

-- bad adj
UPDATE       BRS_Transaction
SET                GL_BusinessUnit = '020001000000'
WHERE        (ID = 23815119)

-- GLBU mapping

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnitClass ADD
	GLBU_Class_map char(5) NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_Class_map DEFAULT ''
GO
ALTER TABLE dbo.BRS_BusinessUnitClass ADD CONSTRAINT
	FK_BRS_BusinessUnitClass_BRS_BusinessUnitClass5 FOREIGN KEY
	(
	GLBU_Class_map
	) REFERENCES dbo.BRS_BusinessUnitClass
	(
	GLBU_Class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_BusinessUnitClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'MERCH'
WHERE [GLBU_Class] in ('MERCH', 'SMEQU', 'VETER', 'MEDIC')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'EQUIP'
WHERE [GLBU_Class] in ('EQUIP', 'HITEC', 'FRTEQ')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'PARTS'
WHERE [GLBU_Class] in ('PARTS')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'LABOU'
WHERE [GLBU_Class] in ('LABOU')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'HICAD'
WHERE [GLBU_Class] in ('HICAD', 'EQDIG')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'TEETH'
WHERE [GLBU_Class] in ('TEETH')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'MECAD'
WHERE [GLBU_Class] in ('MECAD', 'MECAZ')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'DTXSP'
WHERE [GLBU_Class] in ('DTXSP', 'DTXHW', 'DTXSW')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'BSOLN'
WHERE [GLBU_Class] in ('BSOLN')
GO
UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'LEASE'
WHERE [GLBU_Class] in ('LEASE')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'FREIG'
WHERE [GLBU_Class] in ('FREIG')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'FREIG'
WHERE [GLBU_Class] in ('FREIG')
GO

UPDATE BRS_BusinessUnitClass
set [GLBU_Class_map] = 'ZZZZZ'
WHERE [GLBU_Class] in ('ZZZZZ', 'PROMX', 'PROMC', 'ALLOE', 'ALLOM', 'ALLOT','','CAMLG','EXNSW')
GO



-- adj global default

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnitClass ADD
	global_product_class_default char(12) NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_global_product_class DEFAULT ''
GO
ALTER TABLE dbo.BRS_BusinessUnitClass ADD CONSTRAINT
	FK_BRS_BusinessUnitClass_global_product FOREIGN KEY
	(
	global_product_class_default
	) REFERENCES hfm.global_product
	(
	global_product_class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_BusinessUnitClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
