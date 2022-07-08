-- FSC Bonus logic, tmc, 7 Jul 22

-- add generic flag logic for MPC (Equip)
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	comm_bonus1_cd char(6) NOT NULL CONSTRAINT DF_BRS_ItemMPC_comm_fsc_bonus1_cd DEFAULT '',
	comm_bonus2_cd char(6) NOT NULL CONSTRAINT DF_BRS_ItemMPC_comm_bonus2_cd DEFAULT '',
	comm_bonus3_cd char(6) NOT NULL CONSTRAINT DF_BRS_ItemMPC_comm_bonus3_cd DEFAULT ''
GO
ALTER TABLE dbo.BRS_ItemMPC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add generic flag logic for Comm (Equip)
BEGIN TRANSACTION
GO
ALTER TABLE comm.[group] ADD
	comm_bonus1_cd char(6) NOT NULL CONSTRAINT DF_group_comm_bonus1_cd DEFAULT '',
	comm_bonus2_cd char(6) NOT NULL CONSTRAINT DF_group_comm_bonus2_cd DEFAULT '',
	comm_bonus3_cd char(6) NOT NULL CONSTRAINT DF_group_comm_bonus3_cd DEFAULT ''
GO
ALTER TABLE comm.[group] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update with 2022 info
UPDATE dbo.BRS_ItemMPC
set comm_bonus1_cd = 'FSCEQU'
Where [MajorProductClass]
in ('800', '826', '845', '373', '850', '344')
GO

-- update with 2022 info
UPDATE [comm].[group]
set comm_bonus1_cd = 'FSCSND'
Where [comm_group_cd] In ('ITMPVT','ITMSND', 'SPMPVT', 'SPMSND')
GO

UPDATE [comm].[group]
set comm_bonus1_cd = 'FSCEQU'
Where [comm_group_cd] In ('DIGCCS','DIGCIM','DIGIMP','DIGLAB','ITMFO1','ITMFO2','ITMFO3','ITMISC','ITMSOF')
GO

