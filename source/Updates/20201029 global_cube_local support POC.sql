
BEGIN TRANSACTION
GO
ALTER TABLE hfm.account ADD
	HFM_Account_descr nvarchar(30) NOT NULL CONSTRAINT DF_account_HFM_Account_descr DEFAULT '',
	HFM_Account_key int identity(1,1) NOT NULL 
GO
ALTER TABLE hfm.account SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX account_idx_u_01 ON hfm.account
	(
	HFM_Account_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE hfm.account SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDivision ADD
	SalesDivision_key int identity(1,1) NOT NULL 
GO
ALTER TABLE dbo.BRS_SalesDivision SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX BRS_SalesDivision_idx_u_01 ON dbo.BRS_SalesDivision
	(
	SalesDivision_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_SalesDivision SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_SalesDay] ADD
	day_key int identity(1,1) NOT NULL 
GO
ALTER TABLE [dbo].[BRS_SalesDay] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX BRS_SalesDay_idx_u_03 ON [dbo].[BRS_SalesDay] 
	(
	day_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.[BRS_SalesDay] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--


SELECT
TOP (10) 
ShipTo, Billto, Customer, CustomerGroup, SalesPlan, SalesPlanCode, SalesPlanType, FieldSales, Branch, 
SalesDivision, MarketClass, Segment, Specialty, CustomerStatus, 
SalesDivisionCode, BranchCode, MarketClassCode, 
FscTerritoryCd

FROM            Dimension.Customer

-- in prod ->

-- setup finacial services dummy:  added to prod 5 Nov 20
INSERT INTO BRS_Item
                         (Item, ItemDescription, MajorProductClass)
VALUES        ('105ZZZZ','Finacial services','701')
GO

UPDATE
BRS_ItemCategory
SET
	note_txt ='map to finacial service, Scott, 5 Nov 20', 
	global_product_class = '930-10'
WHERE        (MinorProductClass LIKE '701%')
GO

insert into 
[dbo].[BRS_ItemHistory]
(
	[FiscalMonth]
	,[Item]
	,[Supplier]
	,[MinorProductClass]
	,[Label]
	,[Brand]
)
SELECT 
	f.[FiscalMonth]
	,[Item]
	,[Supplier]
	,[MinorProductClass]
	,[Label]
	,[Brand]
FROM BRS_Item i, 
[dbo].[BRS_FiscalMonth] f
WHERE 
	([item] = '105ZZZZ') AND
	(f.FiscalMonth between 201301 and 202010) AND
	(1=1)
GO


UPDATE       BRS_ItemHistory
SET
	[MinorProductClass]='701-**-**',
	[global_product_class]='930-10',
	[Excl_key] = 2
WHERE
(BRS_ItemHistory.Item = '105ZZZZ') AND 
(BRS_ItemHistory.FiscalMonth >= 201301)
GO

print '17. set Financial services dummy code - Transaction'
UPDATE       [dbo].[BRS_Transaction]
	SET Item = '105ZZZZ'
-- SELECT *
FROM
    [dbo].[BRS_Transaction]
WHERE
	([GLBU_Class]=  'LEASE') AND 
	-- ([GL_BusinessUnit] ='020019000000') AND
	(FiscalMonth BETWEEN 201301 AND 202010) AND
	(1=1)
GO
-- prod end
/*
SELECT top 10
	SalesDate_ORG
	,SalesDate
	,SalesDay
	,DayNumber
	,DayType
	,[CalWeek]
	,[FiscWeekName]

FROM
Dimension.Day 
order by 
SalesDate desc

SELECT
promotion_key
,PromotionCode
,PromotionDescription
,PromotionTrackingCode
,PromotionType
FROM
BRS_Promotion

*/