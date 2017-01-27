
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_Rollup_Support01]
AS

/******************************************************************************
**	File: 
**	Name: BRS_Rollup_Support01
**	Desc: Date logic for YoY analysis
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 16 Dec 15
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	16 Feb 16	tmc		Added Holiday & Exception notes
--	05 Apr 16	tmc		Add Global Free Goods Estimate logic 
--  22 Jan 17   tmc     Refactored date logic accomodate different YoY schemes
**    
*******************************************************************************/


SELECT    
	c.id, 
	c.SalesDate, 
	d.SalesDate_LY,

	c.FiscalMonth, 
	pm.FiscalMonth          AS FiscalMonth_LY, 

	cy_jan.FiscalMonth      AS YearFirstFiscalMonth,
	py_jan.FiscalMonth      AS YearFirstFiscalMonth_LY, 

	c.PriorFiscalMonth, 
    c.SalesDateLastWeekly,

	d.DayNumber,
	d.DayType, 
	d.StatusCd             AS DayStatusCd, 
	d.Comment              AS DayComment,
	c.ExceptionCd, 
	c.ExceptionNote, 

--  Support fields

	d.DaySeq,           

	cm.MonthSeq,          
	cm.WorkingDaysMonth     AS MonthWorkingDays, 

	cm.LastWorkingDt        AS MonthLastWorkingDt, 
	cm.BeginDt              AS MonthBeginDt,
	pm.BeginDt              AS MonthBeginDt_LY, 

	cm.FirstMonthSeqInYear  AS YearFirstFiscalSeq, 

	c.OffsetDaySeq_Yoy_Fiscal,
    c.OffsetDaySeq_Yoy_Fiscal_SameDay,
    c.OffsetDaySeq_Yoy_Fiscal_SameDay_Default,

    hist.FiscalMonth        AS YearFirstFiscalMonth_HIST    

FROM         

	dbo.BRS_Config AS c 
	
	INNER JOIN BRS_DS_Day_Yoy AS d 
	ON c.SalesDate = d.SalesDate 

	INNER JOIN dbo.BRS_FiscalMonth AS cm 
	ON c.FiscalMonth = cm.FiscalMonth 

	INNER JOIN dbo.BRS_FiscalMonth AS cy_jan 
	ON (cm.FirstMonthSeqInYear) = cy_jan.MonthSeq

	INNER JOIN dbo.BRS_FiscalMonth AS pm 
	ON (cm.MonthSeq - 12) = pm.MonthSeq 

	INNER JOIN dbo.BRS_FiscalMonth AS py_jan 
	ON (cm.FirstMonthSeqInYear - 12) = py_jan.MonthSeq

	INNER JOIN dbo.BRS_FiscalMonth AS hist
	ON (cm.FirstMonthSeqInYear - c.HistorySummaryMonths) = hist.MonthSeq

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_Rollup_Support01
