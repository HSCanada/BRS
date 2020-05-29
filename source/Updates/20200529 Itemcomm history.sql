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


