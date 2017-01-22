
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_DS_Period]
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Period
**	Desc:   Show months in current and last month, based on FiscalMonth
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
**    
*******************************************************************************/

SELECT     

	m.FiscalMonth, 
	m.MonthNum, 
	m.MonthName, 
	m.QuarterNum, 
	m.YearNum, 
	m.WorkingDaysMonth, 
	m.MonthSeq, 
	m.FirstMonthSeqInQtr, 
	m.FirstMonthSeqInYear, 
	m.LastWorkingDt


FROM         

	BRS_FiscalMonth AS m 

	CROSS JOIN BRS_Config AS c

WHERE     
	(m.YearNum BETWEEN c.FiscalMonth / 100 - 1 AND c.FiscalMonth / 100)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_DS_Period
