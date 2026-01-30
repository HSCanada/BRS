-- Comm FSC 2026 Setup, tmc, 19 Jan 26

-- keep full script from being run
print 'hi'
go
raiserror('Oh no a fatal error', 20, -1) with log
go
print 'ho, no go!'

/*
SELECT [comm_group_cd]
      ,[comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,[creation_dt]
      ,[note_txt]
      ,[booking_rt]
  FROM [comm].[group]
  where 
	active_ind = 1 AND
  source_cd = 'JDE'


select distinct 
[comm_status_cd]
FROM [dbo].[BRS_Customer]

-- medical
select distinct   comm_gm_threshold_cd
from 
[comm].[plan_group_rate]
order by 1

select distinct 
[comm_plan_id]
FROM [comm].[salesperson_master]

          
-- 'FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q'
-- add FSCGP00

*/
-->

-- create thresh table
--

-- drop table [comm].[group_tier]

print 'CREATE TABLE [comm].[group_tier]'
CREATE TABLE [comm].[group_tier](
	[comm_group_tier_cd] [char](3) NOT NULL,
	[comm_group_tier_desc] [varchar](40) NOT NULL,
	[active_ind] [bit] NOT NULL DEFAULT(0),
	[comm_group_tier_tag] [varchar](40)  NULL,
	[creation_dt] [datetime] NOT NULL DEFAULT (getdate()),
	[note_txt] [varchar](255) NULL,
	[comm_group_tier_key] [smallint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [comm_group_tier_c_pk] PRIMARY KEY CLUSTERED 
(
	[comm_group_tier_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO

-- pop with '', T10-T50, TZZ, from Height to low rates
print 'pop rates'
-- unassigned
INSERT INTO [comm].[group_tier]
           ([comm_group_tier_cd]
           ,[comm_group_tier_desc]
           ,[active_ind]
           ,[comm_group_tier_tag]
           ,[note_txt])
     VALUES
           (''
           ,'no tier, pass-through'
           ,0
           ,''
           ,'.')
GO

-- T10
INSERT INTO [comm].[group_tier]
           ([comm_group_tier_cd]
           ,[comm_group_tier_desc]
           ,[active_ind]
           ,[comm_group_tier_tag]
           ,[note_txt])
     VALUES
           ('T10'
           ,'.'
           ,0
           ,''
           ,'.')
GO

-- T20
INSERT INTO [comm].[group_tier]
           ([comm_group_tier_cd]
           ,[comm_group_tier_desc]
           ,[active_ind]
           ,[comm_group_tier_tag]
           ,[note_txt])
     VALUES
           ('T20'
           ,'.'
           ,0
           ,''
           ,'.')
GO

-- T30
INSERT INTO [comm].[group_tier]
           ([comm_group_tier_cd]
           ,[comm_group_tier_desc]
           ,[active_ind]
           ,[comm_group_tier_tag]
           ,[note_txt])
     VALUES
           ('T30'
           ,'.'
           ,0
           ,''
           ,'.')
GO

-- T40
INSERT INTO [comm].[group_tier]
           ([comm_group_tier_cd]
           ,[comm_group_tier_desc]
           ,[active_ind]
           ,[comm_group_tier_tag]
           ,[note_txt])
     VALUES
           ('T40'
           ,'.'
           ,0
           ,''
           ,'.')
GO

-- T50
INSERT INTO [comm].[group_tier]
           ([comm_group_tier_cd]
           ,[comm_group_tier_desc]
           ,[active_ind]
           ,[comm_group_tier_tag]
           ,[note_txt])
     VALUES
           ('T50'
           ,'.'
           ,0
           ,''
           ,'.')
GO

-- T60
INSERT INTO [comm].[group_tier]
           ([comm_group_tier_cd]
           ,[comm_group_tier_desc]
           ,[active_ind]
           ,[comm_group_tier_tag]
           ,[note_txt])
     VALUES
           ('T60'
           ,'.'
           ,0
           ,''
           ,'.')
GO

-- TZZ
INSERT INTO [comm].[group_tier]
           ([comm_group_tier_cd]
           ,[comm_group_tier_desc]
           ,[active_ind]
           ,[comm_group_tier_tag]
           ,[note_txt])
     VALUES
           ('TZZ'
           ,'.'
           ,0
           ,''
           ,'.')
GO

select [comm_group_tier_cd] from [comm].[group_tier] where [comm_group_tier_cd] between 'T10' and 'T60'
--
print 'add comm_gm_threshold_cd to customer, customer_history (1m20)'

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	comm_group_tier_cd char(3) NOT NULL CONSTRAINT DF_BRS_Customer_comm_group_tier_cd DEFAULT ''
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- 1.3m
BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_CustomerFSC_History] ADD
	HIST_comm_group_tier_cd char(3) NOT NULL CONSTRAINT DF_BRS_Customer_hist_comm_group_tier_cd DEFAULT ''
GO
ALTER TABLE dbo.[BRS_CustomerFSC_History] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add RI to FSC

BEGIN TRANSACTION
GO
ALTER TABLE comm.group_tier SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_group_tier FOREIGN KEY
	(
	comm_group_tier_cd
	) REFERENCES comm.group_tier
	(
	comm_group_tier_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_group_tier FOREIGN KEY
	(
	HIST_comm_group_tier_cd
	) REFERENCES comm.group_tier
	(
	comm_group_tier_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD CONSTRAINT
	FK_plan_group_rate_group_tier FOREIGN KEY
	(
	comm_gm_threshold_cd
	) REFERENCES comm.group_tier
	(
	comm_group_tier_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/*
-- free goods (defer for phase 2, use default tiers in calc for now)
BEGIN TRANSACTION
GO
ALTER TABLE comm.freegoods ADD
	comm_group_tier_cd char(3) NOT NULL CONSTRAINT DF_freegoods_comm_group_tier_cd DEFAULT ''
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group_tier FOREIGN KEY
	(
	comm_group_tier_cd
	) REFERENCES comm.group_tier
	(
	comm_group_tier_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
*/

print 'vpa tier for defaults'
BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_CustomerVPA] ADD
	comm_group_tier_cd char(3) NOT NULL CONSTRAINT DF_vpa_comm_group_tier_cd DEFAULT ''
GO
ALTER TABLE [dbo].[BRS_CustomerVPA]  ADD CONSTRAINT
	FK_vpa_group_tier FOREIGN KEY
	(
	comm_group_tier_cd
	) REFERENCES comm.group_tier
	(
	comm_group_tier_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-->
-- add PPE to rates
/*
--review disp_comm mapping
SELECT  [comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_gm_threshold_cd]
      ,[comm_rt]
      ,[active_ind]
      ,[note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
      ,[comm_gm_threshold_ind]
      ,[comm_gm_threshold_descr]
      ,[comm_gm_threshold_min]
      ,[comm_gm_threshold_max]
--      ,[comm_group_tier_ind]
  FROM [comm].[plan_group_rate] 
  where 
  [item_comm_group_cd] = 'ITMSND' and 
  comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00') and
  source_cd in('JDE') and
  --cust_comm_group_cd = '' and
  (1=1)
  order by disp_comm_group_cd
*/


print 'add new ITMPPE'
-- add ITMPPE based on ITMSND - comm 

INSERT INTO [comm].[group]
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
	,[SalesCategory]
)
SELECT  
'ITMPPE' AS [comm_group_cd]
      ,'Merchandise (Branded PPE)' AS [comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,'TC FSC 2026, 19 Jan 26' AS [note_txt]
      ,[booking_rt]
      ,[show_ind]
      ,[sort_id]
      ,[comm_group_scorecard_cd]
      ,[SalesCategory]
  FROM [comm].[group] where comm_group_cd = 'ITMSND'
GO

-- add SPMPPE based on SPMSND - comm 
INSERT INTO [comm].[group]
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
	,[SalesCategory]
)
SELECT  
'SPMPPE' AS [comm_group_cd]
      ,'SM Merchandise (Branded PPE)' AS [comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,'TC FSC 2026, 19 Jan 26' AS [note_txt]
      ,[booking_rt]
      ,[show_ind]
      ,[sort_id]
      ,[comm_group_scorecard_cd]
      ,[SalesCategory]
  FROM [comm].[group] where comm_group_cd = 'SPMSND'

GO


insert into [comm].[plan_group_rate] 
(
	[comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_gm_threshold_cd]
      ,[comm_rt]
      ,[active_ind]
      ,[note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
      ,[comm_gm_threshold_ind]
      ,[comm_gm_threshold_descr]
      ,[comm_gm_threshold_min]
      ,[comm_gm_threshold_max]
--      ,[comm_group_tier_ind]
)
SELECT  
	[comm_plan_id]
      ,'ITMPPE' AS [item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_gm_threshold_cd]
      ,[comm_rt]
      ,[active_ind]
      ,[note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
      ,[comm_gm_threshold_ind]
      ,[comm_gm_threshold_descr]
      ,[comm_gm_threshold_min]
      ,[comm_gm_threshold_max]
--      ,[comm_group_tier_ind]
  FROM [comm].[plan_group_rate] 
  where 
  [item_comm_group_cd] = 'ITMSND' and 
--  comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q') and
--  source_cd in('JDE') and
  --cust_comm_group_cd = '' and
  (1=1)
--  order by disp_comm_group_cd

-- update PPE display
/*
--review disp_comm mapping
SELECT  [comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,CASE [disp_comm_group_cd]
		WHEN 'ITMSND' THEN 'ITMPPE'
		WHEN 'SPMSND' THEN 'SPMPPE'
		END as disp_new

      ,[comm_gm_threshold_cd]
      ,[comm_rt]
      ,[active_ind]
      ,[note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
      ,[comm_gm_threshold_ind]
      ,[comm_gm_threshold_descr]
      ,[comm_gm_threshold_min]
      ,[comm_gm_threshold_max]
--      ,[comm_group_tier_ind]
  FROM [comm].[plan_group_rate] 
  where 
  [item_comm_group_cd] = 'ITMPPE' and 
  comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00') and
  source_cd in('JDE', 'IMP') and
  --cust_comm_group_cd = '' and
  (1=1)
  order by disp_comm_group_cd
*/

print 'set PPE display'
UPDATE  comm.plan_group_rate
SET        disp_comm_group_cd = 
				CASE [disp_comm_group_cd]
						WHEN 'ITMSND' THEN 'ITMPPE'
						WHEN 'SPMSND' THEN 'SPMPPE'
				END 
WHERE   (item_comm_group_cd = 'ITMPPE') AND (comm_plan_id IN ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00')) AND (source_cd IN ('JDE', 'IMP')) AND (1 = 1)

/*
-- not needed as the imp that the tiers set / overriden during comm calc
print 'add tier to Integration_comm_adjustment_Staging'
BEGIN TRANSACTION
GO
ALTER TABLE Integration.comm_adjustment_Staging ADD
	comm_group_tier_cd char(3) NULL
GO
ALTER TABLE Integration.comm_adjustment_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
*/

-- add Tiers to new FSC plan
/*
--review org
SELECT  [comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_gm_threshold_cd]
      ,[comm_rt]
      ,[active_ind]
      ,[note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
      ,[comm_gm_threshold_ind]
      ,[comm_gm_threshold_descr]
      ,[comm_gm_threshold_min]
      ,[comm_gm_threshold_max]
--      ,[comm_group_tier_ind]
  FROM [comm].[plan_group_rate] 
  where 
--  [item_comm_group_cd] = 'ITMSND' and 
  comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00') and
  source_cd in('JDE', 'IMP') and
  active_ind = 1 and
  cust_comm_group_cd not in ('SPCELT', 'SPMEQU') and
--  show_ind <> 0 and
  --cust_comm_group_cd = '' and
--  [item_comm_group_cd] = 'ITMPPE' and 

  (1=1)
  order by disp_comm_group_cd
GO


--review tier expanded
SELECT  [comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]

      ,[comm_gm_threshold_cd]
	  ,t.comm_group_tier_cd

      ,[comm_rt]
      ,r.[active_ind]
      ,'TC2026-cp ' + r.[note_txt] as note_txt2
      ,[show_ind]
      ,[fg_comm_group_cd]
      ,[comm_gm_threshold_ind]
      ,[comm_gm_threshold_descr]
      ,[comm_gm_threshold_min]
      ,[comm_gm_threshold_max]
--      ,[comm_group_tier_ind]
  FROM [comm].[plan_group_rate] r, [comm].[group_tier] t

  where 
  t.[comm_group_tier_cd] between 'T10' and 'T60' and
--  [item_comm_group_cd] = 'ITMSND' and 
  r.comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00') and
  r.source_cd in('JDE', 'IMP') and
  r.active_ind = 1 and
  r.cust_comm_group_cd not in ('SPCELT', 'SPMEQU') and
--  show_ind <> 0 and
  --cust_comm_group_cd = '' and
--  [item_comm_group_cd] = 'ITMPPE' and 

  (1=1)
  order by r.disp_comm_group_cd
GO
*/
print ('add tier expanded to rates')
INSERT INTO [comm].[plan_group_rate]
(
	[comm_plan_id]
	,[item_comm_group_cd]
	,[cust_comm_group_cd]
	,[source_cd]
	,[disp_comm_group_cd]
	,[comm_gm_threshold_cd]
	,[comm_rt]
	,[active_ind]
	,[note_txt]
	,[show_ind]
	,[fg_comm_group_cd]
	,[comm_gm_threshold_ind]
	,[comm_gm_threshold_descr]
	,[comm_gm_threshold_min]
	,[comm_gm_threshold_max]
--	,[comm_group_tier_ind]
)

SELECT
	[comm_plan_id]
	,[item_comm_group_cd]
	,[cust_comm_group_cd]
	,[source_cd]
	,[disp_comm_group_cd]
	,t.comm_group_tier_cd
	,[comm_rt]
	,r.[active_ind]
	,'cp26 ' + r.[note_txt] as note_txt2
	,[show_ind]
	,[fg_comm_group_cd]
	,[comm_gm_threshold_ind]
	,[comm_gm_threshold_descr]
	,[comm_gm_threshold_min]
	,[comm_gm_threshold_max]
--	,[comm_group_tier_ind]
  FROM [comm].[plan_group_rate] r, [comm].[group_tier] t

  where 
  r.comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00') and
  r.source_cd in('JDE', 'IMP') and
  r.active_ind = 1 and
  t.[comm_group_tier_cd] between 'T10' and 'T60' and

  (1=1)
GO
/*
-- set fsc tier flag
SELECT
	[comm_plan_id]
	,[item_comm_group_cd]
	,[cust_comm_group_cd]
	,[source_cd]
	,[comm_gm_threshold_cd]
	,[disp_comm_group_cd]
	,[comm_rt]
	,r.[active_ind]
	,r.[note_txt] as note_txt2
	,[show_ind]
	,[fg_comm_group_cd]
	,[comm_gm_threshold_ind]
	,[comm_gm_threshold_descr]
	,[comm_gm_threshold_min]
	,[comm_gm_threshold_max]
	,[comm_group_tier_ind]
  FROM [comm].[plan_group_rate] r

  where 
  r.comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00') and
  r.[item_comm_group_cd] in ('ITMCAM', 'ITMSND', 'ITMPPE', 'ITMCRD', 'ITMPVT', 'FRESND', 'SPMFGS')  and 
--  r.[comm_gm_threshold_cd] between 'T10' and 'T60' and
  r.source_cd in('JDE', 'IMP') and
  r.active_ind = 1 and
  r.cust_comm_group_cd in ('SPCCRD', 'SPMALL', 'SPMSND') AND
  	(calc_key =34273) AND

  (1=1)
GO

*/
print 'add tier to trans (50s)'
-- comm trans
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	comm_group_tier_cd char(3)  NULL 
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group_tier FOREIGN KEY
	(
	comm_group_tier_cd
	) REFERENCES comm.group_tier
	(
	comm_group_tier_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--<

--
print ('add cust thresh to rate table [comm_gm_threshold_ind]')
BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD
	comm_group_tier_ind bit NOT NULL CONSTRAINT DF_plan_group_rate_comm_group_tier_ind DEFAULT 0
GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE  comm.plan_group_rate
SET
comm_group_tier_ind = 1
, comm_gm_threshold_descr = '.'
, comm_gm_threshold_min = - 1
, comm_gm_threshold_max = - 1
WHERE
	(comm_plan_id IN ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00')) AND 
	(item_comm_group_cd IN ('ITMCAM', 'ITMSND', 'ITMPPE', 'ITMCRD', 'ITMPVT', 'FRESND', 'SPMFGS'))  and 
	(cust_comm_group_cd IN ('SPCCRD', 'SPMALL', 'SPMSND')) AND 
	(source_cd IN ('JDE', 'IMP')) AND 

	(comm_gm_threshold_cd BETWEEN 'T10' AND 'T60') AND 

	(active_ind = 1) AND 

	--test
	--(calc_key =34273) AND
	--
	(1 = 1)
GO



-->
  
-- update customer history proc (tier)
-- monthend_snapshot_proc

-- update FG save proc (tier)
-- comm.comm_stage_update_proc

-- test calc_Key pre (Prod vs Dev)

-- update calc proc
-- [comm].[transaction_commission_calc_proc] 

--test calc with '' cust rate
-- test calc with <>'' cust rate

-- test calc_Key (Prod vs Dev)
-- run comm_proc
-- re-test calc_key (Prod vs Dev)

-- after null test, update Item comm
-- PPE = '006', '008', '013', '054'

--<

-- review
/*
--review disp_comm mapping
SELECT  [comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_gm_threshold_cd]
      ,[comm_rt]
      ,[active_ind]
      ,[note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
      ,[comm_gm_threshold_ind]
      ,[comm_gm_threshold_descr]
      ,[comm_gm_threshold_min]
      ,[comm_gm_threshold_max]
      ,[comm_group_tier_ind]
  FROM [comm].[plan_group_rate] 
  where 
  [item_comm_group_cd] = 'ITMSND' and 
  comm_plan_id in ('FSCMT02') and
  source_cd in('JDE') and
  --cust_comm_group_cd = '' and
  (1=1)
  order by disp_comm_group_cd
*/ 
--< 1. Comm new place backend - DONE (40-50%) 

--2. test comm calc with NO CHANGES to ensure number are the same
--* test DEV vs prod, use ID and Calc ID to test...
--* defaul to Tier ZZ if something is missing


--> 
print('TEST vs Prod: Dec 2025 only')
select 
--top 10 
-- *	
--dev.ess_calc_key, prod.ess_calc_key, * 

--dev.fsc_calc_key, prod.fsc_calc_key, * 

distinct dev.fsc_calc_key

from 
	BRSales.[comm].[transaction_F555115] prod 
	LEFT JOIN DEV_BRSales.[comm].[transaction_F555115] dev
		ON prod.ID = dev.ID
where 
	prod.FiscalMonth = 202512 AND
	(
		(ISNULL(prod.fsc_calc_key,0) <> ISNULL(dev.fsc_calc_key, 0)) OR
		(ISNULL(prod.ess_calc_key,0) <> ISNULL(dev.ess_calc_key, 0)) OR

		(ISNULL(prod.isr_calc_key,0) <> ISNULL(dev.isr_calc_key, 0)) OR
		(ISNULL(prod.eps_calc_key,0) <> ISNULL(dev.eps_calc_key, 0)) OR
		(ISNULL(prod.cps_calc_key,0) <> ISNULL(dev.cps_calc_key, 0)) OR
		(1<>1)
	) and

	-- exclude PPE calcs
	--dev.ess_calc_key not in (89345,89348,89473,89476,89494,89515,89518,89533) AND
	--dev.fsc_calc_key not in 
	--(
	-- 89879, 89880, 89881, 89882, 89915, 89918, 90103, 90114, 90116, 90117, 90118, 90119
	-- , 90120, 90122, 90123, 90125, 90131, 90137, 90141, 90178, 90179, 90181, 90190, 90199
	-- , 90200, 90201, 90202, 90203, 90205, 90206, 90207, 90208, 90209, 90212, 90213, 90214
	-- ) AND

	(1=1)
--order by dev.ess_calc_key
order by dev.fsc_calc_key
GO

-- 10sec

-- review rule details (test baseline null)
select * from  [comm].[plan_group_rate] where 
[calc_key] in (

90911
,92543
,92717
,95195
,97523
,97553
,98549
,98561
,101501
,101513
,103283
,103289
,104507
,104531
,104537
,104549
,104555
,104567
,104579
,104603
,104609
,104627
,104633
,104675
,104681
,104705
,104717
,104723
,104735
,104753
,104759
,104765
,104777
,104813
,104837
,104855
,104867
,104873
,104879
,104885
,104891
,104897
,104933
,104945
,104963
,104969
,104987
,104999
,105011
,105023
,105029
,105047
,105101
,105107
,105119
,105125
,106751
,106769
,106847
,106889
) order by 5

-- review rule details (test new)
select * from  [comm].[plan_group_rate] where 
[calc_key] in (
89879
,89880
,89881
,89882
,89915
,89918
,90103
,90131
,90137
,90190
,92533
,92557
,92581
,100285
,100309
,100333
,103099
,103123
,103147
,104525
,104663
,104669
,104825
,104831
,104903
,104951
,104957
,105077
,105083
,106747
,106765
,106807
,106811
,106819
,106825
,106831
,106837
,106843
,106873
,106885
,106933
,106945
,106963
,107041
,107047
,107077
,107083
,107089
,107095
,107101
,107137
,107161
,107185
,107203
,107209
,107215
,107221
,107293
,107425
,107485
,107509
,107533
,107545
,107551
,107563
,107569
,107581
,107593
,107599
,107605
,107671
,107677
,107689
,107695
,107707
,107713
,107725
,107731
,107737
,107743
,107749
,107761
,107767
,107773
,107779
,107797
,107803
,107971
,107983
,107989
,107995
,108001
,108007
,108025
,108031
,108037
) order by 1,5

--21 158

-- review rule details (test YTD missing)
select * from  [comm].[plan_group_rate] where 
[calc_key] in (
34822
,34823
,34318
) order by 1,5

-- test
EXEC comm.transaction_commission_calc_proc @bDebug = 1
-- prod
EXEC comm.transaction_commission_calc_proc @bDebug = 0
-- 51s

--< TESTing

-- stop here for NULL testing

-- a) test null, new rates, no data changes - SUCCESS
-- b) test null, new cust tier, data change - SUCCESS

print ('set SM tier to T30 for testing')
UPDATE  BRS_CustomerFSC_History
SET        HIST_comm_group_tier_cd = 'T10'
WHERE   (FiscalMonth between 202501 and 202512) AND (HIST_cust_comm_group_cd IN ('SPCCRD', 'SPMALL', 'SPMSND'))
GO

/*
select distinct HIST_cust_comm_group_cd, HIST_comm_group_tier_cd from [dbo].[BRS_CustomerFSC_History] where FiscalMonth = 202512 and HIST_cust_comm_group_cd in ('SPCCRD', 'SPMALL', 'SPMSND')
select distinct HIST_cust_comm_group_cd, HIST_comm_group_tier_cd from [dbo].[BRS_CustomerFSC_History] where FiscalMonth = 202512 and HIST_cust_comm_group_cd <>''
select shipto, HIST_cust_comm_group_cd, HIST_comm_group_tier_cd from [dbo].[BRS_CustomerFSC_History] where FiscalMonth = 202512 and HIST_cust_comm_group_cd in ('SPCCRD', 'SPMALL', 'SPMSND')
*/

-- c) test PPE item add with legacy calc - SUCCESS, with notes
-- note:   ITMPPE did impact FSC and ESS plans, but the rules were cloned so there should be no net impact
/*
select 
--top 10 
* from [dbo].[BRS_ItemHistory] 
where 
FiscalMonth = 202512 and 
LEFT(Minorproductclass,3) in( '006', '008', '013', '054')  and
HIST_Comm_group_cd  in ('ITMCAM', 'ITMSND') and
(1=1)
GO


select distinct HIST_Comm_group_cd from [dbo].[BRS_ItemHistory] 
where 
FiscalMonth = 202512 and 
LEFT(Minorproductclass,3) in( '006', '008', '013', '054')  and
HIST_Comm_group_cd in ('ITMCAM', 'ITMPVT', 'SPMSND', 'ITMSND')
*/

print ('setup PPE')
UPDATE  BRS_ItemHistory
SET        HIST_comm_group_cd = 'ITMPPE'
WHERE   (FiscalMonth between 202501 and 202512) AND (LEFT(MinorProductClass, 3) IN ('006', '008', '013', '054')) AND (HIST_comm_group_cd IN ('ITMCAM', 'ITMSND')) AND (1 = 1)
GO

--3. update comm calc with tier logic using fixed tier for MM and 1/2 rate for INS, but NO rate co
-- add FSC patch to include tiers, setps 8, 9, 10 - TBD
select 
 top 10 *	
-- count (*)
--distinct r.[comm_gm_threshold_cd]

from 
	[comm].[transaction_F555115] t
	INNER JOIN [comm].[plan_group_rate] r
	ON t.fsc_calc_key = r.[calc_key]
where 
	-- t.FiscalMonth = 202512 AND
	t.id in (	20680631, 22567375, 21052418) AND
	-- r.[comm_group_tier_ind] = 1 AND

	(1=1)
--order by dev.ess_calc_key
GO

-- Prod
-- Exec comm.transaction_commission_calc_proc @bDebug=0

-- Debug, 2m
-- Exec comm.transaction_commission_calc_proc @bDebug=1


--5. Gary update DEV Model with new fields / David can start excel - DONE

--4. update the AS model with tier, ask David how he wants the FSC Tiers - DONE
-- * intgrated in FSC 
-- * separate tier breakout
/*
-- FSC org
SELECT 
	[comm_group_key]								AS CommGroupKey
	,[comm_group_cd]	+ ' | ' + [comm_group_desc]	AS CommGroup
	,[comm_group_cd]								AS CommGroupCode
	,comm_group_scorecard_cd
	,SalesCategory									AS CommGroupRollup
FROM 
	[comm].[group]
WHERE
    [active_ind]=1
GO
-- 70 rec

-- Med Thresh
SELECT
	calc_key
	, disp_comm_group_cd
--	, comm_gm_threshold_cd 
	, CASE WHEN comm_gm_threshold_cd = '' and comm_gm_threshold_descr is not null THEN 'T00' ELSE comm_gm_threshold_cd END as comm_gm_threshold_cd 
	, ISNULL(comm_gm_threshold_descr,'na') rate_level_display
--	, comm_gm_threshold_cd + ' ' + ISNULL(comm_gm_threshold_descr,'na') rate_level_display
FROM
	comm.plan_group_rate
WHERE
	(active_ind <> 0) AND 
	(comm_gm_threshold_ind <> 0) AND
--	(comm_plan_id = 'FSCMT02') AND 
	(source_cd <> 'PAY') AND
	(1=1)
UNION ALL
Select 0, '.', 'Txx', ''
GO
-- 3 565

-- FSC Thresh
SELECT
	calc_key
	, disp_comm_group_cd
	, CASE WHEN comm_gm_threshold_cd = '' THEN 'T00' ELSE comm_gm_threshold_cd END as comm_tier_cd 
	, ISNULL(comm_gm_threshold_descr,'na') rate_level_display

	-- temp
	--,[comm_plan_id]
	--,[cust_comm_group_cd]
	--,[source_cd]
	--,comm_gm_threshold_cd AS comm_gm_threshold_cd_ORG
	--,[comm_group_tier_ind]
	--
--	, comm_gm_threshold_cd + ' ' + ISNULL(comm_gm_threshold_descr,'na') rate_level_display
FROM
	comm.plan_group_rate
WHERE
	(comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00')) AND
--	([item_comm_group_cd] in ('ITMCAM', 'ITMSND', 'ITMPPE')) AND
	(active_ind = 1) AND 
--	(comm_group_tier_ind =1) AND
	(source_cd <> 'PAY') AND
	(1=1)

UNION ALL
Select 0, '.', 'Txx', ''
GO
*/

print ('UPDATE  comm.plan_group_rate')
UPDATE  comm.plan_group_rate
SET
comm_group_tier_ind = 1
, comm_gm_threshold_descr = '.'
, comm_gm_threshold_min = - 1
, comm_gm_threshold_max = - 1
-- select * from comm.plan_group_rate
WHERE
	(comm_plan_id IN ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00')) AND 
	(item_comm_group_cd IN ('ITMCAM', 'ITMSND', 'ITMPPE')) AND 
	(comm_gm_threshold_cd BETWEEN 'T10' AND 'T60') AND 
	(source_cd IN ('JDE', 'IMP')) AND 
	(active_ind = 1) AND 
	(cust_comm_group_cd IN ('SPCCRD', 'SPMALL', 'SPMSND')) AND 
	-- test
	-- (calc_key = 63406) AND
	--
	(1 = 1)
GO

/*
select * from [comm].[transaction_F555115] where ID in( 24106575, 24081867)

select * from [dbo].[BRS_CustomerFSC_History] where [Shipto] = 4266443 and FiscalMonth = 202512

select * from comm.plan_group_rate where [calc_key]=34273

select * from comm.plan_group_rate where comm_plan_id = 'FSCGP02   ' and item_comm_group_cd = 'SPMFGS' and cust_comm_group_cd = 'SPMSND'
*/

--6. wrap up day-2 stuff: set the rates, set the main backend
-- test the tiers (is the New tier better / lower than legacy 1/2)
-- update the rates



--* create customer view with tiers?

-->
/*
comm design

Comm MS Rules, and subset of Branded (this week)
Branch only view (but Plan driven)
use MarketClass New
Roll to Plan Level

Inst 1/2 & Full - Kelly cleanup rules
* Sebastian (FSC vs Inst=1/2) (1/2), 
* JonathanMcNight (1/2 & Full - check this) = Full
* Sally = McGll only = Full

MM & Zahn SM @ Branch
* Backpocket will be sunset
* Use 2025 FY for initial setup, Quarter roll
Full = High
1/2 = Lowest
>35
Tier1-5 (line to Medical)
Tier1
...
Tier2

comm SM
* Gary report?
New Levels?
By Branch?

EQ not changing, Full / 1/2
Merch Full & 6 

Rebates?
Free goods?
CCI? include?  in group
Scope?  fully inclusive.

Midmarket, inst

not Med, Not PP

<> LDSO

MM = Plan / Entity?
ZahnSM 
Inst (remove FSC 2026)

SmallEQ = EQ

Comm BI?  test it

Pull the report by Plan

Jan = 2025 FY

*/
--<

print ('fin missing map fix')
UPDATE  hfm.account_master_F0901
SET        HFM_CostCenter = N'CC020099000000', LastUpdated = '2026-01-29'
WHERE   (GMOBJ__object_account = '4730') AND (HFM_CostCenter IS NULL) AND (1 = 1)

-- fix DS fin

-- YTD testing
print ('recalc 2025, 10m')
print 202501
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202501
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202502
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202502
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202503
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202503
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202504
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202504
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202505
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202505
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202506
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202506
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202507
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202507
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202508
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202508
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202509
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202509
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202510
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202510
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202511
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202511
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202512
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202512
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
/*
print 202601
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202601
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
*/

-- set rates
SELECT   
comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, comm_gm_threshold_cd, disp_comm_group_cd, comm_rt, active_ind, creation_dt, note_txt, show_ind, calc_key, fg_comm_group_cd,  comm_group_tier_ind
FROM     comm.plan_group_rate AS r
WHERE   
(comm_plan_id IN ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q')) AND (source_cd IN ('JDE', 'IMP')) AND (active_ind = 1) AND (1 = 1) and
--comm_group_tier_ind = 0 and
-- comm_rt = 0 and
disp_comm_group_cd not in ('SALD30', 'SCRCRD', 'STMPBA', 'ITMEQ0')
ORDER BY disp_comm_group_cd
GO

-- ME testing

-- manual: load dim / fact in dev

print ('set SM tier to T30 for testing')
UPDATE  BRS_Customer
SET        comm_group_tier_cd = 'T10'
WHERE   [comm_status_cd] IN ('SPCCRD', 'SPMALL', 'SPMSND')
GO

print ('setup PPE')
UPDATE  BRS_Item
SET        [comm_group_cd] = 'ITMPPE'
WHERE   (LEFT(MinorProductClass, 3) IN ('006', '008', '013', '054')) AND (comm_group_cd IN ('ITMCAM', 'ITMSND')) AND (1 = 1)
GO


print 202601
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202601

print ('comm.comm_sync_proc')
EXEC comm.comm_sync_proc @bDebug = 1
EXEC comm.comm_sync_proc @bDebug = 0

-- fix missing data
select * from [dbo].[BRS_FSC_Rollup] where TerritoryCd = 'CZ1J2'

-- fix new terr
update [BRS_FSC_Rollup] 
set comm_salesperson_key_id = 'JULIA.MERRITT.FSC'
where TerritoryCd = 'CZ1J2'

-- temp fix
update BRS_Item 
set comm_group_cd = 'ITMSND'
WHERE 
comm_group_cd = ''

print ('monthend_snapshot_proc, 1m20')
EXEC dbo.monthend_snapshot_proc @bDebug = 1
EXEC dbo.monthend_snapshot_proc @bDebug = 0


print ('comm.transaction_load_proc, 3m40')
EXEC comm.transaction_load_proc @bDebug = 1
EXEC comm.transaction_load_proc @bDebug = 0


print ('comm.adjustment_load_proc')
EXEC comm.adjustment_load_proc @bDebug = 1,@bClearStage = 0
EXEC comm.adjustment_load_proc @bDebug = 0,@bClearStage = 0


print ('comm.transaction_commission_calc_proc, 2m26')
EXEC comm.transaction_commission_calc_proc @bDebug = 1
EXEC comm.transaction_commission_calc_proc @bDebug = 0


-- fix ME GL

-- find missing map
print ('T05: missing ENTITY_cb') 
SELECT * FROM [hfm].global_cube where ENTITY_cb is null and ext_chargeback <> 0.0 and PERIOD = 202512

-- fix missing map

SELECT hfm_CostCenter, hfm_account, LastUpdated
FROM
	hfm.account_master_F0901 AS a 
WHERE 
--a.GMMCU__business_unit = '020009000100' AND 
a.GMOBJ__object_account = '4730' AND 
--hfm_CostCenter is null and
-- a.GMSUB__subsidiary = 'xxx' AND
(1=1)
order by 1

