SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_PL_SM_Cube_proc 
	@nFiscalMonth_LY as int = 201612
AS

/******************************************************************************
**	File: 
**	Name: BRS_PL_SM_Cube_proc
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
**	@nFiscalMonth_LY
**
**	Auth: tmc
**	Date: 19 Dec 15
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	21 Dec 15	tmc		Refine fields and set NSA GP to 0    
--	12 Feb 16	tmc		Removed comment ref to legacy code
--	09 May 16	tmc		Added Adjustment for Free Goods
--	22 Jan 17   tmc     Referenced BRS_Rollup_Support01 for conistent logic
--	20 Feb 17	tmc		Updated for new 2017 SM P&L
--	22 Feb 17	tmc		Added Chargebacks to pull
--  23 Feb 17	tmc		Unsplit Teeth from AAD AAL
--	26 Feb 17	tmc		Add top Customer Group breakout

*******************************************************************************/

BEGIN
	SET NOCOUNT ON;


	Declare @nPriorFiscalMonth int, @nYearFirstFiscalMonth_LY int

	SET NOCOUNT ON
 
	Select
		@nYearFirstFiscalMonth_LY	= YearFirstFiscalMonth_LY,
		@nPriorFiscalMonth	= PriorFiscalMonth
	FROM
		BRS_Rollup_Support01 g

	SELECT     
		t.FiscalMonth
		,MIN(f.YearNum)						AS YearNum
		,MIN(f.MonthNum)					AS MonthNum
		,RTrim(t.HIST_SegCd) + ' -'
		 + MIN(glru.GLBU_ClassSM_L3)		AS lookup_key_sm
		,t.SalesDivision						AS SalesDivision
		,t.Branch
		,t.GLBU_Class
		,MIN(glru.GLBU_ClassSM_L3)			AS GLBU_Class_Rollup 
		,t.AdjCode
		,t.HIST_SegCd						AS SegCd
		,t.HIST_MarketClass					AS MarketClass
		,MIN(m.MarketRollup_L2)				AS MarketClass_Rollup

		,ISNULL(c_ly.HIST_SegCd,'')			AS SegCd_PY
		,ISNULL(c_ly.HIST_MarketClass, '')	AS MarketClass_PY
		,MIN(m_ly.MarketRollup_L2)			AS MarketClass_Rollup_PY

		,CASE WHEN cg.Report_SML3_ind = 1 THEN cg.CustGrp ELSE '' END AS CustGrp

		,@nFiscalMonth_LY					AS FiscalMonth_PY_Ref

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

		LEFT JOIN BRS_CustomerFSC_History AS c_ly
		ON c_ly.ShipTo = t.Shipto   AND
			c_ly.FiscalMonth = @nFiscalMonth_ly
			
		INNER JOIN [BRS_CustomerMarketClass] m_ly
		ON ISNULL(c_ly.HIST_MarketClass, '') = m_ly.MarketClass

		INNER JOIN [BRS_Customer] c
		ON c.Shipto = t.Shipto

		INNER JOIN [BRS_CustomerGroup] cg
		ON cg.CustGrp = c.CustGrpWrk
		

	WHERE
		(t.FiscalMonth between @nYearFirstFiscalMonth_LY AND @nPriorFiscalMonth) AND
--		(bu.GLBU_Class='TEETH') AND
		(1=1)

	GROUP BY 
		t.FiscalMonth
		,t.Branch
		,t.GLBU_Class
		,t.AdjCode
		,t.SalesDivision 
		,t.HIST_MarketClass
		,t.HIST_SegCd 
		,c_ly.HIST_MarketClass
		,c_ly.HIST_SegCd
		,CASE WHEN cg.Report_SML3_ind = 1 THEN cg.CustGrp ELSE '' END

END

GO


-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01

-- Run with PrioBRS_PL_SM_Cube_procr Fiscal Month ref (results to text)
-- BRS_PL_SM_Cube_proc 20112


