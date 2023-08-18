
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[CalendarMonth]
AS

/******************************************************************************
**	File: 
**	Name: Date
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 27 Sep 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	15 Aug 23	tmc		added current date to time to allow current month reporting
*******************************************************************************/

SELECT

	cal.CalMonth
	,RTRIM(cal.MonthName) AS MonthName
	,cal.MonthNum
	,'Q' + CAST(cal.QuarterNum AS char) AS QuarterName
	,cal.YearNum

	,cal.MonthSeq
	,cal.FirstMonthSeqInQtr
	,cal.FirstMonthSeqInYear


FROM
	[dbo].[BRS_CalMonth] AS cal 


WHERE
	cal.CalMonth BETWEEN 
		(SELECT YearFirstFiscalMonth_HIST FROM BRS_Rollup_Support01) AND 
		(SELECT FiscalMonth FROM BRS_Rollup_Support01)
--		(SELECT PriorFiscalMonth FROM BRS_Rollup_Support01)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Select FiscalMonth, PriorFiscalMonth, YearFirstFiscalMonth_HIST FROM BRS_Rollup_Support01

-- SELECT  * FROM Dimension.CalendarMonth
