-- Same Day logic

-- drop legacy fields DEV_APPLIED

ALTER TABLE dbo.BRS_Config
	DROP CONSTRAINT FK_BRS_Config_BRS_FiscalMonth3
GO

ALTER TABLE dbo.BRS_Config
	DROP CONSTRAINT DF_BRS_Config_PriorFiscalMonth1
GO
ALTER TABLE dbo.BRS_Config
	DROP CONSTRAINT DF_BRS_Config_DS_FreeGoodsEstInd_1
GO
ALTER TABLE dbo.BRS_Config
	DROP COLUMN FirstFiscalMonth, DS_FreeGoodsEstInd
GO

ALTER TABLE dbo.BRS_Config
	DROP CONSTRAINT FK_BRS_Config_BRS_SalesDay1
GO
ALTER TABLE dbo.BRS_Config
	DROP CONSTRAINT FK_BRS_Config_BRS_SalesDay2
GO
GO
ALTER TABLE dbo.BRS_Config
	DROP COLUMN FirstSalesDate_TY, FirstSalesDate_LY
GO

ALTER TABLE dbo.BRS_Config
	DROP CONSTRAINT FK_BRS_Config_BRS_FiscalMonth1
GO

ALTER TABLE dbo.BRS_Config
	DROP COLUMN FirstFiscalMonth_TY
GO

-- Drop legacy objects

DROP VIEW dbo.BRS_Rollup_Support02
go
 
DROP VIEW zzBRS_Rollup_Corporate_Legacy
GO

DROP VIEW zzBRS_Rollup_Corporate_SM_Dynamic
GO

DROP VIEW zzBRS_Rollup_Corporate_SM_Legacy
GO

DROP VIEW BRS_AGG_CMBGAD_Sales_DS
GO

DROP VIEW BRS_DS_AGG_CMBGAD_Sales
GO

DROP VIEW zzBRS_FiscalMonth_Rollup, zzBRS_MK_Scorecard_Cube, zzBRS_Rollup_VendorSales, zzBRS_SalesDay_Rollup, zzSTAGE_BRS_Transaction_LEG1, zzSTAGE_BRS_Transaction_LEG3, zzSTAGE_BRS_Transaction_LEGLoad


GO

DROP PROCEDURE BRS_DS_CubeAcq_proc
GO



-- Add offset field - DEV APPLIED

ALTER TABLE dbo.BRS_Config ADD
	HistorySummaryMonths smallint NOT NULL CONSTRAINT DF_BRS_Config_HistorySummaryMonths DEFAULT 0,
	OffsetDaySeq_Yoy_Fiscal smallint NOT NULL CONSTRAINT DF_BRS_Config_OffsetDaySeq_Yoy_Fiscal DEFAULT 0,
	OffsetDaySeq_Yoy_Fiscal_SameDay smallint NOT NULL CONSTRAINT DF_BRS_Config_OffsetDaySeq_Yoy_Fiscal_SameDay DEFAULT 0,
	OffsetDaySeq_Yoy_Fiscal_SameDay_Default smallint NOT NULL CONSTRAINT DF_BRS_Config_OffsetDaySeq_Yoy_Fiscal_SameDay_Default DEFAULT 0

GO

UPDATE    BRS_Config
SET              
    HistorySummaryMonths = 25,
    OffsetDaySeq_Yoy_Fiscal = 371, 
    OffsetDaySeq_Yoy_Fiscal_SameDay = 0, 
    OffsetDaySeq_Yoy_Fiscal_SameDay_Default = -7 

GO

ALTER TABLE dbo.BRS_Transaction ADD
	ExtChargebackAmt money NULL
GO

ALTER TABLE dbo.BRS_SalesDay ADD
	FiscalWeek int NOT NULL CONSTRAINT DF_BRS_SalesDay_FiscalWeek DEFAULT (0),
	FiscalQuarter int NOT NULL CONSTRAINT DF_BRS_SalesDay_FiscalQuarter DEFAULT 0,
	FiscalYear int NOT NULL CONSTRAINT DF_BRS_SalesDay_FiscalYear DEFAULT 0
GO

CREATE TABLE [dbo].[STAGE_BRS_SalesDay](
	[SalesDate] [datetime] NOT NULL,
	[FiscalWeek] [int] NULL ,
	[FiscalMonth] [int] NULL ,
	[FiscalQuarter] [int] NULL,
	[FiscalYear] [int] NULL ,
 CONSTRAINT [STAGE_BRS_SalesDay_c_pk] PRIMARY KEY NONCLUSTERED 
(
	[SalesDate] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE dbo.BRS_SalesDay ADD
	OffsetDaySeq_Yoy_Fiscal_Override smallint NULL
GO

-- Load Day / Month from excel (no work-around)

-- update fiscal months

UPDATE    BRS_SalesDay
SET              FiscalMonth = BRS_FiscalMonth.FiscalMonth
FROM         BRS_SalesDay CROSS JOIN
                      BRS_FiscalMonth
WHERE     (BRS_FiscalMonth.FiscalMonth BETWEEN 201801 AND 201812) AND (BRS_SalesDay.SalesDate BETWEEN BRS_FiscalMonth.BeginDt AND BRS_FiscalMonth.EndDt)

-- update weekss
UPDATE    BRS_SalesDay
SET              FiscalWeek = STAGE_BRS_SalesDay.FiscalWeek, FiscalQuarter = STAGE_BRS_SalesDay.FiscalQuarter, FiscalYear = STAGE_BRS_SalesDay.FiscalYear
FROM         STAGE_BRS_SalesDay INNER JOIN
                      BRS_SalesDay ON STAGE_BRS_SalesDay.SalesDate = BRS_SalesDay.SalesDate

-- Add 2018-20 Fiscal info for Fiscal Month and push to day ...
-- ADD 0 entry for map to nowhere
-- Set default dates based on DEV (manually added in dev)

-- Delete old Free Goods (22m)

DELETE FROM BRS_Transaction
WHERE     (FiscalMonth BETWEEN 201401 AND 201610) AND (DocType = 'AA') AND (AdjCode = 'FREEGD') AND (AdjNum <> 'AM-250') AND (AdjNote = 'FG.ACT.COM')


-- Fix bad dates
UPDATE    BRS_Transaction
SET              SalesDate = BRS_FiscalMonth.LastWorkingDt 

FROM         BRS_Transaction INNER JOIN
                      BRS_FiscalMonth ON BRS_Transaction.FiscalMonth = BRS_FiscalMonth.FiscalMonth
WHERE     (BRS_Transaction.SalesDate = CONVERT(DATETIME, '29 Jul 2016', 102)) AND (BRS_Transaction.FiscalMonth IN (201609, 201608))

/*
Fix 

1. BRS_Rollup_Support01
2. BRS_DS_Config

3. Merge using git
    BRS_DS_Cube_proc
    BRS_DS_CubeAcq_proc (prod final)
4. Delete 
    BRS_Rollup_Support02
    BRS_DS_Cube_proc

5. Apply Charback 201501 to currentt 
    Chargeback_Add

5.  Build Daily Summary AGG

6. Create 
    BRS_DS_Day_Yoy

7. Test / Fix DS depedancies using


SELECT OBJECT_NAME(OBJECT_ID),definition
FROM sys.sql_modules
WHERE definition LIKE '%' + 'BRS_AGG_CMBGAD_Sales_DS' + '%'
Order by 1


8. Update BRS_DS_CubeAcq_proc
rename Aqu to DScube in Git
Update dscube

9. Fix weeks 

SELECT     FiscalYear, FiscalWeek
FROM         BRS_SalesDay
GROUP BY FiscalYear, FiscalWeek
ORDER BY 1, 2

10.  Test rollup



-- Year by Month - Actual
SELECT     BRS_FiscalMonth.YearNum, MIN(BRS_FiscalMonth.BeginDt) AS fday, MAX(BRS_FiscalMonth.EndDt) AS lday, SUM(t.SalesAmt) AS sales
FROM         BRS_AGG_CMBGAD_Sales AS t INNER JOIN
                      BRS_FiscalMonth ON t.FiscalMonth = BRS_FiscalMonth.FiscalMonth
WHERE     (BRS_FiscalMonth.YearNum BETWEEN 2015 AND 2016)
GROUP BY BRS_FiscalMonth.YearNum

YearNum fday                    lday                    sales
------- ----------------------- ----------------------- ---------------------
2015    2014-12-28 00:00:00.000 2015-12-26 00:00:00.000 368803854.6937
2016    2015-12-27 00:00:00.000 2016-12-31 00:00:00.000 399109676.1745

-- Calc OffsetDaySeq_Yoy_Fiscal
SELECT     SalesDate, DaySeq
FROM         BRS_SalesDay
WHERE     (SalesDate = CONVERT(DATETIME, '2014-12-28 00:00:00', 102)) OR
                      (SalesDate = CONVERT(DATETIME, '2015-12-27 00:00:00', 102)) ORDER BY 1 DESC

SalesDate               DaySeq
----------------------- ------
2015-12-27 00:00:00.000 11456
2014-12-28 00:00:00.000 11092
                        00364      

-- Config YoY - Test  
SELECT     BRS_DS_Day_Yoy.YearNum, MIN(BRS_DS_Day_Yoy.SalesDate) AS fday, MAX(BRS_DS_Day_Yoy.SalesDate) AS lday, MIN(BRS_DS_Day_Yoy.SalesDate_LY) 
                      AS fday_ly, MAX(BRS_DS_Day_Yoy.SalesDate_LY) AS lday_ly
FROM         BRS_DS_Day_Yoy INNER JOIN
                      BRS_FiscalMonth ON BRS_DS_Day_Yoy.FiscalMonth_LY = BRS_FiscalMonth.FiscalMonth
GROUP BY BRS_DS_Day_Yoy.YearNum ORDER BY 1

YearNum fday                    lday                    fday_ly                 lday_ly
------- ----------------------- ----------------------- ----------------------- -----------------------
2016    2015-12-27 00:00:00.000 2016-12-31 00:00:00.000 2014-12-28 00:00:00.000 2015-12-26 00:00:00.000


-- Year by Day - Actual
SELECT     MIN(SalesDate) AS fday, MAX(SalesDate) AS lday, SUM(SalesAmt) AS sum
FROM         BRS_AGG_CDBGAD_Sales
WHERE     (SalesDate BETWEEN '2014-12-28' AND '2015-12-26')

fday                    lday                    sum
----------------------- ----------------------- ---------------------
2014-12-29 00:00:00.000 2015-12-26 00:00:00.000 368803854.6937


-- Year by Day - Mapped

SELECT     MIN(t.SalesDate) AS fday, MAX(t.SalesDate) AS lday, SUM(t.SalesAmt) AS sales
FROM         BRS_AGG_CDBGAD_Sales AS t INNER JOIN
                      BRS_DS_Day_Yoy AS m ON t.SalesDate = m.SalesDate_LY
WHERE     (m.SalesDate BETWEEN '2015-12-27' AND '2016-12-31')

fday                    lday                    sales
----------------------- ----------------------- ---------------------
2014-12-29 00:00:00.000 2015-12-26 00:00:00.000 368803854.6937


*/

