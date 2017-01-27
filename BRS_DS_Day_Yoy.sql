
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
--  23 Jan 17   tmc     Added Last day override logic to avoid over/under run
**    
*******************************************************************************/


SELECT     
	d.SalesDate, 
	doffset_ly.SalesDate           AS SalesDate_LY, 

	d.DayNumber, 
	doffset_ly.DayNumber           AS DayNumber_LY, 

	d.DaySeq, 
	doffset_ly.DaySeq              AS DaySeq_LY, 
    d.OffsetDaySeq_Yoy_Fiscal_Override,

	d.DayType, 
	doffset_ly.DayType             AS DayType_LY, 

	d.Comment, 
	doffset_ly.Comment              AS Comment_LY, 

    d.FiscalWeek,
    doffset_ly.FiscalWeek           AS FiscalWeek_LY,

    d.FiscalMonth,

    (m.YearNum-1)*100 + m.MonthNum  AS FiscalMonth_LY,      -- Adjusted PY  Fiscal Monthend
    doffset_ly.FiscalMonth          AS FiscalMonth_LY_ORG,  -- Original PY Fiscal Monthend

    m.MonthNum,
    m.QuarterNum,
    m.YearNum,
    m.FirstMonthSeqInQtr,
    m.FirstMonthSeqInYear,
    m.ME_FreeGoodsAct_LoadedInd,

	d.SalesWeighting01, 
	d.SalesWeighting02, 
	d.SalesWeighting03, 
	doffset_ly.SalesWeighting01    AS SalesWeighting01_LY, 
	doffset_ly.SalesWeighting02    AS SalesWeighting02_LY, 
	doffset_ly.SalesWeighting03    AS SalesWeighting03_LY, 

	d.StatusCd,
	doffset_ly.StatusCd            AS StatusCd_LY


FROM         
	BRS_SalesDay AS d 

    INNER JOIN BRS_FiscalMonth m
    ON m.FiscalMonth = d.FiscalMonth

    CROSS JOIN BRS_Config AS c

    INNER JOIN BRS_SalesDay doffset_ly

    ON doffset_ly.DaySeq = ISNULL(d.OffsetDaySeq_Yoy_Fiscal_Override, d.DaySeq - (c.OffsetDaySeq_Yoy_Fiscal + c.OffsetDaySeq_Yoy_Fiscal_SameDay))

--    ON d.DaySeq = doffset_ly.DaySeq + (c.OffsetDaySeq_Yoy_Fiscal + c.OffsetDaySeq_Yoy_Fiscal_SameDay)



WHERE 
    (1=1)   
 
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM BRS_DS_Day_Yoy where FiscalMonth between 201612 AND 201801
