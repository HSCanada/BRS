-- ppe category, tmc, 5 Jun 91

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemCategory ADD
	CategoryRollupPPE char(10) NOT NULL CONSTRAINT DF_BRS_ItemCategory_CategoryRollup1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_ItemCategory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- manually populate