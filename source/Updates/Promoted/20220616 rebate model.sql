-- rebate model, tmc, 16 Jun 22

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerBT ADD
	billto_adhoc_model_code1 varchar(50) NOT NULL CONSTRAINT DF_BRS_CustomerBT_billto_adhoc_model_code1 DEFAULT '',
	billto_adhoc_model_code2 varchar(50) NOT NULL CONSTRAINT DF_BRS_CustomerBT_billto_adhoc_model_code2 DEFAULT ''
GO
ALTER TABLE dbo.BRS_CustomerBT SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
