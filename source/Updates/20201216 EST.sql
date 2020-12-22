-- setup EST support fields

INSERT INTO [comm].[plan]
           ([comm_plan_id]
           ,[comm_plan_nm]
)
     VALUES
           ('ESTGP00'
           ,'EST plan 0'),
           ('ESTGP02'
           ,'EST plan 2'),
           ('ESTGP03'
           ,'EST plan 3'
			)
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	est_salesperson_key_id varchar(30) NULL,
	est_comm_plan_id char(10) NULL,
	est_comm_rt float(53) NULL,
	est_comm_amt money NOT NULL CONSTRAINT DF_transaction_F555115_est_comm_amt DEFAULT ((0)),
	est_code char(5) NULL,
	est_calc_key int NULL
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add missed est comm group code
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	est_comm_group_cd char(6) NULL
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group7 FOREIGN KEY
	(
	est_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add est comm code historical
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemHistory ADD
	HIST_comm_group_est_cd char(6) NOT NULL CONSTRAINT DF_BRS_ItemHistory_HIST_comm_group_est_cd DEFAULT ('')
GO
ALTER TABLE dbo.BRS_ItemHistory ADD CONSTRAINT
	FK_BRS_ItemHistory_group3 FOREIGN KEY
	(
	HIST_comm_group_est_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemHistory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
-- add est to item
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	comm_group_est_cd char(6) NOT NULL CONSTRAINT DF_BRS_Item_comm_group_est_cd DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_group2 FOREIGN KEY
	(
	comm_group_est_cd
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
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_salesperson_master5 FOREIGN KEY
	(
	est_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan5 FOREIGN KEY
	(
	est_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup12 FOREIGN KEY
	(
	est_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan_group_rate5 FOREIGN KEY
	(
	isr_calc_key
	) REFERENCES comm.plan_group_rate
	(
	calc_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	HIST_est_salesperson_key_id varchar(30) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_est_salesperson_key_id DEFAULT (''),
	HIST_est_comm_plan_id char(10) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_est_comm_plan_id DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	HIST_est_code char(5) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_est_code DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_salesperson_master2 FOREIGN KEY
	(
	HIST_est_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_plan2 FOREIGN KEY
	(
	HIST_est_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_code2 FOREIGN KEY
	(
	HIST_est_code
	) REFERENCES [dbo].[BRS_FSC_Rollup]
	(
	[TerritoryCd]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update est current, in Prod 16 Dec 20
BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull ADD
	EstTerritoryCd char(5) NULL
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
--< in QA, 16 Dec 20

----------------------------------------------------------------
--- EST setup plans and groups TBD
----------------------------------------------------------------
-- set history items, run EQ mode calc history
-- re-run calc above & dev model 

-- No comm - Zero Plan
UPDATE comm.plan_group_rate
SET [comm_rt] = 0
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'ESTGP00'   ) AND ([comm_rt] <> 0)
GO


-- mock up est rates
UPDATE comm.plan_group_rate
SET [comm_rt] = 1.5,
[active_ind] = 1,
[disp_comm_group_cd] = [item_comm_group_cd]
FROM comm.plan_group_rate 
WHERE 
([comm_plan_id] like 'ESTGP02' ) AND

[item_comm_group_cd] in(
		'ITMPAR', 'ITMSER'
) AND
(1=1)
GO

-- mock up isr rates based on FSC
UPDATE
	comm.plan_group_rate
set
	[disp_comm_group_cd] = src.[disp_comm_group_cd],
	[comm_rt] = src.[comm_rt],
	[active_ind] = src.[active_ind],
	[note_txt] = 'model2021',
	[show_ind] = src.[show_ind]
FROM 
(
	SELECT        comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind
	FROM            comm.plan_group_rate
	WHERE
	(comm_plan_id = 'FSCGP02') AND 
	(disp_comm_group_cd IN ('FRESEQ', 'FRESND', 'ITMEPS', 'ITMSND', 'ITMTEE', 'SALD30', 'SFFFIN', 'SPMFGE', 'SPMFGS', 'SPMSND', 'STMPBA'))
) src 
WHERE
	(comm.plan_group_rate.[comm_plan_id] = 'ISRGP02') AND
	(comm.plan_group_rate.[item_comm_group_cd] = src.[item_comm_group_cd]) AND
	(comm.plan_group_rate.[cust_comm_group_cd] = src.[cust_comm_group_cd]) AND
	(comm.plan_group_rate.[source_cd] = src.[source_cd]) AND
	(1=1)
GO

--
-- setup ISR users
-- load vis DEV salesperson 

-- set ISR customer history
UPDATE
	BRS_CustomerFSC_History
SET
	HIST_isr_salesperson_key_id = comm_salesperson_key_id, 
	HIST_isr_comm_plan_id = comm_plan_id
FROM
	BRS_CustomerFSC_History 

	INNER JOIN BRS_FSC_Rollup ON 
	BRS_CustomerFSC_History.HIST_TsTerritoryCd = BRS_FSC_Rollup.TerritoryCd 
	
	INNER JOIN comm.salesperson_master ON 
	BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id

WHERE
	(BRS_CustomerFSC_History.FiscalMonth >= 201901) AND 
	(comm.salesperson_master.comm_plan_id LIKE 'ISR%')


-- set ISR plan for Adjustments.  in prod, this is set manually.  We need to fake it
UPDATE
	comm.transaction_F555115
SET
	isr_code = s.HIST_TsTerritoryCd
	,isr_salesperson_key_id = s.HIST_isr_salesperson_key_id
	,isr_comm_plan_id = s.HIST_isr_comm_plan_id
	,[isr_calc_key]=NULL
-- Select s.FiscalMonth, d.[WSLITM_item_number], isr_code, fsc_code, isr_salesperson_key_id, fsc_salesperson_key_id, isr_comm_plan_id, fsc_comm_plan_id, [isr_calc_key], [fsc_calc_key], fsc_comm_group_cd
-- Select s.*	
FROM
	[dbo].[BRS_CustomerFSC_History] AS s 

	INNER JOIN comm.transaction_F555115 d
	ON (d.WSSHAN_shipto = s.Shipto) AND
	(d.FiscalMonth = s.FiscalMonth) AND
	(d.source_cd = 'IMP')
WHERE
	(s.HIST_isr_comm_plan_id <> '') AND
	(s.FiscalMonth between 201901 and 202010) AND
	(1=1)

-- set ISR comm rate for Adjustments.  in prod, this is set manually.  We need to fake it
UPDATE
	comm.transaction_F555115
SET
	isr_comm_group_cd = fsc_comm_group_cd
-- Select FiscalMonth, [WSLITM_item_number], isr_code, fsc_code, isr_salesperson_key_id, fsc_salesperson_key_id, isr_comm_plan_id, fsc_comm_plan_id, [isr_calc_key], [fsc_calc_key], isr_comm_group_cd, fsc_comm_group_cd
FROM
	comm.transaction_F555115 
WHERE
	(source_cd = 'IMP') AND
	(isr_comm_plan_id <> '') AND
	([WSLITM_item_number]='') AND
	fsc_comm_group_cd in(
		'FRESEQ', 'FRESND', 'ITMEPS', 'ITMSND', 'REBSND', 'REBTEE', 'SPMFGE', 'SPMFGS', 'SPMREB', 'SPMSND', 'STMPBA', 'SALD30'
		,'ITMCAM','ITMCPU','ITMEQ0','ITMFO1','ITMFO2','ITMFO3','DIGIMP','DIGMAT','ITMISC','ITMSOF','ITMTEE','SPMFO1','SPMFO2','SPMFO3'
	) AND
	(FiscalMonth between 201901 and 202010) AND
	(1=1)


-- test
Select FiscalMonth, [WSLITM_item_number], [WSSHAN_shipto], isr_code, fsc_code, isr_salesperson_key_id, fsc_salesperson_key_id, isr_comm_plan_id, fsc_comm_plan_id, [isr_calc_key], [fsc_calc_key], isr_comm_group_cd, fsc_comm_group_cd
FROM
comm.transaction_F555115
where 
(FiscalMonth = 201912) and
(source_cd = 'imp') and
(isr_comm_plan_id <> '') AND
--(fsc_comm_group_cd like 'reb%') and
(1=1)
order by 
fsc_comm_group_cd

