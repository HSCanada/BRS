-- update discount to enable quick filter, tmc, 13 Mar 18
-- add Private Label FG 
-- add Private Label breakout, 13 Dec 24

SET NOCOUNT ON;
GO

SELECT        

	t.FiscalMonth, 
	CAST (m.YearNum AS CHAR(4)) +'Q'+ CAST(m.QuarterNum AS CHAR(1)) AS year_qtr, 
	m.YearNum,  
	RTRIM(f.Branch)		AS Branch, 
	RTRIM(i.SalesCategory) AS SalesCategory, 
	t.OrderSourceCode, 

	CASE WHEN t.FreeGoodsInvoicedInd = 1 AND i.Label = 'P' THEN 'F' ELSE t.PriceMethod END as PriceMethod,
--	t.PriceMethod, 

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
	CASE WHEN i.Label = 'P' THEN 'P' ELSE 'B' END AS LabelShow
--	CASE WHEN c.billto = 2613256 THEN 1 ELSE 0 END AS DentalCorpInd

	-- test
	-- ,t.Shipto
	-- ,min(c.[PracticeName]) AS PracticeName
	-- ,min(c.VPA) AS VPA

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
	(
		(t.FiscalMonth BETWEEN 202401 and 202412) OR
		(t.FiscalMonth BETWEEN 202301 and 202312)
	) AND
	(
		t.FreeGoodsInvoicedInd = 0 OR
		(t.FreeGoodsInvoicedInd = 1 AND i.Label = 'P')
	)  AND 

	-- test with quote exclude
	-- (Branch = 'OTTWA') AND
	-- (t.FiscalMonth in (202308, 202308)) AND
	-- ([HIST_MarketClass]='ZAHN') AND

	--

	(1=1)


GROUP BY 
	t.FiscalMonth, 
	m.YearNum, 
	m.QuarterNum, 
	f.Branch, 
	i.SalesCategory, 
	t.OrderSourceCode, 

	-- break out private label Free goods as these are not redeemed
	CASE WHEN t.FreeGoodsInvoicedInd = 1 AND i.Label = 'P' THEN 'F' ELSE t.PriceMethod END,
--	t.PriceMethod, 

	c.SalesDivision, 

	-- fixed 12 Nov 21
	t.HIST_SegCd,
	--	c.SegCd,

	-- replace DCC rollup with HSB to show Private Label discount
	CASE WHEN i.Label = 'P' THEN 'P' ELSE 'B' END
--	CASE WHEN c.billto = 2613256 THEN 1 ELSE 0 END 

	-- test
	-- ,t.shipto
	--

-- test
--HAVING
--	RTRIM(MIN([HIST_MarketClass])) = 'MIDMKT'
--


ORDER BY 1


-- Use BRSales 
-- Update end dates; set Results to Text, tab-delim
-- run!

-- ORG 35 902 rows, 16s
-- NEW 54 171, 17s
