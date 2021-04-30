-- update discount to enable quick filter, tmc, 13 Mar 18
SET NOCOUNT ON;
GO

SELECT        

	t.FiscalMonth, 
	CAST (m.YearNum AS CHAR(4)) +'Q'+ CAST(m.QuarterNum AS CHAR(1)) AS year_qtr, 
	m.YearNum,  
	RTRIM(f.Branch)		AS Branch, 
	RTRIM(i.SalesCategory) AS SalesCategory, 
	t.OrderSourceCode, 
	t.PriceMethod, 
	c.SalesDivision, 
	RTRIM(c.SegCd)		AS SegCd,
	SUM(t.ExtBase)		AS ExtBase, 
	SUM(t.SalesAmt)		AS SalesAmt, 
	0					AS placeholder,
	SUM(t.ExtDiscLine)	AS ExtDiscLine, 
	SUM(t.ExtDiscOrder) AS ExtDiscOrder, 
	SUM(t.ExtDiscAmt)	AS ExtDiscAmt, 
	SUM(t.GPAtCommCostAmt) AS GPAtCommCostAmt,
	SUM(t.GPAmt)		AS GPAmt,
	RTRIM(MIN([HIST_MarketClass]))  AS MarketClass,
	CASE WHEN c.billto = 2613256 THEN 1 ELSE 0 END AS DentalCorpInd

FROM            
	BRS_AGG_CMI_DW_Sales AS t 

	INNER JOIN BRS_FiscalMonth AS m 
	ON t.FiscalMonth = m.FiscalMonth 

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON f.TerritoryCd = c.TerritoryCd	

	INNER JOIN BRS_Item AS i 
	ON t.Item = i.Item 
	

WHERE         
	(t.SalesCategory = 'MERCH') AND 
--	(t.SalesCategory = 'TEETH') AND 
	(t.FreeGoodsInvoicedInd = 0)  And 
	(
		(t.FiscalMonth BETWEEN 202101 and 202104) OR
		(t.FiscalMonth BETWEEN 201901 and 201904)
	) AND
	-- test with quote exclude
--	(t.OrderSourceCode IN ('A', 'L')) AND 

--	i.[Supplier] = 'DENTZA' AND
	(1=1)


GROUP BY 
	t.FiscalMonth, 
	m.YearNum, 
	m.QuarterNum, 
	f.Branch, 
	i.SalesCategory, 
	t.OrderSourceCode, 
	t.PriceMethod, 
	c.SalesDivision, 
	c.SegCd,
	CASE WHEN c.billto = 2613256 THEN 1 ELSE 0 END 

ORDER BY 1


-- Use BRSales 
-- Update end dates; set Results to Text, tab-delim
-- run!
