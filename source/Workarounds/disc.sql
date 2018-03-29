-- update discount to enable quick filter, tmc, 13 Mar 18

SELECT        

	t.FiscalMonth, 
	CAST (m.YearNum AS CHAR(4)) +'Q'+ CAST(m.QuarterNum AS CHAR(1)) AS year_qtr, 
	m.YearNum,  
	f.Branch, 
	i.SalesCategory, 
	t.OrderSourceCode, 
	t.PriceMethod, 
	c.SalesDivision, 
	c.SegCd, 
	SUM(t.ExtBase)		AS ExtBase, 
	SUM(t.SalesAmt)		AS SalesAmt, 
	0					AS placeholder,
	SUM(t.ExtDiscLine)	AS ExtDiscLine, 
	SUM(t.ExtDiscOrder) AS ExtDiscOrder, 
	SUM(t.ExtDiscAmt)	AS ExtDiscAmt, 
	SUM(t.GPAtCommCostAmt) AS GPAtCommCostAmt,
	SUM(t.GPAmt)		AS GPAmt,
	MIN([HIST_MarketClass])  AS MarketClass,
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
	(t.FreeGoodsInvoicedInd = 0)  And 
--	NOT (c.BillTo=2613256 ) AND
	(
		(t.FiscalMonth BETWEEN 201701 and 201702) OR
		(t.FiscalMonth BETWEEN 201801 and 201802)
	) AND
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


-- set Results to text!

