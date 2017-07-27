Alter Table [dbo].[BRS_Branch]
Add BranchKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_Branch_u_idx ON dbo.BRS_Branch
	(
	BranchKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



Alter Table [dbo].[BRS_FSC_Rollup]
Add FscKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_FSC_Rollup_u_idx ON BRS_FSC_Rollup
	(
	FscKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



Alter Table [dbo].[BRS_CustomerGroup]
Add CustGrpKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_CustomerGroup_u_idx ON BRS_CustomerGroup
	(
	CustGrpKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


Alter Table [dbo].[BRS_CustomerVPA]
Add VpaKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_CustomerVPA_u_idx ON BRS_CustomerVPA
	(
	VpaKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


Alter Table [dbo].[BRS_ItemSupplier]
Add SupplierKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_ItemSupplier_u_idx ON BRS_ItemSupplier
	(
	SupplierKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


Alter Table [dbo].[BRS_ItemMPC]
Add MajorProductClassKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_ItemMPC_u_idx ON BRS_ItemMPC
	(
	MajorProductClassKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



Alter Table [dbo].[BRS_ItemCategory]
Add MinorProductClassKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_ItemCategory_u_idx ON BRS_ItemCategory
	(
	MinorProductClassKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


Alter Table [dbo].[BRS_ItemSalesCategory]
Add SalesCategoryKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_ItemSalesCategory_u_idx ON BRS_ItemSalesCategory
	(
	SalesCategoryKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


Alter Table [dbo].[BRS_Currency]
Add CurrencyKey Int Identity(1, 1)
Go


CREATE UNIQUE NONCLUSTERED INDEX BRS_Currency_u_idx ON BRS_Currency
	(
	CurrencyKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


Alter Table [etl].[F4071_price_adjustment_name]
Add AdjustmentNameKey Int Identity(1, 1)
Go


CREATE UNIQUE NONCLUSTERED INDEX F4071_price_adjustment_name_u_idx ON [etl].[F4071_price_adjustment_name]
	(
	[AdjustmentNameKey]
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

ALTER TABLE dbo.BRS_Customer_FSA ADD
	City nvarchar(30) NOT NULL CONSTRAINT DF_BRS_Customer_FSA_City DEFAULT (''),
	Province nchar(2) NOT NULL CONSTRAINT DF_BRS_Customer_FSA_Province DEFAULT (''),
	Border geography NULL
GO

Alter Table [dbo].[BRS_Customer_FSA]
Add FsaKey Int Identity(1, 1)
Go


CREATE UNIQUE NONCLUSTERED INDEX BRS_Customer_FSA_u_idx ON BRS_Customer_FSA
	(
	FsaKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



Alter Table [dbo].[BRS_Customer_Spend_Category]
Add SpendKey Int Identity(1, 1)
Go


CREATE UNIQUE NONCLUSTERED INDEX BRS_Customer_Spend_Category_u_idx ON BRS_Customer_Spend_Category
	(
	SpendKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


Alter Table [dbo].[BRS_DocType]
Add DocTypeKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_DocType_u_idx ON [dbo].[BRS_DocType]
	(
	DocTypeKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


/*
Alter Table xxx
Add yyyKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX xxx_u_idx ON xxx
	(
	yyyKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
*/

Alter Table [dbo].[BRS_OrderSource]
Add OrderSourceCodeKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_OrderSource_u_idx ON [dbo].[BRS_OrderSource]
	(
	OrderSourceCodeKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

Alter Table [dbo].[BRS_PriceMethod]
Add PriceMethodKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX BRS_PriceMethod_u_idx ON [dbo].[BRS_PriceMethod]
	(
	PriceMethodKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

--
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT FK_BRS_CustomerGroup_BRS_FSC_Rollup
GO
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT DF_BRS_CustomerGroup_SpendLevelAmt
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT DF_BRS_CustomerGroup_SpendLevelCode
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT DF_BRS_CustomerGroup_ActiveAccounts
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT DF_BRS_CustomerGroup_TerritoryPrimaryFSC
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP COLUMN SpendLevelAmt, SpendLevelCode, ActiveAccounts, TerritoryPrimaryFSC
GO

ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT DF_BRS_CustomerGroup_StatusCd
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT DF_BRS_CustomerGroup_ReportInd
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP COLUMN StatusCd, ReportInd
GO

GO
EXECUTE sp_rename N'dbo.BRS_Customer_Spend_Category.Spent_Rank', N'Tmp_Spend_Rank', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Customer_Spend_Category.Discount_Rate', N'Tmp_Spend_Discount_Rate_1', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Customer_Spend_Category.Tmp_Spend_Rank', N'Spend_Rank', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_Customer_Spend_Category.Tmp_Spend_Discount_Rate_1', N'Spend_Discount_Rate', 'COLUMN' 
GO

--

ALTER TABLE dbo.BRS_CustomerGroup ADD
	PotentialSpendAmt money NOT NULL CONSTRAINT DF_BRS_CustomerGroup_PotentialSpendAmt DEFAULT (0)
GO


ALTER TABLE [dbo].[BRS_Customer_Spend_Category]
ALTER COLUMN [Spend_Display] nchar(20)

ALTER TABLE dbo.BRS_Customer_FSA ADD
	Country nchar(5) NOT NULL CONSTRAINT DF_BRS_Customer_FSA_Country DEFAULT ('')
GO

-- data update
-- group spend 
Update 
	BRS_CustomerGroup
Set 
	PotentialSpendAmt = s.spend
FROM 
	BRS_CustomerGroup
	INNER JOIN
	(
		SELECT        BRS_Customer.CustGrpWrk, SUM(BRS_Customer.Est12MoTotal) AS spend
		FROM            BRS_Customer 
                          
		WHERE        (BRS_Customer.CustGrpWrk <> '')
		GROUP BY BRS_Customer.CustGrpWrk
	) s
	ON BRS_CustomerGroup.CustGrp = s.CustGrpWrk 

-- FSA

Update 
	BRS_Customer_FSA
Set 
	City  = s.City
	,Province  = s.Province
	,Country  = s.Country
	
FROM 
	BRS_Customer_FSA
INNER JOIN
	(
		SELECT FSA, Country, City, Province FROM (
		SELECT FSA, Country, City, Province, Est12MoMerch, ROW_NUMBER() OVER (PARTITION BY FSA ORDER BY Est12MoMerch DESC) rnk FROM BRS_Customer )a
		WHERE rnk = 1 AND FSA <>''
	) s
ON BRS_Customer_FSA.FSA = s.FSA

