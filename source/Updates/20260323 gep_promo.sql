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
	Line_Promo_End_Date_GEP date NULL,
	Line_Promo_Message_GEP varchar(120) NULL,
	Line_Promo_Redeem_Instructions_GEP varchar(120) NULL,
	Line_Promo_Sales_Division_GEP varchar(10) NULL,
	Line_Promo_Start_Date_GEP date NULL,
	Line_Promo_Status_GEP varchar(10) NULL,
	Line_Promo_Type_GEP varchar(50) NULL,

	Order_Level_Coupon_X_Ref_GEP varchar(100) NULL,
	Order_Level_Coupon_GEP varchar(100) NULL,
	Order_Level_Promo_Campaigns_GEP varchar(100) NULL,
	Order_Level_Promo_Description_GEP varchar(120) NULL,
	Order_Level_Promo_End_Date_GEP date NULL,
	Order_Level_Promo_Message_GEP varchar(120) NULL,
	Order_Level_Promo_Redeem_Instructions_GEP varchar(120) NULL,
	Order_Level_Promo_Sales_Division_GEP varchar(10) NULL,
	Order_Level_Promo_Start_Date_GEP date NULL,
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
