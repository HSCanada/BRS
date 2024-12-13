
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Day]
AS

/******************************************************************************
**	File: 
**	Name: [Dimension].[Day]
**	Desc: Fiscal Day with Fiscal month rollups (add cal, re US?)
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
**	Date: 15 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	31 Jul 17	tmc		change from daily to monthly    
**	29 Aug 17	tmc		change to dynamic dat
**  14 Sep 17	tmc		renamed to Period
--	22 Feb 18	tmc		copied from Period and converted to day
--	15 Nov 18	tmc		Add fiscal week logic
*******************************************************************************/

SELECT
	CAST(d.SalesDate as Date) as SalesDate
	,[SalesDay]
	,d.SalesDate SalesDate_ORG
	,[day_key]
	,d.DaySeq
	,d.DayNumber
	,d.DayType
	,fm.FiscalMonth
	,RTRIM(fm.MonthName) AS MonthName
	,fm.MonthNum
	,'Q' + CAST(fm.QuarterNum AS char)	AS QuarterName
	,fm.YearNum

	,fm.WorkingDaysMonth
	,fm.MonthSeq
	,fm.FirstMonthSeqInQtr
	,fm.FirstMonthSeqInYear
	,d.FiscalWeek						AS FirstWeekSeqInDay
	,[CalWeek]
	,[FiscWeekName]

FROM
	BRS_SalesDay d

	INNER JOIN BRS_FiscalMonth AS fm 
	on d.FiscalMonth = fm.FiscalMonth


WHERE
	d.FiscalMonth >= (SELECT YearFirstFiscalMonth_HIST FROM BRS_Rollup_Support01) AND 
	d.salesdate <= (SELECT [SalesDateLastWeekly] FROM [dbo].[BRS_Config]) AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Select PriorFiscalMonth, YearFirstFiscalMonth_HIST FROM BRS_Rollup_Support01

-- SELECT  top 10 * FROM Dimension.Day order by 1 desc
-- SELECT  * FROM Dimension.Day where FirstWeekSeqInDay = 12499
