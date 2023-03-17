-- comm 2023 setup, tmc, 24 jan 23

-- add new code

INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd)
SELECT        'DIGSOL' AS comm_group_cd, 'CadCam,Dig.Impres.SOL' AS comm_group_desc, source_cd, active_ind, 'TC2023, 24 Jan 23' AS note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd
FROM            comm.[group] AS group_1
WHERE        (comm_group_cd = 'digimp')
GO



-- add to rules

UPDATE       comm.item_group_rule
SET                comm_group_cd = 'DIGSOL', comm_note_txt = 'TC2023'
WHERE        (MinorProductClass = '800-19-01') AND (Supplier = 'CONVER')
GO

-- update current item
UPDATE       
[dbo].[BRS_Item]
SET                [comm_group_cd] = 'DIGSOL', [comm_note_txt] = 'TC2023'
WHERE        ([MinorProductClass] = '800-19-01') AND (Supplier = 'CONVER')
GO

-- synch test

SELECT        Item, comm_group_cd, comm_note_txt, comm_group_cps_cd, comm_group_eps_cd, comm_group_est_cd, comm_group_isr_cd, comm_group_legacy_cd
FROM            BRS_Item
WHERE        (comm_group_cd = 'DIGSOL')


EXEC comm.comm_sync_proc @bDebug=1

EXEC comm.comm_sync_proc @bDebug=0

-- add to rates

INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd)
SELECT        comm_plan_id, 'DIGSOL' AS item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC2023, 24 Jan 23' AS note_txt, show_ind, fg_comm_group_cd
FROM            comm.plan_group_rate AS plan_group_rate_1
WHERE        (item_comm_group_cd = 'digimp')
GO

-- breakout rollup for CCS 
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = 'DIGSOL'
WHERE        (item_comm_group_cd = 'digSOL') AND (comm_plan_id LIKE 'CCS%')

-- update rate for FSC (only run 1x), FSC+3, CCS+1

UPDATE       comm.plan_group_rate
SET                comm_rt = comm_rt + 3, note_txt = 'TC2023, 24 Jan 23'
WHERE        (comm_rt <> 0) AND (item_comm_group_cd = 'DIGSOL') AND (comm_plan_id LIKE 'FSC%')

UPDATE       comm.plan_group_rate
SET                comm_rt = comm_rt + 1, note_txt = 'TC2023, 24 Jan 23'
WHERE        (comm_rt <> 0) AND (item_comm_group_cd = 'DIGSOL') AND (comm_plan_id LIKE 'CCS%')


/*
SELECT         comm_plan_id, item_comm_group_cd, comm_rt, note_txt 
FROM            comm.plan_group_rate AS d
WHERE        (comm_rt <> 0) AND (item_comm_group_cd = 'DIGSOL') and comm_plan_id like 'FSC%'

SELECT         comm_plan_id, item_comm_group_cd, comm_rt, note_txt 
FROM            comm.plan_group_rate AS d
WHERE        (comm_rt <> 0) AND (item_comm_group_cd = 'DIGSOL') and comm_plan_id like 'CCS%'

SELECT         comm_plan_id, item_comm_group_cd, comm_rt, note_txt 
FROM            comm.plan_group_rate AS d
WHERE        comm_plan_id like 'FSC%' AND comm_plan_id<>'FSCGPM' AND (comm_rt <> 0) AND (item_comm_group_cd like 'DIG%') AND (item_comm_group_cd not in ('DIGMAT', 'DIGSOL')) 
order by comm_rt DESC
*/

-- fix DIG CadCAm less DIGMAT and DIGSOL
UPDATE       comm.plan_group_rate
SET                comm_rt = comm_rt + 3, note_txt = 'TC2023, 7 Feb 23'
WHERE        comm_plan_id like 'FSC%' AND comm_plan_id<>'FSCGPM' AND (comm_rt <> 0) AND (item_comm_group_cd like 'DIG%') AND (item_comm_group_cd not in ('DIGMAT', 'DIGSOL')) 


-- update rates DIGMAT

UPDATE       comm.plan_group_rate
SET                comm_rt = s.comm_rt, note_txt = 'TC2023, 24 Jan 23'
FROM            comm.plan_group_rate AS s INNER JOIN
                         comm.plan_group_rate ON s.comm_plan_id = comm.plan_group_rate.comm_plan_id AND s.cust_comm_group_cd = comm.plan_group_rate.cust_comm_group_cd AND s.source_cd = comm.plan_group_rate.source_cd
WHERE        (s.disp_comm_group_cd = 'ITMSND') AND (comm.plan_group_rate.disp_comm_group_cd = 'DIGMAT') AND (comm.plan_group_rate.comm_rt <> 0)
GO

-- test
SELECT        s.comm_plan_id, s.item_comm_group_cd, s.cust_comm_group_cd, s.source_cd, s.note_txt, s.comm_rt, s.disp_comm_group_cd, d.disp_comm_group_cd AS Expr1, d.comm_rt AS Expr2
FROM            comm.plan_group_rate AS s INNER JOIN
                         comm.plan_group_rate AS d ON s.comm_plan_id = d.comm_plan_id AND s.cust_comm_group_cd = d.cust_comm_group_cd AND s.source_cd = d.source_cd
WHERE        (s.disp_comm_group_cd = 'ITMSND') AND (d.disp_comm_group_cd = 'DIGMAT') and d.comm_rt <> 0


-- update item history

UPDATE    BRS_ItemHistory
SET                HIST_comm_group_cd = 'DIGSOL', HIST_comm_group_isr_cd = 'DIGSOL'
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item AS s ON BRS_ItemHistory.Item = s.Item
WHERE        (BRS_ItemHistory.FiscalMonth BETWEEN 202201 AND 202212) AND (s.comm_group_cd = 'DIGSOL') and HIST_comm_group_cd <> 'DIGSOL'

--test
SELECT        TOP (10) d.Item, d.FiscalMonth, d.HIST_comm_group_cd, d.HIST_comm_group_isr_cd,   s.comm_group_cd
FROM            BRS_ItemHistory AS d INNER JOIN
                         BRS_Item AS s ON d.Item = s.Item
WHERE        (d.FiscalMonth between 202201 and 202212) and (s.comm_group_cd = 'DIGSOL')


-- fix customer Elite history (map history to current FSC)

-- ***** TBD, 123 is still a mess ***
-- set ELITE new to current
-- test pre PP account sales in 2022:  closed?  set to house, basedon on Branch?  messy

-- update
UPDATE       BRS_CustomerFSC_History
SET                
HIST_fsc_salesperson_key_id =comm.salesperson_master.salesperson_key_id, 
HIST_fsc_comm_plan_id ='FSCGP00', 
HIST_TerritoryCd =BRS_Customer.TerritoryCd, 
HIST_TsTerritoryCd ='DTSHS', 
HIST_isr_salesperson_key_id = 'ISR.HOUSE', 
HIST_isr_comm_plan_id = 'ISRGP00'
FROM            BRS_Customer INNER JOIN
                         BRS_FSC_Rollup ON BRS_Customer.TerritoryCd = BRS_FSC_Rollup.TerritoryCd INNER JOIN
                         comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id INNER JOIN
                         BRS_CustomerFSC_History ON BRS_Customer.ShipTo = BRS_CustomerFSC_History.Shipto
WHERE        (BRS_Customer.MarketClass_New = 'ELITE') AND (BRS_CustomerFSC_History.FiscalMonth between 202201 and 202212)
GO

-- test
SELECT        BRS_Customer.ShipTo, vpa, BRS_Customer.MarketClass_New, BRS_Customer.TerritoryCd, BRS_Customer.TsTerritoryCd, BRS_FSC_Rollup.comm_salesperson_key_id, comm.salesperson_master.comm_plan_id
FROM            BRS_Customer INNER JOIN
                         BRS_FSC_Rollup ON BRS_Customer.TerritoryCd = BRS_FSC_Rollup.TerritoryCd INNER JOIN
                         comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
WHERE        (BRS_Customer.MarketClass_New = 'ELITE')
ORDER BY comm_plan_id

-- * | * | FSCGP00
-- DTSHS | ISR.HOUSE | ISRGP00                    

-- calc history 2022 FG (6min per month)


update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202201
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202202
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202203
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202204
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202205
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202206
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202207
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202208
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202209
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202210
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202211
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

update [dbo].[BRS_Config] set [PriorFiscalMonth] = 202212
GO
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

-- test DIGSOL
SELECT        TOP (1000) comm.transaction_F555115.*
FROM            comm.transaction_F555115 INNER JOIN
                         BRS_Item ON comm.transaction_F555115.WSLITM_item_number = BRS_Item.Item
WHERE        (comm.transaction_F555115.FiscalMonth >= '202201') AND (BRS_Item.comm_group_cd = 'DIGSOL')
order by 1

-- test ELITE
SELECT        TOP (1000) comm.transaction_F555115.*
FROM            comm.transaction_F555115 INNER JOIN
                         BRS_Item ON comm.transaction_F555115.WSLITM_item_number = BRS_Item.Item INNER JOIN
                         BRS_Customer ON comm.transaction_F555115.WSSHAN_shipto = BRS_Customer.ShipTo
WHERE        (comm.transaction_F555115.FiscalMonth = '202209') AND (BRS_Customer.MarketClass_New = 'ELITE')
ORDER BY comm.transaction_F555115.FiscalMonth
GO

-- test 123DENNC 

SELECT        TOP (1000) comm.transaction_F555115.*
FROM            comm.transaction_F555115 INNER JOIN
                         BRS_Item ON comm.transaction_F555115.WSLITM_item_number = BRS_Item.Item INNER JOIN
                         BRS_Customer ON comm.transaction_F555115.WSSHAN_shipto = BRS_Customer.ShipTo
WHERE        (comm.transaction_F555115.FiscalMonth = '202209') AND WSASN__adjustment_schedule = '123DENNC'
ORDER BY comm.transaction_F555115.FiscalMonth
GO


-- add new bonus

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	comm_bonus1_cd varchar(50) NULL,
	comm_bonus2_cd varchar(50) NULL,
	comm_bonus3_cd varchar(50) NULL
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
