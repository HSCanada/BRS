-- FTA setup, tmc, 2 Aug 23

/****** Script for SelectTopNRows command from SSMS  ******/

-- 1. create a new FTA plan

INSERT INTO [comm].[plan]
([comm_plan_id], [comm_plan_nm], [note_txt], [active_ind])
SELECT 'FTAGP' as[comm_plan_id]
      , 'FTA GP Plan' AS [comm_plan_nm]
      ,'New FTA GP Plan' [note_txt]
      ,[active_ind]
  FROM [comm].[plan] where comm_plan_id = 'ESSGP'
GO

--2. copy CCS to FTA settings to DEV, CCS23 to FTA23


INSERT INTO [BRS_FSC_Rollup]
(
[TerritoryCd]
,[FSCName]
,[Branch]
,[FSCStatusCode]
,[NoteTxt]
, [comm_salesperson_key_id]
)
SELECT 'FTA23' AS [TerritoryCd]
      ,'New FTA' AS [FSCName]
      ,[Branch]
      ,[FSCStatusCode]
      ,[NoteTxt]
      , '' AS [comm_salesperson_key_id]
  FROM [BRS_FSC_Rollup] where [TerritoryCd] = 'CCS23'
GO

INSERT INTO [comm].[salesperson_master]
(
[employee_num]
,[master_salesperson_cd]
,[salesperson_key_id]
,[salesperson_nm]
,[comm_plan_id]
,[note_txt]
,[CostCenter]
,[tracker_ind]
,[salary_draw_amt]
,[deficit_amt]

)
SELECT [employee_num]
      ,'FTA23' [master_salesperson_cd]
      ,'FTA.New' AS [salesperson_key_id]
      ,'New FTA' AS [salesperson_nm]
      ,'FTAGP' AS [comm_plan_id]
      ,'New FTA' as [note_txt]
      ,[CostCenter]
      ,[tracker_ind]
      ,0 [salary_draw_amt]
      ,0 [deficit_amt]
  FROM [comm].[salesperson_master] where [master_salesperson_cd] = 'CCS23'
GO

/*
UPDATE       
comm.transaction_F555115
SET
cps_code = 'FTA23'
, cps_salesperson_key_id ='FTA.New'
, cps_comm_plan_id = 'FTAGP'
, cps_comm_group_cd = ess_comm_group_cd
, cps_comm_rt = 2.0
, cps_comm_amt = cps_comm_amt * 0.2
, cps_calc_key = [ess_calc_key]
WHERE
(FiscalMonth >= 202201) AND (ess_salesperson_key_id = 'ELISE.POIRIER') AND (1 = 1)
GO
*/

  SELECT  [FiscalMonth]
      ,[cps_code]

      ,[cps_salesperson_key_id]
      ,[cps_comm_plan_id]
      ,[cps_comm_group_cd]
      ,[cps_comm_rt]
      ,[cps_comm_amt]
      ,[cps_calc_key] 
  FROM [comm].[transaction_F555115] 
  where 
  [FiscalMonth] = 202201 AND
  ess_salesperson_key_id = 'ELISE.POIRIER' AND
--  ess_code = 'CCS23'
  (1=1)


  -- todo
  -- add rates
/*
  # comm backend - FTA rough plan idea
add FTA rates
update link logic   
update rate logic

FTA test, new plan and rates - Link CCS -> FTA via Salerder
1 Aug - Trevor add FTA to dev / comm model
  Add rates
  map cogs CCS to FTA based on order where FTA code added

2 Aug - Gary & Trevor backend review data DONE
3 Aug - Gary, David, Trevor 30, are we ready?
  Gary, hand off test data to David?
... share withEQ
TBD:   details
*/