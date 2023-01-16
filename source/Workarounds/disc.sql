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

	RTRIM(t.HIST_SegCd)		AS SegCd,
--	RTRIM(c.SegCd)		AS SegCd,

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

	-- test
	--,t.Shipto
	--,min(c.[PracticeName]) AS PracticeName
	--,min(c.VPA) AS VPA
	--

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
	(
		(t.FiscalMonth BETWEEN 202101 and 202112) OR
		(t.FiscalMonth BETWEEN 202201 and 202212)
	) AND
	-- test with quote exclude
	--(Branch = 'TORNT') AND
	--(t.FiscalMonth in (202110, 201910)) AND
	--([HIST_MarketClass]='MIDMKT') AND
	--

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

	-- fixed 12 Nov 21
	t.HIST_SegCd,
	--	c.SegCd,

	CASE WHEN c.billto = 2613256 THEN 1 ELSE 0 END 

	-- test
	-- ,t.shipto

-- test
--HAVING
--	RTRIM(MIN([HIST_MarketClass])) = 'MIDMKT'
--


ORDER BY 1


-- Use BRSales 
-- Update end dates; set Results to Text, tab-delim
-- run!
