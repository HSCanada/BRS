--> in prod, 4 Jul 19

BEGIN TRANSACTION
GO
ALTER TABLE comm.[group] ADD
	comm_group_rollup1_cd char(6) NOT NULL CONSTRAINT DF_group_comm_group_rollup1cd DEFAULT '',
	comm_group_rollup2_cd char(6) NOT NULL CONSTRAINT DF_group_comm_group_rollup2cd DEFAULT '',
	comm_group_rollup3_cd char(6) NOT NULL CONSTRAINT DF_group_comm_group_rollup3cd DEFAULT ''
GO
ALTER TABLE comm.[group] ADD CONSTRAINT
	FK_group_group1 FOREIGN KEY
	(
	comm_group_rollup1_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.[group] ADD CONSTRAINT
	FK_group_group3 FOREIGN KEY
	(
	comm_group_rollup2_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.[group] ADD CONSTRAINT
	FK_group_group4 FOREIGN KEY
	(
	comm_group_rollup3_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.[group] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

update [comm].[group]
set comm_group_rollup1_cd = [comm_group_cd],
comm_group_rollup2_cd = [comm_group_cd],
comm_group_rollup3_cd = [comm_group_cd]

-- manual set rolllup 1, 2, 3 based on legacy fsc and ess statement view

--< end prod 

-- done?