-- ISR Dental new rates, tmc, 22 Nov 22

/****** Script for SelectTopNRows command from SSMS  ******/

INSERT INTO comm.[plan]
                         (comm_plan_id, comm_plan_nm, note_txt, active_ind, creation_dt)
SELECT        'ISRLAB2' AS comm_plan_id, 'ISR Lab plan 2' AS comm_plan_nm, note_txt, active_ind, creation_dt
FROM            comm.[plan] AS plan_1
WHERE        (comm_plan_id = 'ISRGP02')
GO

SELECT  [comm_plan_id]
      ,[comm_plan_nm]
      ,[note_txt]
      ,[active_ind]
      ,[creation_dt]
      ,[comm_key]
  FROM [comm].[plan] where [comm_plan_id] = 'ISRLAB2'
GO

INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd)
SELECT        'ISRLAB2' AS comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC copy ISR, 22 Nov 22' AS note_txt, show_ind, fg_comm_group_cd
FROM            comm.plan_group_rate AS plan_group_rate_1
WHERE        (comm_plan_id = 'ISRGP02')

-- set Lab
UPDATE
	[comm].[salesperson_master]
SET
	[comm_plan_id] = 'ISRLAB2'
WHERE
[salesperson_key_id] in('JULIE.EMERY', 'MADELEINE.KHODAVERDIAN')

-- set Dental
UPDATE
	[comm].[salesperson_master]
SET
	[comm_plan_id] = 'ISRGP03'
WHERE
[salesperson_key_id] in('NOAH.THOMPSON', 'NADIA.XAVIER')

-- set inactive
UPDATE
	[comm].[salesperson_master]
SET
	[comm_plan_id] = 'ISRGP00'
WHERE
[salesperson_key_id] in('ANGELA.VALERIO', 'ASIMA.KHOKHAR', 'ERIC.DORFMAN', 'ISR.HOUSE', 'LISA.ROUSSELLE.ISR', 'MEAGHAN.COLLINS', 'Sara-Claude.Dionne.ISR', 'JANET.DUNPHY', 'NADIA.XAVIER')        


-- review ISR, good
SELECT * FROM 	[comm].[salesperson_master]
WHERE
[comm_plan_id] like 'ISR%'
ORDER BY comm_plan_id

-- review rates
SELECT  [comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_rt]
      ,[active_ind]
      ,[note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
  FROM [comm].[plan_group_rate] 
  where 
	[comm_plan_id] = 'ISRGP03' AND
	[comm_rt] <>0
ORDER BY 2
GO

--
SELECT distinct [comm_rt]
  FROM [comm].[plan_group_rate] where [comm_plan_id] = 'ISRGP03'

--
-- fix rates, plass 1
UPDATE       comm.plan_group_rate
SET                comm_rt = 0.35
WHERE        (comm_plan_id = 'ISRGP03') AND (comm_rt = 1)
GO

UPDATE       comm.plan_group_rate
SET                comm_rt = 0.35/2
WHERE        (comm_plan_id = 'ISRGP03') AND (comm_rt = .5)
GO

UPDATE       comm.plan_group_rate
SET                comm_rt = 0
WHERE        (comm_plan_id = 'ISRGP03') AND source_cd = 'PAY' AND (comm_rt <> 0)
GO

SELECT  [comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_rt]
      ,[active_ind]
      ,[note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
  FROM [comm].[plan_group_rate] where [comm_plan_id] = 'ISRGP03' and comm_rt <>0

--

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
	(BRS_CustomerFSC_History.FiscalMonth >= 202101) AND 
	(comm.salesperson_master.comm_plan_id LIKE 'ISR%')


--


