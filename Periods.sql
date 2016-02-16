
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[Periods]
AS

/******************************************************************************
**	File: 
**	Name: Periods
**	Desc: Used for Power Pivot Finacial calendar reporting
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
**	Date: 16 Feb 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT     

	m.FiscalMonth AS Period, 
	m.YearNum AS Year, 
	m.QuarterNum AS Qtr, 
	m.MonthNum AS Month, 
	m.WorkingDaysMonth AS WorkingDays, 
	m.MonthSeq AS PeriodID, 
	m.FirstMonthSeqInYear AS FirstPeriodInYear, 
	m.FirstMonthSeqInQtr AS FirstPeriodInQtr, 
	m.BeginDt, 
	m.EndDt, 
	m.MonthName

FROM         

	dbo.BRS_FiscalMonth m CROSS JOIN
	dbo.BRS_Config c

WHERE     

	(m.FiscalMonth BETWEEN c.FirstFiscalMonth AND c.PriorFiscalMonth)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM Periods