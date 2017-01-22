
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_TS_Config]
AS

/******************************************************************************
**	File: 
**	Name: BRS_TS_Config
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
**	Date: 29 Dec 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
-- 22 Jan 17    tmc     Reverenced BRS_Rollup_Support01 for conistent logic
**    
*******************************************************************************/

SELECT     
	c.SalesDateLastWeekly, 
	d.FiscalMonth, 
	c.PriorFiscalMonth,
	c.YearFirstFiscalMonth_LY AS FirstFiscalMonth_LY,
	d.DayType, 
	d.DayNumber, 
	m.WorkingDaysMonth

FROM         
	BRS_Rollup_Support01 c INNER JOIN

	BRS_SalesDay AS d 
	ON c.SalesDateLastWeekly = d.SalesDate 

	INNER JOIN BRS_FiscalMonth AS m 
	ON d.FiscalMonth = m.FiscalMonth

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_TS_Config
