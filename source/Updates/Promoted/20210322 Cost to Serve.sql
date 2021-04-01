---Cost to Serve, tmc, 22 Mar 21

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemSupplier ADD
	MELP_code char(1) NOT NULL CONSTRAINT DF_BRS_ItemSupplier_MELP_code DEFAULT ''
GO
ALTER TABLE dbo.BRS_ItemSupplier SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerVPA ADD
	cost_to_serve_show_ind bit NOT NULL CONSTRAINT DF_BRS_CustomerVPA_cost_to_serve_show_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_CustomerVPA SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


UPDATE
	[dbo].[BRS_CustomerVPA]
SET [cost_to_serve_show_ind] = 1
WHERE [VPA] in ('123DENTA', 'DENCORP')
GO

UPDATE
	[dbo].[BRS_ItemSupplier]
SET MELP_code = 'M'
WHERE [Supplier] in ('DENTZA', '3MDENT', 'ADEC')
GO
