

BEGIN TRANSACTION
GO
ALTER TABLE Pricing.entered_by ADD
	role_code char(2) NOT NULL CONSTRAINT DF_entered_by_role_code DEFAULT ''
GO
ALTER TABLE Pricing.entered_by SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- add to prod, 23 Sep 19
ALTER TABLE [dbo].[BRS_Promotion] ADD
	[promotion_key] INT NOT NULL  Identity(1,1)
	
	