/****** Script for SelectTopNRows command from SSMS  ******/
UPDATE       comm.transaction_F555115
SET                fsc_salesperson_key_id = 'LAURA.MOORE'
WHERE        (fsc_salesperson_key_id = 'LAURA.BAUDER')

delete from comm.salesperson_master where salesperson_master_key = 1166

delete  FROM [dbo].[BRS_FSC_Rollup] where TerritoryCd = 'WZlLM'