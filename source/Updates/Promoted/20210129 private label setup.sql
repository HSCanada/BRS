-- private label setup, tmc, 29 Jan 21
--> move to prod 1 Feb 21

USE [master]
GO
ALTER DATABASE CommBE SET READ_ONLY WITH NO_WAIT
GO
ALTER DATABASE DEV_CommBE SET READ_ONLY WITH NO_WAIT
GO


BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX comm_adjustment_Staging_u_idx_01 ON Integration.comm_adjustment_Staging
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Integration.comm_adjustment_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--fix line# range

UPDATE       comm.transaction_F555115
SET                WSLNID_line_number = ID
WHERE        (WSDOCO_salesorder_number = 0)

-- 1. add new codes
/*
According to the attached Skype conversation with Trevor they are
•	ITMPVT for regular rates 
•	SPMPVT for Special Market rates
*/

INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory)
SELECT        'ITMPVT' as comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory
FROM            comm.[group] AS s
WHERE        (comm_group_cd = 'ITMSND')
GO

INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory)
SELECT        'SPMPVT' as comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory
FROM            comm.[group] AS s
WHERE        (comm_group_cd = 'SPMSND')
GO

UPDATE comm.[group]
set comm_group_desc='Merchandise (Private Label)'
WHERE        (comm_group_cd = 'ITMPVT')
GO

UPDATE comm.[group]
set comm_group_desc='SM Merchandise (Private Label)'
WHERE        (comm_group_cd = 'SPMPVT')
GO

--
UPDATE comm.[group]
set comm_group_desc='SM Equipment, Focus level 1'
WHERE        (comm_group_cd = 'SPMFO1')
GO

UPDATE comm.[group]
set comm_group_desc='SM Equipment, Focus level 2'
WHERE        (comm_group_cd = 'SPMFO2')
GO

UPDATE comm.[group]
set comm_group_desc='SM Equipment, Focus level 3'
WHERE        (comm_group_cd = 'SPMFO3')
GO

UPDATE comm.[group]
set comm_group_desc='SM Merchandise'
WHERE        (comm_group_cd = 'SPMSND')
GO

 | 
-- 2. update [comm].[comm_sync_proc] 
-- done

-- 3. clone merch rates to private, PP & SM

INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd)
SELECT        comm_plan_id, 'ITMPVT' as item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd
FROM            comm.plan_group_rate AS s
WHERE        (item_comm_group_cd = 'ITMSND')
GO

INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd)
SELECT        comm_plan_id, 'SPMPVT' as item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd
FROM            comm.plan_group_rate AS s
WHERE        (item_comm_group_cd = 'SPMSND')
GO

-- update rollup

UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = 'ITMPVT'
WHERE        (item_comm_group_cd IN ('ITMPVT', 'SPMPVT')) AND (disp_comm_group_cd = 'ITMSND')
GO

UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = 'SPMPVT'
WHERE        (item_comm_group_cd IN ('ITMPVT', 'SPMPVT')) AND (disp_comm_group_cd = 'SPMSND')
GO



-- 4. update item history (based on current) 
-- EPS->SND->PRV

print '2. revert eps back to merch comm_group_cd (removed from 2021 plan)'
UPDATE
	[dbo].[BRS_ItemHistory]
SET
	[HIST_comm_group_cd] = 'ITMSND'
WHERE
	([HIST_comm_group_cd] = 'ITMEPS') AND
	[FiscalMonth] between 202001 and 202012 AND
	(1=1)


print '2b. map merch private label comm_group_cd '
UPDATE
	[dbo].[BRS_ItemHistory]
SET
	[HIST_comm_group_cd] = 'ITMPVT'
WHERE
	([HIST_comm_group_cd] = 'ITMSND') AND
	([Label]='P') AND
	[FiscalMonth] between 202001 and 202012 AND
	(1=1)


-- 5. re-run the calc
-- done.  good for 202010 FSC and ESS

--move ADJ item from EPS to SND
UPDATE
comm.transaction_F555115
SET
fsc_comm_group_cd = 'ITMSND'
WHERE        (FiscalMonth BETWEEN 202001 AND 202112) AND (source_cd = 'imp') AND (fsc_comm_group_cd = 'itmeps')
GO

-- fix isr mapping issue
UPDATE       comm.customer_rebate
SET                isr_comm_group_cd = ''

UPDATE [dbo].[BRS_FiscalMonth]
SET [BeginDt] = '2020-12-27'
WHERE [FiscalMonth] = 202101
GO

-- new rates, PL not avail
UPDATE [dbo].[BRS_ItemSalesCategory]
   SET [ma_estimate_factor] = 1.092
 WHERE [SalesCategory] in('MERCH', 'VALADD', 'PARTS', 'TEETH', 'SMEQU', 'CAMLOG')
GO


-- 6. test model -> Gary
-- done

-- 7. cleanup old FSC in QA (see email)
-- done, in prod (manual)
/*
-- skipped in prod
UPDATE       BRS_FSC_Rollup
SET                comm_salesperson_key_id = s.comm_salesperson_key_id
FROM            BRS_FSC_Rollup INNER JOIN
                         BRSales.dbo.BRS_FSC_Rollup AS s ON BRS_FSC_Rollup.TerritoryCd = s.TerritoryCd and
						 BRS_FSC_Rollup.comm_salesperson_key_id <> s.comm_salesperson_key_id
*/
-- 8. fix eps view
UPDATE       hfm.exclusive_product
SET                eps_track_ind = 0
WHERE        (Excl_Code = 'ZIRLUX')


-- 9. fix 

EXEC comm.comm_stage_update_proc @bDebug=1

-- Rollback Tran
/*
-- skip in prod
UPDATE       comm.transaction_F555115
SET                FiscalMonth = 202012
WHERE        (FiscalMonth = 202101) AND (source_cd IN ('IMP', 'PAY'))
*/


-- move from Excl to Brand after 202007
UPDATE       [hfm].[exclusive_product]
SET                [eps_track_ind] = 0
--SET                [BrandEquityCategory] = 'Branded'
WHERE        ([Excl_Code] = 'CAO_LASER')

-- move from Excl to Brand after 202012
UPDATE       [hfm].[exclusive_product]
SET                [eps_track_ind] = 0
--SET                [BrandEquityCategory] = 'Branded'
WHERE        (Excl_Code in('COMPUDENT', 'MILESTONE' ))

--> done, 1 Feb 21

-- clear EPS & resync
-- fix EPS branch

-- eps PL fix
UPDATE       BRS_ItemHistory
SET                HIST_comm_group_eps_cd = i.[comm_group_eps_cd]
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item AS i ON BRS_ItemHistory.Item = i.Item
WHERE BRS_ItemHistory.FiscalMonth = 202101 and HIST_comm_group_eps_cd <> i.[comm_group_eps_cd]

