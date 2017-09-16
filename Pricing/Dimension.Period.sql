
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Period]
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
*******************************************************************************/

SELECT

	fm.FiscalMonth
	,RTRIM(fm.MonthName) AS MonthName
	,fm.MonthNum
	,fm.QuarterNum
	,fm.YearNum

	,fm.WorkingDaysMonth
	,fm.MonthSeq
	,fm.FirstMonthSeqInQtr
	,fm.FirstMonthSeqInYear

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


-- SELECT  * FROM Dimension.Period
