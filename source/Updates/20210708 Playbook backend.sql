-- Playbook backend, tmc, 8 Jul 21

------------------------------------------------------------
-- set rollups - START
------------------------------------------------------------

-- UPDATE       comm.[group] SET comm_group_scorecard_cd =''

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='DIGIMP'
WHERE        comm_group_cd in (
'DIGCIM'
,'DIGIMP'
,'DIGLAB'
,'DIGOTH'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='DIGMAT'
WHERE        comm_group_cd in (
'DIGMAT'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ITMEQ0'
WHERE        comm_group_cd in (
'ITMEQ0'
,'ITMPAR'

)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ITMFO2'
WHERE        comm_group_cd in (
'FRESEQ'
,'ITMCPU'
,'ITMFO1'
,'ITMFO2'
,'ITMFO3'
,'ITMFRT'
,'ITMISC'
,'ITMSOF'
,'SAFCOM'
,'SPMFGE'
,'SPMFO1'
,'SPMFO2'
,'SPMFO3'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ITMSER'
WHERE        comm_group_cd in (
'ITMSER'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ITMSND'
WHERE        comm_group_cd in (
'FRESND'
,'ITMCAM'
,'ITMEPS'
,'ITMPVT'
,'ITMSND'
,'ITMTEE'
,'REBSND'
,'REBTEE'
,'SPMFGS'
,'SPMPVT'
,'SPMREB'
,'SPMSND'
)

UPDATE       comm.[group]
SET                comm_group_scorecard_cd ='ZZZZZZ'
WHERE        comm_group_cd in (
'      '
,'BONCCS'
,'BONIMP'
,'CPSCNV'
,'CPSCOR'
,'CPSOTH'
,'CPSPOW'
,'CPSSUP'
,'CPSTRA'
,'CPSVCP'
,'CPSZHW'
,'DIGCCC'
,'DIGCCS'
,'EPSBAI'
,'EPSCAO'
,'EPSCHA'
,'EPSDEN'
,'EPSEDG'
,'EPSMIL'
,'EPSORT'
,'EPSOST'
,'EPSREV'
,'SALD30'
,'SCRCRD'
,'SFFFIN'
,'SPMALL'
,'SPMEQU'
,'STMPBA'
,'ZZZZZZ'
)

-- test, this must be Zero
SELECT Count(*) FROM  comm.[group] WHERE comm_group_scorecard_cd = ''

SELECT distinct comm_group_scorecard_cd FROM  comm.[group]
------------------------------------------------------------
-- set rollups - STOP
------------------------------------------------------------

------------------------------------------------------------
-- Wheel
------------------------------------------------------------
-- 1min
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	wheel_active_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_active_ind DEFAULT 0,
	wheel_seg1_merchandise_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_seg1_merchandise_ind DEFAULT 0,
	wheel_seg2_hs_branded_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_seg2_hs_branded_ind DEFAULT 0,
	wheel_seg3_equip_hitech_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_seg3_equip_hitech_ind DEFAULT 0,
	wheel_seg4_digital_restoration_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_seg4_digital_restoration_ind DEFAULT 0,
	wheel_seg5_henry_schein_one_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_seg5_henry_schein_one_ind DEFAULT 0,
	wheel_seg6_equipment_services_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_seg6_equipment_services_ind DEFAULT 0,
	wheel_seg7_business_solutions_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_seg7_business_solutions_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

------------------------------------------------------------
-- HSBranded baseline
------------------------------------------------------------

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnit ADD
	hs_branded_baseline_ind smallint NOT NULL CONSTRAINT DF_BRS_BusinessUnit_hs_branded_baseline_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_BusinessUnit SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE dbo.BRS_BusinessUnit
Set hs_branded_baseline_ind = 1
WHERE 
[BusinessUnit] in(
'020000000000','020000000071','020000000072','020000000073','020001000000','020001000060','020001001000','020001001001','020001001002','020001001003','020001001004','020001001005','020001001006','020001001007','020001001008','020001001009','020001001010','020001001011','020001001012','020001001013','020001001014','020001001015','020001001016','020001001021','020011000000','020017000000','020017000500','020017000700','020040000000','020098000000','020099000000'
)
GO

------------------------------------------------------------
-- Salesforce Support
------------------------------------------------------------

BEGIN TRANSACTION
GO
ALTER TABLE comm.salesperson_master ADD
	sf_adpt_login_score smallint NOT NULL CONSTRAINT DF_salesperson_master_sf_adpt_login_score DEFAULT 0,
	sf_adpt_created_opps_score smallint NOT NULL CONSTRAINT DF_salesperson_master_sf_adpt_created_opps_score DEFAULT 0,
	sf_adpt_activity_score smallint NOT NULL CONSTRAINT DF_salesperson_master_sf_adpt_activity_score DEFAULT 0,
	sf_adpt_pastdue_opps_score smallint NOT NULL CONSTRAINT DF_salesperson_master_sf_adpt_pastdue_opps_score DEFAULT 0,
	sf_adpt_closed_opps_score smallint NOT NULL CONSTRAINT DF_salesperson_master_sf_adpt_closed_opps_score DEFAULT 0,
	sf_opps_equipment_technology_cnt int NOT NULL CONSTRAINT DF_salesperson_master_sf_opps_equipment_technology_cnt DEFAULT 0,
	sf_opps_equipment_technology_amt money NOT NULL CONSTRAINT DF_salesperson_master_sf_opps_equipment_technology_amt DEFAULT 0,
	sf_opps_cadcam_digitial_imaging_cnt int NOT NULL CONSTRAINT DF_salesperson_master_sf_opps_cadcam_digitial_imaging_cnt DEFAULT 0,
	sf_opps_cadcam_digitial_imaging_amt money NOT NULL CONSTRAINT DF_salesperson_master_sf_opps_cadcam_digitial_imaging_amt DEFAULT 0,
	sf_opps_merchandise_cnt int NOT NULL CONSTRAINT DF_salesperson_master_sf_opps_merchandise_cnt DEFAULT 0,
	sf_opps_merchandise_amt money NOT NULL CONSTRAINT DF_salesperson_master_sf_opps_merchandise_amt DEFAULT 0,
	sf_opps_other_cnt int NOT NULL CONSTRAINT DF_salesperson_master_sf_opps_other_cnt DEFAULT 0,
	sf_opps_other_amt money NOT NULL CONSTRAINT DF_salesperson_master_sf_opps_other_amt DEFAULT 0,
	sf_note_dt varchar(50) NULL
GO
ALTER TABLE comm.salesperson_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
