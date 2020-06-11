-- commission repeatability, tmc, 10 Jun 20

-- setup history struct

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	cust_comm_group_cd char(6) NULL
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group4 FOREIGN KEY
	(
	cust_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- customer history...

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	HIST_fsc_salesperson_key_id varchar(30) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_fsc_salesperson_key_id DEFAULT '',
	HIST_fsc_comm_plan_id char(10) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_fsc_comm_plan_id DEFAULT '',

	HIST_cps_code char(5) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_cps_code DEFAULT '',
	HIST_cps_salesperson_key_id varchar(30) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_cps_salesperson_key_id DEFAULT '',
	HIST_cps_comm_plan_id char(10) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_cps_comm_plan_id DEFAULT '',
	HIST_eps_code char(5) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_eps_code DEFAULT '',
	HIST_eps_salesperson_key_id varchar(30) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_eps_salesperson_key_id DEFAULT '',
	HIST_eps_comm_plan_id char(10) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_eps_comm_plan_id DEFAULT ''
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_salesperson_master_fsc FOREIGN KEY
	(
	HIST_fsc_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_plan_fsc FOREIGN KEY
	(
	HIST_fsc_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_BRS_FSC_Rollup_cps FOREIGN KEY
	(
	HIST_cps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_salesperson_master_cps FOREIGN KEY
	(
	HIST_cps_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_plan_cps FOREIGN KEY
	(
	HIST_cps_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_BRS_FSC_Rollup_eps FOREIGN KEY
	(
	HIST_eps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_salesperson_master_eps FOREIGN KEY
	(
	HIST_eps_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_plan_eps FOREIGN KEY
	(
	HIST_eps_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- pop FSC test, logic in new comm ETL sync
/*
SELECT
	CAST(fiscal_yearmo_num AS int) AS FiscalMonth
	,hsi_shipto_id
	,MIN(salesperson_cd) AS salesperson_cd_MIN
	,MAX(salesperson_cd) AS salesperson_cd_MAX
	,MIN(salesperson_key_id) AS salesperson_key_id_MIN
	,MAX(salesperson_key_id) AS salesperson_key_id_MAX
	,MIN(comm_plan_id) AS comm_plan_id_MIN
	,MAX(comm_plan_id) AS comm_plan_id_MAX
FROM
	CommBE.dbo.comm_transaction
WHERE
	(source_cd = 'JDE') AND 
	(fiscal_yearmo_num >= '201901') AND 
	(salesperson_cd<>'') AND
	(salesperson_key_id='Internal') AND
	(1 = 1)
GROUP BY 
	fiscal_yearmo_num, 
	hsi_shipto_id
HAVING
	MIN(salesperson_cd) <> MAX(salesperson_cd) AND
--	MIN(salesperson_key_id) <> MAX(salesperson_key_id) AND
--	MIN(comm_plan_id) <> MAX(comm_plan_id) AND
	(1=1)
order by 5
*/
-- check item for fsc / ess
/*
SELECT
	CAST(fiscal_yearmo_num AS int) AS FiscalMonth
	,item_id
	,MAX(item_comm_group_cd) AS item_comm_group_cd_MAX
	,MAX(ess_comm_group_cd) AS ess_comm_group_cd_MAX
	,COALESCE(NULLIF(MAX(item_comm_group_cd),''), NULLIF(MAX(ess_comm_group_cd),'')) n

FROM
	CommBE.dbo.comm_transaction
WHERE
	(source_cd = 'JDE') AND 
	(fiscal_yearmo_num >= '201901') AND 
	(item_id<>'') AND
	(salesperson_key_id='Internal') AND
	(1 = 1)
GROUP BY 
	fiscal_yearmo_num, 
	item_id
HAVING
--	MIN(item_comm_group_cd) = MAX(item_comm_group_cd) OR
	MAX(item_comm_group_cd) = '' AND
	MAX(ess_comm_group_cd) <> '' 
--	MAX(item_comm_group_cd) <> MAX(ess_comm_group_cd) 
--	MIN(ess_comm_group_cd) <> MAX(ess_comm_group_cd) AND

*/

-- add item_comm to track overrides, ITMPAR

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	item_comm_group_cd char(6) NULL
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group5 FOREIGN KEY
	(
	item_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
