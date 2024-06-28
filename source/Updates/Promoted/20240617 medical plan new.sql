-- medical plan new, tmc, 20240617

-- 1. Add new plan

SELECT *
  FROM [comm].[plan]
  where comm_plan_id = 'FSCGPM'
GO

INSERT INTO comm.[plan]
             (comm_plan_id, comm_plan_nm, note_txt, active_ind)
SELECT   'FSCMT02' AS comm_plan_id, 'Medical Plan new' comm_plan_nm, 'GP Plan - Medical New' note_txt, active_ind
FROM     comm.[plan] AS plan_1
WHERE   (comm_plan_id = 'FSCGPM')
GO

-- review new plan
SELECT *
  FROM [comm].[plan]
  where comm_plan_id = 'FSCMT02'
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.[plan] ADD
	comm_gm_threshold_ind bit NOT NULL CONSTRAINT DF_plan_comm_gm_threshold_ind DEFAULT 0
GO
ALTER TABLE comm.[plan] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE  comm.[plan]
SET        comm_gm_threshold_ind = 1
WHERE   (comm_plan_id = 'FSCMT02')

  --
  --FSCMT02v


-- 2. Assign FSC to new plan, current and history

select * from [dbo].[BRS_FSC_Rollup] 
where [TerritoryCd] in('MZ1PD')
--where [TerritoryCd] in('MZ1PD', 'WZ1AS')

select * from [comm].[salesperson_master]
where [master_salesperson_cd] in('MZ1PD')

UPDATE  comm.salesperson_master
SET        comm_plan_id = 'FSCMT02'
WHERE   (master_salesperson_cd IN ('MZ1PD'))

--history review
select * from [dbo].[BRS_CustomerFSC_History]
where 
FiscalMonth = 202405 AND
[HIST_TerritoryCd] in('MZ1PD') and
HIST_fsc_comm_plan_id <> 'FSCMT02'

--history update
UPDATE  BRS_CustomerFSC_History
SET        HIST_fsc_comm_plan_id = 'FSCMT02'
WHERE   (FiscalMonth = 202405) AND (HIST_TerritoryCd IN ('MZ1PD'))

-- master update

SELECT  [employee_num]
      ,[master_salesperson_cd]
      ,[salesperson_key_id]
      ,[salesperson_nm]
      ,[comm_plan_id]
      ,[territory_start_dt]
      ,[salesperson_master_key]
  FROM [comm].[salesperson_master] where [salesperson_key_id] = 'PAIGE.DALLEY'


UPDATE  comm.salesperson_master
SET        comm_plan_id = 'FSCMT02'
WHERE   (salesperson_key_id = 'PAIGE.DALLEY') 


--3. Calc rates (old)
select [PriorFiscalMonth] from  [dbo].[BRS_Config]

update  [dbo].[BRS_Config]  set [PriorFiscalMonth] = 202405


-- debug review


-- Debug
-- EXEC comm.comm_stage_update_proc @bDebug=1

-- Prod
-- EXEC comm.comm_stage_update_proc @bDebug=0


Exec comm.transaction_commission_calc_proc @bDebug=1

Exec comm.transaction_commission_calc_proc @bDebug=0

-- test calc, should work

SELECT   TOP (10) FiscalMonth, [WSDCTO_order_type], fsc_calc_key
FROM     comm.transaction_F555115
WHERE   (FiscalMonth = 202405) AND (fsc_comm_plan_id = 'FSCMT02') and fsc_calc_key is not null

--4. Add new rate
-- review plan
SELECT   d.comm_plan_id, d.item_comm_group_cd, d.cust_comm_group_cd, d.source_cd, d.disp_comm_group_cd, d.comm_rt, d.active_ind, d.note_txt, d.show_ind, d.fg_comm_group_cd
FROM     comm.plan_group_rate AS d INNER JOIN
             comm.plan_group_rate AS s ON d.item_comm_group_cd = s.item_comm_group_cd AND d.cust_comm_group_cd = s.cust_comm_group_cd AND d.source_cd = s.source_cd
WHERE   (d.comm_plan_id = 'FSCMT02') and (s.comm_plan_id = 'FSCGPM') 

-- clone rate info
UPDATE  comm.plan_group_rate
SET        disp_comm_group_cd = s.disp_comm_group_cd, comm_rt = s.comm_rt, active_ind = s.active_ind, note_txt = s.note_txt, show_ind = s.show_ind, fg_comm_group_cd = s.fg_comm_group_cd
FROM     comm.plan_group_rate INNER JOIN
             comm.plan_group_rate AS s ON comm.plan_group_rate.item_comm_group_cd = s.item_comm_group_cd AND comm.plan_group_rate.cust_comm_group_cd = s.cust_comm_group_cd AND comm.plan_group_rate.source_cd = s.source_cd
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') AND (s.comm_plan_id = 'FSCGPM')

-- consolidate groups
-- simplify the rollup Merch, Privat, EQ, and Zero

SELECT    distinct d.disp_comm_group_cd, comm_rt, fg_comm_group_cd
FROM     comm.plan_group_rate d
WHERE   (d.comm_plan_id = 'FSCMT02') 


UPDATE  comm.plan_group_rate
SET        disp_comm_group_cd = 'FRESND'
FROM     comm.plan_group_rate 
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') and
[disp_comm_group_cd] in (
 'FRESEQ'
, 'FRESND'
, 'SPMFGE'
, 'SPMFGS'
)

UPDATE  comm.plan_group_rate
SET        disp_comm_group_cd = 'ITMEQ0'
FROM     comm.plan_group_rate 
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') and
[disp_comm_group_cd] in (
 'DIGIMP'
, 'DIGMAT'
, 'ITMCAM'
, 'ITMEPS'
, 'ITMEQ0'
, 'ITMISC'
, 'ITMPAR'
, 'ITMSER'
, 'ITMTEE'
, 'REBSND'
, 'REBTEE'
, 'SCRCRD'
, 'SPMREB'
,'ITMFRT'
)
GO

UPDATE  comm.plan_group_rate
SET        disp_comm_group_cd = 'ITMFO2'
FROM     comm.plan_group_rate 
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') and
[disp_comm_group_cd] in (
 'ITMCPU'
, 'ITMFO1'
, 'ITMFO2'
, 'ITMFO3'
, 'ITMSOF'
, 'SPMFO1'
, 'SPMFO2'
, 'SPMFO3'
)
GO


-- rule added AFTER testing so the filter correct
UPDATE  comm.plan_group_rate
SET        disp_comm_group_cd = 'SFFFIN'
FROM     comm.plan_group_rate 
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') and
[item_comm_group_cd] in (
 'SFFFIN'
)
GO


UPDATE  comm.plan_group_rate
SET        disp_comm_group_cd = 'ITMPVT'
FROM     comm.plan_group_rate 
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') and
[disp_comm_group_cd] in (
 'ITMPVT'
, 'SPMPVT'
)
GO

UPDATE  comm.plan_group_rate
SET        disp_comm_group_cd = 'ITMSND'
FROM     comm.plan_group_rate 
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') and
[disp_comm_group_cd] in (
 'ITMSND'
, 'SPMSND'
)
GO

-- update free goods rollup
UPDATE  comm.plan_group_rate
SET        [fg_comm_group_cd] = 'FRESND'
FROM     comm.plan_group_rate 
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') and
[fg_comm_group_cd] in (
 'FRESEQ'
, 'FRESND'
, 'SPMFGE'
, 'SPMFGS'
)


-- 5. add Level table to rate rule?
-- add the Level concept with Defautls ONLY 

BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD
	comm_gm_threshold_cd char(3) NOT NULL CONSTRAINT DF_plan_group_rate_comm_gm_threshold_cd DEFAULT ''
GO
ALTER TABLE comm.plan_group_rate
	DROP CONSTRAINT commission_plan_c_pk
GO
ALTER TABLE comm.plan_group_rate ADD CONSTRAINT
	commission_plan_c_pk PRIMARY KEY CLUSTERED 
	(
	comm_plan_id,
	item_comm_group_cd,
	cust_comm_group_cd,
	source_cd,
	comm_gm_threshold_cd
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD
	comm_gm_threshold_ind bit NOT NULL CONSTRAINT DF_plan_group_rate_comm_gm_threshold_ind DEFAULT 0
GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--> TC oopsy here.   manual review, OK
BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD

	BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD
	comm_gm_threshold_descr varchar(30) NULL
GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
-- varchar(30) NULL
GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
--< TC oopsy here.   manual review, OK


-- enable threhold for all
UPDATE  comm.plan_group_rate
SET        comm_gm_threshold_ind = 1
WHERE   (comm_plan_id = 'FSCMT02')

-- exluclude for pay, as it is not GP driven
UPDATE  comm.plan_group_rate
SET        comm_gm_threshold_ind = 0
WHERE   (comm_plan_id = 'FSCMT02') and source_cd = 'PAY'


-- fix new Med IMP transations -- clear old plan so new plan gets set

--
SELECT   FiscalMonth, WSDOCO_salesorder_number, WSLNID_line_number, fsc_comm_plan_id, fsc_comm_group_cd, source_cd, WSDCTO_order_type, WSLITM_item_number, WSDSC1_description, fsc_comm_group_cd, fsc_comm_rt, FreeGoodsInvoicedInd, gp_ext_amt, transaction_amt, gp_ext_amt / nullif(transaction_amt,0) gm
FROM     comm.transaction_F555115
WHERE   (FiscalMonth >= 202301) AND (source_cd='IMP') AND fsc_code='MZ1PD' and
(1=1)
order by gm

-- fix Paige adj by setting to new plan (as this is setup by offline pre- and post- adj process)
UPDATE  comm.transaction_F555115
SET        fsc_comm_plan_id = 'FSCMT02'
--, fsc_comm_group_cd =
WHERE   (FiscalMonth >= 202301) AND (source_cd = 'IMP') AND (fsc_code = 'MZ1PD') AND (1 = 1)

-- Calc Commission, pre and post calc proc update

print 202405
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202405

-- update calc, pre prod test

Exec comm.transaction_commission_calc_proc @bDebug=1
-- DEV 1m
-- PROD 1m
Exec comm.transaction_commission_calc_proc @bDebug=0

GO

-- test calc QA vs PROD

SELECT        s.FiscalMonth, s.WSCO___company, s.source_cd, s.WSDOCO_salesorder_number, s.WSDCTO_order_type, s.WSLNTY_line_type, s.WSLNID_line_number, s.WS$OSC_order_source_code, s.WSAN8__billto, s.WSSHAN_shipto, 
                         s.WSDGL__gl_date, s.fsc_calc_key, d.fsc_calc_key AS fsc_calc_key_prod, s.fsc_code, d.fsc_code AS fsc_code_prod, s.fsc_comm_group_cd, d.fsc_comm_group_cd, s.fsc_comm_amt, d.fsc_comm_amt, d.gp_ext_amt
FROM            comm.transaction_F555115 AS s INNER JOIN
                         BRSales.comm.transaction_F555115 AS d ON s.ID = d.ID AND ISNULL(s.fsc_calc_key,0) <> ISNULL(d.fsc_calc_key,0)
WHERE        (s.FiscalMonth = 202405)
order by d.fsc_calc_key
GO

--< skip prod

-- 170 rowdiff, baseline

-- add new levels to medical
-- set the rates
-- add the Level concept with DEautls, Level, Lower



-- test rates by display code
SELECT   comm_plan_id, source_cd, disp_comm_group_cd, MIN(comm_rt) AS comm_rt_min, MAX(comm_rt) AS comm_rt_max
FROM     comm.plan_group_rate
where    (comm_plan_id = 'FSCGPM')
GROUP BY comm_plan_id, source_cd, disp_comm_group_cd
order by 4,5
GO

-- review comm used codes

SELECT   comm.plan_group_rate.comm_plan_id, comm.plan_group_rate.source_cd, comm.plan_group_rate.disp_comm_group_cd, MIN(fsc_comm_rt) as comm_rt_min, MAX(fsc_comm_rt) as comm_rt_max, sum(gp_ext_amt) gp
FROM     comm.transaction_F555115 INNER JOIN
             comm.plan_group_rate ON comm.transaction_F555115.fsc_calc_key = comm.plan_group_rate.calc_key
WHERE   (comm.transaction_F555115.fsc_comm_plan_id = 'FSCGPM') and
(comm.transaction_F555115.FiscalMonth >= 202301)
GROUP BY comm.plan_group_rate.comm_plan_id, comm.plan_group_rate.source_cd, comm.plan_group_rate.disp_comm_group_cd
order by 3


-- review rates

SELECT    *
FROM     comm.plan_group_rate
WHERE   (comm_plan_id = 'FSCMT02') and active_ind <> 0 and
(item_comm_group_cd = 'SFFFIN') AND source_cd <> 'PAY' AND
(1=1)
order by comm_rt desc


-- create levels
truncate table zzzitem
insert into zzzitem 
(Item)
values('T10')
insert into zzzitem 
(Item)
values('T20')
insert into zzzitem 
(Item)
values('T30')
insert into zzzitem 
(Item)
values('T40')
insert into zzzitem 
(Item)
values('TZZ')

SELECT   comm.plan_group_rate.comm_plan_id, comm.plan_group_rate.item_comm_group_cd, comm.plan_group_rate.cust_comm_group_cd, comm.plan_group_rate.source_cd, comm.plan_group_rate.disp_comm_group_cd, comm.plan_group_rate.comm_rt, comm.plan_group_rate.active_ind, comm.plan_group_rate.note_txt, 
             comm.plan_group_rate.show_ind, comm.plan_group_rate.calc_key, comm.plan_group_rate.comm_gm_threshold_ind, zzzItem.Item
FROM     comm.plan_group_rate CROSS JOIN
             zzzItem
WHERE   (comm.plan_group_rate.comm_plan_id = 'FSCMT02') AND (comm.plan_group_rate.active_ind <> 0) and source_cd <>'PAY'
order by disp_comm_group_cd, calc_key

-- add threshold levels
INSERT INTO comm.plan_group_rate
             (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, comm_gm_threshold_ind, comm_gm_threshold_cd)
SELECT   r.comm_plan_id, r.item_comm_group_cd, r.cust_comm_group_cd, r.source_cd, r.disp_comm_group_cd, r.comm_rt, r.active_ind, r.note_txt, r.show_ind, r.comm_gm_threshold_ind, t.Item
FROM     comm.plan_group_rate AS r CROSS JOIN
             zzzItem AS t
WHERE   (r.comm_plan_id = 'FSCMT02') AND (r.active_ind <> 0) AND (r.source_cd <> 'PAY')

-- add threshold params

BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD
	comm_gm_threshold_min float(53) NULL,
	comm_gm_threshold_max float(53) NULL
GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- update threshold params
   

-- review
SELECT   comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_gm_threshold_cd, comm_rt, comm_gm_threshold_min, comm_gm_threshold_max
FROM     comm.plan_group_rate
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY')
ORDER BY disp_comm_group_cd, comm_gm_threshold_cd

-- review pay
SELECT   comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_gm_threshold_ind, comm_gm_threshold_cd, comm_rt, comm_gm_threshold_min, comm_gm_threshold_max
FROM     comm.plan_group_rate
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd = 'PAY')
ORDER BY disp_comm_group_cd, comm_gm_threshold_cd


-- 'T10', 'T20', 'T30', 'T40'

--init
UPDATE  comm.plan_group_rate
SET        comm_rt =0, comm_gm_threshold_descr=null
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') 

-- merch 1 
UPDATE  comm.plan_group_rate
SET        comm_rt =12, comm_gm_threshold_min =25, comm_gm_threshold_max =999, comm_gm_threshold_descr='>25%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMSND', 'FRESND')) and comm_gm_threshold_cd ='T10'

-- merch 2 
UPDATE  comm.plan_group_rate
SET        comm_rt =11, comm_gm_threshold_min =23, comm_gm_threshold_max =25, comm_gm_threshold_descr='>23 to 25%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMSND', 'FRESND')) and comm_gm_threshold_cd ='T20'

-- merch 3 
UPDATE  comm.plan_group_rate
SET        comm_rt =10, comm_gm_threshold_min =21, comm_gm_threshold_max =23, comm_gm_threshold_descr='>21 to 23%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMSND', 'FRESND')) and comm_gm_threshold_cd ='T30'

-- merch 4 
UPDATE  comm.plan_group_rate
SET        comm_rt =9, comm_gm_threshold_min =0, comm_gm_threshold_max =21, comm_gm_threshold_descr='<21%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMSND', 'FRESND')) and comm_gm_threshold_cd ='T40'

-- merch z
UPDATE  comm.plan_group_rate
SET        comm_rt =9, comm_gm_threshold_min =-999, comm_gm_threshold_max =0, comm_gm_threshold_descr='<0%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMSND', 'FRESND')) and comm_gm_threshold_cd ='TZZ'

-- merch default
UPDATE  comm.plan_group_rate
SET        comm_rt =12, comm_gm_threshold_descr='default'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMSND', 'FRESND')) and comm_gm_threshold_cd =''

-- 
-- private 1  
UPDATE  comm.plan_group_rate
SET        comm_rt =14, comm_gm_threshold_min =45, comm_gm_threshold_max =999, comm_gm_threshold_descr='>45%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMPVT')) and comm_gm_threshold_cd ='T10'

-- private 2 
UPDATE  comm.plan_group_rate
SET        comm_rt =13, comm_gm_threshold_min =40, comm_gm_threshold_max =45, comm_gm_threshold_descr='>40 to 45%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMPVT')) and comm_gm_threshold_cd ='T20'

-- private 3 
UPDATE  comm.plan_group_rate
SET        comm_rt =12, comm_gm_threshold_min =35, comm_gm_threshold_max =40, comm_gm_threshold_descr='>35 to 40%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMPVT')) and comm_gm_threshold_cd ='T30'

-- private 4 
UPDATE  comm.plan_group_rate
SET        comm_rt =11, comm_gm_threshold_min =0, comm_gm_threshold_max =35, comm_gm_threshold_descr='<35%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMPVT')) and comm_gm_threshold_cd ='T40'

-- private z 
UPDATE  comm.plan_group_rate
SET        comm_rt =11, comm_gm_threshold_min =-999, comm_gm_threshold_max =0, comm_gm_threshold_descr='<0%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMPVT')) and comm_gm_threshold_cd ='TZZ'

-- private default 
UPDATE  comm.plan_group_rate
SET        comm_rt =14, comm_gm_threshold_descr='default'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMPVT')) and comm_gm_threshold_cd =''

-- 
-- EQ 1 
UPDATE  comm.plan_group_rate
SET        comm_rt =12, comm_gm_threshold_min =25, comm_gm_threshold_max =999, comm_gm_threshold_descr='>25%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMFO2')) and comm_gm_threshold_cd ='T10'

-- EQ 2 
UPDATE  comm.plan_group_rate
SET        comm_rt =11, comm_gm_threshold_min =20, comm_gm_threshold_max =25, comm_gm_threshold_descr='>20 to 25%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMFO2')) and comm_gm_threshold_cd ='T20'

-- EQ 3 
UPDATE  comm.plan_group_rate
SET        comm_rt =10, comm_gm_threshold_min =15, comm_gm_threshold_max =20, comm_gm_threshold_descr='>15 to 20%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMFO2')) and comm_gm_threshold_cd ='T30'

-- EQ 4 
UPDATE  comm.plan_group_rate
SET        comm_rt =9, comm_gm_threshold_min =0, comm_gm_threshold_max =15, comm_gm_threshold_descr='<15%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMFO2')) and comm_gm_threshold_cd ='T40'

-- EQ z 
UPDATE  comm.plan_group_rate
SET        comm_rt =9, comm_gm_threshold_min =-999, comm_gm_threshold_max =0, comm_gm_threshold_descr='<0%'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMFO2')) and comm_gm_threshold_cd ='TZZ'

-- EQ default 
UPDATE  comm.plan_group_rate
SET        comm_rt =12, comm_gm_threshold_descr='default'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('ITMFO2')) and comm_gm_threshold_cd =''


-- Zero
UPDATE  comm.plan_group_rate
SET        comm_rt =0, comm_gm_threshold_min =-999, comm_gm_threshold_max =999, comm_gm_threshold_descr='default'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('', 'ITMEQ0')) and comm_gm_threshold_cd =''


-- ITMFRT
UPDATE  comm.plan_group_rate
SET        comm_rt =10, comm_gm_threshold_min =-999, comm_gm_threshold_max =999, comm_gm_threshold_descr='default'
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY') AND (disp_comm_group_cd IN ('SFFFIN')) and comm_gm_threshold_cd =''

GO


-- GM by line, test null
SELECT   FiscalMonth, WSDOCO_salesorder_number, WSLNID_line_number, fsc_comm_plan_id, fsc_comm_group_cd, source_cd, WSDCTO_order_type, WSLITM_item_number, WSDSC1_description, fsc_comm_group_cd, fsc_comm_rt, FreeGoodsInvoicedInd, gp_ext_amt, transaction_amt, gp_ext_amt / nullif(transaction_amt,0) gm

FROM     comm.transaction_F555115
WHERE   (FiscalMonth >= 202301) AND (fsc_comm_plan_id LIKE 'FSC%') AND (source_cd IN ('JDE', 'IMP')) AND 
(WSDOCO_salesorder_number=17260811) and
(transaction_amt = 0) AND
(source_cd='IMP') AND
(1=1)
order by gm


-- review
SELECT   calc_key, disp_comm_group_cd, comm_gm_threshold_cd + ' ' + ISNULL(comm_gm_threshold_descr,'na') rate_level_display
FROM     comm.plan_group_rate
WHERE   (comm_plan_id = 'FSCMT02') AND (active_ind <> 0) AND (source_cd <> 'PAY')
ORDER BY rate_level_display

GO

--
-- update calc, post prod test

Exec comm.transaction_commission_calc_proc @bDebug=1
-- DEV 1m
-- PROD 1m
Exec comm.transaction_commission_calc_proc @bDebug=0

GO

-- test calc QA vs PROD

SELECT        s.FiscalMonth, s.fsc_comm_plan_id, d.fsc_comm_plan_id, s.fsc_salesperson_key_id, d.fsc_salesperson_key_id, s.WSCO___company, s.source_cd, s.WSDOCO_salesorder_number, s.WSDCTO_order_type, s.WSLNTY_line_type, s.WSLNID_line_number, s.WS$OSC_order_source_code, s.WSAN8__billto, s.WSSHAN_shipto, 
                         s.WSDGL__gl_date, s.fsc_calc_key, d.fsc_calc_key AS fsc_calc_key_prod, s.fsc_code, d.fsc_code AS fsc_code_prod, s.fsc_comm_group_cd, d.fsc_comm_group_cd, s.fsc_comm_amt, d.fsc_comm_amt, s.gp_ext_amt, d.gp_ext_amt, s.id, d.id
FROM            comm.transaction_F555115 AS s INNER JOIN
                         BRSales.comm.transaction_F555115 AS d ON s.ID = d.ID AND ISNULL(s.fsc_calc_key,0) <> ISNULL(d.fsc_calc_key,0)
WHERE
(s.FiscalMonth = 202405) and
(d.fsc_salesperson_key_id = 'PAIGE.DALLEY') 
--order by 4
order by d.fsc_calc_key
GO

--< skip prod

--

--< Stop prod here

--  testing, in IN QA only...

-- move from Med to new Med

-- 2. Assign FSC to new plan, current and history

SELECT   BRS_FSC_Rollup.TerritoryCd, comm.salesperson_master.comm_plan_id
FROM     BRS_FSC_Rollup INNER JOIN
             comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
where comm_plan_id like 'FSCGPM%'

UPDATE  comm.salesperson_master
SET        comm_plan_id = 'FSCMT02'
WHERE   (comm_plan_id LIKE 'FSCGPM%')
-- xx

--history review
select * from [dbo].[BRS_CustomerFSC_History]
where 
FiscalMonth = 202405 AND
HIST_fsc_comm_plan_id LIKE 'FSCGPM%'

--history update
UPDATE  BRS_CustomerFSC_History
SET        HIST_fsc_comm_plan_id = 'FSCMT02'
WHERE   (FiscalMonth = 202405) AND (HIST_fsc_comm_plan_id LIKE 'FSCGPM%')

UPDATE  comm.transaction_F555115
SET        fsc_comm_plan_id = 'FSCMT02'
WHERE   (FiscalMonth >= 202301) AND (source_cd = 'IMP') AND (fsc_comm_plan_id LIKE 'FSCGPM%') AND (1 = 1)

-- div test
select * from [comm].[salesperson_master] where [master_salesperson_cd] in ('CZ25T', 'WZ2CV' )

SELECT   comm.transaction_F555115.FiscalMonth, comm.transaction_F555115.WSDOCO_salesorder_number, comm.transaction_F555115.WSDCTO_order_type, comm.transaction_F555115.WSLNTY_line_type, comm.transaction_F555115.WSLNID_line_number, comm.transaction_F555115.WSSHAN_shipto, BRS_Customer.SalesDivision
FROM     comm.transaction_F555115 INNER JOIN
             BRS_Customer ON comm.transaction_F555115.WSSHAN_shipto = BRS_Customer.ShipTo
WHERE   (comm.transaction_F555115.FiscalMonth = 202405) AND (comm.transaction_F555115.ID IN (18144316, 18131821, 18149524))
GO
