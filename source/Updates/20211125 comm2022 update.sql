-- isr model, tmc, 25 Nov 21
/*
-- in prod
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	adhoc_model_code2 char(5) NOT NULL CONSTRAINT DF_BRS_Customer_adhoc_model_code2 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
*/
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

-- promote procs, run debug to test
-- 1. comm.comm_sync_proc.sql
-- 2. monthend_snapshot_proc.sql
-- 3. comm.transaction_commission_calc_proc.sql


-- update / run sync to populate
--EXEC comm.comm_sync_proc @bDebug=0
--EXEC comm.comm_sync_proc @bDebug=1

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

--< STOP.  Use excel to update, faster.
/*
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

*/

-- Plan 2022 start here, 27 Jan 22

-- test EPS vs FSC codes: EPS and PVT
select [Item], [comm_group_cd],[comm_group_eps_cd]
from [dbo].[BRS_Item]
where [comm_group_cd]<>[comm_group_eps_cd]
order by 2

-- fix icat
-- history

-- test current, sb 0
SELECT [comm_group_cd] FROM [dbo].[BRS_Item] WHERE [comm_group_cd] = 'ITMISC'

-- fix history

UPDATE       BRS_ItemHistory
SET                HIST_comm_group_cd = 'ITMFO1'
WHERE        (FiscalMonth >= 202101) AND (HIST_comm_group_cd = 'ITMISC')

/*
SELECT  [Item]
      ,[FiscalMonth]
      ,[HIST_comm_group_cd]
  FROM [dbo].[BRS_ItemHistory]
  where FiscalMonth >= 202101
  and [HIST_comm_group_cd] = 'ITMISC'
*/

-- test
SELECT TOP (1000) *
  FROM [comm].[transaction_F555115]
  where (FiscalMonth between 202101 and 202112) AND
  item_comm_group_cd = 'ITMISC'
GO

-- run can to confirm that ITMISC fixed (one month only)
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202105
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

-- fix adj
UPDATE [comm].[transaction_F555115]
SET   item_comm_group_cd = 'ITMFO1'
where (FiscalMonth between 202101 and 202112) AND
  item_comm_group_cd = 'ITMISC'
GO

-- add new plans & sync

INSERT INTO comm.[plan]
                         (comm_plan_id, comm_plan_nm, note_txt, active_ind)
SELECT        RTRIM(comm_plan_id)+'_Q', comm_plan_nm, RTRIM(ISNULL(note_txt,''))+' Quebec vacay', active_ind
FROM            comm.[plan] AS plan_1
WHERE        (comm_plan_id IN ('FSCGP02', 'FSCGP03', 'ESSGP', 'CCSGP'))


SELECT        comm_plan_id, comm_plan_nm, note_txt, active_ind
FROM            comm.[plan]
WHERE        (comm_plan_id IN ('FSCGP02', 'FSCGP03', 'ESSGP', 'CCSGP'))

-- pending
-- EPSGP, ISRGP02, ISRGP03   

-- run to build up rate rules for new plans
-- Prod
-- Exec comm.transaction_commission_calc_proc @bDebug=0

-- fix PPE private label 
UPDATE       BRS_ItemHistory
SET                HIST_comm_group_eps_cd = BRS_Item.comm_group_eps_cd
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item ON BRS_ItemHistory.Item = BRS_Item.Item AND BRS_ItemHistory.HIST_comm_group_eps_cd <> BRS_Item.comm_group_eps_cd
WHERE        (BRS_ItemHistory.FiscalMonth BETWEEN 202101 AND 202112) AND (BRS_Item.comm_group_eps_cd = 'ITMPVT')


SELECT        BRS_Item.Item, BRS_ItemHistory.[Label], BRS_Item.comm_group_eps_cd, BRS_ItemHistory.HIST_comm_group_eps_cd, BRS_ItemHistory.FiscalMonth
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item ON BRS_ItemHistory.Item = BRS_Item.Item AND BRS_ItemHistory.HIST_comm_group_eps_cd <> BRS_Item.comm_group_eps_cd
WHERE        (BRS_ItemHistory.FiscalMonth between 202101 and 202112) AND (BRS_Item.comm_group_eps_cd ='ITMPVT')

--

-- update master plan

-- add new plans & sync

SELECT        m.employee_num, m.master_salesperson_cd, m.salesperson_key_id, m.salesperson_nm, m.comm_plan_id,  f.Branch
FROM            comm.salesperson_master AS m INNER JOIN
                         BRS_FSC_Rollup AS f ON m.master_salesperson_cd = f.TerritoryCd
where 
	f.Branch in ('MNTRL', 'QUEBC') AND
(comm_plan_id IN ('FSCGP02', 'FSCGP03', 'ESSGP', 'CCSGP'))
ORDER BY 3

UPDATE       comm.salesperson_master
SET                comm_plan_id = RTRIM(comm_plan_id)+'_Q'
FROM            comm.salesperson_master INNER JOIN
                         BRS_FSC_Rollup AS f ON comm.salesperson_master.master_salesperson_cd = f.TerritoryCd
WHERE        (f.Branch IN ('MNTRL', 'QUEBC')) AND (comm.salesperson_master.comm_plan_id IN ('FSCGP02', 'FSCGP03', 'ESSGP', 'CCSGP'))


SELECT        *
FROM            comm.salesperson_master
WHERE        (comm_plan_id IN ('FSCGP02_Q', 'FSCGP03_Q', 'ESSGP_Q', 'CCSGP_Q'))

-- set Dec plans (to test) QA ONLY 

UPDATE       BRS_CustomerFSC_History
SET                HIST_fsc_comm_plan_id = m.comm_plan_id
FROM            BRS_CustomerFSC_History INNER JOIN
                         comm.salesperson_master AS m ON BRS_CustomerFSC_History.HIST_fsc_salesperson_key_id = m.salesperson_key_id
WHERE
	(m.comm_plan_id IN ('FSCGP02_Q', 'FSCGP03_Q', 'ESSGP_Q', 'CCSGP_Q')) AND 
	(HIST_fsc_comm_plan_id <> m.comm_plan_id) AND
	(BRS_CustomerFSC_History.FiscalMonth BETWEEN 202112 AND 202112) 


SELECT
h.Shipto, h.FiscalMonth, h.HIST_fsc_salesperson_key_id, h.HIST_fsc_comm_plan_id, m.comm_plan_id
FROM            BRS_CustomerFSC_History AS h INNER JOIN
                         comm.salesperson_master AS m ON h.HIST_fsc_salesperson_key_id = m.salesperson_key_id
WHERE
(m.comm_plan_id IN ('FSCGP02_Q', 'FSCGP03_Q', 'ESSGP_Q', 'CCSGP_Q')) AND
(h.FiscalMonth between 202112 and 202112)


-- re-run plans

-- recalc model 2020 (12m)
print 202101
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202101
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202102
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202102
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202103
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202103
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202104
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202104
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202105
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202105
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202106
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202106
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202107
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202107
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202108
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202108
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202109
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202109
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202110
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202110
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202111
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202111
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202112
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202112
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

-- test model in DEV
-- plan rollups? old vs new plan codes (see Gary template)
-- DONE!

-- update rates (excel)

SELECT        comm.plan_group_rate.calc_key, comm.plan_group_rate.comm_plan_id, comm.plan_group_rate.item_comm_group_cd, comm.plan_group_rate.cust_comm_group_cd, comm.plan_group_rate.source_cd, 
                         comm.plan_group_rate.disp_comm_group_cd, comm.plan_group_rate.comm_rt, comm.plan_group_rate.active_ind, comm.plan_group_rate.note_txt, comm.plan_group_rate.show_ind, comm.plan_group_rate.fg_comm_group_cd, 
                         comm.[group].comm_group_desc
FROM            comm.plan_group_rate INNER JOIN
                         comm.[group] ON comm.plan_group_rate.disp_comm_group_cd = comm.[group].comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id IN ('FSCGP02', 'FSCGP03', 'ESSGP', 'ESSGPSP', 'CCSGP', 'FSCGP02_Q', 'FSCGP03_Q', 'ESSGP_Q', 'CCSGP_Q'))

-- in CommBE-new PROD
-- run qupd_comm_plan_group_rate_DEV
-- run qapp_comm_plan_group_rate_DEV

-- test
print 202112
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202112
Exec comm.transaction_commission_calc_proc @bDebug=0
GO






