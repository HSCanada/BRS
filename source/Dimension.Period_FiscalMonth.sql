
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Period]
AS

/******************************************************************************
**	File: 
**	Name: [Dimension].[Period]
**	Desc:  Fiscal Month
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
**	24 Apr 24	tmc		add inside sales quarter gowth support
*******************************************************************************/

SELECT

	fm.FiscalMonth
	,RTRIM(fm.MonthName) AS MonthName
	,fm.MonthNum
	,'Q' + CAST(fm.QuarterNum AS char) AS QuarterName
	,fm.YearNum

	,fm.WorkingDaysMonth
	,fm.MonthSeq
	,fm.FirstMonthSeqInQtr
	,fm.FirstMonthSeqInYear
	,CAST(fm.LastWorkingDt as date)		AS LastWorkingDay

	-- this code maps prior year quarters to current quarter so that we can compare QoQ using current ISR reps
	,(((select PriorFiscalMonth / 100 from BRS_Rollup_Support01) - fm.YearNum) * 12) + fm.FirstMonthSeqInQtr  as RetroFirstMonthSeqInQtr

FROM
	BRS_FiscalMonth AS fm 


WHERE
	fm.FiscalMonth BETWEEN 
		(SELECT YearFirstFiscalMonth_HIST FROM BRS_Rollup_Support01) AND 
		(SELECT PriorFiscalMonth FROM BRS_Rollup_Support01)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Select PriorFiscalMonth, YearFirstFiscalMonth_HIST FROM BRS_Rollup_Support01

-- SELECT  * FROM Dimension.Period order by 1 desc

 -- update BRS_Config set PriorFiscalMonth = 202404

 -- test retro logic
 /*
 SELECT  * FROM Dimension.Period p
 left join Dimension.Period pp on p.RetroFirstMonthSeqInQtr = pp.MonthSeq
 order by 1 desc
 */
--select * from BRS_Rollup_Support01