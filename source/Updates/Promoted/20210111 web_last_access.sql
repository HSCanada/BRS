-- web_last_access, tmc, 11 Jan 20

ALTER TABLE [dbo].[BRS_Customer] DROP COLUMN [web_last_access_dt]
GO


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	web_last_access_dt datetime NULL
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT