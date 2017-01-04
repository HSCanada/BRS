
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_Rollup_Support01]
AS

/******************************************************************************
**	File: 
**	Name: BRS_Rollup_Support01
**	Desc: Primary Sales lookup fields
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
--	16 Feb 16	tmc		Added Holiday & Exception notes
--	05 Apr 16	tmc		Add Global Free Goods Estimate logic 
**    
*******************************************************************************/


SELECT     
	c.id, 
	c.SalesDate, 
	cd.DayNumber, 
	cd.DaySeq AS SalesDateSeq, 
	c.FiscalMonth, 
	cm.MonthSeq AS FiscalMonthSeq, 
	cm.WorkingDaysMonth, 
	cm.LastWorkingDt, 
	tyd.DaySeq - lyd.DaySeq AS DaySeq_LY_OFFSET, 
	12 AS MonthSeq_LY_OFFSET, 
	c.FirstFiscalMonth_TY, 
	fm.MonthSeq AS FirstFiscalMonth_TY_Seq, 
	c.PriorFiscalMonth, 
	c.ExceptionCd, 
	c.ExceptionNote, 
	cd.DayType, 
	cd.StatusCd AS DayStatusCd, 
	cm.BeginDt AS FiscalMonthBeginDt,

--	16 Feb 16	tmc		Added Holiday & Exception notes
	cd.Comment AS DayComment,

--	05 Apr 16	tmc		Add Global Free Goods Estimate logic 
	c.DS_FreeGoodsEstInd

FROM         

	dbo.BRS_Config AS c 

	
	INNER JOIN dbo.BRS_SalesDay AS tyd 
	ON c.FirstSalesDate_TY = tyd.SalesDate 

	INNER JOIN dbo.BRS_SalesDay AS lyd 
	ON c.FirstSalesDate_LY = lyd.SalesDate 

	INNER JOIN dbo.BRS_SalesDay AS cd 
	ON c.SalesDate = cd.SalesDate 

	INNER JOIN dbo.BRS_FiscalMonth AS cm 
	ON c.FiscalMonth = cm.FiscalMonth 

	INNER JOIN dbo.BRS_FiscalMonth AS fm 
	ON c.FirstFiscalMonth_TY = fm.FiscalMonth

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_Rollup_Support01
