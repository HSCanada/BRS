
/******************************************************************************
**	File: 
**	Name: BRS_DS_AGG_Build_proc
**	Desc: Rebuild aggragate tables
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
-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
**    
*******************************************************************************/

Declare @nFiscalTo int, @nFiscalFrom int, @nFiscalCurrent int

SET NOCOUNT ON
 
Select
	@nFiscalCurrent 	= FiscalMonth,
	@nFiscalFrom		= FirstFiscalMonth_TY,
	@nFiscalTo			= PriorFiscalMonth
FROM
	BRS_Rollup_Support02 g



--------------------------------------------------------------------------------
Print 'Building Core summary (BRS_AGG_CMBGAD_Sales), used by Daily Sales ...'
--------------------------------------------------------------------------------
-- Takes 9min to run, 19 Jan 16

	TRUNCATE TABLE BRS_AGG_CMBGAD_Sales

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

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
		CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE mpc.AdjCode END  as AdjCode, 

		SalesDivision, 
		t.Shipto, 
		t.FreeGoodsEstInd, 
		OrderSourceCode, 

		SUM(NetSalesAmt) AS SalesAmt, 

		CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) - SUM(ExtendedCostAmt) END AS GPAmt, 

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

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
		LEFT JOIN BRS_ItemMPC as mpc
		ON mpc.MajorProductClass = t.MajorProductClass

	WHERE     
		(t.FiscalMonth BETWEEN @nFiscalFrom AND @nFiscalTo )
--		(t.FiscalMonth BETWEEN 201512 AND 201512)
	GROUP BY 
		t.FiscalMonth, 
		Branch, 
		t.GLBU_Class, 

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
		CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE mpc.AdjCode END, 

		SalesDivision, 
		t.Shipto, 
		t.FreeGoodsEstInd, 
		OrderSourceCode

	GO


--------------------------------------------------------------------------------
Print 'Building Item Summary (BRS_AGG_ICMBGAD_Sales), used by Vendor Sales ...'
--------------------------------------------------------------------------------
-- Takes xxx min to run, 19 Jan 16

TRUNCATE TABLE BRS_AGG_ICMBGAD_Sales

GO

INSERT INTO BRS_AGG_ICMBGAD_Sales
(
	Item,
	FiscalMonth, 
	Shipto, 
	Branch, 
	GLBU_Class, 
-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
	CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE mpc.AdjCode END  as AdjCode, 

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

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
	LEFT JOIN BRS_ItemMPC as mpc
	ON mpc.MajorProductClass = t.MajorProductClass

WHERE     
	(t.FiscalMonth BETWEEN @nFiscalFrom AND @nFiscalTo )
GROUP BY 
	Item,
	FiscalMonth, 
	Shipto, 
	Branch, 
	GLBU_Class, 

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
	CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE mpc.AdjCode END, 

	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode, 
	Branch
GO



--------------------------------------------------------------------------------
Print 'Building DW Summary (BRS_AGG_IMD_Sales), used by Promo and Datamining...'
--------------------------------------------------------------------------------
-- Takes xxx min to run, 19 Jan 16

TRUNCATE TABLE BRS_AGG_IMD_Sales
GO

INSERT INTO BRS_AGG_IMD_Sales
(
	Item,
	t.CalMonth, 
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
	(t.CalMonth BETWEEN @nFiscalFrom AND @nFiscalTo)
GROUP BY 
	Item,
	CalMonth, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode

GO


/*
-- Below needs to be steamlined and possibly moved

-- Run only ONCE on Last day of month, after Dimension loaded and SM corrections run

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

