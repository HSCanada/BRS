-- BR_BusinessSolutions_Tabular add Marketing Scorecard functionality, tmc, 15 Jul 23

-- update cal week


UPDATE       BRS_SalesDay
SET                CalWeek = concat(year(salesdate),Format(DATEPART( wk, salesdate)  , '00') )
GO


select  salesdate, CalWeek, concat(year(salesdate),Format(DATEPART( wk, salesdate)  , '00') ) from [dbo].[BRS_SalesDay] order by 1 desc


BEGIN TRANSACTION
GO
ALTER TABLE comm.salesperson_master ADD
	adhoc_model_1_text varchar(50) NOT NULL CONSTRAINT DF_salesperson_master_adhoc_model_1_text DEFAULT '',
	adhoc_model_2_text varchar(50) NOT NULL CONSTRAINT DF_salesperson_master_adhoc_model_2_text DEFAULT '',
	adhoc_model_3_text varchar(50) NOT NULL CONSTRAINT DF_salesperson_master_adhoc_model_3_text DEFAULT ''
GO
ALTER TABLE comm.salesperson_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- set groups manually?

UPDATE       comm.salesperson_master
SET                adhoc_model_1_text = note_txt
WHERE        (comm_plan_id LIKE 'FSC%')

SELECT        employee_num, master_salesperson_cd, comm_plan_id, adhoc_model_1_text, note_txt
FROM            comm.salesperson_master
WHERE        (comm_plan_id like 'FSC%')
order by 5

-- changes

-- Dimension.PeriodCalendar
-- Dimension.Customer
-- Fact.Sale_brs



