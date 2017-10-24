SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_global_cube_proc 
	@StartMonth int = 201701, 
	@EndMonth int = 201701
AS

/******************************************************************************
**	File: 
**	Name: BRS_global_cube_proc
**	Desc: Pull Global Vendor Cube data
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@StartMonth -- if 0, use defaults  
**	@EndMonth 
**	
**
**	Auth: tmc
**	Date: 23 Oct 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------

*******************************************************************************/

BEGIN
	SET NOCOUNT ON;

	IF (@StartMonth = 0)
	BEGIN	
		SELECT     
			@StartMonth = YearFirstFiscalMonth_LY, 
			@EndMonth = PriorFiscalMonth
		FROM         
			BRS_Rollup_Support01
	END

	SELECT     
		t.FiscalMonth
		,MIN(f.YearNum)						AS YearNum
		,MIN(f.MonthNum)					AS MonthNum
		,t.SalesDivision					AS SalesDivision
		,t.AdjCode
		,t.HIST_SegCd						AS SegCd
		,t.HIST_MarketClass					AS MarketClass
		,MIN(m.MarketRollup_L3)				AS MarketClass_Rollup

		,MIN(glru.ReportingClass)			AS ReportingClass
		,'A'								AS TrxSrc
		,'SM.YTD.ACT'						AS Status

		,SUM(t.SalesAmt)					AS SalesAmt
		,CASE	WHEN MIN(glru.ReportingClass) = 'NSA' 
				THEN 0 
				ELSE SUM(t.GPAmt) 
		 END								AS GPAmt
		 ,SUM(t.ExtChargebackAmt)			AS ExtChargebackAmt

		,MIN(t.ID_MAX)						AS UniqueID

	FROM         

		BRS_AGG_CMBGAD_Sales AS t 

		INNER JOIN BRS_DS_GLBU_Rollup AS glru
		ON	t.GLBU_Class = glru.GLBU_Class

		INNER JOIN BRS_BusinessUnitClass as bu
		ON bu.GLBU_Class = t.GLBU_Class

		INNER JOIN BRS_FiscalMonth as f
		ON t.FiscalMonth = f.FiscalMonth

		INNER JOIN [BRS_CustomerMarketClass] m
		ON t.HIST_MarketClass = m.MarketClass
/*			
		INNER JOIN [BRS_Customer] c
		ON c.Shipto = t.Shipto

		INNER JOIN [BRS_CustomerGroup] cg
		ON cg.CustGrp = c.CustGrpWrk
*/		

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth) AND
--		(bu.GLBU_Class='TEETH') AND
--		(t.Shipto=1528737) AND
		(1=1)

	GROUP BY 
		t.FiscalMonth
		,t.GLBU_Class
		,t.AdjCode
		,t.SalesDivision 
		,t.HIST_MarketClass
		,t.HIST_SegCd 

END

GO


-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01

-- Run with PrioBRS_global_cube_procr Fiscal Month ref (results to text)
-- BRS_global_cube_proc 201612, 1

-- ORG = 29323 rows, 11 sec



