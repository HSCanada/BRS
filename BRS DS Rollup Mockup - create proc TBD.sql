-- Monthend & Summary procs

/* 

-- Run on LAST Day of Month

-- last day of Monthend (run only once)
-- Gary run 25 Sep 2015 after daily sales
--  Highlight to bottom and hit cntl E

INSERT INTO BRS_ItemHistory 
(
	Item, 
	FiscalMonth, 
	Supplier
)
SELECT     
	BRS_Item.Item, 
	BRS_Config.FiscalMonth, 
	BRS_Item.Supplier
FROM         
	BRS_Item 
	CROSS JOIN BRS_Config

GO

INSERT INTO BRS_CustomerFSC_History
(
	Shipto, 
	FiscalMonth,
	HIST_TerritoryCd,
	HIST_VPA,
	HIST_Specialty,
	HIST_MarketClass,
	HIST_SegCd

)
SELECT     
	c.ShipTo, 
	g.FiscalMonth,
	c.TerritoryCd, 
	c.VPA,
	c.Specialty,
	c.MarketClass,
	c.SegCd

FROM         
	BRS_Customer c
	CROSS JOIN BRS_Config g

GO

*/


-- FSC / BR update, fix on First day of month

/*

-- FSC / Branch 

-- Missing ST in history?

SELECT     SalesOrderNumberKEY, DocType, LineNumber, SalesDate, FiscalMonth, Shipto, TerritoryCd
FROM         BRS_Transaction t

where 
(t.FiscalMonth between 201401 and 201412) And
(t.Shipto >= 0) And
not exists (select * from dbo.BRS_CustomerFSC_History where t.FiscalMonth = FiscalMonth and t.Shipto = Shipto)


-- Fix FSC?
SELECT     
	SalesOrderNumberKEY, 
	DocType, 
	LineNumber, 
	SalesDate, 
	t.FiscalMonth, 
	t.Shipto, 
	t.TerritoryCd as TerritoryCd_Trans, 
	h.HIST_TerritoryCd , 
	t.Branch as TransBranch, 
	b.Branch as HIST_Branch
FROM         BRS_Transaction t

INNER JOIN BRS_CustomerFSC_History h
ON t.FiscalMonth = h.FiscalMonth AND t.Shipto = h.Shipto

INNER JOIN BRS_FSC_Rollup b
ON h.HIST_TerritoryCd = b.TerritoryCd

where 
	(t.Shipto > 0) And
	(DocType <> 'AA') And
	(t.TerritoryCd <> h.HIST_TerritoryCd) AND
	(t.FiscalMonth between 201401 and 201512) 

-- Fix FSC & Branch - DO IT!

UPDATE   
	BRS_Transaction
SET              
	TerritoryCd = h.HIST_TerritoryCd,
	Branch = b.Branch
FROM         
	BRS_Transaction t INNER JOIN
	
	BRS_CustomerFSC_History AS h 
	ON t.FiscalMonth = h.FiscalMonth AND 
		t.Shipto = h.Shipto AND 
		t.TerritoryCd <> h.HIST_TerritoryCd 

	INNER JOIN BRS_FSC_Rollup AS b 
	ON h.HIST_TerritoryCd = b.TerritoryCd

WHERE     
	(t.Shipto > 0) AND 
	(t.DocType <> 'AA') AND 
	(t.FiscalMonth between 201401 and 201512) 

*/


/*

-- Takes 3:20 to run, 30 Jan 15


	truncate table BRS_AGG_CMBGAD_Sales

	GO
	INSERT INTO BRS_AGG_CMBGAD_Sales
	(
		FiscalMonth, 
		Branch, 
		GLBU_Class, 
		AdjCode, 
		SalesDivision, 
		Shipto, 
		FreeGoodsEstInd, 
		OrderSourceCode, 

		SalesAmt, 
		GPAmt, 
		FactCount,
		ID_MAX,

		HIST_Specialty,
		HIST_MarketClass,
		HIST_TerritoryCd,
		HIST_VPA,
		HIST_SegCd

	)
	SELECT     
		t.FiscalMonth, 
		Branch, 
		t.GLBU_Class, 
		AdjCode, 
		SalesDivision, 
		t.Shipto, 
		FreeGoodsEstInd, 
		OrderSourceCode, 

		SUM(NetSalesAmt) AS SalesAmt, 

		CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 
	--			SUM(NetSalesAmt) - SUM(ExtendedCostAmt) AS GPAmt, 
		COUNT(*) AS FactCount,
		MAX(t.ID) as ID_MAX,

		ISNULL( MAX(c.HIST_Specialty), '') AS HIST_Specialty,
		ISNULL( MAX(c.HIST_MarketClass), '') AS HIST_MarketClass,
		ISNULL( MAX(c.HIST_TerritoryCd),'') AS HIST_TerritoryCd,
		ISNULL( MAX(c.HIST_VPA), '') AS HIST_VPA,
		ISNULL( MAX(c.HIST_SegCd), '') AS HIST_SegCd

	FROM         
		BRS_Transaction AS t

		INNER JOIN BRS_DS_GLBU_Rollup AS glru
		ON	t.GLBU_Class = glru.GLBU_Class

		LEFT JOIN BRS_CustomerFSC_History AS c 
		ON c.ShipTo = t.Shipto   AND
			c.FiscalMonth = t.FiscalMonth

	WHERE     
		(t.FiscalMonth BETWEEN 201401 AND 201512)
	GROUP BY 
		t.FiscalMonth, 
		Branch, 
		t.GLBU_Class, 
		AdjCode, 
		SalesDivision, 
		t.Shipto, 
		FreeGoodsEstInd, 
		OrderSourceCode

	GO

-- END HIGHLIGHT


-- *** Run this by YEAR, 5 min per (19 Mar 15) ***!

truncate table dbo.BRS_AGG_ICMBGAD_Sales

GO

INSERT INTO BRS_AGG_ICMBGAD_Sales
(
	Item,
	FiscalMonth, 
	Shipto, 
	Branch, 
	GLBU_Class, 
	AdjCode, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode, 
	SalesAmt, 
	GPAmt, 
	FactCount
)
SELECT     
	Item,
	FiscalMonth, 
	Shipto, 
	Branch, 
	GLBU_Class, 
	AdjCode, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode, 
	SUM(NetSalesAmt) AS SalesAmt, 
	SUM(NetSalesAmt) - SUM(ExtendedCostAmt) AS GPAmt, 
	COUNT(*) AS FactCount

FROM         
	BRS_Transaction AS t
WHERE     
	(FiscalMonth BETWEEN 201301 AND 201512)
GROUP BY 
	Item,
	FiscalMonth, 
	Shipto, 
	Branch, 
	GLBU_Class, 
	AdjCode, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode, 
	Branch

GO

truncate table BRS_AGG_IMD_Sales
GO

INSERT INTO BRS_AGG_IMD_Sales
(
	Item,
	CalMonth, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode, 

	ShippedQty,
	NetSalesAmt, 
	GPAmt, 
	GPAtFileCostAmt, 
	GPAtCommCostAmt, 
	ExtChargebackAmt, 
	ExtDiscAmt, 

	FactCount
)
SELECT     
	Item,
	CalMonth, 
	SalesDivision, 

	FreeGoodsEstInd, 

	OrderSourceCode, 

	SUM(ShippedQty) AS ShippedQty,
	SUM(NetSalesAmt) AS SalesAmt, 
	SUM(GPAmt) AS GPAmt, 
	SUM(GPAtFileCostAmt) AS GPAtFileCostAmt, 
	SUM(GPAtCommCostAmt) AS GPAtCommCostAmt, 
	SUM(ExtChargebackAmt) AS ExtChargebackAmt, 
	SUM(ExtDiscAmt) AS ExtDiscAmt, 

	COUNT(*) AS FactCount

FROM         
	BRS_TransactionDW AS t
WHERE     
	(CalMonth BETWEEN 201301 AND 201512)
GROUP BY 
	Item,
	CalMonth, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode

GO


*/



/*

-- LEGACY

-- Monthend Special Markets Freeze (after adjustments loaded) - 16 m / qtr 13 Jul

UPDATE    
	BRS_Transaction
SET              
	MarketClass = c.MarketClass, 
	Specialty = c.Specialty
FROM         
	BRS_Transaction 
	
	INNER JOIN BRS_Customer c 
	ON BRS_Transaction.Shipto = c.ShipTo

WHERE     
	(c.ShipTo) > 0 And
	(BRS_Transaction.FiscalMonth between 201304 and 201506) 

		-- BEGIN HIGHLIGHT

		truncate table BRS_AGG_MBGAD_Sales

		GO

		INSERT INTO dbo.BRS_AGG_MBGAD_Sales
		(
			FiscalMonth, 
			Branch, 
			GLBU_Class, 
			AdjCode, 
			SalesDivision, 
			SalesAmt, 
			GPAmt, 
			FactCount
		)
		SELECT     
			FiscalMonth, 
			Branch, 
			GLBU_Class, 
			AdjCode, 
			SalesDivision,  
			SUM(NetSalesAmt) AS SalesAmt, 
			SUM(NetSalesAmt) - SUM(ExtendedCostAmt) AS GPAmt, 
			Count(*) as FactCount
		FROM         
			BRS_Transaction AS t
		WHERE     
			(FiscalMonth BETWEEN 201301 AND 201511)
		GROUP BY 
			FiscalMonth, 
			Branch, 
			GLBU_Class, 
			AdjCode, 
			SalesDivision

		GO

*/


