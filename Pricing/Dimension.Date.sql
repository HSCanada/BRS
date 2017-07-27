
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Date]
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
**    
*******************************************************************************/

SELECT

	d.SalesDate			AS DateKey,
	d.DayNumber,
	d.DayType,
	d.DaySeq,

	d.FiscalWeek,
	d.FiscalMonth,
	fm.MonthNum,
	fm.MonthName,
	fm.MonthSeq,
	fm.WorkingDaysMonth,

	fm.QuarterNum,
	fm.FirstMonthSeqInQtr,
	fm.YearNum,
	fm.FirstMonthSeqInYear

FROM
	BRS_SalesDay AS d 

	INNER JOIN BRS_FiscalMonth AS fm 
	ON d.FiscalMonth = fm.FiscalMonth

WHERE
	d.SalesDate <= (Select SalesDateLastWeekly from BRS_Config)
	
   

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT * FROM Dimension.Date
