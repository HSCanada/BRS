-- refine adjustment, tmc 6 Dec 2017

-- DROP TABLE [Integration].[account_adjustment_F0911]

CREATE TABLE [Integration].[account_adjustment_F0911](
	[BatchNumber] [int] NOT NULL,
	[DocType] [char](2) NOT NULL,
	[LineNumber] [int] NOT NULL,

	[FiscalMonth] [int] NOT NULL,
	[SalesDate] [datetime] NOT NULL,

	[AdjNum] [char](10) NOT NULL,
	[AdjCode] [char](10) NOT NULL,
	[AdjNote] [varchar](50) NOT NULL,
	[AdjNoteRemark] [varchar](50) NOT NULL,
	[AdjSource] [varchar](16) NOT NULL,
	[AdjOwner] [varchar](20) NOT NULL,

	[ValueAmt] [money] NOT NULL,

	[GL_BusinessUnit] [char](12) NOT NULL,
	[GL_Object] [char](10) NOT NULL,
	[GL_Subsidiary] [char](8) NOT NULL,

	[Shipto] [int] NOT NULL,
	[SalesOrderNumber] [int] NOT NULL,
	[Item] [char](10) NOT NULL,

	[GL_DocType] [char](2) NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,

	[GLBU_Class] [char](5) NULL,
	[Branch] [char](5) NULL,
	[TerritoryCd] [char](5) NULL,
	[SalesDivision] [char](3) NULL,

	[ExceptionText] [varchar](50) NULL,
	
 CONSTRAINT [Integration_account_adjustment_F0911_c_PK] PRIMARY KEY CLUSTERED 
(
	[BatchNumber] ASC,
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
	[BatchNumber] [int] NOT NULL,
	[DocType] [char](2) NOT NULL,
	[LineNumber] [int] NOT NULL,

	[FiscalMonth] [int] NOT NULL,
	[SalesDate] [datetime] NOT NULL,

	[AdjNum] [char](10) NOT NULL,
	[AdjCode] [char](10) NOT NULL,
	[AdjNote] [varchar](50) NOT NULL,
	[AdjNoteRemark] [varchar](50) NOT NULL,
	[AdjSource] [varchar](16) NOT NULL,
	[AdjOwner] [varchar](20) NOT NULL,

	[ValueAmt] [money] NOT NULL,

	[GL_BusinessUnit] [char](12) NOT NULL,
	[GL_Object] [char](10) NOT NULL,
	[GL_Subsidiary] [char](8) NOT NULL,

	[Shipto] [int] NOT NULL,
	[SalesOrderNumber] [int] NOT NULL,
	[Item] [char](10) NOT NULL,

	[GL_DocType] [char](2) NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,

	[GLBU_Class] [char](5) NULL,
	[Branch] [char](5) NULL,
	[TerritoryCd] [char](5) NULL,
	[SalesDivision] [char](3) NULL,

	[AdjPostStatus] [smallint] NULL,

 CONSTRAINT [account_adjustment_F0911_c_PK] PRIMARY KEY CLUSTERED 
(
	[BatchNumber] ASC,
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

---
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Object ADD
	AdjCode char(10) NOT NULL CONSTRAINT DF_BRS_Object_AdjCode DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Object SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Object ADD CONSTRAINT
	FK_BRS_Object_BRS_AdjCode FOREIGN KEY
	(
	AdjCode
	) REFERENCES dbo.BRS_AdjCode
	(
	AdjCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Object SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- update BU Map
UPDATE       BRS_BusinessUnit
SET                GLBU_Class = n.text
FROM            zzzBU AS n INNER JOIN
                         BRS_BusinessUnit ON n.BU = LEFT(BRS_BusinessUnit.BusinessUnit, 10) AND n.text <> BRS_BusinessUnit.GLBU_Class

UPDATE       BRS_BusinessUnit
SET                GLBU_Class = s.GLBU_Class
FROM            BRS_BusinessUnit INNER JOIN
                         DEV_BRSales.dbo.BRS_BusinessUnit AS s ON BRS_BusinessUnit.BusinessUnit = s.BusinessUnit AND BRS_BusinessUnit.GLBU_Class <> s.GLBU_Class

UPDATE       BRS_Object
SET                AdjCode = 'ALLOWA'
WHERE        (GLAcctNumberObj = '4147')

UPDATE       BRS_Object
SET                AdjCode = 'PROMOT'
WHERE        (GLAcctNumberObj in ('4320', '4330'))

UPDATE       BRS_Object
SET                AdjCode = 'FREEGD'
WHERE        (GLAcctNumberObj = '4579')

UPDATE       BRS_Object
SET                AdjCode = 'REBATE'
WHERE        (GLAcctNumberObj in ('4300', '4310'))






