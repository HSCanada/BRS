SELECT   
-- distinct  t.EnteredBy
 t.SalesOrderNumber, t.DocType, t.ID, t.EnteredBy, t.OrderTakenBy, t.OrderSourceCode, t.NetSalesAmt

FROM     BRS_TransactionDW AS t INNER JOIN
             zzzShipto AS s ON t.SalesOrderNumber = s.ST
WHERE 
DocType like 's%' and

 not EnteredBy in ('HSIWEB', 'GEPUSR') AND

 -- OrderTakenBy <> 'FSC' AND

--DocType = 'SE' AND
--EnteredBy <> 'HSIWEB' AND
-- EnteredBy = 'GEPUSR' AND

-- OrderTakenBy <> 'FSC' AND
(1 = 1)
--order by OrderTakenBy
 order by EnteredBy


SELECT   
-- distinct  t.EnteredBy
 t.SalesOrderNumber, t.EnteredBy, t.OrderTakenBy

FROM     BRS_TransactionDW AS t INNER JOIN
             zzzShipto AS s ON t.SalesOrderNumber = s.ST
WHERE 
-- DocType like 's%' and

 not EnteredBy in ('HSIWEB', 'GEPUSR') AND

 -- OrderTakenBy <> 'FSC' AND

--DocType = 'SE' AND
--EnteredBy <> 'HSIWEB' AND
-- EnteredBy = 'GEPUSR' AND

-- OrderTakenBy <> 'FSC' AND
(1 = 1)
--order by OrderTakenBy
 order by EnteredBy


UPDATE  BRS_TransactionDW
SET        EnteredBy = 'GEPUSR', OrderTakenBy = 'CUSTOMER'
FROM     BRS_TransactionDW INNER JOIN
             zzzShipto AS s ON BRS_TransactionDW.SalesOrderNumber = s.ST
WHERE   
--(NOT (BRS_TransactionDW.EnteredBy IN ('HSIWEB', 'GEPUSR'))) 
 (1 = 1)

select top 10 * from [Integration].[F5503_canned_message_file_parameters_Staging] where Q3DOCO_salesorder_number = 18414779

delete from [Integration].[F5503_canned_message_file_parameters_Staging] where Q3DOCO_salesorder_number = 18414779



-- add for GEP KPI model
-- 17 Sep 25


-- add GEP_Cohort_Code (customer)
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	GEP_Cohort_Code char(3)  NULL 
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add GEP_Order_Flag_ind (transDW)  (1min)

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW ADD
	GEP_Order_Flag_ind bit NOT NULL CONSTRAINT DF_BRS_TransactionDW_GEP_Order_Flag_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- cohort table add

-- drop TABLE pbi.gep_cohort

BEGIN TRANSACTION
GO
CREATE TABLE pbi.gep_cohort
	(
	GEP_Cohort_Code char(3) NOT NULL,
	GEP_Cohort nchar(10) NOT NULL,
	GEP_StartDate datetime NOT NULL,
	Comment nvarchar(50) NULL
	)  ON USERDATA
GO
ALTER TABLE pbi.gep_cohort ADD CONSTRAINT
	PK_gep_cohort PRIMARY KEY CLUSTERED 
	(
	GEP_Cohort_Code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE pbi.gep_cohort SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE pbi.gep_cohort ADD
	GEP_StartDate_LY datetime NULL
GO
ALTER TABLE pbi.gep_cohort ADD CONSTRAINT
	FK_gep_cohort_BRS_SalesDay1 FOREIGN KEY
	(
	GEP_StartDate_LY
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE pbi.gep_cohort SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

select * from [pbi].[gep_cohort]


-- cohort table populate

INSERT INTO [pbi].[gep_cohort]
           ([GEP_Cohort_Code]
           ,[GEP_Cohort]
           ,[GEP_StartDate]
		   ,[GEP_StartDate_LY]
           ,[Comment])
     VALUES
           ('CTL'
           ,'Control'
           ,'2025-06-23'
           ,'2024-06-24'

           ,'GW confirmed')
GO

INSERT INTO [pbi].[gep_cohort]
           ([GEP_Cohort_Code]
           ,[GEP_Cohort]
           ,[GEP_StartDate]
		   ,[GEP_StartDate_LY]
           ,[Comment])
     VALUES
           ('C01'
           ,'Cohort1'
           ,'2025-06-23'
           ,'2024-06-24'

           ,'GW confirmed')
GO

INSERT INTO [pbi].[gep_cohort]
           ([GEP_Cohort_Code]
           ,[GEP_Cohort]
           ,[GEP_StartDate]
		   ,[GEP_StartDate_LY]
           ,[Comment])
     VALUES
           ('C02'
           ,'Cohort2'
           ,'2025-06-30'
           ,'2024-07-01'
           ,'GW confirmed')
GO

INSERT INTO [pbi].[gep_cohort]
           ([GEP_Cohort_Code]
           ,[GEP_Cohort]
           ,[GEP_StartDate]
		   ,[GEP_StartDate_LY]
           ,[Comment])
     VALUES
           ('C03'
           ,'Cohort3'
           ,'2025-07-14 '
           ,'2024-07-15 '
           ,'GW confirmed')
GO

INSERT INTO [pbi].[gep_cohort]
           ([GEP_Cohort_Code]
           ,[GEP_Cohort]
           ,[GEP_StartDate]
		   ,[GEP_StartDate_LY]
           ,[Comment])
     VALUES
           ('C04'
           ,'Cohort4'
           ,'2025-07-28'
           ,'2024-07-29'

           ,'GW confirmed')
GO

INSERT INTO [pbi].[gep_cohort]
           ([GEP_Cohort_Code]
           ,[GEP_Cohort]
           ,[GEP_StartDate]
		   ,[GEP_StartDate_LY]
           ,[Comment])
     VALUES
           ('C05'
           ,'Cohort5'
           ,'2025-08-25'
           ,'2024-08-26'

           ,'GW confirmed')
GO

INSERT INTO [pbi].[gep_cohort]
           ([GEP_Cohort_Code]
           ,[GEP_Cohort]
           ,[GEP_StartDate]
		   ,[GEP_StartDate_LY]
           ,[Comment])
     VALUES
           ('C06'
           ,'Cohort6'
           ,'2025-09-15'
           ,'2024-09-16'
           ,'GW confirmed')
GO


INSERT INTO [pbi].[gep_cohort]
           ([GEP_Cohort_Code]
           ,[GEP_Cohort]
           ,[GEP_StartDate]
		   ,[GEP_StartDate_LY]
           ,[Comment])
     VALUES
           ('ZZZ'
           ,'no Cohort'
           ,'2026-12-26'
           ,'2026-12-26'

           ,'.')
GO

-- add RI
BEGIN TRANSACTION
GO
ALTER TABLE pbi.gep_cohort ADD CONSTRAINT
	FK_gep_cohort_BRS_SalesDay FOREIGN KEY
	(
	GEP_StartDate
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE pbi.gep_cohort SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


select * from [pbi].[gep_cohort]


/*
GEP_Cohort_Code coho_start
--------------- -----------------------
C01             2025-06-23  YES
C02             2025-06-30  YES
C03             2025-07-14  YES
C04             2025-07-28  YES
C05             2025-08-25  YES  
*/

-- cohort table RI

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_gep_cohort FOREIGN KEY
	(
	GEP_Cohort_Code
	) REFERENCES pbi.gep_cohort
	(
	GEP_Cohort_Code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- GEP_TimePeriod_cd table add
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDay ADD
	GEP_TimePeriod_cd char(2) NOT NULL CONSTRAINT DF_BRS_SalesDay_GEP_TimePeriod_cd DEFAULT 'ZZ'
GO
ALTER TABLE dbo.BRS_SalesDay SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- GEP_TimePeriod_cd table update

update [dbo].[BRS_SalesDay]
set GEP_TimePeriod_cd = 'AF'
where [SalesDate] between '2025-06-23' and '2025-12-28'
GO

update [dbo].[BRS_SalesDay]
set GEP_TimePeriod_cd = 'BF'
where [SalesDate] between '2025-03-30' and '2025-06-22'
GO

update [dbo].[BRS_SalesDay]
set GEP_TimePeriod_cd = 'ZZ'
where [SalesDate] between '2024-06-23' and '2024-12-28'

/*
update [dbo].[BRS_SalesDay]
set GEP_TimePeriod_cd = 'PY'
where [SalesDate] between '2024-06-23' and '2024-12-28'
*/

-- test
SELECT   SalesDate, DayNumber, GEP_TimePeriod_cd
FROM     BRS_SalesDay
WHERE   (SalesDate >= '2024-01-01')
ORDER BY SalesDate

--patch DW trans with GEP flag 
/*
SELECT   TOP (10) t.SalesOrderNumber, t.DocType, t.LineNumber, t.GEP_Order_Flag_ind, t.EnteredBy, t.OrderTakenBy, s.Note as doctype, s.Note2 as takenby, s.Note3 enterby, 1 as gep_ind
FROM     BRS_TransactionDW AS t INNER JOIN
             BRSales.dbo.zzzShipto AS s ON t.SalesOrderNumber = s.ST


-- set Trans GEP flag
UPDATE  
-- TOP (10) 
BRS_TransactionDW
SET        GEP_Order_Flag_ind = 1
-- , EnteredBy = s.Note3, OrderTakenBy = s.Note2
FROM     BRS_TransactionDW INNER JOIN
             BRSales.dbo.zzzShipto AS s ON BRS_TransactionDW.SalesOrderNumber = s.ST

*/

SELECT   TOP (10) BRS_Customer.ShipTo, BRS_Customer.GEP_Cohort_Code, s.Note2
FROM     BRS_Customer INNER JOIN
             BRSales.dbo.zzzShipto2 AS s ON BRS_Customer.ShipTo = s.ST


-- setup Customer 
UPDATE  
-- TOP (10) 
BRS_Customer
SET        GEP_Cohort_Code = s.Note2
FROM     BRS_Customer INNER JOIN
             BRSales.dbo.zzzShipto2 AS s ON BRS_Customer.ShipTo = s.ST


-- ID cohart start date

SELECT   TOP (10) BRS_TransactionDW.SalesOrderNumber, BRS_TransactionDW.DocType, BRS_TransactionDW.LineNumber, BRS_TransactionDW.Date, BRS_Customer.GEP_Cohort_Code, BRS_TransactionDW.GEP_Order_Flag_ind
FROM     BRS_TransactionDW INNER JOIN
             BRS_Customer ON BRS_TransactionDW.Shipto = BRS_Customer.ShipTo
where 
CalMonth >= 202506 and
GEP_Order_Flag_ind = 1
GO

-- test cohort start date using Trans
SELECT    BRS_Customer.GEP_Cohort_Code, BRS_TransactionDW.Date, sum(BRS_TransactionDW.NetSalesAmt) spend, count(*) lines, MIN(BRS_TransactionDW.Date) AS coho_start
FROM     BRS_TransactionDW INNER JOIN
             BRS_Customer ON BRS_TransactionDW.Shipto = BRS_Customer.ShipTo
WHERE   
(BRS_TransactionDW.CalMonth >= 202506) AND 
(BRS_TransactionDW.GEP_Order_Flag_ind = 1) AND 
BRS_Customer.GEP_Cohort_Code is not null and
(1=1)
GROUP BY BRS_Customer.GEP_Cohort_Code, BRS_TransactionDW.Date
order by 1,2 


SELECT   SalesDate, SalesDay, SalesDate_ORG, day_key, DaySeq, DayNumber, DayType, FiscalMonth, MonthName, MonthNum, QuarterName, YearNum, WorkingDaysMonth, MonthSeq, FirstMonthSeqInQtr, FirstMonthSeqInYear, FirstWeekSeqInDay, CalWeek, FiscWeekName, GEP_TimePeriod_cd
FROM     Dimension.Day


SELECT   SalesDate, day_key, CalWeek, FiscWeekName, FirstWeekSeqInDay, GEP_TimePeriod_cd
FROM     Dimension.Day
/*
-- last week
2025-09-12

2025-09-12

-- fist day AF
2025-06-22	6303	202526	Wk 26 2025	14921	BF

-- first day PY
2024-06-23	5569	202426	Wk 26 2024	14557	PY

test
14998
14634
-364
*/


-- add GEP_Order_Flag to ETL, DONE


BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_TransactionDW ADD
	GEP_Order_Flag char(10) NULL
GO
ALTER TABLE dbo.STAGE_BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
drop TABLE [dbo].[STAGE_BRS_TransactionDW]

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
	GEP_Order_Flag char(10) NULL,

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


--

select GEP_Order_Flag, convert(bit, GEP_Order_Flag) from [STAGE_BRS_TransactionDW]

select top 10 * from BRS_TransactionDW where date = '2025-09-19'

-- add 


SELECT   
 -- top 10
  distinct  t.OrderTakenBy
--	distinct EnteredBy
--  t.SalesOrderNumber, t.date, t.DocType, t.ID, t.shipto, t.EnteredBy, t.OrderTakenBy, t.OrderSourceCode, t.[CustomerPOText1], t.OriginalSalesOrderNumber, t.OriginalOrderDocumentType, t.NetSalesAmt

FROM     BRS_TransactionDW  t
WHERE 
GEP_Order_Flag_ind = 1 AND
OrderSourceCode = 'w' AND

-- EnteredBy in ('HSIWEB', 'GEPUSR') AND
--not [CustomerPOText1] like 'WEB%' AND

--OrderTakenBy = 'GEPUSR' and

(1=1)

order by netsalesamt desc



-- patch GEP to Customer, the logic & data has been thoroughly reviewed by Gary & Trevor 3 Oct 25
SELECT   
 -- top 10
--  distinct  t.OrderTakenBy
--	distinct EnteredBy
  t.SalesOrderNumber, t.date, t.DocType, t.ID, t.shipto, t.EnteredBy, t.OrderTakenBy, t.OrderSourceCode, t.[CustomerPOText1], t.OriginalSalesOrderNumber, t.OriginalOrderDocumentType, t.NetSalesAmt

FROM     BRS_TransactionDW  t
WHERE 
GEP_Order_Flag_ind = 1 AND
OrderSourceCode = 'w' AND

-- EnteredBy in ('HSIWEB', 'GEPUSR') AND
--not [CustomerPOText1] like 'WEB%' AND

OrderTakenBy <> 'CUSTOMER' and

(1=1)

UPDATE  BRS_TransactionDW
SET        OrderTakenBy = 'CUSTOMER'
WHERE   
	(GEP_Order_Flag_ind = 1) AND 
	(OrderSourceCode = 'w') AND 
	(OrderTakenBy <> 'CUSTOMER') AND 
	([CalMonth]=202510) AND
	(1 = 1)

-- ORG 13 809
