-- isr model, tmc, 25 Nov 21

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	adhoc_model_code2 char(5) NOT NULL CONSTRAINT DF_BRS_Customer_adhoc_model_code2 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

SELECT  [employee_num]
      ,[salesperson_key_id]
      ,[comm_plan_id]
  FROM [comm].[salesperson_master]
  where
[comm_plan_id] like 'ISR%'
order by 3


UPDATE       comm.salesperson_master
SET
	comm_plan_id = 'ISRGP03'
WHERE
[comm_plan_id] = 'ISRGP02' AND
(salesperson_key_id NOT IN ('FRANCA.PARENTE', 'NADIA.XAVIER', 'NOAH.THOMPSON'))

UPDATE       comm.salesperson_master
SET
	comm_plan_id = 'ISRGP02'
WHERE
(salesperson_key_id IN ('FRANCA.PARENTE', 'NADIA.XAVIER', 'NOAH.THOMPSON'))

UPDATE       comm.salesperson_master
SET
	comm_plan_id = 'ISRGP00'
WHERE
(salesperson_key_id IN ('ERIC.DORFMAN', 'ISR.HOUSE'))

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	comm_isr_merch_override_ind bit NOT NULL CONSTRAINT DF_BRS_ItemMPC_comm_isr_merch_override_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_ItemMPC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE dbo.BRS_ItemMPC
	set comm_isr_merch_override_ind = 1
WHERE [MajorProductClass] In ('011','022','023','345')
GO

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	comm_group_isr_cd char(6) NOT NULL CONSTRAINT DF_BRS_Item_comm_group_cps_cd1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_group4 FOREIGN KEY
	(
	comm_group_isr_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
--add ISR to item history (2.5min)
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemHistory ADD
	HIST_comm_group_isr_cd char(6) NOT NULL CONSTRAINT DF_BRS_ItemHistory_HIST_comm_group_isr_cd DEFAULT ('')
GO
ALTER TABLE dbo.BRS_ItemHistory ADD CONSTRAINT
	FK_BRS_ItemHistory_group4 FOREIGN KEY
	(
	HIST_comm_group_isr_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemHistory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update / run sync to populate
--EXEC comm.comm_sync_proc @bDebug=0

-- test
SELECT  [Item]
      ,[ItemDescription]
      ,[MajorProductClass]
      ,[comm_group_cd]
      ,[comm_note_txt]
      ,[comm_group_isr_cd]
  FROM [dbo].[BRS_Item]
  where [comm_group_cd] <> [comm_group_isr_cd]
  GO

-- update history (2.5min)
UPDATE       BRS_ItemHistory
SET                HIST_comm_group_isr_cd = i.comm_group_isr_cd
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item AS i ON BRS_ItemHistory.Item = i.Item
GO

-- test history
SELECT        t.FiscalMonth, t.source_cd, t.isr_comm_group_cd, h.HIST_comm_group_isr_cd
FROM            comm.transaction_F555115 AS t INNER JOIN
                         BRS_ItemHistory AS h ON t.FiscalMonth = h.FiscalMonth AND t.WSLITM_item_number = h.Item
WHERE
(t.FiscalMonth = 202111) and
(t.source_cd = 'JDE') and
(t.isr_comm_group_cd <> h.HIST_comm_group_isr_cd) and
h.HIST_comm_group_isr_cd <> 'ITMSND'
order by 4

-- set calc



-- init
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 0
,[active_ind] = 0
,[show_ind] = 0
,[disp_comm_group_cd] = ''
,[fg_comm_group_cd] = ''
,[note_txt] = '.'
where [comm_plan_id] like 'ISR%'

-- pay
-- "SALD30","STMPBA"
UPDATE [comm].[plan_group_rate]
	set [active_ind] = 1
	,[disp_comm_group_cd] = [item_comm_group_cd]
	,[note_txt] = 'init20211216'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] = 'PAY' AND
	[item_comm_group_cd] in ('SALD30', 'STMPBA')

-- IMP
-- "ITMSND","ITMPVT"
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 1
,[active_ind] = 1
,[show_ind] = 1
,[disp_comm_group_cd] = 'ITMSND'
,[note_txt] = 'init20211216'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('IMP','JDE') AND
	[item_comm_group_cd] in ('ITMSND','ITMPVT')
GO

-- "FRESND","FRESEQ",
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 1
,[active_ind] = 1
,[show_ind] = 1
,[disp_comm_group_cd] = 'FRESND'
,[note_txt] = 'init20211216'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('IMP','JDE') AND
	[item_comm_group_cd] in ('FRESND','FRESEQ')
GO

-- "REBSND",
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 1
,[active_ind] = 1
,[show_ind] = 1
,[disp_comm_group_cd] = 'REBSND'
,[note_txt] = 'init20211216'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('IMP','JDE') AND
	[item_comm_group_cd] in ('REBSND')
GO

-- "SPMSND","SPMPVT"
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 0.5
,[active_ind] = 1
,[show_ind] = 1
,[disp_comm_group_cd] = 'SPMSND'
,[note_txt] = 'init20211216'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('IMP','JDE') AND
	[item_comm_group_cd] in ('SPMSND','SPMPVT')
GO

-- "SPMFGS","SPMFGE",
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 0.5
,[active_ind] = 1
,[show_ind] = 1
,[disp_comm_group_cd] = 'SPMFGS'
,[note_txt] = 'init20211216'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('IMP','JDE') AND
	[item_comm_group_cd] in ('SPMFGS','SPMFGE')
GO

-- "SPMREB"
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 0.5
,[active_ind] = 1
,[show_ind] = 1
,[disp_comm_group_cd] = 'SPMREB'
,[note_txt] = 'init20211216'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('IMP','JDE') AND
	[item_comm_group_cd] in ('SPMREB')
GO

-- SM map
--  JDE
-- "ITMSND","ITMPVT"
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 0.5
,[disp_comm_group_cd] = 'SPMSND'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('JDE') AND
	[item_comm_group_cd] in ('ITMSND','ITMPVT') AND
	[cust_comm_group_cd] in ('SPMALL', 'SPMSND') 

GO

-- "FRESND","FRESEQ",
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 0.5
,[disp_comm_group_cd] = 'SPMFGS'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('JDE') AND
	[item_comm_group_cd] in ('FRESND','FRESEQ') AND
	[cust_comm_group_cd] in ('SPMALL', 'SPMSND') 
GO

-- "REBSND",
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 0.5
,[disp_comm_group_cd] = 'SPMREB'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('JDE') AND
	[item_comm_group_cd] in ('REBSND') AND
	[cust_comm_group_cd] in ('SPMALL', 'SPMSND') 
GO

-- FG map fix
-- "ITMSND","ITMPVT"
UPDATE [comm].[plan_group_rate]
set [fg_comm_group_cd] = 'SPMFGS'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('JDE') AND
	[item_comm_group_cd] in ('ITMSND','ITMPVT') AND
	[cust_comm_group_cd] in ('SPMALL', 'SPMSND') 
GO

-- "ITMSND","ITMPVT"
UPDATE [comm].[plan_group_rate]
set [fg_comm_group_cd] = 'FRESND'
where 
	[comm_plan_id] like 'ISR%' AND
	[source_cd] in ('JDE') AND
	[item_comm_group_cd] in ('ITMSND','ITMPVT') AND
	[cust_comm_group_cd] in ('', 'SPMEQU') 
GO

-- clear 
UPDATE [comm].[plan_group_rate]
set [comm_rt] = 0
where [comm_plan_id] = 'ISRGP00'

-- test
SELECT * FROM  [comm].[plan_group_rate] where [comm_plan_id] like 'ISR%' and active_ind=1 and [fg_comm_group_cd] <>'' order by [fg_comm_group_cd]

