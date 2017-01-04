
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_Rollup_Support02]
AS

/******************************************************************************
**	File: 
**	Name: BRS_Rollup_Support02
**	Desc:  Secondary Sales lookup fields
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
--	05 Apr 16	tmc		Add Global Free Goods Estimate logic 
**    
*******************************************************************************/

SELECT     
	g.id, 
	g.SalesDate, 
	g.FiscalMonth, 
	g.FirstFiscalMonth_TY, 

	d.SalesDate AS SalesDate_LY, 
--  04 Jan 17	tmc		Add LY Override date logic for testing.  DO NOT USE in production.
--	CAST ('29 Dec 15' as datetime) AS SalesDate_LY, 

	m.FiscalMonth AS FiscalMonth_LY, 
	m2.FiscalMonth AS FirstFiscalMonth_LY, 
	g.DayNumber, 
	g.WorkingDaysMonth, 
	g.PriorFiscalMonth, 
	m.BeginDt AS FiscalMonthBeginDt_LY, 
	g.FiscalMonthBeginDt,
--	05 Apr 16	tmc		Add Global Free Goods Estimate logic 
	g.DS_FreeGoodsEstInd
FROM         

	dbo.BRS_Rollup_Support01 AS g 

	INNER JOIN dbo.BRS_SalesDay AS d 
	ON g.SalesDateSeq - g.DaySeq_LY_OFFSET = d.DaySeq 

	INNER JOIN dbo.BRS_FiscalMonth AS m 
	ON g.FiscalMonthSeq - g.MonthSeq_LY_OFFSET = m.MonthSeq 

	INNER JOIN dbo.BRS_FiscalMonth AS m2 
	ON g.FirstFiscalMonth_TY_Seq - g.MonthSeq_LY_OFFSET = m2.MonthSeq

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_Rollup_Support02
