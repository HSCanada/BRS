
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_TS_Period]
AS

/******************************************************************************
**	File: 
**	Name: BRS_TS_Period
**	Desc:  
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
**	Date: 11 Oct 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	29 Dec 16	tmc		moved from prior monthend to current month (weekly upd)
**	28 Apr 21	tmc		added covid correction to start at 2019
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
	-- temp start 201901 for covid
	(m.FiscalMonth BETWEEN (SELECT FirstFiscalMonth_LY - 100 FROM BRS_TS_Config) AND 
							(SELECT FiscalMonth FROM BRS_TS_Config) )


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_TS_Period
