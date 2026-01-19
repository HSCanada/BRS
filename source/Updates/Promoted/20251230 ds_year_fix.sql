SELECT   s.id, s.SalesDate, s.FiscalMonth, s.DayNumber, s.DayType, s.DayStatusCd, s.ExceptionCd, s.ExceptionNote, p.MonthName, p.MonthNum, p.QuarterNum, p.YearNum, p.LastWorkingDt, s.PriorFiscalMonth, s.YearFirstFiscalMonth, s.DayComment, s.OffsetDaySeq_Yoy_Fiscal_SameDay
FROM     dbo.BRS_Rollup_Support01 AS s LEFT JOIN
             dbo.BRS_DS_Period AS p ON s.FiscalMonth = p.FiscalMonth


select * from dbo.BRS_DS_Period

select * from dbo.BRS_Rollup_Support01



SELECT   c.id, c.SalesDate, d.SalesDate_LY, c.FiscalMonth, pm.FiscalMonth AS FiscalMonth_LY, cy_jan.FiscalMonth AS YearFirstFiscalMonth, py_jan.FiscalMonth AS YearFirstFiscalMonth_LY, c.PriorFiscalMonth, c.SalesDateLastWeekly, d.DayNumber, d.DayType, d.StatusCd AS DayStatusCd, d.Comment AS DayComment, c.ExceptionCd, 
             c.ExceptionNote, d.DaySeq, cm.MonthSeq, cm.WorkingDaysMonth AS MonthWorkingDays, cm.LastWorkingDt AS MonthLastWorkingDt, cm.BeginDt AS MonthBeginDt, pm.BeginDt AS MonthBeginDt_LY, cm.FirstMonthSeqInYear AS YearFirstFiscalSeq, c.OffsetDaySeq_Yoy_Fiscal, c.OffsetDaySeq_Yoy_Fiscal_SameDay, 
             c.OffsetDaySeq_Yoy_Fiscal_SameDay_Default, hist.FiscalMonth AS YearFirstFiscalMonth_HIST
FROM     dbo.BRS_Config AS c 

LEFT JOIN dbo.BRS_DS_Day_Yoy AS d ON c.SalesDate = d.SalesDate 

INNER JOIN dbo.BRS_FiscalMonth AS cm ON c.FiscalMonth = cm.FiscalMonth 
INNER JOIN dbo.BRS_FiscalMonth AS cy_jan ON cm.FirstMonthSeqInYear = cy_jan.MonthSeq 
INNER JOIN dbo.BRS_FiscalMonth AS pm ON cm.MonthSeq - 12 = pm.MonthSeq 
INNER JOIN dbo.BRS_FiscalMonth AS py_jan ON cm.FirstMonthSeqInYear - 12 = py_jan.MonthSeq 
INNER JOIN dbo.BRS_FiscalMonth AS hist ON cm.FirstMonthSeqInYear - c.HistorySummaryMonths = hist.MonthSeq



--

SELECT   

d.OffsetDaySeq_Yoy_Fiscal_Override
,d.DaySeq 
,c.OffsetDaySeq_Yoy_Fiscal
,c.OffsetDaySeq_Yoy_Fiscal_SameDay
,'test-<' as test

,d.SalesDate, doffset_ly.SalesDate AS SalesDate_LY, d.DayNumber, doffset_ly.DayNumber AS DayNumber_LY, d.DaySeq, doffset_ly.DaySeq AS DaySeq_LY, d.OffsetDaySeq_Yoy_Fiscal_Override, d.DayType, doffset_ly.DayType AS DayType_LY, d.Comment, doffset_ly.Comment AS Comment_LY, d.FiscalWeek, 
             doffset_ly.FiscalWeek AS FiscalWeek_LY, d.FiscalMonth, (m.YearNum - 1) * 100 + m.MonthNum AS FiscalMonth_LY, doffset_ly.FiscalMonth AS FiscalMonth_LY_ORG, m.MonthNum, m.QuarterNum, m.YearNum, m.FirstMonthSeqInQtr, m.FirstMonthSeqInYear, m.ME_FreeGoodsAct_LoadedInd, d.SalesWeighting01, d.SalesWeighting02, 
             d.SalesWeighting03, doffset_ly.SalesWeighting01 AS SalesWeighting01_LY, doffset_ly.SalesWeighting02 AS SalesWeighting02_LY, doffset_ly.SalesWeighting03 AS SalesWeighting03_LY, d.StatusCd, doffset_ly.StatusCd AS StatusCd_LY
FROM     
dbo.BRS_SalesDay AS d 

INNER JOIN dbo.BRS_FiscalMonth AS m ON m.FiscalMonth = d.FiscalMonth 

CROSS JOIN dbo.BRS_Config AS c 

-- this
LEFT JOIN dbo.BRS_SalesDay AS doffset_ly ON doffset_ly.DaySeq = ISNULL(d.OffsetDaySeq_Yoy_Fiscal_Override, d.DaySeq - (c.OffsetDaySeq_Yoy_Fiscal + c.OffsetDaySeq_Yoy_Fiscal_SameDay))


WHERE   (1 = 1)

--
 BRS_SalesDay AS doffset_ly ON doffset_ly.DaySeq = ISNULL(d.OffsetDaySeq_Yoy_Fiscal_Override, d.DaySeq - (c.OffsetDaySeq_Yoy_Fiscal + c.OffsetDaySeq_Yoy_Fiscal_SameDay))



select * from BRS_Config


select OffsetDaySeq_Yoy_Fiscal_Override from dbo.BRS_SalesDay where OffsetDaySeq_Yoy_Fiscal_Override =0

UPDATE  BRS_SalesDay
SET        OffsetDaySeq_Yoy_Fiscal_Override = NULL
WHERE   (OffsetDaySeq_Yoy_Fiscal_Override = 0)