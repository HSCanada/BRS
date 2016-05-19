SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_PL_SM_Cube_proc 
	@nFiscalMonth_LY as int = 201412
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
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


Declare @nPriorFiscalMonth int, @nFirstFiscalMonth_TY int

SET NOCOUNT ON
 
Select
	@nPriorFiscalMonth		= PriorFiscalMonth,
	@nFirstFiscalMonth_TY	= FirstFiscalMonth_TY
FROM
	BRS_Rollup_Support02 g

SELECT     
	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
--	09 May 16	tmc		Added Adjustment for Free Goods
	t.AdjCode, 

	t.SalesDivision, 
	'A' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd, 

	ISNULL(c_ly.HIST_MarketClass, '') as MarketClass_PY, 
	ISNULL(c_ly.HIST_SegCd,'') as SegCd_PY,

	MIN(bu.ReportingClass) AS GLBU_ReportingClass,

	MIN(glru.GLBU_ClassDS_L1)AS DS_L1,
	MIN(glru.ReportingClass)AS ReportingClass,

	'SM.YTD.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 

	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(t.GPAmt) END AS GPAmt, 

	@nFiscalMonth_LY AS FiscalMonth_PY_Ref,
	MIN(t.ID_MAX) as UniqueID

FROM         

	BRS_AGG_CMBGAD_Sales AS t 


	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN BRS_BusinessUnitClass as bu
	ON bu.GLBU_Class = t.GLBU_Class

	LEFT JOIN BRS_CustomerFSC_History AS c_ly
	ON c_ly.ShipTo = t.Shipto   AND
		c_ly.FiscalMonth = @nFiscalMonth_LY

WHERE
	t.FiscalMonth between @nFirstFiscalMonth_TY AND @nPriorFiscalMonth

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



END

GO


-- Run with Prior Fiscal Month ref (results to text)
-- BRS_PL_SM_Cube_proc 201512

-- BRS_PL_SM_Cube_proc 201412

