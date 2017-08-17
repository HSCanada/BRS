
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
**	31 Jul 17	tmc		change from daily to monthly    
*******************************************************************************/

SELECT

	fm.FiscalMonth,
	fm.MonthNum,
	fm.MonthName,
	fm.MonthSeq,
	fm.WorkingDaysMonth,

	fm.QuarterNum,
	fm.FirstMonthSeqInQtr,
	fm.YearNum,
	fm.FirstMonthSeqInYear

FROM
	BRS_FiscalMonth AS fm 


WHERE
	-- temp
	fm.FiscalMonth BETWEEN 201401 AND 201706
	
   

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT * FROM Dimension.Date
