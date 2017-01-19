
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
--  19 Jan 17   tmc     Refactored date logic accomodate different YoY schemes
**    
*******************************************************************************/


SELECT    
	c.id, 
	c.SalesDate, 

	c.FiscalMonth, 
	c.PriorFiscalMonth, 

	cy_jan.FiscalMonth      AS YearFirstFiscalMonth,

	pd.SalesDate            AS SalesDate_LY,
	pm.FiscalMonth          AS FiscalMonth_LY, 

	py_jan.FiscalMonth      AS YearFirstFiscalMonth_LY, 

	cd.DayNumber,
	cd.DayType, 
	cd.StatusCd             AS DayStatusCd, 
	cd.Comment              AS DayComment,

	c.ExceptionCd, 
	c.ExceptionNote, 

--  Support fields

	cd.DaySeq,           

	cm.MonthSeq,          
	cm.WorkingDaysMonth     AS MonthWorkingDays, 

	cm.LastWorkingDt        AS MonthLastWorkingDt, 
	cm.BeginDt              AS MonthBeginDt,
	pm.BeginDt              AS MonthBeginDt_LY, 

	cm.FirstMonthSeqInYear  AS YearFirstFiscalSeq, 

	c.YoyOffsetDaySeq_Fiscal,
    c.YoyOffsetDaySeq_SameDay

FROM         

	dbo.BRS_Config AS c 
	
	INNER JOIN dbo.BRS_SalesDay AS cd 
	ON c.SalesDate = cd.SalesDate 

	INNER JOIN dbo.BRS_FiscalMonth AS cm 
	ON c.FiscalMonth = cm.FiscalMonth 

	INNER JOIN dbo.BRS_FiscalMonth AS cy_jan 
	ON (cm.FirstMonthSeqInYear) = cy_jan.MonthSeq

    -- Change Fiscal vs Sameday lookup logic here
	INNER JOIN dbo.BRS_SalesDay AS pd 
	ON (cd.DaySeq - c.YoyOffsetDaySeq_Fiscal) = pd.DaySeq 

	INNER JOIN dbo.BRS_FiscalMonth AS pm 
	ON (cm.MonthSeq - 12) = pm.MonthSeq 

	INNER JOIN dbo.BRS_FiscalMonth AS py_jan 
	ON (cm.FirstMonthSeqInYear - 12) = py_jan.MonthSeq

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_Rollup_Support01
