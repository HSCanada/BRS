
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
**    
*******************************************************************************/

SELECT     
	c.SalesDateLastWeekly, 
	d.FiscalMonth, 
	c.PriorFiscalMonth,
	(c.FirstFiscalMonth_TY-100) AS FirstFiscalMonth_LY,
	d.DayType, 
	d.DayNumber, 
	m.WorkingDaysMonth

FROM         
	BRS_Config c INNER JOIN

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
