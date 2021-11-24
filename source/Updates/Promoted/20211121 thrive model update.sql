-- thrive model update, tmc, 21 Nov 21
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	adhoc_model_code char(5) NOT NULL CONSTRAINT DF_BRS_Item_adhoc_model_code DEFAULT (''),
	adhoc_model_code2 char(5) NOT NULL CONSTRAINT DF_BRS_Item_adhoc_model_code1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
