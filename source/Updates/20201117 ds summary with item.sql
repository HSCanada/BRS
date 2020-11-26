-- ds summary with item, tmc, 17 Nov 20
-- tmc, 26 Nov 20, use PPE code instead of item for performace reasons

-- truncate table dbo.BRS_AGG_CDBGAD_Sales
-- truncate table dbo.BRS_AGG_CMBGAD_Sales

-- 1 of 2

--

CREATE TABLE [dbo].[BRS_ItemCategoryPPE](
	[CategoryRollupPPE] [char](10) NOT NULL,
	[category_rollup_ppe_desc] [nvarchar](35) NOT NULL default (''),
	[active_ind] [bit] NOT NULL default (0),
	category_ppe_key int NOT NULL identity(1,1)
 CONSTRAINT [BRS_ItemCategoryPPE_c_pk] PRIMARY KEY CLUSTERED 
(
	[CategoryRollupPPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX BRS_ItemCategoryPPE_u_idx_01 ON dbo.BRS_ItemCategoryPPE
	(
	category_ppe_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemCategory ADD CONSTRAINT
	FK_BRS_ItemCategory_BRS_ItemCategoryPPE FOREIGN KEY
	(
	CategoryRollupPPE
	) REFERENCES dbo.BRS_ItemCategoryPPE
	(
	CategoryRollupPPE
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemCategory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
-- truncate table [dbo].[BRS_ItemCategoryPPE]
INSERT INTO [dbo].[BRS_ItemCategoryPPE]([CategoryRollupPPE])
VALUES 
(''),
('INFO-DAMS'),
('INFO-EVAC'),
('INFO-THERM'),
('PPE-EYEWAR'),
('PPE-GLOV'),
('PPE-GOWNS'),
('PPE-INFCON'),
('PPE-MASK'),
('PPQ-AIRPY')
GO


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales ADD
	[CategoryRollupPPE] char(10) NOT NULL CONSTRAINT DF_BRS_AGG_CDBGAD_Sales_ppe DEFAULT ''
GO
ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales
	DROP CONSTRAINT BRS_AGG_CDBGAD_Sales_c_pk
GO
ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales ADD CONSTRAINT
	BRS_AGG_CDBGAD_Sales_c_pk PRIMARY KEY CLUSTERED 
	(
	SalesDate,
	FreeGoodsEstInd,
	Shipto,
	GLBU_Class,
	[CategoryRollupPPE],
	Branch,
	AdjCode,
	SalesDivision,
	OrderSourceCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX BRS_AGG_CDBGAD_Sales_idx_09 ON dbo.BRS_AGG_CDBGAD_Sales
	(
	[CategoryRollupPPE]
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO

ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales ADD CONSTRAINT
	FK_BRS_AGG_CDBGAD_Sales_BRS_ppe FOREIGN KEY
	(
	[CategoryRollupPPE]
	) REFERENCES [dbo].[BRS_ItemCategoryPPE]
	(
	[CategoryRollupPPE]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO


ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- 2 of 2

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_AGG_CMBGAD_Sales ADD
	[CategoryRollupPPE] char(10) NOT NULL CONSTRAINT DF_BRS_AGG_CMBGAD_Sales_ppe DEFAULT ''
GO
ALTER TABLE dbo.BRS_AGG_CMBGAD_Sales
	DROP CONSTRAINT BRS_AGG_CMBGAD_Sales_c_pk
GO
ALTER TABLE dbo.BRS_AGG_CMBGAD_Sales ADD CONSTRAINT
	BRS_AGG_CMBGAD_Sales_c_pk PRIMARY KEY CLUSTERED 
	(
	FiscalMonth,
	FreeGoodsEstInd,
	Shipto,
	GLBU_Class,
	[CategoryRollupPPE],
	Branch,
	AdjCode,
	SalesDivision,
	OrderSourceCode
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX BRS_AGG_CMBGAD_Sales_idx_09 ON dbo.BRS_AGG_CMBGAD_Sales
	(
	[CategoryRollupPPE]
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO


ALTER TABLE dbo.BRS_AGG_CMBGAD_Sales ADD CONSTRAINT
	FK_BRS_AGG_CMBGAD_Sales_BRS_ppe FOREIGN KEY
	(
	[CategoryRollupPPE]
	) REFERENCES [dbo].[BRS_ItemCategoryPPE]
	(
	[CategoryRollupPPE]
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO


ALTER TABLE dbo.BRS_AGG_CMBGAD_Sales SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


