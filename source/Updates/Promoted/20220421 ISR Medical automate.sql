-- ISR Medical automate, tmc, 21 Apr 22

/****** Script for SelectTopNRows command from SSMS  ******/

INSERT INTO comm.[plan]
                         (comm_plan_id, comm_plan_nm, note_txt, active_ind, creation_dt)
SELECT        'ISRMED2' AS comm_plan_id, 'ISR Med plan 2' AS comm_plan_nm, note_txt, active_ind, creation_dt
FROM            comm.[plan] AS plan_1
WHERE        (comm_plan_id = 'ISRGP02')
GO

SELECT  [comm_plan_id]
      ,[comm_plan_nm]
      ,[note_txt]
      ,[active_ind]
      ,[creation_dt]
      ,[comm_key]
  FROM [comm].[plan] where [comm_plan_id] = 'ISRGP02'
GO

INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd)
SELECT        'ISRMED2' AS comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC copy ISR, 21 Apr 22' AS note_txt, show_ind, fg_comm_group_cd
FROM            comm.plan_group_rate AS plan_group_rate_1
WHERE        (comm_plan_id = 'ISRGP02')


SELECT  'ISRMED2' AS [comm_plan_id]
      ,[item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,[disp_comm_group_cd]
      ,[comm_rt]
      ,[active_ind]
      ,'TC copy ISR, 21 Apr 22' AS [note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
  FROM [comm].[plan_group_rate] where [comm_plan_id] = 'ISRGP02'

UPDATE       comm.plan_group_rate
SET                comm_rt = 3
WHERE        (comm_plan_id = 'ISRMED2') AND (comm_rt = 1)

UPDATE       comm.plan_group_rate
SET                comm_rt = 1.5
WHERE        (comm_plan_id = 'ISRMED2') AND (comm_rt = .5)


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
  FROM [comm].[plan_group_rate] where [comm_plan_id] = 'ISRMED2' and comm_rt <>0

  --
UPDATE
	[comm].[salesperson_master]
SET
	[comm_plan_id] = 'ISRMED2'
WHERE
[salesperson_key_id] = 'amanda.yip'



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
	(comm.salesperson_master.comm_plan_id LIKE 'ISRMED%')



