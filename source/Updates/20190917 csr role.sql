

BEGIN TRANSACTION
GO
ALTER TABLE Pricing.entered_by ADD
	role_code char(2) NOT NULL CONSTRAINT DF_entered_by_role_code DEFAULT ''
GO
ALTER TABLE Pricing.entered_by SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
