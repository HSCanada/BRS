-- Refresh QA, tmc, 2 Jun 20

truncate table [comm].[transaction_F555115]
go

delete from [comm].[plan_group_rate]
go

-- fold tested rate params back into prod
INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, creation_dt, note_txt, show_ind)
SELECT        comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, creation_dt, note_txt, show_ind
FROM            [DEV_BRSales].comm.plan_group_rate AS plan_group_rate_1
go

-- synch first
-- update item comm history based on current item (synced from prod)
UPDATE       BRS_ItemHistory
SET                HIST_comm_group_cd = s.comm_group_cd, HIST_comm_group_cps_cd = s.[comm_group_cps_cd], HIST_comm_group_eps_cd = s.comm_group_eps_cd
FROM            BRS_ItemHistory dd INNER JOIN
                         BRS_Item AS s ON dd.Item = s.Item AND
						 dd.FiscalMonth >= 201901
GO
