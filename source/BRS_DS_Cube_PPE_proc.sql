SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_DS_Cube_PPE_proc 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Cube_PPE_proc
**	Desc: copy of BRS_DS_Cube_proc with product seg
**			Market class dynimic, not static
**          No acquistion    
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
**	Date: 30 Jul 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

BEGIN
	SET NOCOUNT ON;  

Declare @dtSalesDate datetime, @nFiscalMonthBeginDt datetime 

Declare @nFiscalMonth int, @nFirstFiscalMonth int
Declare @nPriorFiscalMonth int

Declare @nWorkingDaysMonth int, @nDayNumber int

Declare @dtSalesDate_LY datetime 
Declare @nFiscalMonth_LY int, @nFirstFiscalMonth_LY int


SET NOCOUNT ON

if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0)
	Print 'BRS_DS_Cube_PPE_proc - DEBUG MODE.'
 
Select
	@dtSalesDate    		= SalesDate,
	@dtSalesDate_LY			= SalesDate_LY,

	@nFiscalMonth			= FiscalMonth,
	@nFiscalMonth_LY		= FiscalMonth_LY,
	@nPriorFiscalMonth		= PriorFiscalMonth,

	@nFirstFiscalMonth  	= YearFirstFiscalMonth,
	@nFirstFiscalMonth_LY	= YearFirstFiscalMonth_LY,

	@nDayNumber				= DayNumber,
	@nWorkingDaysMonth		= MonthWorkingDays

FROM
	BRS_Rollup_Support01 g

--PRINT '1. Current Day CY - Actual from Detail - (CY.DAY.ACT) - OK'

SELECT     
	'CY' AS TimePeriod, 
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

	-- Use Current Seg as MTD is dynamic
	c.MarketClass, 
	CASE WHEN c.BillTo = 2613256 THEN 'DENCORP' ELSE '' END as SegCd,
	CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END as PPE,

	'CY.DAY.ACT' AS Status,

	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL([ExtChargebackAmt],0))) END AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]


WHERE
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	t.FiscalMonth = @nFiscalMonth AND
	t.SalesDate = @dtSalesDate AND

	--	Current Day ALWAYS used the Free Goods estimate as actuals are not availible, 17 May 16	tmc		
	(t.FreeGoodsEstInd =  0 ) AND
	(t.GLBU_Class = 'MERCH') AND

	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,c.MarketClass
	,CASE WHEN c.BillTo = 2613256 THEN 'DENCORP' ELSE '' END
	,CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END
--	,c.SegCd 

UNION ALL


--PRINT '2. Current Day PY - Actual from Detail - (PY.DAY.ACT) - OK' 

SELECT     
	'PY' AS TimePeriod, 
	'DAY' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	c.HIST_MarketClass AS MarketClass, 
	CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END as SegCd,
	CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END as PPE,

	'PY.DAY.ACT' AS Status,

	SUM(t.[NetSalesAmt]) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) END AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_CustomerFSC_History AS c 
	ON c.ShipTo = t.Shipto   AND
		c.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]


WHERE
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	m.FiscalMonth = @nFiscalMonth AND
	m.SalesDate = @dtSalesDate AND

	--	Current Day ALWAYS used the Free Goods estimate as actuals are not availible, 17 May 16	tmc
	(t.FreeGoodsEstInd =  0 ) AND
	(t.GLBU_Class = 'MERCH') AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision
	,c.HIST_MarketClass
	,CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END
	,CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END


UNION ALL

--PRINT '5. MTD CY - Actual from Detail - (CY.MTD.ACT) - OK'
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
	'A' AS TrxSrc, 

	-- Use Current Seg as MTD is dynamic
	c.MarketClass, 
	CASE WHEN c.BillTo = 2613256 THEN 'DENCORP' ELSE '' END as SegCd,
	CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END as PPE,

	'CY.MTD.ACT' AS Status,

	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM( NetSalesAmt - (ExtendedCostAmt - ISNULL([ExtChargebackAmt],0))) END AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class


	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = t.FiscalMonth

	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]


WHERE
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	@nFiscalMonth <> @nPriorFiscalMonth AND

	t.SalesDate < @dtSalesDate AND 
		t.FiscalMonth = @nFiscalMonth AND

	--	Current Day ALWAYS used the Free Goods estimate as actuals are not availible, 17 May 16	tmc
	(t.FreeGoodsEstInd =  0 ) AND
	(t.GLBU_Class = 'MERCH') AND

	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,c.MarketClass
	,CASE WHEN c.BillTo = 2613256 THEN 'DENCORP' ELSE '' END
	,CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END

UNION ALL


--PRINT '6. MTD PY - Actual from LY Detail - (PY.MTD.ACT) - OK'
SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	c.HIST_MarketClass AS MarketClass, 
	CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END as SegCd,
	CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END as PPE,

	'PY.MTD.ACT' AS Status,
	                      
	SUM(t.[NetSalesAmt]) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) END AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_CustomerFSC_History AS c 
	ON c.ShipTo = t.Shipto   AND
		c.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]


WHERE 
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	m.SalesDate < @dtSalesDate AND 
	m.FiscalMonth = @nFiscalMonth AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
--  MUST use estimates for this case 
	(t.FreeGoodsEstInd =  0 ) AND
	(t.GLBU_Class = 'MERCH') AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,c.HIST_MarketClass
	,CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END
	,CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END

UNION ALL


-- MONTHEND MODE - BEGIN

--PRINT '5m. ME CY - Actual from Summary - (CY.ME.ACT)'
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
	'A' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END as SegCd,
	CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END as PPE,

	'CY.ME.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	SUM(t.GPAmt) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) as UniqueID

FROM         
	BRS_AGG_ICMBGAD_Sales AS t 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = t.FiscalMonth

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]


WHERE
	-- Enabled when IN monthend mode
	(@nFiscalMonth = @nPriorFiscalMonth) AND

	(t.FiscalMonth = @nFiscalMonth) AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND
	(t.GLBU_Class = 'MERCH') AND

	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END
	,CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END

UNION ALL


--PRINT '6m. ME PY - Actual from LY Summary - (PY.ME.ACT)'
SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	MIN(m.FiscalMonth_LY) AS FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	cc.MarketClass AS MarketClass, 
	CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END as SegCd,
	CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END as PPE,

	'PY.ME.ACT' AS Status,
	                      
	SUM(t.[NetSalesAmt]) AS SalesAmt, 
	SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]

WHERE 
	-- Enabled when IN monthend mode
	(@nFiscalMonth = @nPriorFiscalMonth) AND

	m.FiscalMonth = @nFiscalMonth AND 

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND
	(t.GLBU_Class = 'MERCH') AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,cc.MarketClass
	,CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END
	,CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END

UNION ALL


-- MONTHEND MODE - END


--PRINT '9. YTD CY - Actual from Aggregate - (CY.YTD.ACT) - OK'

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
	CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END as SegCd,
	CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END as PPE,

	'CY.YTD.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	SUM(t.GPAmt) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) as UniqueID

FROM         
	BRS_AGG_ICMBGAD_Sales AS t 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = t.FiscalMonth

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]


WHERE
	t.FiscalMonth < @nFiscalMonth AND 
		t.FiscalMonth >= @nFirstFiscalMonth AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND
	(t.GLBU_Class = 'MERCH') AND

	(1=1)


GROUP BY 
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth THEN 'QTD' ELSE '' END

	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	,CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END
	,CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END

UNION ALL


--PRINT '10. LYTD PY - Actual from Aggregate - (PY.YTD.ACT) - OK'

SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'' AS MTD, 
	CASE WHEN (((m.FiscalMonth_LY % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		m.FiscalMonth_LY <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END AS QTD, 
	'YTD' AS YTD, 

	MIN(m.FiscalMonth_LY) AS FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	cc.MarketClass AS MarketClass, 
	CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END as SegCd,
	CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END as PPE,

	'PY.YTD.ACT' AS Status,

	SUM(t.[NetSalesAmt]) AS SalesAmt, 
	SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID) as UniqueID

FROM         
	BRS_Transaction AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]


WHERE
	m.FiscalMonth < @nFiscalMonth AND 
	m.FiscalMonth >= @nFirstFiscalMonth AND


--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND
	(t.GLBU_Class = 'MERCH') AND

	(1=1)


GROUP BY 
	CASE WHEN (((m.FiscalMonth_LY % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		m.FiscalMonth_LY <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,cc.MarketClass
	,CASE WHEN cc.BillTo = 2613256 THEN 'DENCORP' ELSE '' END
	,CASE WHEN cat.CategoryRollupPPE <> '' THEN 'PPE' ELSE 'OTHER' END


END

GO


-- Prod
-- Exec BRS_DS_Cube_PPE_proc @bDebug=0

-- Dev
-- Exec BRS_DS_Cube_PPE_proc @bDebug=1
-- ORG 9577 rows in 33s
