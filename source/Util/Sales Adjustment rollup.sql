-- helper to fix 5 days into 3, tmc & gw, 21 Dec 17

-- Sales
SELECT     
	'Sales' as src,
	t.FiscalMonth,
	t.AdjCode,

	SUM(t.NetSalesAmt) AS value,

	t.GL_BusinessUnit,
	t.GL_Object_Sales,
	t.GL_Subsidiary_Sales,

	t.GLBU_Class,
	t.Branch,

	t.SalesDivision,

	ISNULL(h.HIST_MarketClass, '') AS HIST_MarketClass


FROM            
	BRS_Transaction AS t 

	LEFT OUTER JOIN BRS_CustomerFSC_History AS h 
	ON t.Shipto = h.Shipto and 
	t.FiscalMonth = h.FiscalMonth
WHERE        
	(t.SalesDate BETWEEN CONVERT(DATETIME, '2016-12-22 00:00:00', 102) AND CONVERT(DATETIME, '2016-12-31 00:00:00', 102))
GROUP BY 
	t.FiscalMonth,
	t.Branch,
	t.GLBU_Class,
	t.SalesDivision,
	t.AdjCode,
	t.GL_BusinessUnit,
	t.GL_Object_Sales,
	t.GL_Subsidiary_Sales,

	ISNULL(h.HIST_MarketClass, '')
HAVING 
  SUM(t.NetSalesAmt) <>0

UNION ALL

-- Costs
SELECT     
	'Costs' as src,
	t.FiscalMonth,
	t.AdjCode,

	SUM(t.ExtendedCostAmt) AS value,

	t.GL_BusinessUnit,
	t.GL_Object_Cost,
	t.GL_Subsidiary_Cost,

	t.GLBU_Class,
	t.Branch,

	t.SalesDivision,

	ISNULL(h.HIST_MarketClass, '') AS HIST_MarketClass


FROM            
	BRS_Transaction AS t 

	LEFT OUTER JOIN BRS_CustomerFSC_History AS h 
	ON t.Shipto = h.Shipto and
	t.FiscalMonth = h.FiscalMonth
WHERE        
	(t.SalesDate BETWEEN CONVERT(DATETIME, '2016-12-22 00:00:00', 102) AND CONVERT(DATETIME, '2016-12-31 00:00:00', 102))
GROUP BY 
	t.FiscalMonth,
	t.Branch,
	t.GLBU_Class,
	t.SalesDivision,
	t.AdjCode,
	t.GL_BusinessUnit,
	t.GL_Object_Cost,
	t.GL_Subsidiary_Cost,
	ISNULL(h.HIST_MarketClass, '')
HAVING 
  SUM(t.ExtendedCostAmt)  <>0

UNION ALL

-- CB
SELECT     
	'CB' as src,
	t.FiscalMonth,
	t.AdjCode,

	SUM(ISNULL(t.ExtChargebackAmt, 0)) AS value,

	t.GL_BusinessUnit,
	t.GL_Object_ChargeBack,
	t.GL_Subsidiary_ChargeBack,

	t.GLBU_Class,
	t.Branch,

	t.SalesDivision,

	ISNULL(h.HIST_MarketClass, '') AS HIST_MarketClass


FROM            
	BRS_Transaction AS t 

	LEFT OUTER JOIN BRS_CustomerFSC_History AS h 
	ON t.Shipto = h.Shipto and 
	t.FiscalMonth = h.FiscalMonth

WHERE        
	(t.SalesDate BETWEEN CONVERT(DATETIME, '2016-12-22 00:00:00', 102) AND CONVERT(DATETIME, '2016-12-31 00:00:00', 102))
GROUP BY 
	t.FiscalMonth,
	t.Branch,
	t.GLBU_Class,
	t.SalesDivision,
	t.AdjCode,
	t.GL_BusinessUnit,
	t.GL_Object_ChargeBack,
	t.GL_Subsidiary_ChargeBack,
	ISNULL(h.HIST_MarketClass, '')
HAVING 
  SUM(ISNULL(t.ExtChargebackAmt, 0)) <>0


--

-- Sales
/*

SELECT     
	'Sales' as src,
	t.FiscalMonth,
	t.AdjCode,

	SUM(t.NetSalesAmt) AS value,

	t.GL_BusinessUnit,
	t.GL_Object_Sales,
	t.GL_Subsidiary_Sales,

	t.GLBU_Class,
	t.Branch,

	t.SalesDivision,

	ISNULL(h.HIST_MarketClass, '') AS HIST_MarketClass,
	MAX(t.Shipto) as st



FROM            
	BRS_Transaction AS t 

	LEFT OUTER JOIN BRS_CustomerFSC_History AS h 
	ON t.Shipto = h.Shipto and 
	t.FiscalMonth = h.FiscalMonth
WHERE        
	(t.SalesDate BETWEEN CONVERT(DATETIME, '2016-12-22 00:00:00', 102) AND CONVERT(DATETIME, '2016-12-31 00:00:00', 102))
GROUP BY 
	t.FiscalMonth,
	t.Branch,
	t.GLBU_Class,
	t.SalesDivision,
	t.AdjCode,
	t.GL_BusinessUnit,
	t.GL_Object_Sales,
	t.GL_Subsidiary_Sales,

	ISNULL(h.HIST_MarketClass, '')
HAVING 
  SUM(t.NetSalesAmt) <>0

*/