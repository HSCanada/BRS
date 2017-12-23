-- add add EssCode, CcsCode, TssCode, CagCode to BRS_FSC_Rollup 
-- 28 Nov 

-- ESS
INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd], [Branch])
SELECT DISTINCT EssCode, ''
FROM            BRS_TransactionDW 
WHERE 
	EssCode IS NOT NULL AND
	NOT EXISTS (SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE EssCode = [TerritoryCd])

-- CCS
INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd], [Branch])
SELECT DISTINCT [CcsCode], ''
FROM            BRS_TransactionDW 
WHERE NOT EXISTS (SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE [CcsCode] = [TerritoryCd])

-- TSS
INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd], [Branch])
SELECT DISTINCT [TssCode], ''
FROM            BRS_TransactionDW 
WHERE NOT EXISTS (SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE [TssCode] = [TerritoryCd])

-- DTX
INSERT INTO [dbo].[BRS_FSC_Rollup] ([TerritoryCd], [Branch])
SELECT DISTINCT [CagCode], ''
FROM            BRS_TransactionDW 
WHERE NOT EXISTS (SELECT * FROM [dbo].[BRS_FSC_Rollup] WHERE [CagCode] = [TerritoryCd])


-- add index for FK

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX BRS_TransactionDW_idx_05 ON dbo.BRS_TransactionDW
	(
	EssCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX BRS_TransactionDW_idx_06 ON dbo.BRS_TransactionDW
	(
	CagCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- RI

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_BRS_FSC_Rollup FOREIGN KEY
	(
	EssCode
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_BRS_FSC_Rollup1 FOREIGN KEY
	(
	CcsCode
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_BRS_FSC_Rollup2 FOREIGN KEY
	(
	TssCode
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_BRS_FSC_Rollup3 FOREIGN KEY
	(
	CagCode
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
