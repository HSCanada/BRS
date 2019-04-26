

-- CREATE SCHEMA [usd] AUTHORIZATION [dbo]


-- drop table [usd].[BRS_Item]

CREATE TABLE [usd].[BRS_Item](
	[Item] [char](10) NOT NULL,
	[ItemDescription] [varchar](40) NOT NULL,
	[Supplier] [char](6) NOT NULL,
	[Size] [varchar](8) NOT NULL,
	[Strength] [varchar](12) NOT NULL,
	[ManufPartNumber] [varchar](15) NOT NULL,
	[FamilySetLeader] [char](10) NOT NULL,
	[ItemStatus] [char](1) NOT NULL,
	[Label] [char](1) NOT NULL,
	[StockingType] [char](1) NOT NULL,
	[GLCategory] [char](4) NOT NULL,
	[TagableItemFlag] [char](1) NOT NULL,
	[ItemCreationDate] [date] NOT NULL,
	[SalesCategory] [varchar](6) NOT NULL,
	[MajorProductClass] [char](3) NOT NULL,
	[SubMajorProdClass] [char](6) NOT NULL,
	[MinorProductClass] [char](9) NOT NULL,
	[CurrentFileCost] [money] NOT NULL,
	[FreightAdjPct] [float] NOT NULL,
	[CorporateMarketAdjustmentPct] [float] NOT NULL,
	[DivisionalMarketAdjustmentPct] [float] NOT NULL,
	[CurrentCorporatePrice] [money] NOT NULL,
	[AddedDt] [date] NOT NULL,
	[Est12MoSales] [money] NOT NULL DEFAULT (0),
	[ItemKey] [int] IDENTITY(1,1) NOT NULL,
	[Brand] [char](6) NOT NULL,
 CONSTRAINT [usd_BRS_Item_c_pk] PRIMARY KEY CLUSTERED 
(
	[Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [usd].[BRS_Item] ADD  CONSTRAINT [DF_usd_BRS_Item_AddedDate]  DEFAULT (getdate()) FOR [AddedDt]
GO

BEGIN TRANSACTION
GO
ALTER TABLE usd.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_BRS_ItemMPC FOREIGN KEY
	(
	MajorProductClass
	) REFERENCES dbo.BRS_ItemMPC
	(
	MajorProductClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE usd.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_BRS_ItemCategory FOREIGN KEY
	(
	MinorProductClass
	) REFERENCES dbo.BRS_ItemCategory
	(
	MinorProductClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE usd.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT