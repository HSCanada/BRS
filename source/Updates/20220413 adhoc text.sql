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

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	DSO_operatory_count smallint NOT NULL CONSTRAINT DF_BRS_Customer_DSO_operatories_count DEFAULT 0
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



UPDATE       BRS_Customer
SET                adhoc_model_2_text = adhoc_model_code2
WHERE        (adhoc_model_code2 <> '')

UPDATE       BRS_Customer
SET            DSO_operatory_count = 10
WHERE        (DSO_TrackingCd = 'DSO')
