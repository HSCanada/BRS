-- rebate model, tmc, 10 Nov 22

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerBT ADD
	billto_adhoc_model_amt1 money NOT NULL CONSTRAINT DF_BRS_CustomerBT_billto_adhoc_model_amt1 DEFAULT 0,
	billto_adhoc_model_amt2 money NOT NULL CONSTRAINT DF_BRS_CustomerBT_billto_adhoc_model_amt2 DEFAULT 0
GO
ALTER TABLE dbo.BRS_CustomerBT SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
