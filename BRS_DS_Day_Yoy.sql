
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_DS_Day_Yoy]
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Day_Yoy
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
**	Date: 19 Jan 17
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

	d.StatusCd,

    d.FiscalMonth,

    doffset_ly.FiscalMonth         AS FiscalMonth_LY,
	doffset_ly.SalesDate           AS SalesDate_LY, 
	doffset_ly.DayNumber           AS DayNumber_LY, 
	doffset_ly.DaySeq              AS DaySeq_LY, 
	doffset_ly.DayType             AS DayType_LY, 
	doffset_ly.Comment             AS Comment_LY, 
	doffset_ly.SalesWeighting01    AS SalesWeighting01_LY, 
	doffset_ly.SalesWeighting02    AS SalesWeighting02_LY, 
	doffset_ly.SalesWeighting03    AS SalesWeighting03_LY, 
	doffset_ly.StatusCd            AS StatusCd_LY


FROM         
	BRS_SalesDay AS d 

    INNER JOIN BRS_FiscalMonth m
    ON m.FiscalMonth = d.FiscalMonth

    CROSS JOIN BRS_Config AS c

    INNER JOIN BRS_SalesDay doffset_ly
    ON d.DaySeq = doffset_ly.DaySeq + (c.OffsetDaySeq_Yoy_Fiscal + c.OffsetDaySeq_Yoy_Fiscal_SameDay)


WHERE 
    (1=1)   
 
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM BRS_DS_Day_Yoy Where (SalesDate = '26 dec 2015') ORDER BY 3
