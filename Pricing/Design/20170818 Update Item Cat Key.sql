

Alter Table [dbo].[BRS_ItemCategoryRollup]
Add CategoryRollupKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_ItemCategoryRollup_u_idx ON dbo.BRS_ItemCategoryRollup
	(
	CategoryRollupKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

--

Alter Table [dbo].[BRS_BusinessUnitClass]
Add GLBU_ClassKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_BusinessUnitClass_u_idx ON dbo.BRS_BusinessUnitClass
	(
	GLBU_ClassKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


--

Alter Table [dbo].[BRS_AdjCode]
Add AdjCodeKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_AdjCode_u_idx ON dbo.BRS_AdjCode
	(
	AdjCodeKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


--

Alter Table [dbo].[BRS_CustomerMarketClass]
Add MarketClassKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_CustomerMarketClass_u_idx ON dbo.BRS_CustomerMarketClass
	(
	MarketClassKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
