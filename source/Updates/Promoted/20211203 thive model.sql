BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	adhoc_model_code3 char(5) NOT NULL CONSTRAINT DF_BRS_Item_adhoc_model_code3 DEFAULT (''),
	adhoc_model_code4 char(5) NOT NULL CONSTRAINT DF_BRS_Item_adhoc_model_code4 DEFAULT (''),
	adhoc_model_code5 char(5) NOT NULL CONSTRAINT DF_BRS_Item_adhoc_model_code5 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
