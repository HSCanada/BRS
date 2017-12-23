
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
-- 22 Jan 17    tmc     Reverenced BRS_Rollup_Support01 for conistent logic
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

	dbo.BRS_FiscalMonth m

WHERE     

	(m.FiscalMonth BETWEEN (SELECT YearFirstFiscalMonth_LY FROM BRS_Rollup_Support01) AND (SELECT PriorFiscalMonth FROM BRS_Rollup_Support01) )

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM Periods
