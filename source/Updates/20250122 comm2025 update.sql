--comm2025 update, tmc, 22 Jan 25

-- ESS Elite 
-- create 1 new Elite Customer Seg for ESS 
-- copy SPMEQU -> SMPELT
/*
-- reset dev from prod
-- 16min

USE [master]

RESTORE DATABASE [DEV_BRSales] FROM  DISK = N'\\cahsionnlfp04\test2\SQLData2\Backup\BRSales_backup_2025_01_22_200252_5010957.bak' WITH  FILE = 2,  
MOVE N'BRS_Primary' TO N'F:\SQLData\DEV_BRSales_PROD.mdf',  
MOVE N'BRS_UserData' TO N'F:\SQLData\DEV_BRSales_UserData.ndf',  
MOVE N'BRS_Log' TO N'F:\SQLData\DEV_BRSales_log.ldf',  NOUNLOAD,  REPLACE,STATS = 5
GO
*/


/*
SELECT   comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd
FROM     comm.[group]
WHERE   (comm_group_cd = 'SPMEQU')


SELECT   'SPCELT', 'Elite Customer', source_cd, active_ind, 'TC added 22 Jan 25', booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd
FROM     comm.[group]
WHERE   (comm_group_cd = 'SPMEQU')
*/


--> FIRST
-- ensure notes not null so NEW rates can be Identified
UPDATE  comm.plan_group_rate SET        note_txt = '.'  WHERE   (note_txt IS NULL)
GO

-- de-activate invalude rule (using customer group in item)
UPDATE  comm.plan_group_rate SET active_ind = 0, note_txt = 'TC added 24 Jan 25'  WHERE  [cust_comm_group_cd]=[item_comm_group_cd] and active_ind = 1
-- org 78

select * from   comm.plan_group_rate   WHERE  [cust_comm_group_cd]=[item_comm_group_cd] and active_ind = 1

-- ORG 5533
--< FIRST

-- Action-> 1a. Add ESS code
-- add
INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd)
SELECT        'SPCELT' AS comm_group_cd, 'Elite Customer' AS comm_group_desc, source_cd, active_ind, 'TC added 22 Jan 25' AS note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, 
                         comm_bonus2_cd, comm_bonus3_cd
FROM            comm.[group] AS group_1
WHERE        (comm_group_cd = 'SPMEQU')
GO


-- set Elite New to comm custom
/*
SELECT        TOP (10) ShipTo, MarketClass, comm_status_cd, comm_note_txt
FROM            BRS_Customer where MarketClass = 'ELITE'
*/

UPDATE       BRS_Customer
SET                comm_status_cd = 'SPCELT', comm_note_txt = 'TC added 22 Jan 25'
-- this make ensure the ESS elite ties to prod
WHERE        (comm_status_cd = 'SPMALL') AND MarketClass = 'ELITE'
GO
-- Action-> 1b. assign to cust




-- ORG 1 134

-- 2a FSC CRD -- add code

-- Create 1 new CRD Item Zero comm for FSC
-- Create 2 new CRD Cusotmer (PP & MM) comm for FSC

-- cust
-- copy SPMSND -> SPMCRD  (
-- copy SPMPVT -> SMPCRD

--> CRD stuff

-- REVIVEW - ok
INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd)
SELECT        'SPCCRD' AS comm_group_cd, 'CRD Existing for SM  Customer' AS comm_group_desc, source_cd, active_ind, 'TC added 22 Jan 25' AS note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, 
                         comm_bonus2_cd, comm_bonus3_cd
FROM            comm.[group] AS group_1
WHERE        (comm_group_cd = 'SPMSND')
GO

-- REVIVEW - ok
INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd)
SELECT        'PPCCRD' AS comm_group_cd, 'CRD Existing for PP Customer' AS comm_group_desc, source_cd, active_ind, 'TC added 22 Jan 25' AS note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, 
                         comm_bonus2_cd, comm_bonus3_cd
-- fixed 24 Jan (use non-sm for core, to match baseline)
FROM            comm.[group] AS group_1
WHERE        (comm_group_cd = '')
GO
--< CRD stuff

-- 2b FSC CRD update (dummy code, use excel final for prod) -- assign code

-- PP
/*
select * from BRS_item where supplier In ('clinre','decmat')

SELECT        c.ShipTo, c.BillTo, c.comm_status_cd, c.comm_note_txt, i.comm_group_cd
FROM            BRS_Item AS i INNER JOIN
                         BRS_TransactionDW AS t ON i.Item = t.Item INNER JOIN
                         BRS_Customer AS c ON t.Shipto = c.ShipTo
WHERE        (i.Supplier IN ('clinre', 'decmat'))

-- item group
SELECT        i.comm_group_cd, SUM(t.NetSalesAmt) AS Expr1
FROM            BRS_Item AS i INNER JOIN
                         BRS_TransactionDW AS t ON i.Item = t.Item
WHERE       
(i.Supplier IN ('clinre' )) AND 
(i.comm_group_cd in ('ITMSND', 'ITMPVT')) AND
(t.CalMonth >= '202401')
GROUP BY i.comm_group_cd
order by 2 desc

-- cust group
SELECT        c.comm_status_cd, SUM(t.NetSalesAmt) AS sales 
FROM            BRS_Item AS i INNER JOIN
                         BRS_TransactionDW AS t ON i.Item = t.Item INNER JOIN
                         BRS_Customer AS c ON t.Shipto = c.ShipTo
WHERE        (i.Supplier IN ('clinre')) AND (i.comm_group_cd IN ('ITMSND', 'ITMPVT')) AND (t.CalMonth >= '202401') AND c.comm_status_cd in ('', 'SPMALL', 'SPMSND')
GROUP BY c.comm_status_cd
ORDER BY 2 DESC

-- accounts with CRD sales (working)
SELECT        
-- top 10 
c.shipto, SUM(t.NetSalesAmt) AS sales 
FROM            BRS_Item AS i INNER JOIN
                         BRS_TransactionDW AS t ON i.Item = t.Item INNER JOIN
                         BRS_Customer AS c ON t.Shipto = c.ShipTo
WHERE        (i.Supplier IN ('clinre')) AND (i.comm_group_cd IN ('ITMSND', 'ITMPVT')) AND (t.CalMonth >= '202401') AND c.comm_status_cd in ('', 'SPMALL', 'SPMSND')
GROUP BY c.shipto
having  SUM(t.NetSalesAmt) > 0

SELECT
	c.ShipTo, MarketClass, comm_status_cd, comm_note_txt, sales.crd_sales
FROM            
	BRS_Customer c 

	INNER JOIN 
	(
		SELECT        
		-- top 10 
		c.shipto, SUM(t.NetSalesAmt) AS crd_sales 
		FROM            BRS_Item AS i INNER JOIN
								 BRS_TransactionDW AS t ON i.Item = t.Item INNER JOIN
								 BRS_Customer AS c ON t.Shipto = c.ShipTo
		WHERE        (i.Supplier IN ('clinre')) AND (i.comm_group_cd IN ('ITMSND', 'ITMPVT')) AND (t.CalMonth >= '202401') AND c.comm_status_cd in ('', 'SPMALL', 'SPMSND')
		GROUP BY c.shipto
		having  SUM(t.NetSalesAmt) > 0
	) sales
	ON c.ShipTo = sales.ShipTo
where c.comm_status_cd in ('', 'SPMALL', 'SPMSND')
GO

*/

--> CRD stuff

-- REVIVEW - ok
-- Action-> 2b assign CRD PP
UPDATE       BRS_Customer
SET                comm_status_cd = 'PPCCRD', comm_note_txt = 'TC added 22 Jan 25'
FROM            BRS_Customer INNER JOIN
                             (SELECT        c.ShipTo, SUM(t.NetSalesAmt) AS crd_sales
                               FROM            BRS_Item AS i INNER JOIN
                                                         BRS_TransactionDW AS t ON i.Item = t.Item INNER JOIN
                                                         BRS_Customer AS c ON t.Shipto = c.ShipTo
								-- ussing CRD Merch only for PP & SM.   There are exclusive and small EQ in here, which we will not include in CRD
                               WHERE        (i.Supplier IN ('clinre')) AND (i.comm_group_cd IN ('ITMSND')) AND (t.CalMonth >= '202401') AND (c.comm_status_cd IN (''))
                               GROUP BY c.ShipTo
                               HAVING         (SUM(t.NetSalesAmt) > 0)) AS sales ON BRS_Customer.ShipTo = sales.ShipTo
WHERE        (BRS_Customer.comm_status_cd IN (''))
GO

-- ORG 4 130

-- REVIVEW - ok
-- Action-> 2b assign CRD MM
-- yes, SM SND and ALL being merged, tc

UPDATE       BRS_Customer
SET                comm_status_cd = 'SPCCRD', comm_note_txt = 'TC added 22 Jan 25'
FROM            BRS_Customer INNER JOIN
                             (SELECT        c.ShipTo, SUM(t.NetSalesAmt) AS crd_sales
                               FROM            BRS_Item AS i INNER JOIN
                                                         BRS_TransactionDW AS t ON i.Item = t.Item INNER JOIN
                                                         BRS_Customer AS c ON t.Shipto = c.ShipTo
							   -- this is effectivly Merch for Mulitsite  (the ITMSND will mask the EQ from the SPMALL customers
                               WHERE        (i.Supplier IN ('clinre')) AND (i.comm_group_cd IN ('ITMSND')) AND (t.CalMonth >= '202401') AND (c.comm_status_cd IN ('SPMALL', 'SPMSND'))
                               GROUP BY c.ShipTo
                               HAVING         (SUM(t.NetSalesAmt) > 0)) AS sales ON BRS_Customer.ShipTo = sales.ShipTo
WHERE        (BRS_Customer.comm_status_cd IN ('SPMALL', 'SPMSND'))
GO
-- 370
--< CRD stuff


/*
SELECT        TOP (10) ShipTo, MarketClass, comm_status_cd, comm_note_txt
FROM            BRS_Customer where MarketClass = 'ELITE'

UPDATE       BRS_Customer
SET                comm_status_cd = 'SPCELT', comm_note_txt = 'TC added 22 Jan 25'
WHERE        (MarketClass = 'ELITE')
*/
-- ORG 1 134


-- MM

-- item
-- copy ITMPVT -> SPMCRD  (1/4 rate)
-- copy ITMPVT -> ITMCRD  (1/2 rate)

-- REVIVEW - ok
--> CRD stuff
--3a
INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd)
SELECT        'SPMCRD' AS comm_group_cd, 'CRD Product for SM Customer' AS comm_group_desc, source_cd, active_ind, 'TC added 22 Jan 25' AS note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, 
                         comm_bonus2_cd, comm_bonus3_cd
FROM            comm.[group] AS group_1

-- based on Special Market Sundry
WHERE        (comm_group_cd = 'SPMSND')
GO

-- REVIVEW - ok
--3b
INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd)
SELECT        'ITMCRD' AS comm_group_cd, 'CRD Product for PP Customer' AS comm_group_desc, source_cd, active_ind, 'TC added 22 Jan 25' AS note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, 
                         comm_bonus2_cd, comm_bonus3_cd
FROM            comm.[group] AS group_1
-- based on PP Sundry
WHERE        (comm_group_cd = 'ITMSND')
GO
--< CRD stuff


-- dummy assign CRD items for Dev testing (use excel for prod)
/*
select top 10 * from BRS_Item where Supplier = 'CLINRE' and comm_group_cd = 'ITMSND'

SELECT        TOP (10) Supplier, comm_group_cd
FROM            BRS_Item
WHERE        (Supplier = 'CLINRE') AND (comm_group_cd = 'ITMSND')
*/

-- REVIVEW - ok
--> CRD stuff
-- Action-> 3b update CRD item (dummy dev)
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMCRD', comm_note_txt = 'TC added 22 Jan 25'
-- using CRD Merch only for PP & SM.   There are exclusive and small EQ in here, which we will not include in CRD 
WHERE        (Supplier = 'CLINRE') AND (comm_group_cd = 'ITMSND')
GO
--< CRD stuff

-- 

-- FSC PL

-- reclass the ITMPVT to include extra stuff

-- 
-- FSC Vacay new plan
-- rename plan?   we ok with smae code and name change?

-- MED recon


-- ORG 12 632
-- 22 224

-- REVIVEW ***
--> CRD stuff
-- items
-- 3a

/*
high level approach:  
a) clone the rates to new group and default rates
b) set the display rollup based on context
c) set the new rates (TBD)
*/

--> ITEM, init

-- ok, update display / rate after
INSERT INTO comm.plan_group_rate
             (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max)
SELECT   comm_plan_id, 'SPMCRD' AS item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC added 22 Jan 25' AS note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max
FROM     comm.plan_group_rate AS plan_group_rate_1
WHERE   (item_comm_group_cd = 'SPMSND')
GO

-- ok, update display / rate after
INSERT INTO comm.plan_group_rate
             (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max)
SELECT   comm_plan_id, 'ITMCRD' AS item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC added 22 Jan 25' AS note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max
FROM     comm.plan_group_rate AS plan_group_rate_1
WHERE   (item_comm_group_cd = 'ITMSND')
GO
--< ITEM, init

-- CUST, init
-- ok, update display / rate after
INSERT INTO comm.plan_group_rate
             (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max)
SELECT   comm_plan_id, item_comm_group_cd, 'SPCCRD' AS cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC added 22 Jan 25' AS note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max
FROM     comm.plan_group_rate AS plan_group_rate_1
WHERE   (cust_comm_group_cd = 'SPMSND')
GO

-- ok, update display / rate after
INSERT INTO comm.plan_group_rate
             (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max)
SELECT   comm_plan_id, item_comm_group_cd, 'PPCCRD' AS cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC added 22 Jan 25' AS note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max
FROM     comm.plan_group_rate AS plan_group_rate_1
WHERE   (cust_comm_group_cd = '')
GO

--< CUST, init
--< CRD stuff

--> ESS CUST, init
-- ok, update display / rate after
INSERT INTO comm.plan_group_rate
             (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max)
SELECT   comm_plan_id, item_comm_group_cd, 'SPCELT' AS cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC added 22 Jan 25' AS note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max
FROM     comm.plan_group_rate AS plan_group_rate_1
WHERE   (cust_comm_group_cd = 'SPMALL')
GO

--< ESS CUST, init


--> TBD  CRD / ESS elite ****

SELECT        comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC added 24 Jan 25' AS note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, 
                         comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max
FROM            comm.plan_group_rate AS plan_group_rate_1
WHERE
	comm_plan_id in ('ESSGP', 'ESSGP_Q', 'ESSGPSP', 'ESSGP00' ) AND
	item_comm_group_cd in ('ITMFO1', 'ITMFO2', 'ITMFO3', 'SPMFO1', 'SPMFO2', 'SPMFO3') AND
	source_cd in('IMP', 'JDE') AND
	comm_gm_threshold_cd = ''  AND
	cust_comm_group_cd = 'SPCELT' AND
	(1=1)
ORDER BY 5 
GO

-- map EQ -> ITMFO1, 'TC added 24 Jan 25', 'SPCELT'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = 'ITMFO1', note_txt = 'TC added 24 Jan 25'
WHERE        (comm_plan_id IN ('ESSGP', 'ESSGP_Q', 'ESSGPSP', 'ESSGP00')) AND (item_comm_group_cd IN ('ITMFO1', 'ITMFO2', 'ITMFO3', 'SPMFO1', 'SPMFO2', 'SPMFO3')) AND (source_cd IN ('IMP', 'JDE')) AND 
                         (comm_gm_threshold_cd = '') AND (cust_comm_group_cd = 'SPCELT') AND (1 = 1)
GO



-- Cust item UPDATE display

SELECT        comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, 'TC added 24 Jan 25' AS note_txt, show_ind, fg_comm_group_cd, comm_gm_threshold_cd, 
                         comm_gm_threshold_ind, comm_gm_threshold_descr, comm_gm_threshold_min, comm_gm_threshold_max
FROM            comm.plan_group_rate AS plan_group_rate_1
WHERE
	comm_plan_id in ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00') AND
	item_comm_group_cd in ('ITMCRD', 'SPMCRD') AND
	source_cd in('IMP', 'JDE') AND
	comm_gm_threshold_cd = ''  AND
	(1=1)
ORDER BY 5 
GO

-- map SPMSND -> SPMCRD, 'TC added 24 Jan 25', 'SPMCRD'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = 'SPMCRD', note_txt = 'TC added 24 Jan 25'
WHERE        (comm_plan_id IN ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00')) AND (item_comm_group_cd IN ('ITMCRD', 'SPMCRD')) AND (source_cd IN ('IMP', 'JDE')) AND (comm_gm_threshold_cd = '') AND 
                         (disp_comm_group_cd = 'SPMSND') AND (1 = 1)
GO


-- map ITMSND -> ITMCRD, 'TC added 24 Jan 25', 'SPMCRD'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = 'ITMCRD', note_txt = 'TC added 24 Jan 25'
WHERE        (comm_plan_id IN ('FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCGP00')) AND (item_comm_group_cd IN ('ITMCRD', 'SPMCRD')) AND (source_cd IN ('IMP', 'JDE')) AND (comm_gm_threshold_cd = '') AND 
                         (disp_comm_group_cd = 'ITMSND') AND (1 = 1)
GO


-- Cust item update Rates (TBD)



--< TBD  ****

/*
-- update history
SELECT   TOP (10) h.Shipto, h.FiscalMonth, h.HIST_cust_comm_group_cd, c.comm_status_cd
FROM     BRS_CustomerFSC_History AS h INNER JOIN
             BRS_Customer AS c ON h.Shipto = c.ShipTo AND h.HIST_cust_comm_group_cd <> c.comm_status_cd
WHERE   (h.FiscalMonth = 202412)
*/

--> update item / cust history so comm calc works -- this is for ESS and CRD
UPDATE  BRS_CustomerFSC_History
SET        HIST_cust_comm_group_cd = c.comm_status_cd
FROM     BRS_CustomerFSC_History INNER JOIN
             BRS_Customer AS c ON BRS_CustomerFSC_History.Shipto = c.ShipTo AND BRS_CustomerFSC_History.HIST_cust_comm_group_cd <> c.comm_status_cd
WHERE   (BRS_CustomerFSC_History.FiscalMonth between 202401 and 202412)
GO

UPDATE  BRS_ItemHistory
SET        HIST_comm_group_cd = i.comm_group_cd
FROM     BRS_ItemHistory INNER JOIN
             BRS_Item AS i ON BRS_ItemHistory.Item = i.Item AND BRS_ItemHistory.HIST_comm_group_cd <> i.comm_group_cd
WHERE   (BRS_ItemHistory.FiscalMonth  between 202401 and 202412)
GO

/*
SELECT   h.Item, h.FiscalMonth, h.HIST_comm_group_cd, i.comm_group_cd
FROM     BRS_ItemHistory AS h INNER JOIN
             BRS_Item AS i ON h.Item = i.Item
WHERE h.FiscalMonth = 202412 and h.HIST_comm_group_cd <> i.comm_group_cd
*/

--< ESS and CRD


--> test if calc has been run using new rates  - this is for ESS and CRD
-- fsc
SELECT   comm.transaction_F555115.FiscalMonth, comm.transaction_F555115.WSDOCO_salesorder_number, comm.transaction_F555115.WSDCTO_order_type, comm.transaction_F555115.WSLNID_line_number, comm.transaction_F555115.WSLNTY_line_type, comm.transaction_F555115.fsc_calc_key
FROM     comm.plan_group_rate INNER JOIN
             comm.transaction_F555115 ON comm.plan_group_rate.calc_key = comm.transaction_F555115.fsc_calc_key
WHERE   (comm.plan_group_rate.note_txt = 'TC added 22 Jan 25')
GO

-- isr
SELECT   comm.transaction_F555115.FiscalMonth, comm.transaction_F555115.WSDOCO_salesorder_number, comm.transaction_F555115.WSDCTO_order_type, comm.transaction_F555115.WSLNID_line_number, comm.transaction_F555115.WSLNTY_line_type, comm.transaction_F555115.fsc_calc_key
FROM     comm.plan_group_rate INNER JOIN
             comm.transaction_F555115 ON comm.plan_group_rate.calc_key = comm.transaction_F555115.isr_calc_key
WHERE   (comm.plan_group_rate.note_txt = 'TC added 22 Jan 25')
GO

-- eps
SELECT   comm.transaction_F555115.FiscalMonth, comm.transaction_F555115.WSDOCO_salesorder_number, comm.transaction_F555115.WSDCTO_order_type, comm.transaction_F555115.WSLNID_line_number, comm.transaction_F555115.WSLNTY_line_type, comm.transaction_F555115.fsc_calc_key
FROM     comm.plan_group_rate INNER JOIN
             comm.transaction_F555115 ON comm.plan_group_rate.calc_key = comm.transaction_F555115.eps_calc_key
WHERE   (comm.plan_group_rate.note_txt = 'TC added 22 Jan 25')
GO

-- ess
SELECT   comm.transaction_F555115.FiscalMonth, comm.transaction_F555115.WSDOCO_salesorder_number, comm.transaction_F555115.WSDCTO_order_type, comm.transaction_F555115.WSLNID_line_number, comm.transaction_F555115.WSLNTY_line_type, comm.transaction_F555115.fsc_calc_key
FROM     comm.plan_group_rate INNER JOIN
             comm.transaction_F555115 ON comm.plan_group_rate.calc_key = comm.transaction_F555115.ess_calc_key
WHERE   (comm.plan_group_rate.note_txt = 'TC added 22 Jan 25')
GO

--< ESS and CRD

/*
-- active plan pull for testing
select * from [comm].[plan]
where
(comm_plan_id IN ('CCSGP', 'CCSGP_Q', 'CCSGP00', 'CSCGP02', 'FSCGP00', 'EPSGP', 'ESSGP', 'ESSGP_Q', 'ESSGPSP', 'ESSGP00', 'ESTGP00', 'ESTGP02', 'ESTGP03', 
                         'FTAGP', 'FSCGP02', 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'ISRGP00', 'ISRLAB2', 'ISRGP02', 'ISRGP03', 'FSCMT02', 'FSCGPM0')) AND (1 = 1)

*/
-- pull the active rate table for review / update
SELECT
	-- pk
	comm_plan_id,
	item_comm_group_cd,
	cust_comm_group_cd,
	source_cd,
	disp_comm_group_cd,
	comm_gm_threshold_cd,

	-- can update, core
	fg_comm_group_cd,
	comm_rt,
	active_ind,
	show_ind,
	note_txt,

	-- can update, core
	comm_gm_threshold_ind,
	comm_gm_threshold_descr,
	comm_gm_threshold_min,
	comm_gm_threshold_max,

	calc_key,
	-- new stuff
	disp_comm_group_cd		AS new_disp_comm_group_cd,
	fg_comm_group_cd		AS new_fg_comm_group_cd,
	comm_rt					AS new_comm_rt,
	active_ind				AS new_active_ind,
	show_ind				AS new_show_ind,
	note_txt				AS new_note_txt,

	-- can update, core
	comm_gm_threshold_ind	AS new_comm_gm_threshold_ind,
	comm_gm_threshold_descr AS new_comm_gm_threshold_descr,
	comm_gm_threshold_min	AS new_comm_gm_threshold_min,
	comm_gm_threshold_max	AS new_comm_gm_threshold_max
FROM
	comm.plan_group_rate
WHERE
	(source_cd <> 'PAY') AND 
	(comm_plan_id IN	( 
--					'FSCGP02'
					 'ESSGP'
--					, 'FSCGP02_Q', 'FSCGP03', 'FSCGP03_Q', 'FSCMT02', 'FSCGP00'
--					, 'FSCGPM0' 
--					, 'ESSGP_Q', 'ESSGPSP', 'ESSGP00' 
					)
	) AND 
	(1 = 1)
GO


-- add update rate table
-- Debug
-- EXEC comm.comm_stage_update_proc @bDebug=1
-- ORG 2520 adds
-- Prod
-- EXEC comm.comm_stage_update_proc @bDebug=0

-- run for prod
-- ensure notes not null so NEW rates can be Identified  (Customer group goingto items for logic but should not set to non-active)
-- UPDATE  comm.plan_group_rate SET        note_txt = '.'  WHERE   (note_txt IS NULL)
-- ORG 5533


-- Debug
-- Exec comm.transaction_commission_calc_proc @bDebug=1

-- Prod
print '202401'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202401'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202402'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202402'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202403'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202403'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202404'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202404'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202405'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202405'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202406'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202406'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202407'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202407'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202408'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202408'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202409'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202409'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202410'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202410'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202411'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202411'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print '202412'
update [dbo].[BRS_Config] set [PriorFiscalMonth] = '202412'
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

-- 