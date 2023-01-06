
-- DS fix stage sizing, tmc, 4 Dec 22

-- drop table [dbo].[STAGE_BRS_ItemFull]

CREATE TABLE [dbo].[STAGE_BRS_ItemFull](
	[ItemID] [int] NULL,
	[Item] [char](10) NOT NULL,
	[ItemDescription] [varchar](100) NULL,
	[Supplier] [char](6) NULL,
	[Size] [varchar](50) NULL,
	[Strength] [varchar](50) NULL,
	[ManufPartNumber] [varchar](100) NULL,
	[FamilySetLeader] [char](10) NULL,
	[ItemStatus] [char](1) NULL,
	[Label] [char](1) NULL,
	[StockingType] [char](1) NULL,
	[GLCategory] [char](4) NULL,
	[TagableItemFlag] [char](1) NULL,
	[ItemCreationDate] [datetime] NULL,
	[SalesCategory] [varchar](6) NULL,
	[MajorProductClass] [char](3) NULL,
	[SubMajorProdClassID] [varchar](50) NULL,
	[SubMajorProdClass] [char](6) NULL,
	[MinorProductClassID] [varchar](50) NULL,
	[MinorProductClass] [char](9) NULL,
	[CurrentFileCost] [money] NULL,
	[FreightAdjPct] [float] NULL,
	[CorporateMarketAdjustmentPct] [float] NULL,
	[DivisionalMarketAdjustmentPct] [float] NULL,
	[CurrentCorporatePrice] [money] NULL,
	[Brand] [char](6) NULL,
	[SMNPRCLID] [char](9) NULL,
 CONSTRAINT [STAGE_BRS_Item_pk] PRIMARY KEY CLUSTERED 
(
	[Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Exec BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=1


-- drop table [dbo].[STAGE_BRS_Promotion]

CREATE TABLE [dbo].[STAGE_BRS_Promotion](
	[PMID] [int] NOT NULL,
	[PMCD] [char](2) NULL,
	[PMDE0] [nvarchar](50) NULL,
	[MKTPGIN] [char](1) NULL,
	[PMSTPDID] [int] NULL,
	[PMSTDT] [datetime] NULL,
	[PMENPDID] [int] NULL,
	[PMENDT] [datetime] NULL,
	[SDCD0] [char](3) NULL,
	[PMSTCD] [char](1) NULL,
	[PMTYID] [int] NULL,
	[PMTYDE] [nchar](30) NULL,
 CONSTRAINT [STAGE_BRS_Promotion_c_pk] PRIMARY KEY CLUSTERED 
(
	[PMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--

-- drop TABLE [dbo].[STAGE_BRS_TransactionDW]

CREATE TABLE [dbo].[STAGE_BRS_TransactionDW](
	[JDEORNO] [int] NOT NULL,
	[ORDOTYCD] [char](2) NOT NULL,
	[LNNO] [float] NOT NULL,
	[CMID] [int] NULL,
	[PDID] [int] NULL,
	[PDDT] [datetime] NULL,
	[CUID] [int] NULL,
	[ADNOID] [int] NULL,
	[ITID] [int] NULL,
	[ITLONO] [char](10) NULL,
	[ENBYNA] [char](10) NULL,
	[ORTKBYID] [char](10) NULL,
	[ORSCCD] [char](1) NULL,
	[RF1TT] [nvarchar](30) NULL,
	[PRMDCD] [char](1) NULL,
	[SPCDID] [char](10) NULL,
	[LNTY] [char](2) NULL,
	[HSDCDID] [char](3) NULL,
	[MJPRCLID] [char](3) NULL,
	[CBCONTRNO] [char](10) NULL,
	[GLBUNO] [char](12) NULL,
	[ORFISHDT] [nvarchar](30) NULL,
--	[ORFISHDT] [datetime] NULL,
	[IVNO] [int] NULL,
	[PMID] [int] NULL,
	[OPMID] [int] NULL,
	[OORNO] [int] NULL,
	[OORTY] [char](2) NULL,
	[OORLINO] [float] NULL,
	[PCADLINO] [nchar](30) NULL,
	[BTADNO] [int] NULL,
	[ESSCD] [char](5) NULL,
	[CCSCD] [char](5) NULL,
	[ESTCD] [int] NULL,
	[TSSCD] [char](5) NULL,
	[CAGREPCD] [char](5) NULL,
	[EQORDNO] [char](6) NULL,
	[EQORDTYCD] [char](2) NULL,
	[WJXBFS1] [int] NULL,
	[WJXBFS2] [money] NULL,
	[WJXBFS3] [money] NULL,
	[WJXBFS4] [money] NULL,
	[WJXBFS5] [money] NULL,
	[WJXBFS6] [money] NULL,
	[WJXBFS7] [money] NULL,
	[WJXBFS8] [money] NULL,
 CONSTRAINT [STAGE_BRS_TransactionDW_PK] PRIMARY KEY NONCLUSTERED 
(
	[JDEORNO] ASC,
	[ORDOTYCD] ASC,
	[LNNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



-- rights

GO
GRANT DELETE ON [dbo].[STAGE_BRS_TransactionDW] TO [maint_role]
GO
GO
GRANT INSERT ON [dbo].[STAGE_BRS_TransactionDW] TO [maint_role]
GO
GO
GRANT UPDATE ON [dbo].[STAGE_BRS_TransactionDW] TO [maint_role]
GO
GO
GRANT DELETE ON [dbo].[STAGE_BRS_Promotion] TO [maint_role]
GO
GO
GRANT INSERT ON [dbo].[STAGE_BRS_Promotion] TO [maint_role]
GO
GO
GRANT UPDATE ON [dbo].[STAGE_BRS_Promotion] TO [maint_role]
GO
GO
GRANT DELETE ON [dbo].[STAGE_BRS_ItemFull] TO [maint_role]
GO
GO
GRANT INSERT ON [dbo].[STAGE_BRS_ItemFull] TO [maint_role]
GO
GO
GRANT UPDATE ON [dbo].[STAGE_BRS_ItemFull] TO [maint_role]
GO

GRANT UPDATE ON [dbo].[BRS_FSC_Rollup] TO [maint_role]
GO


-- fix DW

BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240
	DROP CONSTRAINT FK_transaction_F5554240_BRS_TransactionDW
GO
ALTER TABLE fg.transaction_F5554240
	DROP CONSTRAINT FK_transaction_F5554240_BRS_TransactionDW1
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- DELETE FROM [dbo].[BRS_TransactionDW] where  ID = 41684051

DELETE FROM [dbo].[BRS_TransactionDW] where  CalMonth >= 202211

DELETE FROM fg.transaction_F5554240 WHERE [CalMonthRedeem] in(202211, 202212)


-- load 11, 12, 01

-- test
SELECT        CalMonth, SUM(NetSalesAmt) AS SumOfNetSalesAmt
FROM            BRS_TransactionDW
WHERE        (CalMonth BETWEEN 202101 AND 202301)
GROUP BY CalMonth

-- FG update / fix ref

SELECT 	WKDOCO_salesorder_number,
	WKDCTO_order_type,
	WKLNNO_line_number,  [CalMonthRedeem]from fg.transaction_F5554240
WHERE NOT EXISTS (SELECT * FROM BRS_TransactionDW where WKDOCO_salesorder_number=SalesOrderNumber and WKDCTO_order_type=DocType and WKLNNO_line_number=LineNumber )

SELECT 	WKDOCO_salesorder_number,
	WKDCTO_order_type,
	WKLNNO_line_number,  [CalMonthRedeem], [ID_source_ref] from fg.transaction_F5554240
WHERE NOT EXISTS (SELECT * FROM BRS_TransactionDW where ID=[ID_source_ref] )


-- add RI back
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_TransactionDW FOREIGN KEY
	(
	WKDOCO_salesorder_number,
	WKDCTO_order_type,
	WKLNNO_line_number
	) REFERENCES dbo.BRS_TransactionDW
	(
	SalesOrderNumber,
	DocType,
	LineNumber
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_TransactionDW1 FOREIGN KEY
	(
	ID_source_ref
	) REFERENCES dbo.BRS_TransactionDW
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update ISR / models

-- reload FG 202211, 202212