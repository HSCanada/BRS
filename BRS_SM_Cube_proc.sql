SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_SM_Cube_proc  
	@nDebug int = 1
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
--	19 Mar 16	tmc		Added MTD and PY MTD logic
--	21 Mar 16	tmc		Minor change to test GIT
--  06 May 16	tmc		Replaced Free Goods flag with Adjustments
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Declare @dtSalesDay datetime,  @dtSalesDay_PY datetime
Declare @nFiscalMonth int, @nFiscalMonth_PY int
Declare @nFirstFiscalMonth int, @nPriorFiscalMonth int
Declare @nFirstFiscalMonth_PY int, @nPriorFiscalMonth_PY int 

 
Select
	@dtSalesDay				= SalesDate,
	@dtSalesDay_PY			= SalesDate_LY,

	@nFiscalMonth			= FiscalMonth,
	@nFiscalMonth_PY		= FiscalMonth_LY,

	@nFirstFiscalMonth		= FirstFiscalMonth_TY,
	@nFirstFiscalMonth_PY	= FirstFiscalMonth_LY,

	@nPriorFiscalMonth		= PriorFiscalMonth,
	@nPriorFiscalMonth_PY	= (PriorFiscalMonth-100)
FROM
	BRS_Rollup_Support02 g

if (@nDebug <> 0 )
Begin

	Print @dtSalesDay				
	Print @nFirstFiscalMonth		
	Print @nPriorFiscalMonth		
	Print @nFiscalMonth			
	Print ''
	Print @dtSalesDay_PY			
	Print @nFirstFiscalMonth_PY	
	Print @nPriorFiscalMonth_PY	
	Print @nFiscalMonth_PY		

End


-- '1. MTD CY - Actual from Detail - (CY.MTD.ST.SM)'
SELECT     
	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 
	t.SalesDivision, 

	t.Shipto,

	t.AdjCode,
--	CASE WHEN t.NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and bu.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END AS FreeGoodsEstInd,
	t.OrderSourceCode,
	'A' AS TrxSrc, 

	-- Use Current Seg as MTD is dynamic
	MIN(c.MarketClass) AS MarketClass, 
	MIN(c.SegCd) AS SegCd, 
	MIN(c.Specialty) AS Specialty, 

	MIN(bu.ReportingClass) AS GLBU_ReportingClass,

	MIN(glru.GLBU_ClassDS_L1) AS DS_L1,
	MIN(glru.ReportingClass) AS ReportingClass,

	'CY.MTD.ST.SM' AS Status,


	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 

	@dtSalesDay AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t

	INNER JOIN dbo.BRS_DocType as dt
	ON t.DocType = dt.DocType
 

	INNER JOIN BRS_BusinessUnitClass as bu
	ON bu.GLBU_Class = t.GLBU_Class

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_CustomerGroup AS cg
	ON	c.CustGrpWrk = cg.CustGrp

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN BRS_ItemMPC AS mpc 
	ON t.MajorProductClass= mpc.MajorProductClass


WHERE
	(t.SalesDate <= @dtSalesDay) AND 
	(t.FiscalMonth = @nFiscalMonth) AND 
	(cg.ReportInd = 1 ) AND
	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.Shipto
--	,CASE WHEN t.NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and bu.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END
	,t.OrderSourceCode

UNION ALL


-- '2. MTD CY - Actual from Detail - (CY.MTD.OTHER.SM)'
SELECT     
	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 
	t.SalesDivision, 

	0 AS Shipto,

	t.AdjCode,
--	CASE WHEN t.NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and bu.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END AS FreeGoodsEstInd,

	t.OrderSourceCode,
	'A' AS TrxSrc, 

	-- Use Current Seg as MTD is dynamic
	c.MarketClass AS MarketClass, 
	c.SegCd AS SegCd, 
	c.Specialty AS Specialty, 

	MIN(bu.ReportingClass) AS GLBU_ReportingClass,

	MIN(glru.GLBU_ClassDS_L1) AS DS_L1,
	MIN(glru.ReportingClass) AS ReportingClass,

	'CY.MTD.OTHER.SM' AS Status,


	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 

	@dtSalesDay AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t

	INNER JOIN dbo.BRS_DocType as dt
	ON t.DocType = dt.DocType
 

	INNER JOIN BRS_BusinessUnitClass as bu
	ON bu.GLBU_Class = t.GLBU_Class

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_CustomerGroup AS cg
	ON	c.CustGrpWrk = cg.CustGrp

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN BRS_ItemMPC AS mpc 
	ON t.MajorProductClass= mpc.MajorProductClass


WHERE
	(t.SalesDate <= @dtSalesDay) AND 
	(t.FiscalMonth = @nFiscalMonth) AND 
	(cg.ReportInd = 0 ) AND
	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

--	,CASE WHEN t.NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and bu.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END
	,t.OrderSourceCode

	,c.Specialty
	,c.SegCd
	,c.MarketClass

UNION ALL

-- '3. MTD PY - Actual from Detail - (PY.MTD.ST.SM)' 
SELECT     
	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 
	t.SalesDivision, 

	t.Shipto,

	t.AdjCode,
--	CASE WHEN t.NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and bu.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END AS FreeGoodsEstInd,

	t.OrderSourceCode,
	'A' AS TrxSrc, 

	-- Use Current Seg as MTD is dynamic
	MIN(ch.HIST_MarketClass) AS MarketClass, 
	MIN(ch.HIST_SegCd) AS SegCd, 
	MIN(ch.HIST_Specialty) AS Specialty, 

	MIN(bu.ReportingClass) AS GLBU_ReportingClass,

	MIN(glru.GLBU_ClassDS_L1) AS DS_L1,
	MIN(glru.ReportingClass) AS ReportingClass,

	'PY.MTD.ST.SM' AS Status,


	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 

	@dtSalesDay AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t

	INNER JOIN dbo.BRS_DocType as dt
	ON t.DocType = dt.DocType
 

	INNER JOIN BRS_BusinessUnitClass as bu
	ON bu.GLBU_Class = t.GLBU_Class

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_CustomerGroup AS cg
	ON	c.CustGrpWrk = cg.CustGrp

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN BRS_ItemMPC AS mpc 
	ON t.MajorProductClass= mpc.MajorProductClass

	INNER JOIN BRS_CustomerFSC_History AS ch 
	ON ch.ShipTo = t.Shipto   AND
		ch.FiscalMonth = t.FiscalMonth


WHERE
	(t.SalesDate <= @dtSalesDay_PY) AND 
	(t.FiscalMonth = @nFiscalMonth_PY) AND 
	(cg.ReportInd = 1 ) AND
	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.Shipto
--	,CASE WHEN t.NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and bu.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END
	,t.OrderSourceCode

UNION ALL


-- '4. MTD PY - Actual from Detail - (PY.MTD.OTHER.SM)'
SELECT     
	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 
	t.SalesDivision, 

	0 AS Shipto,

	t.AdjCode,
--	CASE WHEN t.NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and bu.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END AS FreeGoodsEstInd,

	t.OrderSourceCode,
	'A' AS TrxSrc, 

	-- Use Historic Seg as PY MTD
	ch.HIST_MarketClass AS MarketClass, 
	ch.HIST_SegCd AS SegCd, 
	ch.HIST_Specialty AS Specialty, 

	MIN(bu.ReportingClass) AS GLBU_ReportingClass,

	MIN(glru.GLBU_ClassDS_L1) AS DS_L1,
	MIN(glru.ReportingClass) AS ReportingClass,

	'PY.MTD.OTHER.SM' AS Status,


	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 

	@dtSalesDay AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t

	INNER JOIN dbo.BRS_DocType as dt
	ON t.DocType = dt.DocType
 

	INNER JOIN BRS_BusinessUnitClass as bu
	ON bu.GLBU_Class = t.GLBU_Class

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_CustomerGroup AS cg
	ON	c.CustGrpWrk = cg.CustGrp

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN BRS_ItemMPC AS mpc 
	ON t.MajorProductClass= mpc.MajorProductClass

	INNER JOIN BRS_CustomerFSC_History AS ch 
	ON ch.ShipTo = t.Shipto   AND
		ch.FiscalMonth = t.FiscalMonth


WHERE
	(t.SalesDate <= @dtSalesDay_PY) AND 
	(t.FiscalMonth = @nFiscalMonth_PY) AND 
	(cg.ReportInd = 0 ) AND
	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode

	,t.SalesDivision
--	,CASE WHEN t.NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and bu.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 THEN 1 ELSE 0 END
	,t.OrderSourceCode

	,ch.HIST_Specialty
	,ch.HIST_SegCd
	,ch.HIST_MarketClass

UNION ALL
--5. SM Grouped accounts at the ST Level - (HIST.ST.ACT)' 

SELECT     
	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.SalesDivision, 

	t.Shipto,

	t.AdjCode,
--	t.FreeGoodsEstInd,

	t.OrderSourceCode,
	'A' AS TrxSrc, 

	MIN(t.HIST_MarketClass) AS MarketClass, 
	MIN(t.HIST_SegCd) AS SegCd, 
	MIN(t.HIST_Specialty) AS Specialty, 

	MIN(bu.ReportingClass) AS GLBU_ReportingClass,

	MIN(glru.GLBU_ClassDS_L1)AS DS_L1,
	MIN(glru.ReportingClass)AS ReportingClass,

	'HIST.ST.SM' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(t.GPAmt) END AS GPAmt, 

	@dtSalesDay AS SalesDate,
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
	(cg.ReportInd = 1 ) AND
		(
			(t.FiscalMonth between @nFirstFiscalMonth AND @nPriorFiscalMonth) OR
			(t.FiscalMonth between @nFirstFiscalMonth_PY AND @nPriorFiscalMonth_PY) 
		) AND
	(1=1)
	

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode

	,t.SalesDivision

	,t.Shipto
--	,t.FreeGoodsEstInd
	,t.OrderSourceCode


UNION ALL
--6. SM Grouped accounts at the ST Level - (HIST.OTHER.SM)' 

SELECT     
	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.SalesDivision, 

	0 AS Shipto,

	t.AdjCode,
--	t.FreeGoodsEstInd,

	t.OrderSourceCode,

	'A' AS TrxSrc, 

	t.HIST_MarketClass,
	t.HIST_SegCd,
	t.HIST_Specialty,

	bu.ReportingClass AS GLBU_ReportingClass,

	glru.GLBU_ClassDS_L1 AS DS_L1,
	glru.ReportingClass AS ReportingClass,

	'HIST.OTHER.SM' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(t.GPAmt) END AS GPAmt, 

	@dtSalesDay AS SalesDate,
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
	(cg.ReportInd = 0 ) AND
		(
			(t.FiscalMonth between @nFirstFiscalMonth AND @nPriorFiscalMonth) OR
			(t.FiscalMonth between @nFirstFiscalMonth_PY AND @nPriorFiscalMonth_PY) 
		) AND
	(1=1)
	

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

--	,t.FreeGoodsEstInd
	,t.OrderSourceCode

	,t.HIST_MarketClass
	,t.HIST_SegCd
	,t.HIST_Specialty

	,bu.ReportingClass 

	,glru.GLBU_ClassDS_L1
	,glru.ReportingClass



END

GO


-- Debug
-- BRS_SM_Cube_proc 


