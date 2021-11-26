-- isr model, tmc, 25 Nov 21

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	adhoc_model_code2 char(5) NOT NULL CONSTRAINT DF_BRS_Customer_adhoc_model_code2 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


