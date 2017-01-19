
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_DS_Config]
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Config
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
**	Date: 16 Feb 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	16 Feb 16	tmc		Added Holiday & Exception notes
--  19 Jan 17   tmc     Updated naming from BRS_Rollup_Support01 refactor
**    
*******************************************************************************/

SELECT     

	s.id, 
	s.SalesDate, 
	s.FiscalMonth, 
	s.DayNumber, 
	s.DayType, 
	s.DayStatusCd, 
	s.ExceptionCd, 
	s.ExceptionNote, 
	p.MonthName, 
	p.MonthNum, 
	p.QuarterNum, 
	p.YearNum, 
	p.LastWorkingDt, 
	s.PriorFiscalMonth, 

    --  19 Jan 17   tmc     Updated naming from BRS_Rollup_Support01 refactor
	s.YearFirstFiscalMonth,

--	16 Feb 16	tmc		Added Holiday & Exception notes
	s.DayComment

FROM         

	BRS_Rollup_Support01 AS s 

	INNER JOIN BRS_DS_Period AS p 
	ON s.FiscalMonth = p.FiscalMonth

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Select * from BRS_DS_Config
