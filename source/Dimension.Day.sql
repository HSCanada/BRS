
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Day]
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
--	19 Sep 25	tmc		update model to support GEP KPI
*******************************************************************************/

SELECT
	CAST(d.SalesDate as Date) as SalesDate
	,d.[SalesDay]
	,d.SalesDate SalesDate_ORG
	,d.[day_key]
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
	,d.[CalWeek]
	,d.[FiscWeekName]

	--,d.GEP_TimePeriod_cd
	,CASE WHEN d_gep.GEP_TimePeriod_cd = 'AF' THEN 'PY' ELSE d.GEP_TimePeriod_cd END GEP_TimePeriod_cd

	--temp
	--,d_gep.GEP_TimePeriod_cd as GEP_TimePeriod_cd_LY
	--,d_gep.FiscalWeek AS FirstWeekSeqInDay_LY

--	, Select las

FROM
	BRS_SalesDay d

	-- GEP LY code:  pull in so we can use GEP arbitry time period (non-leap year)
	LEFT JOIN BRS_SalesDay d_gep
	-- constrain LY same as CY so that the offset logic works to constain PY last date
	ON (d.DaySeq)  = (d_gep.DaySeq - 364) AND
		d_gep.FiscalMonth >= (SELECT YearFirstFiscalMonth_HIST FROM BRS_Rollup_Support01) AND 
		d_gep.salesdate <= (SELECT [SalesDateLastWeekly] FROM [dbo].[BRS_Config]) AND
		(1=1)

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

-- SELECT  distinct GEP_TimePeriod_cd FROM Dimension.Day order by 1

 SELECT  count(*) FROM Dimension.Day 
-- ORG 1 021


