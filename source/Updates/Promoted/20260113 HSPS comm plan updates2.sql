-- HSPS comm updates2 - retro set the terr for 2025 based on 2026 accounts , tmc, 13 Jan 26

SELECT
	top 10

    zzzShipto.ST,
    CASE WHEN zzzShipto.Note = '**' THEN '' ELSE zzzShipto.Note END as new_terr,
    CASE WHEN zzzShipto.Note = '**' THEN '' ELSE BRS_FSC_Rollup.comm_salesperson_key_id END as new_key ,
	CASE WHEN zzzShipto.Note = '**' THEN '' ELSE comm.salesperson_master.comm_plan_id END as new_plan ,

    comm.salesperson_master.comm_plan_id,

    BRS_CustomerFSC_History.HIST_eps_code,
    BRS_CustomerFSC_History.HIST_eps_salesperson_key_id,
    BRS_CustomerFSC_History.HIST_eps_comm_plan_id
FROM
    (
        (
            zzzShipto
            INNER JOIN BRS_FSC_Rollup ON zzzShipto.Note = BRS_FSC_Rollup.TerritoryCd
        )
        INNER JOIN comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
    )
    INNER JOIN BRS_CustomerFSC_History ON zzzShipto.ST = BRS_CustomerFSC_History.Shipto
WHERE
    (((BRS_CustomerFSC_History.FiscalMonth) = 202512)) AND

	note <> '**'


--

UPDATE  
--  TOP (10) 
BRS_CustomerFSC_History
SET        
HIST_eps_code = CASE WHEN zzzShipto.Note = '**' THEN '' ELSE zzzShipto.Note END 
, HIST_eps_salesperson_key_id = CASE WHEN zzzShipto.Note = '**' THEN '' ELSE BRS_FSC_Rollup.comm_salesperson_key_id END 
, HIST_eps_comm_plan_id = CASE WHEN zzzShipto.Note = '**' THEN '' ELSE comm.salesperson_master.comm_plan_id END 

FROM     zzzShipto INNER JOIN
             BRS_FSC_Rollup ON zzzShipto.Note = BRS_FSC_Rollup.TerritoryCd INNER JOIN
             comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id INNER JOIN
             BRS_CustomerFSC_History ON zzzShipto.ST = BRS_CustomerFSC_History.Shipto
WHERE   
(BRS_CustomerFSC_History.FiscalMonth >= 202501) AND 
--(zzzShipto.Note = '**') AND
(1=1)
GO


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
