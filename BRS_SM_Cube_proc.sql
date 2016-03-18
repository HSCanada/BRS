SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_SM_Cube_proc  
	@nFiscalMonth as int = 0
AS

/******************************************************************************
**	File: 
**	Name: BRS_SM_Cube_proc 
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
**	@nFiscalMonth
**
**	Auth: tmc
**	Date: 18 Dec 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


Declare @nPriorFiscalMonth int, @nFirstFiscalMonth_TY int

SET NOCOUNT ON

 
Select
	@nPriorFiscalMonth		= CASE WHEN @nFiscalMonth=0 THEN PriorFiscalMonth		ELSE @nFiscalMonth END,
	@nFirstFiscalMonth_TY	= CASE WHEN @nFiscalMonth=0 THEN FirstFiscalMonth_TY	ELSE @nFiscalMonth END
FROM
	BRS_Rollup_Support02 g


--SM Grouped accounts at the ST Level - (SM.ST.ACT)' 

SELECT     
	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.SalesDivision, 

	MIN(cg.CustGrp) AS CustomerGroup,
	t.Shipto,
	t.FreeGoodsEstInd,
	t.OrderSourceCode,

	'A' AS TrxSrc, 

	MIN(t.HIST_MarketClass) AS HIST_MarketClass, 
	MIN(t.HIST_SegCd) AS HIST_SegCd, 
	MIN(t.HIST_Specialty) AS HIST_Specialty, 

	MIN(bu.ReportingClass) AS GLBU_ReportingClass,

	MIN(glru.GLBU_ClassDS_L1)AS DS_L1,
	MIN(glru.ReportingClass)AS ReportingClass,

	'SM.ST.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 

	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(t.GPAmt) END AS GPAmt, 

	MIN(t.ID_MAX) as UniqueID

FROM         

	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN BRS_BusinessUnitClass as bu
	ON bu.GLBU_Class = t.GLBU_Class

	INNER JOIN BRS_Customer AS c
	ON	t.ShipTo = c.ShipTo

	INNER JOIN BRS_CustomerGroup AS cg
	ON	c.CustGrpWrk = cg.CustGrp


WHERE
	(t.FiscalMonth between @nFirstFiscalMonth_TY AND @nPriorFiscalMonth) AND
	(cg.ReportInd = 1 ) AND
	(1=1)
	

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.Shipto
	,t.FreeGoodsEstInd
	,t.OrderSourceCode

UNION ALL


--SM Grouped accounts at the ST Level - (SM.ST.ACT)' 

SELECT     
	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.SalesDivision, 

	'OTHER' AS CustomerGroup,
	0 AS Shipto,

	t.FreeGoodsEstInd,
	t.OrderSourceCode,

	'A' AS TrxSrc, 

	t.HIST_MarketClass,
	t.HIST_SegCd,
	t.HIST_Specialty,

	bu.ReportingClass AS GLBU_ReportingClass,

	glru.GLBU_ClassDS_L1 AS DS_L1,
	glru.ReportingClass AS ReportingClass,

	'SM.OTH.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 

	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(t.GPAmt) END AS GPAmt, 

	MIN(t.ID_MAX) as UniqueID

FROM         

	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN BRS_BusinessUnitClass as bu
	ON bu.GLBU_Class = t.GLBU_Class

	INNER JOIN BRS_Customer AS c
	ON	t.ShipTo = c.ShipTo

	INNER JOIN BRS_CustomerGroup AS cg
	ON	c.CustGrpWrk = cg.CustGrp


WHERE
	(t.FiscalMonth between @nFirstFiscalMonth_TY AND @nPriorFiscalMonth) AND
	(cg.ReportInd = 0 ) AND
	(1=1)
	

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.FreeGoodsEstInd
	,t.OrderSourceCode

	,t.HIST_MarketClass
	,t.HIST_SegCd
	,t.HIST_Specialty

	,bu.ReportingClass 

	,glru.GLBU_ClassDS_L1
	,glru.ReportingClass


END

GO


-- Test Run
-- BRS_SM_Cube_proc  201412


