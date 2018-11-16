-- add data to tables to support Business Review mode
-- 28 Sep 18


-- Dimension.[ItemCategory]

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemCategoryRollup ADD
	active_ind bit NOT NULL CONSTRAINT DF_BRS_ItemCategoryRollup_active_ind DEFAULT 1,
	top15_ind bit NOT NULL CONSTRAINT DF_BRS_ItemCategoryRollup_top15_ind DEFAULT 0,
	CategorySharePercent float(53) NOT NULL CONSTRAINT DF_BRS_ItemCategoryRollup_CategorySharePercent DEFAULT 0
GO
ALTER TABLE dbo.BRS_ItemCategoryRollup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


CREATE NONCLUSTERED INDEX BRS_TransactionDW_idx_07 ON dbo.BRS_TransactionDW
	(
	EnteredBy
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO


select top 10 EnteredBy from [dbo].[BRS_TransactionDW]

INSERT INTO BRS_ItemSupplier
(Supplier)
SELECT DISTINCT brand
FROM BRS_ITEM
WHERE NOT EXISTS (SELECT * FROM BRS_ItemSupplier s WHERE s.Supplier = brand)


ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_BRS_ItemSupplier1 FOREIGN KEY
	(
	Brand
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- 4m
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX BRS_TransactionDW_idx_08 ON dbo.BRS_TransactionDW
	(
	DocType
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX BRS_TransactionDW_idx_09 ON dbo.BRS_TransactionDW
	(
	OrderPromotionCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX BRS_TransactionDW_idx_10 ON dbo.BRS_TransactionDW
	(
	OrderSourceCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



CREATE UNIQUE NONCLUSTERED INDEX BRS_TransactionDW_index_11 ON dbo.BRS_TransactionDW
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO