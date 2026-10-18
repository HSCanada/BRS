SELECT        

	t.CalMonth, 
	CAST (m.YearNum AS CHAR(4)) +'Q'+ CAST(m.QuarterNum AS CHAR(1)) AS year_qtr, 
	m.YearNum,  
	RTRIM(f.Branch)		AS Branch, 
	RTRIM(i.SalesCategory) AS SalesCategory, 
	t.OrderSourceCode, 

	CASE WHEN t.FreeGoodsInvoicedInd = 1 AND i.Label = 'P' THEN 'F' ELSE t.PriceMethod END as PriceMethod,

	--> added 
	t.FreeGoodsEstInd,
	t.GEP_Order_Flag_ind,
	i.Excl_Code,
	--< added

--	t.PriceMethod, 

	c.SalesDivision, 

	RTRIM(c.[SegCd_New])		AS SegCd,
--	RTRIM(c.SegCd)		AS SegCd,

--	SUM(t.ExtBase)		AS ExtBase, 
	SUM(t.[NetSalesAmt])		AS SalesAmt, 
	0					AS placeholder,
--	SUM(t.ExtDiscLine)	AS ExtDiscLine, 
--	SUM(t.ExtDiscOrder) AS ExtDiscOrder, 
	SUM(t.ExtDiscAmt)	AS ExtDiscAmt, 
	SUM(t.GPAtCommCostAmt) AS GPAtCommCostAmt,
	SUM(t.GPAmt)		AS GPAmt,
	RTRIM(MIN(c.[MarketClass_New]))  AS MarketClass,
	CASE WHEN i.Label = 'P' THEN 'P' ELSE 'B' END AS LabelShow
--	CASE WHEN c.billto = 2613256 THEN 1 ELSE 0 END AS DentalCorpInd

	-- test
	-- ,t.Shipto
	-- ,min(c.[PracticeName]) AS PracticeName
	-- ,min(c.VPA) AS VPA

	--

FROM            
	[dbo].[BRS_TransactionDW] AS t 

	INNER JOIN BRS_FiscalMonth AS m 
	ON t.calMonth = m.FiscalMonth 

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON f.TerritoryCd = c.TerritoryCd	

	INNER JOIN BRS_Item AS i 
	ON t.Item = i.Item 
	

WHERE         
	(i.SalesCategory = 'MERCH') AND 
	(
		(t.CalMonth BETWEEN 202601 and 202609) OR
		(t.CalMonth BETWEEN 202501 and 202509)
	) AND
	(
		-- back out free goods billed
		t.FreeGoodsInvoicedInd = 0 OR
		-- except owned and corporate
		(t.FreeGoodsInvoicedInd = 1 AND i.Excl_Code <> 'BRANDED') or 
		-- excel GSP
		(t.FreeGoodsInvoicedInd = 1 AND i.Supplier = 'PROCGA') 
--		(t.FreeGoodsInvoicedInd = 1 AND i.Label = 'P')
	)  AND 

	-- test with quote exclude
	-- (Branch = 'OTTWA') AND
	-- (t.FiscalMonth in (202308, 202308)) AND
	-- ([HIST_MarketClass]='ZAHN') AND

	--

	(1=1)


GROUP BY 
	t.calMonth, 
	m.YearNum, 
	m.QuarterNum, 
	f.Branch, 
	i.SalesCategory, 
	t.OrderSourceCode, 

	t.FreeGoodsEstInd,
	t.GEP_Order_Flag_ind,
	i.Excl_Code,


	-- break out private label Free goods as these are not redeemed
	CASE WHEN t.FreeGoodsInvoicedInd = 1 AND i.Label = 'P' THEN 'F' ELSE t.PriceMethod END,
--	t.PriceMethod, 

	c.SalesDivision, 

	-- fixed 12 Nov 21
	c.[SegCd_New],
	--	c.SegCd,

	-- replace DCC rollup with HSB to show Private Label discount
	CASE WHEN i.Label = 'P' THEN 'P' ELSE 'B' END
--	CASE WHEN c.billto = 2613256 THEN 1 ELSE 0 END 
