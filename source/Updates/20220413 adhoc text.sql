-- add free form text for drop off

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	adhoc_model_1_text varchar(50) NOT NULL CONSTRAINT DF_BRS_Customer_adhoc_model_1_text1 DEFAULT (''),
	adhoc_model_2_text varchar(50) NOT NULL CONSTRAINT DF_BRS_Customer_adhoc_model_2_text DEFAULT (''),
	adhoc_model_3_text varchar(50) NOT NULL CONSTRAINT DF_BRS_Customer_adhoc_model_3_text1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
