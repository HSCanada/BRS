-- fix eps reto, tmc, 12 Mar 26

-- fix eps terr
UPDATE  BRS_CustomerFSC_History
SET        HIST_eps_code =BRS_Customer.eps_code
FROM     BRS_Customer INNER JOIN
             BRS_CustomerFSC_History ON BRS_Customer.ShipTo = BRS_CustomerFSC_History.Shipto AND BRS_Customer.eps_code <> BRS_CustomerFSC_History.HIST_eps_code
WHERE   (BRS_Customer.ShipTo <> BRS_Customer.BillTo) AND (BRS_Customer.BillTo > 0) AND (BRS_CustomerFSC_History.FiscalMonth >= 202501)
-- rows = 620359

-- fix eps salesperson
UPDATE  BRS_CustomerFSC_History
SET        HIST_eps_salesperson_key_id = BRS_FSC_Rollup.comm_salesperson_key_id
FROM     BRS_CustomerFSC_History INNER JOIN
             BRS_FSC_Rollup ON BRS_CustomerFSC_History.HIST_eps_code = BRS_FSC_Rollup.TerritoryCd AND BRS_CustomerFSC_History.HIST_eps_salesperson_key_id <> BRS_FSC_Rollup.comm_salesperson_key_id
WHERE   (BRS_CustomerFSC_History.FiscalMonth >= 202501)
-- rows = 1093423

-- fix eps plan

UPDATE  BRS_CustomerFSC_History
SET        HIST_eps_salesperson_key_id = '', HIST_eps_comm_plan_id = ''
FROM     BRS_CustomerFSC_History INNER JOIN
             comm.salesperson_master ON BRS_CustomerFSC_History.HIST_eps_salesperson_key_id = comm.salesperson_master.salesperson_key_id AND BRS_CustomerFSC_History.HIST_eps_comm_plan_id <> comm.salesperson_master.comm_plan_id
WHERE   (BRS_CustomerFSC_History.FiscalMonth >= 202501) AND (BRS_CustomerFSC_History.HIST_eps_salesperson_key_id = 'HouseNCZE')
-- rows = 607510