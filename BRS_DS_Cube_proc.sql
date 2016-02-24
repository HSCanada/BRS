SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_DS_Cube_proc 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Cube_proc
**	Desc: Load Weekly Customer & Item Dimentions 
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@bDebug
**
**	Auth: tmc
**	Date: 19 Dec 15
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	21 Dec 15	tmc		Change Prior Estimate (P) to (E)stimate -- CY Est removed
**						Set NSA sales to 0 GP for Transactions (already adj in AGG)
**	23 Dec 15	tmc		Change E & P back -- needed for ME transition from Est to Act adj
**  19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 report recon
--	24 Feb 16	tmc		Added Prior Month Estimate to catch an estimate gap between day 1 and ME final adj load
**    
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Declare @dtSalesDay datetime, @nFiscalMonthBeginDt datetime 

Declare @nFiscalMonth int, @nFirstFiscalMonth_TY int
Declare @nWorkingDaysMonth int, @nDayNumber int

Declare @dtSalesDate_LY datetime 
Declare @nFiscalMonth_LY int, @nFirstFiscalMonth_LY int

SET NOCOUNT ON
 
Select
	@dtSalesDay				= SalesDate,
	@nFiscalMonth			= FiscalMonth,
	@nFirstFiscalMonth_TY	= FirstFiscalMonth_TY,
	@nWorkingDaysMonth		= WorkingDaysMonth,
	@nDayNumber				= DayNumber,
	@dtSalesDate_LY			= SalesDate_LY,
	@nFiscalMonth_LY		= FiscalMonth_LY,
	@nFirstFiscalMonth_LY	= FirstFiscalMonth_LY

FROM
	BRS_Rollup_Support02 g


--PRINT '1. Current Day CY - Actual from Detail - (CY.DAY.ACT)'

SELECT     
	'CY' AS TimePeriod, 
	'DAY' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 
	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 

	-- Added Shadow adjustments to sales to track X codes for 380 recon, tmc, 19 Jan 16
	CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE mpc.AdjCode END  as AdjCode, 
--	t.AdjCode,

	t.SalesDivision, 
	'A' AS TrxSrc, 

	-- Use Current Seg as MTD is dynamic
	c.MarketClass, 
	c.SegCd, 

	'CY.DAY.ACT' AS Status,

	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 
--	SUM(t.NetSalesAmt) - SUM(t.ExtendedCostAmt) AS GPAmt, 
	@dtSalesDay AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	-- Added Shadow adjustments to sales to track X codes for 380 recon, tmc, 19 Jan 16
	LEFT JOIN BRS_ItemMPC as mpc
	ON mpc.MajorProductClass = t.MajorProductClass


WHERE
	t.FiscalMonth = @nFiscalMonth AND
	t.SalesDate = @dtSalesDay

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class

	-- Added Shadow adjustments to sales to track X codes for 380 recon, tmc, 19 Jan 16
	,CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE mpc.AdjCode END
--	,t.AdjCode

	,t.SalesDivision

	,c.MarketClass
	,c.SegCd 

UNION ALL


--PRINT '2. Current Day PY - Actual from Detail - (PY.DAY.ACT)' 

SELECT     
	'PY' AS TimePeriod, 
	'DAY' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	c.HIST_MarketClass AS MarketClass, 
	c.HIST_SegCd AS SegCd, 

	'PY.DAY.ACT' AS Status,

	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 
--	SUM(t.NetSalesAmt) - SUM(t.ExtendedCostAmt) AS GPAmt, 
	@dtSalesDay AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

	INNER JOIN BRS_CustomerFSC_History AS c 
	ON c.ShipTo = t.Shipto   AND
		c.FiscalMonth = t.FiscalMonth

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

WHERE
	t.FiscalMonth = @nFiscalMonth_LY AND
	t.SalesDate = @dtSalesDate_LY

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,c.HIST_MarketClass
	,c.HIST_SegCd 


UNION ALL

--PRINT '3. Current Day CY - Estimate from LY Aggregate - (CY.DAY.EST)'
SELECT     
	'CY' AS TimePeriod, 
	'DAY' AS DAY, 
	'' AS MTD, -- avoid double day counting, tmc, 29 Jan 15
	'' AS QTD, -- avoid double day counting, tmc, 29 Jan 15
	'' AS YTD, -- avoid double day counting, tmc, 30 Jan 15
	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'E' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd,

	'CY.DAY.EST' AS Status,
                      
	SUM(t.SalesAmt * a.MTDEst_rt) * (1.0 / @nWorkingDaysMonth) AS SalesAmt, 
	SUM(t.GPAmt * a.MTDEst_rt) * (1.0 / @nWorkingDaysMonth) AS GPAmt, 

	@dtSalesDay  AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 1 * 1024 as UniqueID	

FROM         
	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode

WHERE     
	t.FiscalMonth = @nFiscalMonth_LY AND
	(a.MTDEstInd = 1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,t.HIST_SegCd 

UNION ALL

--PRINT '4. Current Day PY - Pro-rated from LY Aggregate - (PY.DAY.PRO)'
--PRINT GETDATE()

SELECT     
	'PY' AS TimePeriod, 
	'DAY' AS DAY, 
	'' AS MTD, -- avoid double day counting, tmc, 29 Jan 15
	'' AS QTD, -- avoid double day counting, tmc, 29 Jan 15
	'' AS YTD, -- avoid double day counting, tmc, 30 Jan 15
	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'P' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd,

	'PY.DAY.PRO' AS Status,

	SUM(t.SalesAmt) * (1.0 / @nWorkingDaysMonth) AS SalesAmt, 
	SUM(t.GPAmt) * (1.0 / @nWorkingDaysMonth) AS GPAmt, 

	@dtSalesDay  AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 3 * 1024 as UniqueID	

FROM         
	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode

WHERE     
	t.FiscalMonth = @nFiscalMonth_LY AND
	(a.MTDEstInd = 1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,t.HIST_SegCd 

UNION ALL


--PRINT '5. MTD CY - Actual from Detail - (CY.MTD.ACT)'
SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 

	-- Added Shadow adjustments to sales to track X codes for 380 recon, tmc, 19 Jan 16
	CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE mpc.AdjCode END  as AdjCode, 
--	t.AdjCode,

	t.SalesDivision, 
	'A' AS TrxSrc, 

	-- Use Current Seg as MTD is dynamic
	c.MarketClass, 
	c.SegCd, 

	'CY.MTD.ACT' AS Status,

	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 
--	SUM(t.NetSalesAmt) - SUM(t.ExtendedCostAmt) AS GPAmt, 
	@dtSalesDay AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	-- Added Shadow adjustments to sales to track X codes for 380 recon, tmc, 19 Jan 16
	LEFT JOIN BRS_ItemMPC as mpc
	ON mpc.MajorProductClass = t.MajorProductClass


WHERE
	t.SalesDate < @dtSalesDay AND 
		t.FiscalMonth = @nFiscalMonth 

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class

	-- Added Shadow adjustments to sales to track X codes for 380 recon, tmc, 19 Jan 16
	,CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE mpc.AdjCode END
--	,t.AdjCode

	,t.SalesDivision

	,c.MarketClass
	,c.SegCd 

UNION ALL


--PRINT '6. MTD PY - Actual from LY Detail - (PY.MTD.ACT)'
SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	c.HIST_MarketClass AS MarketClass, 
	c.HIST_SegCd AS SegCd, 

	'PY.MTD.ACT' AS Status,
	                      
	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 
--	SUM(t.NetSalesAmt) - SUM(t.ExtendedCostAmt) AS GPAmt, 
	@dtSalesDay AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

	INNER JOIN BRS_CustomerFSC_History AS c 
	ON c.ShipTo = t.Shipto   AND
		c.FiscalMonth = t.FiscalMonth

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

WHERE 
	t.SalesDate < @dtSalesDate_LY AND 
		t.FiscalMonth = @nFiscalMonth_LY 

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,c.HIST_MarketClass
	,c.HIST_SegCd 

UNION ALL

-- 7. MTD CY - Estimate from LY Aggregate - (CY.MTD.EST)
SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'E' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd,

	'CY.MTD.EST' AS Status,
	                      
	SUM(t.SalesAmt * a.MTDEst_rt) * ((@nDayNumber * 1.0) / @nWorkingDaysMonth) AS SalesAmt, 
	SUM(t.GPAmt * a.MTDEst_rt) * ((@nDayNumber * 1.0) / @nWorkingDaysMonth) AS GPAmt, 


	@dtSalesDay  AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 2 * 1024 as UniqueID	


FROM         
	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode 

WHERE     
	t.FiscalMonth = @nFiscalMonth_LY AND
	(a.MTDEstInd = 1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,t.HIST_SegCd 

UNION ALL

-- 7 end

--PRINT '8. MTD PY - Pro-rated from LY Aggregate - (PY.MTD.PRO)'

SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'P' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd,

	'PY.MTD.PRO' AS Status,

	SUM(t.SalesAmt) * (@nDayNumber * 1.0 / @nWorkingDaysMonth) AS SalesAmt, 
	SUM(t.GPAmt) * (@nDayNumber * 1.0 / @nWorkingDaysMonth) AS GPAmt, 
	@dtSalesDay AS SalesDate,
	MIN(t.ID_MAX) * 7 + 4 * 1024 as UniqueID	

FROM         
	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN dbo.BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode

WHERE     
	t.FiscalMonth = @nFiscalMonth_LY AND
	(a.MTDEstInd = 1)
GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,t.HIST_SegCd 

UNION ALL


--PRINT '9. YTD CY - Actual from Aggregate - (CY.YTD.ACT)'

SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'' AS MTD, 
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth THEN 'QTD' ELSE '' END AS QTD, 
	'YTD' AS YTD, 

	MIN(t.FiscalMonth) as FiscalMonth,
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd,

	'CY.YTD.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	SUM(t.GPAmt) AS GPAmt, 
	@dtSalesDay AS SalesDate,
	MIN(t.ID_MAX) as UniqueID

FROM         
	BRS_AGG_CMBGAD_Sales AS t 

WHERE
	t.FiscalMonth < @nFiscalMonth AND 
		t.FiscalMonth >= @nFirstFiscalMonth_TY 

GROUP BY 
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth THEN 'QTD' ELSE '' END
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,t.HIST_SegCd 

UNION ALL


--PRINT '10. LYTD PY - Actual from Aggregate - (PY.YTD.ACT)'

SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'' AS MTD, 
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END AS QTD, 
	'YTD' AS YTD, 

	MIN(t.FiscalMonth) AS FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd,

	'PY.YTD.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	SUM(t.GPAmt) AS GPAmt, 
	@dtSalesDay AS SalesDate,
	MIN(t.ID_MAX) as UniqueID

FROM         
	BRS_AGG_CMBGAD_Sales AS t 

WHERE
	t.FiscalMonth < @nFiscalMonth_LY AND 
		t.FiscalMonth >= @nFirstFiscalMonth_LY 

GROUP BY 
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,t.HIST_SegCd 

UNION ALL

--	24 Feb 16	tmc		Added Prior Month Estimate to catch an estimate gap between day 1 and ME final adj load

-- 11. MTD-1 CY - Estimate from LY Aggregate - (CY.PMTD.EST)
SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'' AS MTD, 
--  PM logic:  pull the last year's monthend - 1 data and set the appropriate quarter logic
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'F' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd,

	'CY.PMTD.EST' AS Status,
	                      
	SUM(t.SalesAmt * a.MTDEst_rt)  AS SalesAmt, 
	SUM(t.GPAmt * a.MTDEst_rt)  AS GPAmt, 


	@dtSalesDay  AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 5 * 1024 as UniqueID	


FROM         
	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode 

WHERE    
-- Note (Month - 1) logic is ok for Jan -> N/A, as the year is reset and no estimates are needed, tmc, 24 Feb 16
	t.FiscalMonth = (@nFiscalMonth_LY-1) AND

	(a.MTDEstInd = 1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,t.HIST_SegCd 


END

GO

-- Debug
-- BRS_DS_Cube_proc 

-- Prod
-- BRS_DS_Cube_proc 0


--
--
/*

-- Temp testing for step 11

Declare @nFiscalMonth int
Declare @nFiscalMonth_LY int
Declare @dtSalesDay datetime

--Set @nFiscalMonth		= 201512
--Set @nFiscalMonth_LY	= 201412
--Set @dtSalesDay = '5 Dec 2015'

Set @nFiscalMonth		= 201501
Set @nFiscalMonth_LY	= 201401
Set @dtSalesDay = '4 Jan 2015'

-- 11. MTD-1 CY - Estimate from LY Aggregate - (CY.PMTD.EST)
SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'' AS MTD, 
--  PM logic:  pull the last year's monthend - 1 data and set the appropriate quarter logic
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'F' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	t.HIST_SegCd AS SegCd,

	'CY.PMTD.EST' AS Status,
	                      
	SUM(t.SalesAmt * a.MTDEst_rt)  AS SalesAmt, 
	SUM(t.GPAmt * a.MTDEst_rt)  AS GPAmt, 


	@dtSalesDay  AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 5 * 1024 as UniqueID	


FROM         
	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode 

WHERE    
-- Note (Month - 1) logic is ok for Jan -> N/A, as the year is reset and no estimates are needed, tmc, 24 Feb 16
	t.FiscalMonth = (@nFiscalMonth_LY-1) AND

	(a.MTDEstInd = 1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,t.HIST_SegCd 

*/
