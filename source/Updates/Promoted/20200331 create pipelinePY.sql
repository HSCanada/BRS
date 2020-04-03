-- create pipelinePY, tmc 31 Mar 20

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Config ADD
	PY_SalesDateLastWeekly datetime NOT NULL CONSTRAINT DF_BRS_Config_PY_SalesDateLastWeekly DEFAULT 0
GO
ALTER TABLE dbo.BRS_Config SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

update dbo.BRS_Config
set PY_SalesDateLastWeekly ='2019-03-22'
GO

update dbo.BRS_Config
set SalesDateLastWeekly ='2020-03-27'
GO


select distinct [ess_code] from [nes].[open_order_opordrpt]
where not exists (select * from BRS_FSC_Rollup where TerritoryCd = [ess_code])

select distinct [dts_code] from [nes].[open_order_opordrpt]
where not exists (select * from BRS_FSC_Rollup where TerritoryCd = [dts_code])

select distinct [fsc_code] from [nes].[open_order_opordrpt]
where not exists (select * from BRS_FSC_Rollup where TerritoryCd = [fsc_code])

select distinct [cps_code] from [nes].[open_order_opordrpt]
where not exists (select * from BRS_FSC_Rollup where TerritoryCd = [cps_code] AND [comm_salesperson_key_id] is null)
