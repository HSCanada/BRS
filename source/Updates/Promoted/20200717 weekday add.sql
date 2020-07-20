-- weekday add, tmc, 17 Jul 20

-- add weekday

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDay ADD
	CalWeek int NOT NULL CONSTRAINT DF_BRS_SalesDay_CalWeek DEFAULT 0
GO
ALTER TABLE dbo.BRS_SalesDay SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- test
select top 10 SalesDate, DATEPART (wk, SalesDate)
from BRS_SalesDay where SalesDate >0
order by 1 desc

-- update
update BRS_SalesDay
set calweek = DATEPART (wk, SalesDate)
where SalesDate >0


