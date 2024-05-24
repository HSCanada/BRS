-- pro-repair update, tmc 19 Mar 24


select * from [nes].[cause] where cause_code between '10PR' and 'C99' order by 1

-- D0
UPDATE       nes.cause
SET                owner ='Tech', work_flow = 'P1.Quote Create'
WHERE        
	(cause_code BETWEEN '10PR' AND '12PR') 
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'O1.Quote Create'
WHERE        
	(cause_code BETWEEN '70PR' AND '71PR')
GO

-- D1
UPDATE       nes.cause
SET                owner ='SC', work_flow = 'P2.Quote Follow-up'
WHERE        
	(cause_code BETWEEN '20PR' AND '29PR') 
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'O2.Quote Follow-up'
WHERE        
	(cause_code BETWEEN '72PR' AND '75PR')
GO

-- D2
UPDATE       nes.cause
SET                owner ='SC', work_flow = 'P3.Quote Approve / Deny'
WHERE        
	(cause_code BETWEEN '30PR' AND '30PR') 
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'O3.Quote Approve / Deny'
WHERE        
	(cause_code BETWEEN '76PR' AND '79PR')
GO


--D3

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'P4.Parts Source'
WHERE        (cause_code BETWEEN '50PR' AND '50PR')
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'O4.Parts Source (n/a)'
WHERE        (cause_code BETWEEN '83PR' AND '85PR')
GO


UPDATE       nes.cause
SET                owner ='Tech', work_flow = 'P5.Fix It'
WHERE        (cause_code BETWEEN '40PR' AND '40PR')
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'O5.Fix It'
WHERE        (cause_code BETWEEN '80PR' AND '82PR')
GO


-- D4
UPDATE       nes.cause
SET                owner ='SC', work_flow = 'P6.Billing'
WHERE        (cause_code BETWEEN '60PR' AND '62PR')
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'O6.Billing'
WHERE        (cause_code BETWEEN '86PR' AND '86PR')
GO

-- D2 
UPDATE       nes.cause
SET                owner ='SC', work_flow = 'P6.Work-order Complete (Deny)'
WHERE        
	(cause_code BETWEEN '31PR' AND '32PR') 
GO

UPDATE       nes.cause
SET                owner ='SC', work_flow = 'O6.Work-order Complete (Deny)'
WHERE        
	(cause_code BETWEEN '81PR' AND '81PR')
GO


-- layered via Dates -- Cannot check accuracy
UPDATE       nes.cause
SET                owner ='Tech', work_flow = 'Branch Repair (non-Hub)'
WHERE        (cause_code BETWEEN 'C00' AND 'C99')
GO

--

-- update view nes.order_open_prorepr_current

SELECT * FROM nes.order_open_prorepr_current


select top 10 * from nes.order_open_prorepr order by 1 desc

select top 10 * from BRSales.nes.order_open_prorepr order by 1 desc

-- update dev

select  * from BRSales.nes.order_open_prorepr where salesdate = '2024-05-16'

insert into [nes].[order]
(work_order_num, note)
select  distinct  work_order_num, '' as note from BRSales.nes.order_open_prorepr s
where salesdate = '2024-05-16' and
 not exists (select * from [nes].[order] w where w.work_order_num = s.work_order_num)

insert into [dbo].[BRS_FSC_Rollup]
(TerritoryCd, Branch)
select  distinct  est_code, '' br from BRSales.nes.order_open_prorepr s
where salesdate = '2024-05-16' and
 not exists (select * from  [dbo].[BRS_FSC_Rollup] t where t.TerritoryCd = s.est_code)


INSERT INTO nes.order_open_prorepr
             (SalesDate, work_order_num, branch_code, rma_code, order_status_code, order_received_date, estimate_complete_date, approved_date, approved_part_release_date, order_complete_date, shipto, privileges_code, model_number, est_code, call_type_code, problem_code, cause_code, user_id)
SELECT   SalesDate, work_order_num, branch_code, rma_code, order_status_code, order_received_date, estimate_complete_date, approved_date, approved_part_release_date, order_complete_date, shipto, privileges_code, model_number, est_code, call_type_code, problem_code, cause_code, '' as user_id
FROM     BRSales.nes.order_open_prorepr AS order_open_prorepr_1
WHERE   (SalesDate = '2024-05-16')
