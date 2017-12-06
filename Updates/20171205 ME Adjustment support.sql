-- refine adjustment, tmc 5 Dec 2017

-- DROP TABLE [Integration].[account_adjustment_F0911]

CREATE TABLE [Integration].[account_adjustment_F0911](
	[FiscalMonth] [int] NOT NULL,
	[SalesDate] [datetime] NOT NULL,

	[SalesOrderNumberKEY] [int] NOT NULL,
	[DocType] [char](2) NOT NULL,
	[LineNumber] [int] NOT NULL,

	[SalesDivision] [char](3) NOT NULL,
	[Branch] [char](5) NOT NULL,
	[TerritoryCd] [char](5) NOT NULL,

	[AdjCode] [char](10) NOT NULL,
	[AdjNum] [char](10) NOT NULL,
	[AdjNote] [varchar](50) NOT NULL,

	[GLBU_Class] [char](5) NOT NULL,
	[GL_BusinessUnit] [char](12) NOT NULL,
	[GL_Object] [char](10) NOT NULL,
	[GL_Subsidiary] [char](8) NOT NULL,

	[ValueAmt] [money] NOT NULL,
	[CustomerPOText1] [varchar](16) NOT NULL,

	[SalesOrderNumber] [int] NOT NULL,
	[Shipto] [int] NOT NULL,
	[Item] [char](10) NOT NULL,

	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExceptionText] [varchar](50) NULL,

 CONSTRAINT [Integration_account_adjustment_F0911_c_PK] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumberKEY] ASC,
	[DocType] ASC,
	[LineNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

BEGIN TRANSACTION
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_SalesOrderNumber DEFAULT (0) FOR SalesOrderNumber
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_Shipto DEFAULT (0) FOR Shipto
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_Item DEFAULT ('') FOR Item
GO
ALTER TABLE Integration.account_adjustment_F0911 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

---

/****** Object:  Table [hfm].[account_adjustment_F0911]    Script Date: 2017/12/05 9:48:36 PM ******/
-- DROP TABLE [hfm].[account_adjustment_F0911]


CREATE TABLE [hfm].[account_adjustment_F0911](
	[FiscalMonth] [int] NOT NULL,
	[SalesDate] [datetime] NOT NULL,

	[SalesOrderNumberKEY] [int] NOT NULL,
	[DocType] [char](2) NOT NULL,
	[LineNumber] [int] NOT NULL,

	[SalesDivision] [char](3) NOT NULL,
	[Branch] [char](5) NOT NULL,
	[TerritoryCd] [char](5) NOT NULL,

	[AdjCode] [char](10) NOT NULL,
	[AdjNum] [char](10) NOT NULL,
	[AdjNote] [varchar](50) NOT NULL,

	[GLBU_Class] [char](5) NOT NULL,
	[GL_BusinessUnit] [char](12) NOT NULL,
	[GL_Object] [char](10) NOT NULL,
	[GL_Subsidiary] [char](8) NOT NULL,

	[ValueAmt] [money] NOT NULL,
	[CustomerPOText1] [varchar](16) NOT NULL,

	[SalesOrderNumber] [int] NOT NULL,
	[Item] [char](10) NOT NULL,
	[Shipto] [int] NOT NULL,

	[ID] [int] IDENTITY(1,1) NOT NULL,

	[AdjPostStatus] [smallint] NULL,
 CONSTRAINT [account_adjustment_F0911_c_PK] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumberKEY] ASC,
	[DocType] ASC,
	[LineNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_AdjCode] FOREIGN KEY([AdjCode])
REFERENCES [dbo].[BRS_AdjCode] ([AdjCode])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_Branch] FOREIGN KEY([Branch])
REFERENCES [dbo].[BRS_Branch] ([Branch])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_BusinessUnitClass] FOREIGN KEY([GLBU_Class])
REFERENCES [dbo].[BRS_BusinessUnitClass] ([GLBU_Class])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_Customer] FOREIGN KEY([Shipto])
REFERENCES [dbo].[BRS_Customer] ([ShipTo])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_DocType] FOREIGN KEY([DocType])
REFERENCES [dbo].[BRS_DocType] ([DocType])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_FiscalMonth] FOREIGN KEY([FiscalMonth])
REFERENCES [dbo].[BRS_FiscalMonth] ([FiscalMonth])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_FSC_Rollup] FOREIGN KEY([TerritoryCd])
REFERENCES [dbo].[BRS_FSC_Rollup] ([TerritoryCd])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_Item] FOREIGN KEY([Item])
REFERENCES [dbo].[BRS_Item] ([Item])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_SalesDay] FOREIGN KEY([SalesDate])
REFERENCES [dbo].[BRS_SalesDay] ([SalesDate])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_SalesDivision] FOREIGN KEY([SalesDivision])
REFERENCES [dbo].[BRS_SalesDivision] ([SalesDivision])
GO

ALTER TABLE [hfm].[account_adjustment_F0911]  WITH CHECK ADD  CONSTRAINT [FK_account_adjustment_F0911_BRS_TransactionDW_Ext] FOREIGN KEY([SalesOrderNumber])
REFERENCES [dbo].[BRS_TransactionDW_Ext] ([SalesOrderNumber])
GO


ALTER TABLE hfm.account_adjustment_F0911 ADD CONSTRAINT
	FK_account_adjustment_F0911_account_master_F0901 FOREIGN KEY
	(
	GL_BusinessUnit,
	GL_Object,
	GL_Subsidiary
	) REFERENCES hfm.account_master_F0901
	(
	GMMCU__business_unit,
	GMOBJ__object_account,
	GMSUB__subsidiary
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO




