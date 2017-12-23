
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_DS_Day]
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Day
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
**    
*******************************************************************************/


SELECT     
	d.SalesDate, 
	d.DayNumber, 
	d.DaySeq, 
	d.DayType, 
	d.Comment, 
	d.SalesWeighting01, 
	d.SalesWeighting02, 
	d.SalesWeighting03, 
	d.StatusCd
FROM         

	BRS_SalesDay AS d 

	INNER JOIN BRS_Config AS c 
	ON d.FiscalMonth = c.FiscalMonth

WHERE     
	(d.DayType <> 'E')

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM [BRS_DS_Day]
