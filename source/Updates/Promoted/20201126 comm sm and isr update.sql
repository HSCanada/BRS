-- sm and isr update, tmc, 26 nov 20
-- add config-based part to eq promo support, added to QA, 20 Nov 20
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Config ADD
	comm_partprom_supplier char(6) NOT NULL CONSTRAINT DF_BRS_Config_comm_partprom_supplier DEFAULT '',
	comm_partprom_group_cd char(6) NOT NULL CONSTRAINT DF_BRS_Config_comm_partprom_group_cd DEFAULT '',
	comm_partprom_group_focus_cd char(6) NOT NULL CONSTRAINT DF_BRS_Config_comm_partprom_group_focus_cd DEFAULT ''
GO
ALTER TABLE dbo.BRS_Config ADD CONSTRAINT
	FK_BRS_Config_BRS_ItemSupplier FOREIGN KEY
	(
	comm_partprom_supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Config ADD CONSTRAINT
	FK_BRS_Config_group FOREIGN KEY
	(
	comm_partprom_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Config ADD CONSTRAINT
	FK_BRS_Config_group1 FOREIGN KEY
	(
	comm_partprom_group_focus_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Config SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	isr_comm_group_cd char(6) NULL
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group6 FOREIGN KEY
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

--
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_16 ON comm.transaction_F555115
	(
	isr_comm_group_cd
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--
-- add EQ only special markets, based on SPMALL
insert into [comm].[group]
(
	[comm_group_cd]
	,[comm_group_desc]
	,[source_cd]
	,[active_ind]
	,[note_txt]
	,[booking_rt]
	,[show_ind]
	,[sort_id]
	,[comm_group_scorecard_cd]
)
SELECT 'SPMEQU' as [comm_group_cd]
      ,'Special Market Customer, EQ only' as [comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,[note_txt]
      ,[booking_rt]
      ,[show_ind]
      ,33 as [sort_id]
      ,[comm_group_scorecard_cd]
  FROM [comm].[group]
  where comm_group_cd = 'SPMALL'
GO

insert into [comm].[plan_group_rate]
(
	[comm_plan_id]
	,[item_comm_group_cd]
	,[cust_comm_group_cd]
    ,[source_cd]
	,[disp_comm_group_cd]
	,[comm_rt]
    ,[active_ind]
	,[creation_dt]
    ,[note_txt]
    ,[show_ind]
)
SELECT
	[comm_plan_id]
	,[item_comm_group_cd]
	,'SPMEQU' as [cust_comm_group_cd]
    ,[source_cd]
	,[disp_comm_group_cd]
	,[comm_rt]
    ,[active_ind]
	,[creation_dt]
    ,'Special Market Customer, EQxx only, 26 Nov 20' as [note_txt]
    ,[show_ind]
  FROM [comm].[plan_group_rate]
    where [cust_comm_group_cd] = 'SPMALL'
GO

-- update new group rate

-- revert for non EQ - test
EXEC comm.comm_stage_update_proc @bDebug=0

SELECT
d.comm_plan_id, d.item_comm_group_cd, d.cust_comm_group_cd, d.source_cd, d.disp_comm_group_cd, s.disp_comm_group_cd, d.comm_rt, s.comm_rt, d.active_ind, d.note_txt, d.show_ind
FROM
comm.plan_group_rate AS d 
INNER JOIN comm.plan_group_rate AS s 
ON d.comm_plan_id = s.comm_plan_id AND 
d.item_comm_group_cd = s.item_comm_group_cd AND
d.source_cd = s.source_cd AND 
d.item_comm_group_cd  = s.item_comm_group_cd 
WHERE
  (s.[cust_comm_group_cd] = ' ') and
  (d.[cust_comm_group_cd] = 'SPMEQU') and
  (d.[comm_plan_id] like 'FSCGP0[2 3]') and
  (d.[active_ind] = 1) and
  (d.[comm_rt] <>0) and
  d.comm_rt <> s.comm_rt and
  d.item_comm_group_cd not like 'ITMFO[1 2 3]' and
  d.item_comm_group_cd <> 'FRESEQ' and
  (1=1)
order by 2

-- revert for non EQ 
UPDATE
	comm.plan_group_rate
SET
	disp_comm_group_cd = s.disp_comm_group_cd, 
	comm_rt = s.comm_rt
FROM
	comm.plan_group_rate 
	INNER JOIN comm.plan_group_rate AS s 
	ON comm.plan_group_rate.comm_plan_id = s.comm_plan_id AND 
	comm.plan_group_rate.item_comm_group_cd = s.item_comm_group_cd AND 
	comm.plan_group_rate.source_cd = s.source_cd AND 
	comm.plan_group_rate.item_comm_group_cd = s.item_comm_group_cd AND 
	comm.plan_group_rate.comm_rt <> s.comm_rt
WHERE
	(s.cust_comm_group_cd = ' ') AND 
	(comm.plan_group_rate.cust_comm_group_cd = 'SPMEQU') AND 
	(comm.plan_group_rate.comm_plan_id LIKE 'FSCGP0[2 3]') AND 
	(comm.plan_group_rate.active_ind = 1) AND 
    (comm.plan_group_rate.comm_rt <> 0) AND 
	(comm.plan_group_rate.item_comm_group_cd NOT LIKE 'ITMFO[1 2 3]') AND 
	(comm.plan_group_rate.item_comm_group_cd <> 'FRESEQ') AND 
	(1 = 1)

-- enable mapping so that above calc works
UPDATE       comm.special_market_map
SET                cust_comm_group_cd = 'SPMEQU', note_txt = 'SM EQ only'
WHERE        (merch_comm_cd = 'Full') AND (equip_comm_cd = 'Half')


-- part promtion logic
UPDATE
	BRS_Config
SET
	comm_partprom_supplier = 'PELTON', 
	comm_partprom_group_focus_cd = 'ITMFO1',
	comm_partprom_group_cd = 'ITMFO3'
GO


