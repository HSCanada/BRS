
INSERT INTO [dbo].[BRS_CustomerSpecialty]
           ([Specialty]
           ,[SpecialtyNm]
           )
     VALUES
           ('CAMP'
           ,'.'
           ),
           ('CLIN'
           ,'.'
           )
GO
--


INSERT INTO [comm].[plan]
           ([comm_plan_id]
           ,[comm_plan_nm]
)
     VALUES
           ('ISRGP02'
           ,'ISR plan 2'),
           ('ISRGP03'
           ,'ISR plan 3'
			)
GO


BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	isr_salesperson_key_id varchar(30) NULL,
	isr_comm_plan_id char(10) NULL,
	isr_comm_rt float(53) NULL,
	isr_comm_amt money NOT NULL CONSTRAINT DF_transaction_F555115_isr_comm_amt DEFAULT ((0)),
	isr_code char(5) NULL,
	isr_calc_key int NULL
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_salesperson_master4 FOREIGN KEY
	(
	isr_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan4 FOREIGN KEY
	(
	isr_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup11 FOREIGN KEY
	(
	isr_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan_group_rate4 FOREIGN KEY
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
	HIST_isr_salesperson_key_id varchar(30) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_isr_salesperson_key_id DEFAULT (''),
	HIST_isr_comm_plan_id char(10) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_isr_comm_plan_id DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_salesperson_master FOREIGN KEY
	(
	HIST_isr_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_plan FOREIGN KEY
	(
	HIST_isr_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

---------------------------
--> END OF PROD, DEV below, 26 Nov 20

----------------------------------------------------------------
--- ISR model
----------------------------------------------------------------
-- set history items, run '-- update 2019 history' above
-- re-run calc above & dev model 


-- update new group
SELECT
d.comm_plan_id, d.item_comm_group_cd, d.cust_comm_group_cd, d.source_cd, d.disp_comm_group_cd, d.comm_rt, d.active_ind, d.note_txt, d.show_ind
FROM
comm.plan_group_rate AS d 
INNER JOIN comm.plan_group_rate AS s 
ON d.comm_plan_id like 'ISR%' AND
s.comm_plan_id = 'FSCGP02' AND 
d.cust_comm_group_cd = s.cust_comm_group_cd AND 
d.source_cd = s.source_cd AND 
d.item_comm_group_cd = s.item_comm_group_cd

-- clone FSC params to ISR
UPDATE
	comm.plan_group_rate
SET
	disp_comm_group_cd = s.disp_comm_group_cd
	, comm_rt = s.comm_rt
	, active_ind = s.active_ind
	, note_txt = 'model2021'
	, show_ind = s.show_ind
FROM
	comm.plan_group_rate 
	INNER JOIN comm.plan_group_rate AS s 
ON comm.plan_group_rate.comm_plan_id like 'ISR%' AND
	s.comm_plan_id = 'FSCGP02' AND 
	comm.plan_group_rate.cust_comm_group_cd = s.cust_comm_group_cd AND 
	comm.plan_group_rate.source_cd = s.source_cd AND 
	comm.plan_group_rate.item_comm_group_cd = s.item_comm_group_cd
GO

SELECT
distinct d.disp_comm_group_cd
--d.comm_plan_id, d.item_comm_group_cd, d.cust_comm_group_cd, d.source_cd, d.disp_comm_group_cd, d.comm_rt, d.active_ind, d.note_txt, d.show_ind
FROM
comm.plan_group_rate AS d 
WHERE 
([comm_plan_id] like 'ISRGP0[2 3]' ) AND
-- merch & small eq
not d.disp_comm_group_cd in(
	'FRESEQ', 'FRESND', 'ITMEPS', 'ITMSND', 'REBSND', 'REBTEE', 'SPMFGE', 'SPMFGS', 'SPMREB', 'SPMSND', 'STMPBA', 'SALD30'
,'ITMCAM','ITMCPU','ITMEQ0','ITMFO1','ITMFO2','ITMFO3','DIGIMP','DIGMAT','ITMISC','ITMSOF','ITMTEE','SPMFO1','SPMFO2','SPMFO3'

) AND
(1=1)
GO

-- full list, for ref.  FG & REB will not work currently
SELECT [item_comm_group_cd], disp_comm_group_cd, active_ind
  FROM [comm].[plan_group_rate]
  where 
	comm_plan_id like 'ISR%' AND
	item_comm_group_cd in(
	'FRESEQ', 'FRESND', 'ITMEPS', 'ITMSND', 'REBSND', 'REBTEE', 'SPMFGE', 'SPMFGS', 'SPMREB', 'SPMSND', 'STMPBA', 'SALD30'
,'ITMCAM','ITMCPU','ITMEQ0','ITMFO1','ITMFO2','ITMFO3','DIGIMP','DIGMAT','ITMISC','ITMSOF','ITMTEE','SPMFO1','SPMFO2','SPMFO3'

	) AND
	(1 = 1)
GO

-- set ISR comm group - active
UPDATE
	comm.plan_group_rate
SET
	active_ind = 1
	,disp_comm_group_cd = item_comm_group_cd
WHERE
	(comm_plan_id LIKE 'ISR%') AND 
	(item_comm_group_cd in(
		'FRESEQ', 'FRESND', 'ITMEPS', 'ITMSND', 'REBSND', 'REBTEE', 'SPMFGE', 'SPMFGS', 'SPMREB', 'SPMSND', 'STMPBA', 'SALD30'
		,'ITMCAM','ITMCPU','ITMEQ0','ITMFO1','ITMFO2','ITMFO3','DIGIMP','DIGMAT','ITMISC','ITMSOF','ITMTEE','SPMFO1','SPMFO2','SPMFO3'
	) ) AND 
	(1 = 1)
GO

-- set ISR comm group - NOT active
UPDATE
	comm.plan_group_rate
SET
	active_ind = 0
	,disp_comm_group_cd = ''
WHERE
	(comm_plan_id LIKE 'ISR%') AND 
	(item_comm_group_cd NOT in(
		'FRESEQ', 'FRESND', 'ITMEPS', 'ITMSND', 'REBSND', 'REBTEE', 'SPMFGE', 'SPMFGS', 'SPMREB', 'SPMSND', 'STMPBA', 'SALD30'
		,'ITMCAM','ITMCPU','ITMEQ0','ITMFO1','ITMFO2','ITMFO3','DIGIMP','DIGMAT','ITMISC','ITMSOF','ITMTEE','SPMFO1','SPMFO2','SPMFO3'
	) ) AND 
	(1 = 1)
GO

-- No comm - Zero Plan
UPDATE comm.plan_group_rate
SET [comm_rt] = 0
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'ISRGP00'   ) AND ([comm_rt] <> 0)
GO

-- No comm - non Merch and Small EQ
UPDATE comm.plan_group_rate
SET [comm_rt] = 0
FROM comm.plan_group_rate 
WHERE 
([comm_plan_id] like 'ISRGP0[2 3]' ) AND
-- merch & small eq
not disp_comm_group_cd in(
		'FRESEQ', 'FRESND', 'ITMEPS', 'ITMSND', 'REBSND', 'REBTEE', 'SPMFGE', 'SPMFGS', 'SPMREB', 'SPMSND', 'STMPBA', 'SALD30'
		,'ITMCAM','ITMCPU','ITMEQ0','ITMFO1','ITMFO2','ITMFO3','DIGIMP','DIGMAT','ITMISC','ITMSOF','ITMTEE','SPMFO1','SPMFO2','SPMFO3'

) AND
(1=1)
GO

-- Set Merch 
UPDATE comm.plan_group_rate
SET [comm_rt] = 1.5
FROM comm.plan_group_rate 
WHERE 
([comm_plan_id] like 'ISRGP0[2 3]' ) AND
-- merch & small eq
disp_comm_group_cd in(
		'FRESND', 'ITMEPS', 'ITMSND', 'REBSND', 'REBTEE', 
		'ITMCAM','DIGMAT','ITMTEE'
) AND
(1=1)
GO

-- Set EQ 
UPDATE comm.plan_group_rate
SET [comm_rt] = 1
FROM comm.plan_group_rate 
WHERE 
([comm_plan_id] like 'ISRGP0[2 3]' ) AND
-- merch & small eq
disp_comm_group_cd in(
		'FRESEQ', 
		'ITMCPU','ITMFO1','ITMFO2','ITMFO3','DIGIMP','ITMISC','ITMSOF'
) AND
(1=1)
GO

-- update 2019 customer history - test
SELECT
-- TOP (100) 
d.[Shipto], d.FiscalMonth, d.[HIST_cust_comm_group_cd], s.[comm_status_cd]
FROM            [dbo].[BRS_CustomerFSC_History] AS d INNER JOIN
                         [dbo].[BRS_Customer] AS s ON d.[Shipto] = s.[Shipto]
WHERE
(d.FiscalMonth = 202010) AND 
(s.[comm_status_cd] <> d.[HIST_cust_comm_group_cd]) and
(1=1)
GO

-- update 2019 customer history
UPDATE       BRS_CustomerFSC_History
SET                HIST_cust_comm_group_cd = s.comm_status_cd
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_Customer AS s ON BRS_CustomerFSC_History.Shipto = s.ShipTo AND BRS_CustomerFSC_History.HIST_cust_comm_group_cd <> s.comm_status_cd
WHERE        (BRS_CustomerFSC_History.FiscalMonth = 202010) AND (1 = 1)

--
-- setup ISR users
-- manually populate integration.comm_salesperson_master_Staging
/*
202009	1545	ZTSED	Eric.Dorfman	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Eric.Dorfman
202009	1259	ZTSJE	Julie.Emery	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Julie.Emery
202009	3334	ZTSMK	Madeleine.Khodaverdi	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Madeleine.Khodaverdi

202009	4354	DTSAR	Amanda.Russell	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Amanda.Russell
202009	4252	DTSAV	Angela.Valerio	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Angela.Valerio
202009	4398	DTSEB	Emilia.Bronowicki	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Emilia.Bronowicki
202009	6235	DTSFP	Franca.Parente	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Franca.Parente
202009	1527	DTSJD	Janet.Dunphy	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Janet.Dunphy
202009	4371	DTSMT	Maya.Thibodeau	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Maya.Thibodeau
202009	4307	DTSMC	Meaghan.Collins	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Meaghan.Collins
202009	1723	DTSNX	Nadia.Xavier	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Nadia.Xavier
202009	3384	DTSNS	Natasha.Singh	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Natasha.Singh
202009	4083	DTSNT	Noah.Thompson	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Noah.Thompson

202009	4486	MTSAY	Amanda.Yip	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Amanda.Yip
202009	3255	MTSSJ	Shenila.Jaffer	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Shenila.Jaffer
202009	3414	MTSWS	Willen.Sun	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Willen.Sun
*/

EXEC comm.comm_stage_update_proc @bDebug=0

delete from [dbo].[zzzItem]

/*
TerritoryCd	comm_salesperson_key_id
ZTSED	Eric.Dorfman
ZTSJ2	Julie.Emery
ZTSJE	Julie.Emery
ZTSMK	Madeleine.Khodaverdi

MTSSJ	Shenila.Jaffer
MTSWS	Willen.Sun

DTSAR	Amanda.Russell
MTSAY	Amanda.Yip
DTSAV	Angela.Valerio
DTSEB	Emilia.Bronowicki
MTSFP	Franca.Parente
DTSFP	Franca.Parente
DTSJD	Janet.Dunphy
MTSJD	Janet.Dunphy
DTSMT	Maya.Thibodeau
DTSMC	Meaghan.Collins
DTSNX	Nadia.Xavier
DTSNS	Natasha.Singh
DTSNT	Noah.Thompson
DTSN2	Noah.Thompson

*/

UPDATE       BRS_FSC_Rollup
SET                comm_salesperson_key_id = zzzItem.Note1
FROM            zzzItem INNER JOIN
                         BRS_FSC_Rollup ON zzzItem.Item = BRS_FSC_Rollup.TerritoryCd


-- set ISR customer history - test
SELECT        TOP (1000) BRS_CustomerFSC_History.Shipto, BRS_CustomerFSC_History.FiscalMonth, BRS_CustomerFSC_History.HIST_TsTerritoryCd, BRS_CustomerFSC_History.HIST_isr_salesperson_key_id, 
                         BRS_CustomerFSC_History.HIST_isr_comm_plan_id, BRS_FSC_Rollup.comm_salesperson_key_id, comm.salesperson_master.comm_plan_id
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_FSC_Rollup ON BRS_CustomerFSC_History.HIST_TsTerritoryCd = BRS_FSC_Rollup.TerritoryCd INNER JOIN
                         comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
WHERE
(BRS_CustomerFSC_History.FiscalMonth >= 201901) and 
(comm_plan_id like 'ISR%')

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
	(s.FiscalMonth between 201901 and 201912) AND
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
	(FiscalMonth between 201901 and 201912) AND
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

