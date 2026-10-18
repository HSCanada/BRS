-- GEP promo, tmc, 2 Apr 26

-- keep full script from being run
print 'hi'
go
raiserror('Oh no a fatal error', 20, -1) with log
go
print 'ho, no go!'


--drop TABLE dbo.STAGE_BRS_Promotion_GEP

-- truncate TABLE dbo.STAGE_BRS_Promotion_GEP
-- truncate table STAGE_BRS_TransactionDW

-- select top 10 * from dbo.STAGE_BRS_Promotion_GEP
-- select top 10 * from dbo.STAGE_BRS_TransactionDW

BEGIN TRANSACTION
GO
CREATE TABLE dbo.STAGE_BRS_Promotion_GEP
	(
	Line_Promo_Campaigns_GEP varchar(255) NULL,
	Line_Promo_Code_GEP varchar(255) NULL,
	Line_Promo_Coupon_X_Ref_GEP varchar(255) NULL,
	Line_Promo_Coupon_GEP varchar(255) NULL,
	Line_Promo_Description_GEP varchar(255) NULL,
	Line_Promo_End_Date_GEP varchar(255) NULL,
	Line_Promo_Message_GEP varchar(255) NULL,
	Line_Promo_Redeem_Instructions_GEP varchar(255) NULL,
	Line_Promo_Sales_Division_GEP varchar(255) NULL,
	Line_Promo_Start_Date_GEP varchar(255) NULL,
	Line_Promo_Status_GEP varchar(255) NULL,
	Line_Promo_Type_GEP varchar(255) NULL,
	Order_Level_Coupon_X_Ref_GEP varchar(255) NULL,
	Order_Level_Coupon_GEP varchar(255) NULL,
	Order_Level_Promo_Campaigns_GEP varchar(255) NULL,
	Order_Level_Promo_Code_GEP varchar(255) NULL,
	Order_Level_Promo_Description_GEP varchar(255) NULL,
	Order_Level_Promo_End_Date_GEP varchar(255) NULL,
	Order_Level_Promo_Message_GEP varchar(255) NULL,
	Order_Level_Promo_Redeem_Instructions_GEP varchar(255) NULL,
	Order_Level_Promo_Sales_Division_GEP varchar(255) NULL,
	Order_Level_Promo_Start_Date_GEP varchar(255) NULL,
	Order_Level_Promo_Status_GEP varchar(255) NULL,
	Order_Level_Promo_Type_GEP varchar(255) NULL,

	ID int NOT NULL IDENTITY (1, 1),
	status_cd char(5) NULL

	)  ON USERDATA
GO
ALTER TABLE dbo.STAGE_BRS_Promotion_GEP SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_Promotion_GEP ADD CONSTRAINT
	PK_STAGE_BRS_Promotion_GEP PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE dbo.STAGE_BRS_Promotion_GEP SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- create load view

CREATE view STAGE_BRS_Promotion_GEP_load as 
SELECT [Line_Promo_Campaigns_GEP]
      ,[Line_Promo_Code_GEP]
      ,[Line_Promo_Coupon_X_Ref_GEP]
      ,[Line_Promo_Coupon_GEP]
      ,[Line_Promo_Description_GEP]
      ,[Line_Promo_End_Date_GEP]
      ,[Line_Promo_Message_GEP]
      ,[Line_Promo_Redeem_Instructions_GEP]
      ,[Line_Promo_Sales_Division_GEP]
      ,[Line_Promo_Start_Date_GEP]
      ,[Line_Promo_Status_GEP]
      ,[Line_Promo_Type_GEP]
      ,[Order_Level_Coupon_X_Ref_GEP]
      ,[Order_Level_Coupon_GEP]
      ,[Order_Level_Promo_Campaigns_GEP]
      ,[Order_Level_Promo_Code_GEP]
      ,[Order_Level_Promo_Description_GEP]
      ,[Order_Level_Promo_End_Date_GEP]
      ,[Order_Level_Promo_Message_GEP]
      ,[Order_Level_Promo_Redeem_Instructions_GEP]
      ,[Order_Level_Promo_Sales_Division_GEP]
      ,[Order_Level_Promo_Start_Date_GEP]
      ,[Order_Level_Promo_Status_GEP]
      ,[Order_Level_Promo_Type_GEP]
  FROM [dbo].[STAGE_BRS_Promotion_GEP]

GO


--

select * from dbo.STAGE_BRS_Promotion_GEP

select count(*) from dbo.STAGE_BRS_Promotion_GEP
-- ORG 3462

-- run from cmd in working dir
-- tab
-- BCP DEV_BRSales..STAGE_BRS_Promotion_GEP in ../Upload/BRS_Promotion_GEP.txt -w -T -S CAHSIONNLSQL1 -e BRS_Promotion_GEP_ERR.txt -F 2

-- pipe
-- BCP DEV_BRSales..STAGE_BRS_Promotion_GEP_load in ../Upload/BRS_Promotion_GEP.txt -w -T -S CAHSIONNLSQL1 -e BRS_Promotion_GEP_ERR.txt -F 2 -t"|"

-- BCP BRSales..STAGE_BRS_Promotion_GEP_load in ../Upload/BRS_Promotion_GEP.txt -w -T -S CAHSIONNLSQL1 -e BRS_Promotion_GEP_ERR.txt -F 2 -t"|"

-- review GEP Order, null
/*

SELECT
	ISNULL(Order_Level_Coupon_X_Ref_GEP, 0)		AS Order_Level_Coupon_X_Ref_GEP
	,ISNULL(Order_Level_Coupon_GEP, 0)			AS Order_Level_Coupon_GEP
	,Order_Level_Promo_Campaigns_GEP
	,Order_Level_Promo_Code_GEP
	,Order_Level_Promo_Description_GEP
	,Order_Level_Promo_End_Date_GEP
	,Order_Level_Promo_Message_GEP
	,Order_Level_Promo_Redeem_Instructions_GEP
	,Order_Level_Promo_Sales_Division_GEP
	,Order_Level_Promo_Start_Date_GEP
	,Order_Level_Promo_Status_GEP
	,Order_Level_Promo_Type_GEP
	,ID
FROM
	STAGE_BRS_Promotion_GEP
where
--	Order_Level_Coupon_X_Ref_GEP is null or 
--	Order_Level_Coupon_GEP is null or 
--	Order_Level_Promo_Campaigns_GEP is null
--	Order_Level_Promo_Code_GEP is null
--	Order_Level_Promo_Description_GEP is null
--	Order_Level_Promo_End_Date_GEP is null
--	Order_Level_Promo_Message_GEP is null 
--	Order_Level_Promo_Redeem_Instructions_GEP is null 
--	Order_Level_Promo_Sales_Division_GEP is null 
--	Order_Level_Promo_Start_Date_GEP is null 
--	Order_Level_Promo_Status_GEP is null 
--	Order_Level_Promo_Type_GEP is null 
(1=1)
*/

-- review GEP order, dups

SELECT
	Order_Level_Promo_Code_GEP
	,Order_Level_Promo_Description_GEP
	,Order_Level_Promo_Start_Date_GEP
	,Order_Level_Promo_End_Date_GEP
	,Order_Level_Promo_Message_GEP
	,Order_Level_Promo_Redeem_Instructions_GEP
	,Order_Level_Promo_Sales_Division_GEP
	,Order_Level_Promo_Status_GEP
	,Order_Level_Promo_Type_GEP

	,Order_Level_Promo_Campaigns_GEP
	,ISNULL(Order_Level_Coupon_X_Ref_GEP, 0)		AS Order_Level_Coupon_X_Ref_GEP
	,ISNULL(Order_Level_Coupon_GEP, 0)			AS Order_Level_Coupon_GEP

	,ID
FROM
	STAGE_BRS_Promotion_GEP
ORDER BY 1


SELECT
	Order_Level_Promo_Code_GEP

	,Order_Level_Promo_Description_GEP
	,Order_Level_Promo_Start_Date_GEP
	,Order_Level_Promo_End_Date_GEP
	,Order_Level_Promo_Message_GEP
	,Order_Level_Promo_Redeem_Instructions_GEP
	,Order_Level_Promo_Sales_Division_GEP
	,Order_Level_Promo_Status_GEP
	,Order_Level_Promo_Type_GEP

	,Order_Level_Promo_Campaigns_GEP
	,ISNULL(Order_Level_Coupon_X_Ref_GEP, 0)		AS Order_Level_Coupon_X_Ref_GEP
	,ISNULL(Order_Level_Coupon_GEP, 0)			AS Order_Level_Coupon_GEP

	,ID


FROM
	STAGE_BRS_Promotion_GEP
WHERE 
	Order_Level_Promo_Code_GEP <> '***' AND
--	Order_Level_Promo_Start_Date_GEP = '0'
--	Order_Level_Promo_Code_GEP in('CA-AAD-0226-ORD-PDC2026-P9194-OC-0002', 'CA-AAD-0925-FG-SeptSelectPromos-BK-0040', 'CA-AAD-0925-FG-SeptSelectPromos-BK-0044') AND
	(1=1)
 order by 1, ID

GROUP BY 	Order_Level_Promo_Code_GEP

HAVING
	MIN(Order_Level_Promo_Description_GEP) <> MAX(Order_Level_Promo_Description_GEP) OR
	MIN(Order_Level_Promo_Start_Date_GEP) <>  MAX(Order_Level_Promo_Start_Date_GEP) OR
	MIN(Order_Level_Promo_End_Date_GEP) <> MAX(Order_Level_Promo_End_Date_GEP) OR
	MIN(Order_Level_Promo_Message_GEP) <> MAX(Order_Level_Promo_Message_GEP) OR
	MIN(Order_Level_Promo_Redeem_Instructions_GEP) <> MAX(Order_Level_Promo_Redeem_Instructions_GEP) OR
	MIN(Order_Level_Promo_Sales_Division_GEP) <> MAX(Order_Level_Promo_Sales_Division_GEP) OR
	MIN(Order_Level_Promo_Status_GEP) <> MAX(Order_Level_Promo_Status_GEP) OR
	MIN(Order_Level_Promo_Type_GEP) <> MAX(Order_Level_Promo_Type_GEP) 


-- tag header

SELECT
	Order_Level_Promo_Code_GEP
	,MIN(ID)


FROM
	STAGE_BRS_Promotion_GEP
WHERE 
	Order_Level_Promo_Code_GEP <> '***' AND
--	Order_Level_Promo_Start_Date_GEP = '0'
--	Order_Level_Promo_Code_GEP in('CA-AAD-0226-ORD-PDC2026-P9194-OC-0002', 'CA-AAD-0925-FG-SeptSelectPromos-BK-0040', 'CA-AAD-0925-FG-SeptSelectPromos-BK-0044') AND
	(1=1)
 order by 1, ID

GROUP BY 	Order_Level_Promo_Code_GEP


SELECT   distinct Line_Promo_Code_GEP, Order_Level_Promo_Code_GEP
FROM     STAGE_BRS_Promotion_GEP


SELECT   * 
FROM     STAGE_BRS_Promotion_GEP
where 
Line_Promo_Code_GEP = 'CA-AAD-0925-FG-SeptSelectPromos-OC-0003' OR
Order_Level_Promo_Code_GEP = 'CA-AAD-0925-FG-SeptSelectPromos-OC-0003'

-- add gep promo to stage, 

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
	[GEP_Order_Flag] [char](10) NULL,

	Order_Level_Promo_Code_GEP varchar(255) NULL,
	Line_Promo_Coupon_GEP varchar(255) NULL,

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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


-- ORG DW 137147
-- NEW DW 137147

-- drop table dbo.BRS_Promotion_GEP

BEGIN TRANSACTION
GO
CREATE TABLE dbo.BRS_Promotion_GEP
	(
	Promo_Code_GEP varchar(100) NOT NULL,

	Line_Promo_Campaigns_GEP varchar(100) NULL,
	Line_Promo_Coupon_X_Ref_GEP varchar(100) NULL,
	Line_Promo_Coupon_GEP varchar(100) NULL,
	Line_Promo_Description_GEP varchar(120) NULL,
	Line_Promo_End_Date_GEP varchar(100) NULL,
	Line_Promo_Message_GEP varchar(120) NULL,
	Line_Promo_Redeem_Instructions_GEP varchar(120) NULL,
	Line_Promo_Sales_Division_GEP varchar(10) NULL,
	Line_Promo_Start_Date_GEP varchar(100) NULL,
	Line_Promo_Status_GEP varchar(10) NULL,
	Line_Promo_Type_GEP varchar(50) NULL,

	Order_Level_Coupon_X_Ref_GEP varchar(100) NULL,
	Order_Level_Coupon_GEP varchar(100) NULL,
	Order_Level_Promo_Campaigns_GEP varchar(100) NULL,
	Order_Level_Promo_Description_GEP varchar(120) NULL,
	Order_Level_Promo_End_Date_GEP varchar(100) NULL,
	Order_Level_Promo_Message_GEP varchar(120) NULL,
	Order_Level_Promo_Redeem_Instructions_GEP varchar(120) NULL,
	Order_Level_Promo_Sales_Division_GEP varchar(10) NULL,
	Order_Level_Promo_Start_Date_GEP varchar(100) NULL,
	Order_Level_Promo_Status_GEP varchar(10) NULL,
	Order_Level_Promo_Type_GEP varchar(50) NULL,

	Promo_Code_GEP_key int NOT NULL IDENTITY (1, 1),
	note_txt varchar(50) NULL

	)  ON USERDATA
GO
ALTER TABLE dbo.BRS_Promotion_GEP SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Promotion_GEP ADD CONSTRAINT
	BRS_Promotion_GEP_c_pk PRIMARY KEY CLUSTERED 
	(
	Promo_Code_GEP
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE dbo.BRS_Promotion_GEP SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


insert into BRS_Promotion_GEP
(Promo_Code_GEP)
VALUES ('')

select * from BRS_Promotion_GEP

--
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX BRS_Promotion_GEP_u_idx_1 ON dbo.BRS_Promotion_GEP
	(
	Promo_Code_GEP_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_Promotion_GEP SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- GEP Promo DW Add
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW ADD
	GEP_PromotionCode_key int NULL,
	GEP_OrderPromotionCode_key int NULL
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- GEP Promo DW RI
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_BRS_Promotion_GEP FOREIGN KEY
	(
	GEP_OrderPromotionCode_key
	) REFERENCES dbo.BRS_Promotion_GEP
	(
	Promo_Code_GEP_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_BRS_Promotion_GEP1 FOREIGN KEY
	(
	GEP_PromotionCode_key
	) REFERENCES dbo.BRS_Promotion_GEP
	(
	Promo_Code_GEP_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- delete from BRS_TransactionDW where [Date] >= '2026-09-01'

-- free goods

-- clear DW FG (re-run newer model):  iterate from 202601 -> 202401
UPDATE    
	BRS_TransactionDW
SET              
	FreeGoodsEstInd = 0
-- SELECT *
FROM         
	BRS_TransactionDW s
		
WHERE     
	FreeGoodsEstInd <> 0 AND
	[CalMonth] >= 202401 AND
	(1=1)
GO
-- add 185 143 rows

-- clear DS FG (re-run newer model)
UPDATE    
	BRS_Transaction
SET              
	FreeGoodsEstInd = 0,
	AdjCode ='',
	AdjNote = ''
WHERE     
	FreeGoodsEstInd <> 0 AND
	[FiscalMonth] >= 202401 AND
	(1=1)
GO
-- 185 137 rows


-- clear DS missed FG XXXFGE 
UPDATE    
	BRS_Transaction
SET              
	AdjCode ='',
	AdjNote = ''
WHERE     
	FreeGoodsEstInd = 0 AND
	 AdjCode = 'XXXFGE' AND
	[FiscalMonth] >= 202401 AND
	(1=1)
GO


select AdjCode, AdjNote, FreeGoodsEstInd, DocType FROM BRS_Transaction where AdjCode = 'XXXFGE' and FreeGoodsEstInd = 0 and [FiscalMonth] >= 202401



SELECT        d.FiscalMonth, t.SalesOrderNumber, t.Item, i.Supplier, SUM(t.GPAtFileCostAmt) AS ExtFileCostAmt, 'DS' as src
FROM            BRS_TransactionDW AS t INNER JOIN
                         BRS_SalesDay AS d ON t.Date = d.SalesDate INNER JOIN
                         BRS_Item AS i ON t.Item = i.Item
WHERE        (t.FreeGoodsEstInd = 1) AND (d.FiscalMonth between 202501 and 202603)
GROUP BY d.FiscalMonth, t.SalesOrderNumber, t.Item, i.Supplier

UNION ALL

SELECT        FiscalMonth, SalesOrderNumber, Item, Supplier, SUM(ExtFileCostCadAmt) AS ExtFileCostAmt, 'FG' as src
FROM            comm.freegoods
WHERE        (SourceCode = 'ACT') AND 
       (FiscalMonth BETWEEN 202501 AND 202603)
GROUP BY FiscalMonth, SalesOrderNumber, DocType, Item, Supplier


-- test model
SELECT         i.Supplier, SUM(t.GPAtFileCostAmt) AS ExtFileCostAmt, 'DS' as src
FROM            BRS_TransactionDW AS t INNER JOIN
                         BRS_SalesDay AS d ON t.Date = d.SalesDate INNER JOIN
                         BRS_Item AS i ON t.Item = i.Item
WHERE        t.[FreeGoodsInvoicedInd] = 1 and (t.FreeGoodsEstInd = 0) AND (d.FiscalMonth between 202501 and 202603) AND
	i.MajorProductClass = '081'
GROUP BY  i.Supplier


-- test actual

SELECT        comm.freegoods.FiscalMonth, comm.freegoods.Item, comm.freegoods.Supplier, SUM(comm.freegoods.ExtFileCostCadAmt) AS ExtFileCostAmt, 'FG' AS src, i.Label
FROM            comm.freegoods INNER JOIN
                         BRS_Item AS i ON comm.freegoods.Item = i.Item
WHERE        (comm.freegoods.SourceCode = 'ACT') AND (comm.freegoods.FiscalMonth BETWEEN 202501 AND 202603) AND (comm.freegoods.Supplier = 'MEDICO')
GROUP BY comm.freegoods.FiscalMonth, comm.freegoods.DocType, comm.freegoods.Item, comm.freegoods.Supplier, i.Label



--

SELECT 
--top 10 
Line_Promo_Campaigns_GEP
,Line_Promo_Code_GEP
,Line_Promo_Coupon_X_Ref_GEP
,Line_Promo_Coupon_GEP
,Line_Promo_Description_GEP

,Line_Promo_End_Date_GEP
,cast(NULLIF(Line_Promo_End_Date_GEP, '0') as date) as Line_Promo_End_Date_GEP_new

,Line_Promo_Message_GEP
,Line_Promo_Redeem_Instructions_GEP
,Line_Promo_Sales_Division_GEP

,Line_Promo_Start_Date_GEP

,Line_Promo_Status_GEP
,Line_Promo_Type_GEP
,Order_Level_Coupon_X_Ref_GEP
,Order_Level_Coupon_GEP
,Order_Level_Promo_Campaigns_GEP
,Order_Level_Promo_Code_GEP
,Order_Level_Promo_Description_GEP

,Order_Level_Promo_End_Date_GEP

,Order_Level_Promo_Message_GEP
,Order_Level_Promo_Redeem_Instructions_GEP
,Order_Level_Promo_Sales_Division_GEP

,Order_Level_Promo_Start_Date_GEP

,Order_Level_Promo_Status_GEP
,Order_Level_Promo_Type_GEP
,ID
,status_cd
FROM            STAGE_BRS_Promotion_GEP
--where Line_Promo_End_Date_GEP = '0'


-- temp remove PK to allow dup load to fix in source

BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_TransactionDW
	DROP CONSTRAINT STAGE_BRS_TransactionDW_PK
GO
ALTER TABLE dbo.STAGE_BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- temp add PK back
BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_TransactionDW ADD CONSTRAINT
	STAGE_BRS_TransactionDW_PK PRIMARY KEY CLUSTERED 
	(
	JDEORNO,
	ORDOTYCD,
	LNNO
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.STAGE_BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- test dups after BCP
SELECT        JDEORNO, ORDOTYCD, LNNO, COUNT(*) AS Expr1
FROM            STAGE_BRS_TransactionDW
GROUP BY JDEORNO, ORDOTYCD, LNNO
HAVING        (COUNT(*) > 1)
ORDER BY 1,2,3


-- BRS_TransactionDW_cloud-2025H1
-- 0 dups

-- BRS_TransactionDW_cloud-2025H2-fix-dups
/*
JDEORNO	ORDOTYCD	LNNO	Expr1
18432098	SE	3	2
18432098	SE	4	2

18491047	SE	1	2
18491047	SE	2	2
18491047	SE	3	2
18491047	SE	4	2
18491047	SE	5	2
18491047	SE	6	2
18491047	SE	7	2
18491047	SE	8	2
18491047	SE	9	2
18491047	SE	10	2
18491047	SE	11	2
18491047	SE	12	2
18491047	SE	13	2
18491047	SE	14	2
18491047	SE	15	2
18491047	SE	16	2
18491047	SE	17	2
18491047	SE	18	2
18491047	SE	19	2
18491047	SE	20	2

18498623	SE	3	2
18498623	SE	8	2

18502394	SE	5	2
18502394	SE	7	2

18507828	SE	1	2
18507828	SE	2	2
18507828	SE	3	2
18507828	SE	4	2
18507828	SE	5	2
18507828	SE	6	2
18507828	SE	7	2
18507828	SE	8	2
18507828	SE	9	2
18507828	SE	10	2
18507828	SE	11	2
18507828	SE	12	2
18507828	SE	13	2
18507828	SE	14	2
18507828	SE	15	2

18514876	SE	1	2
18514876	SE	2	2
18514876	SE	3	2
18514876	SE	4	2
18514876	SE	5	2
18514876	SE	6	2
18514876	SE	7	2
18514876	SE	8	2
18514876	SE	9	2
18514876	SE	10	2
18514876	SE	11	2
18514876	SE	12	2
18514876	SE	13	2

18515022	SE	1	2
18515022	SE	2	2
18515022	SE	3	2
18515022	SE	4	2
18515022	SE	5	2
18515022	SE	6	2
18515022	SE	7	2

18516633	SE	1	2
18516633	SE	2	2

18519737	SE	1	2
18519737	SE	2	2
18519737	SE	3	2
18519737	SE	4	2
18519737	SE	5	2
18519737	SE	6	2
18519737	SE	7	2
18519737	SE	8	2
18519737	SE	9	2
18519737	SE	10	2
18519737	SE	11	2
18519737	SE	12	2
18519737	SE	13	2
18519737	SE	14	2
18519737	SE	15	2
18519737	SE	16	2
18519737	SE	17	2
18519737	SE	18	2
18519737	SE	19	2
18519737	SE	20	2
18519737	SE	21	2
18519737	SE	22	2
18519737	SE	23	2
18519737	SE	24	2
18519737	SE	25	2
18519737	SE	26	2
18519737	SE	27	2
18519737	SE	28	2
18519737	SE	29	2
18519737	SE	30	2
18519737	SE	31	2
18519737	SE	32	2
18519737	SE	33	2
18519737	SE	34	2
18519737	SE	35	2
18519737	SE	36	2
18519737	SE	37	2
18519737	SE	38	2
18519737	SE	39	2

18520054	SE	1	2
18520054	SE	2	2
18520054	SE	3	2
18520054	SE	4	2
18520054	SE	5	2
18520054	SE	6	2
18520054	SE	7	2
18520054	SE	8	2
18520054	SE	9	2
18520054	SE	10	2
18520054	SE	11	2
18520054	SE	12	2
18520054	SE	13	2
18520054	SE	14	2
18520054	SE	15	2
18520054	SE	16	2
18520054	SE	17	2
18520054	SE	18	2
18520054	SE	19	2
18520054	SE	20	2
18520054	SE	21	2
18520054	SE	22	2
18520054	SE	23	2

18520480	SE	1	2
18520480	SE	2	2
18520480	SE	3	2
18520480	SE	4	2
18520480	SE	5	2
18520480	SE	6	2
18520480	SE	7	2
18520480	SE	8	2
18520480	SE	9	2
18520480	SE	10	2
18520480	SE	11	2
18520480	SE	12	2
18520480	SE	13	2
18520480	SE	14	2
18520480	SE	15	2

18523274	SE	1	3
18523274	SE	2	3
18523274	SE	3	3
18523274	SE	4	3
18523274	SE	5	3
18523274	SE	6	3
18523274	SE	7	3
18523274	SE	8	3
18523274	SE	9	3
18523274	SE	10	3
18523274	SE	11	3

18525978	SE	1	2
18525978	SE	2	2
18525978	SE	3	2
18525978	SE	4	2

18527166	SE	1	2
18527166	SE	2	2
18527166	SE	3	2
18527166	SE	4	2
18527166	SE	5	2
18527166	SE	6	2
18527166	SE	7	2
18527166	SE	8	2
18527166	SE	9	2
18527166	SE	10	2
18527166	SE	11	2
18527166	SE	12	2

18529368	SE	1	2
18529368	SE	2	2
18529368	SE	3	2
18529368	SE	4	2
18529368	SE	5	2
18529368	SE	6	2
18529368	SE	7	2
18529368	SE	8	2
18529368	SE	9	2
18529368	SE	10	2
18529368	SE	11	2
18529368	SE	12	2
18529368	SE	13	2
18529368	SE	14	2
18529368	SE	15	2

18529754	SE	1	2
18529754	SE	2	2
18529754	SE	3	2

18529814	SE	1	2
18529814	SE	2	2
18529814	SE	3	2
18529814	SE	4	2
18529814	SE	5	2
18529814	SE	6	2

18534618	SE	1	2
18534618	SE	2	2
18534618	SE	3	2
18534618	SE	4	2
18534618	SE	5	2
18534618	SE	6	2
18534618	SE	7	2
18534618	SE	8	2
18534618	SE	9	2
18534618	SE	10	2
18534618	SE	11	2

18543559	SE	1	2
18543559	SE	2	2

18545868	SE	1	2
18545868	SE	2	2
18545868	SE	3	2
18545868	SE	4	2
18545868	SE	5	2
18545868	SE	6	2
18545868	SE	7	2
18545868	SE	8	2
18545868	SE	9	2
18545868	SE	10	2
18545868	SE	11	2
18545868	SE	12	2
18545868	SE	13	2
18545868	SE	14	2

18548951	SE	1	2
18548951	SE	2	2
18548951	SE	3	2
18548951	SE	4	2
18548951	SE	5	2
18548951	SE	6	2

18558227	SE	1	2
18558227	SE	2	2
18558227	SE	3	2
18558227	SE	4	2
18558227	SE	5	2
18558227	SE	6	2

18559881	SE	1	2
18559881	SE	2	2
18559881	SE	3	2
18559881	SE	4	2
18559881	SE	5	2
18559881	SE	6	2

18560494	SE	1	2
18560494	SE	2	2
18560494	SE	3	2
18560494	SE	4	2
18560494	SE	5	2
18560494	SE	6	2
18560494	SE	7	2
18560494	SE	8	2
18560494	SE	9	2
18560494	SE	10	2

18561331	SE	1	2
18561331	SE	2	2

18561489	SE	1	2
18561489	SE	2	2
18561489	SE	3	2
18561489	SE	4	2
18561489	SE	5	2
18561489	SE	6	2
18561489	SE	7	2
18561489	SE	8	2
18561489	SE	9	2
18561489	SE	10	2
18561489	SE	11	2
18561489	SE	12	2
18561489	SE	13	2
18561489	SE	14	2
18561489	SE	15	2
18561489	SE	16	2
18561489	SE	17	2
18561489	SE	18	2
18561489	SE	19	2
18561489	SE	20	2
18561489	SE	21	2
18561489	SE	22	2
18561489	SE	23	2
18561489	SE	24	2
18561489	SE	25	2
18561489	SE	26	2
18561489	SE	27	2
18561489	SE	28	2
18561489	SE	29	2
18561489	SE	30	2
18561489	SE	31	2
18561489	SE	32	2
18561489	SE	33	2
18561489	SE	34	2
18561489	SE	35	2
18561489	SE	36	2
18561489	SE	37	2
18561489	SE	38	2
18561489	SE	39	2
18561489	SE	40	2
18561489	SE	41	2
18561489	SE	42	2
18561489	SE	43	2
18561489	SE	44	2
18561489	SE	45	2
18561489	SE	46	2
18561489	SE	47	2
18561489	SE	48	2
18561489	SE	49	2
18561489	SE	50	2
18561489	SE	51	2
18561489	SE	52	2
18561489	SE	53	2
18561489	SE	54	2
18561489	SE	55	2
18561489	SE	56	2

18561709	SE	1	3
18561709	SE	2	3
18561709	SE	3	3
18561709	SE	4	3
18561709	SE	5	3

18561841	SE	1	2
18561841	SE	2	2
18561841	SE	3	2
18561841	SE	4	2
18561841	SE	5	2
18561841	SE	6	2
18561841	SE	7	2
18561841	SE	8	2
18561841	SE	9	2

18567402	SE	1	2
18570827	SE	1	2
18571561	SE	11	2
18571960	SE	5	2
18577118	SE	3	2
18577913	SE	7	2
18578841	SE	1	2
18581124	SE	7	2
18581966	SE	2	2
18582649	SE	2	2
18585326	SE	2	2
18667913	SE	3	2
*/

-- BRS_TransactionDW_cloud-2026H1-fix-dups
/*
JDEORNO	ORDOTYCD	LNNO	Expr1
18828687	SE	4	3
18830405	SE	7	2
18833207	SE	7	2
18842219	SE	4	2
18868706	SE	4	2
18902647	SE	4	2
18908187	SE	3	2
18908264	SE	5	2
18912192	SE	15	2
18912708	SE	9	2
18913096	SE	4	2
18913948	SE	13	2
*/
-- BRS_TransactionDW_cloud-2026H2
-- 0 dups

-- BRS_TransactionDW_cloud-today
-- 0 dups

truncate table STAGE_BRS_TransactionDW

DELETE FROM STAGE_BRS_TransactionDW
FROM            STAGE_BRS_TransactionDW INNER JOIN
                         zzzShipto ON STAGE_BRS_TransactionDW.JDEORNO = zzzShipto.ST

-- test
SELECT        top 100  [SalesOrderNumber],[DocType], LineNumber,[Item] , [OrderSourceCode], [PriceMethod], [OrderPromotionCode], PromotionCode, GEP_PromotionCode_key, GEP_OrderPromotionCode_key, FreeGoodsInvoicedInd,[ShippedQty], [NetSalesAmt], EnteredBy, [CustomerPOText1]
FROM            BRS_TransactionDW
WHERE   
--[SalesOrderNumber] = 19385944 and

(CalMonth >= 202601) AND 
(doctype  in ('se')) and
(GEP_Order_Flag_ind = 0) AND 
([PriceMethod] = 'P') and 
(FreeGoodsInvoicedInd = 0) and
(GEP_PromotionCode_key is null) and
([PromotionCode] = '') and
(1=1)
order by 1,2,3
GO
