-- Itemcomm history, tmc 29 May 20
-- setup FSC/ESS/CCS, CPS, EPS history for comm calc repeatabitly and audit

-- setup structure

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemHistory ADD
	HIST_comm_group_cd char(6) NOT NULL CONSTRAINT DF_BRS_ItemHistory_HIST_comm_group_cd DEFAULT '',
	HIST_comm_group_cps_cd char(6) NOT NULL CONSTRAINT DF_BRS_ItemHistory_HIST_comm_group_cps_cd DEFAULT '',
	HIST_comm_group_eps_cd char(6) NOT NULL CONSTRAINT DF_BRS_ItemHistory_HIST_comm_group_eps_cd DEFAULT ''
GO
ALTER TABLE dbo.BRS_ItemHistory ADD CONSTRAINT
	FK_BRS_ItemHistory_group FOREIGN KEY
	(
	HIST_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemHistory ADD CONSTRAINT
	FK_BRS_ItemHistory_group1 FOREIGN KEY
	(
	HIST_comm_group_cps_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemHistory ADD CONSTRAINT
	FK_BRS_ItemHistory_group2 FOREIGN KEY
	(
	HIST_comm_group_eps_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemHistory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- populate structure
UPDATE
	BRS_ItemHistory
SET
	HIST_comm_group_cd = i.comm_group_cd, 
	HIST_comm_group_cps_cd = i.comm_group_cps_cd, 
	HIST_comm_group_eps_cd = i.comm_group_eps_cd
FROM
	BRS_ItemHistory 
	INNER JOIN BRS_Item AS i 
	ON BRS_ItemHistory.Item = i.Item
WHERE
	BRS_ItemHistory.FiscalMonth >= 201901


-- cleanup group, remove unneeded fields
BEGIN TRANSACTION
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT FK_group_group1
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT FK_group_group3
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT FK_group_group4
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT FK_group_group
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT DF_comm_group_comm_status_cd
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT DF_comm_group_comm_group_sm_cd
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT DF_group_comm_group_rollup1cd
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT DF_group_comm_group_rollup2cd
GO
ALTER TABLE comm.[group]
	DROP CONSTRAINT DF_group_comm_group_rollup3cd
GO
ALTER TABLE comm.[group]
	DROP COLUMN comm_status_cd, comm_group_sm_cd, comm_note_txt, comm_group_rollup1_cd, comm_group_rollup2_cd, comm_group_rollup3_cd
GO
ALTER TABLE comm.[group] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
