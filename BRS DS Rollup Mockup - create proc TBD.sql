
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
-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 
--							380 recon

--	29 Feb 16	tmc		Updated documentation, pre automation
--	29 Mar 16	tmc		Set month flag to 10 after rebuild (ME adj and logic 
--							still TBD)

--	6 May 16	tmc		Fixed missing FSC for adjustments
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts 
--							with FG est logic)

-- 23 Sep 16	tmc		Add TS territory to snapshot
-- 25 Sep 16	tmc		Add DW Summary (BRS_AGG_CMI_DW_Sales) builder
-- 26 Sep 16	tmc		Add Cursor summary logic to reduce transaction load
-- 27 Sep 16	tmc		Optimize cursors for DS - 1h 15m for full update...
-- 03 Oct 16	tmc		moved manual BRS_AGG_IMD_Sales script end.  Needs to 
--							be added to proc
-- 24 Oct 16	tmc		Record last build date

**    
*******************************************************************************/


Declare @nFiscalTo int, @nFiscalFrom int, @nFiscalCurrent int


--------------------------------------------------------------------------------
Print 'Init'
--------------------------------------------------------------------------------


-- Get Params
Select
	@nFiscalCurrent 	= FiscalMonth,
	@nFiscalFrom		= FirstFiscalMonth_LY,
	@nFiscalTo			= PriorFiscalMonth
FROM
	BRS_Rollup_Support02 g

DECLARE c CURSOR 
	LOCAL STATIC FORWARD_ONLY READ_ONLY
	FOR 
		SELECT 
			FiscalMonth
		FROM 
			BRS_FiscalMonth
		WHERE 
			FiscalMonth BETWEEN @nFiscalFrom AND @nFiscalTo
		ORDER BY 
			FiscalMonth


UPDATE    
	BRS_FiscalMonth
SET              
	StatusCd = -1
WHERE     
	(FiscalMonth = @nFiscalTo)


TRUNCATE TABLE BRS_AGG_CMBGAD_Sales


--------------------------------------------------------------------------------
Print 'Primary Update *****'
--------------------------------------------------------------------------------


OPEN c;

FETCH NEXT FROM c INTO @nFiscalCurrent;

WHILE @@FETCH_STATUS = 0
BEGIN

	Print 'Building Core summary (BRS_AGG_CMBGAD_Sales), used by Daily Sales...'

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
		t.AdjCode, 
		SalesDivision, 
		t.Shipto, 
		t.FreeGoodsEstInd, 
		OrderSourceCode, 

		SUM(NetSalesAmt) AS SalesAmt, 

		CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt) 
			- SUM(ExtendedCostAmt) END AS GPAmt, 

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
		(t.FiscalMonth = @nFiscalCurrent)
--		(t.FiscalMonth BETWEEN 201301 AND 201312)
	GROUP BY 
		t.FiscalMonth, 
		Branch, 
		t.GLBU_Class, 
		t.AdjCode,	
		SalesDivision, 
		t.Shipto, 
		t.FreeGoodsEstInd, 
		OrderSourceCode

	FETCH NEXT FROM c INTO @nFiscalCurrent;

END 

CLOSE c;
-- DEALLOCATE c;


--------------------------------------------------------------------------------
Print 'Mark month stataus as complete'
--------------------------------------------------------------------------------
--	29 Mar 16	tmc		Set month flag to 10 after rebuild (ME adj and logic 
--		still TBD)

-- 24 Oct 16	tmc		Record last build date
UPDATE    
	BRS_FiscalMonth
SET              
	StatusCd = 10, LastSummaryUpdateDt = GetDate()
WHERE     
	(FiscalMonth = @nFiscalTo)



--------------------------------------------------------------------------------
Print 'Secondary Update *****'
--------------------------------------------------------------------------------



TRUNCATE TABLE BRS_AGG_ICMBGAD_Sales
TRUNCATE TABLE BRS_AGG_CMI_DW_Sales

OPEN c;

FETCH NEXT FROM c INTO @nFiscalCurrent;

WHILE @@FETCH_STATUS = 0
BEGIN

	Print 'Building Item Summary (BRS_AGG_ICMBGAD_Sales), Vendor Sales ...'

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
		t.GLBU_Class, 
		t.AdjCode,	
		SalesDivision, 
		t.FreeGoodsEstInd, 
		OrderSourceCode, 
		SUM(NetSalesAmt) AS SalesAmt, 
		SUM(NetSalesAmt) - SUM(ExtendedCostAmt) AS GPAmt, 
		COUNT(*) AS FactCount

	FROM         
		BRS_Transaction AS t

	WHERE     
		(t.FiscalMonth = @nFiscalCurrent )
	--	(t.FiscalMonth BETWEEN 201401 AND 201412 )

	GROUP BY 
		Item,
		FiscalMonth, 
		Shipto, 
		Branch, 
		t.GLBU_Class, 
		t.AdjCode,
		SalesDivision, 
		t.FreeGoodsEstInd, 
		OrderSourceCode, 
		Branch
 
	-- 25 Sep 16	tmc		Add DW Summary (BRS_AGG_CMI_DW_Sales) builder
	Print 'Building DW Summary (BRS_AGG_CMI_DW_Sales) ...'

	INSERT INTO BRS_AGG_CMI_DW_Sales
	(
		Shipto, 
		FiscalMonth,

		FreeGoodsEstInd, 
		SalesCategory,

		TAG_TsTerritoryCd,

		Item,
		PriceMethod, 
		OrderSourceCode, 

		HIST_TsTerritoryCd,
		HIST_TerritoryCd,
		HIST_Specialty,
		HIST_MarketClass,
		HIST_VPA,
		HIST_SegCd,


		ShippedQty,
		SalesAmt, 
		GPAmt, 
		GPAtFileCostAmt, 
		GPAtCommCostAmt, 
		ExtChargebackAmt, 
		ExtDiscAmt, 

		FactCount,
		ID_MAX
	)

	SELECT 

		t.Shipto,     
		d.FiscalMonth, 
		t.FreeGoodsEstInd, 
		i.SalesCategory,
		t2.TsTerritoryCd,

		t.Item,
		t.PriceMethod,
		t.OrderSourceCode, 

		ISNULL( MAX(c.HIST_TsTerritoryCd),'') AS HIST_TsTerritoryCd,
		ISNULL( MAX(c.HIST_TerritoryCd),'') AS HIST_TerritoryCd,
		ISNULL( MAX(c.HIST_Specialty), '') AS HIST_Specialty,
		ISNULL( MAX(c.HIST_MarketClass), '') AS HIST_MarketClass,
		ISNULL( MAX(c.HIST_VPA), '') AS HIST_VPA,
		ISNULL( MAX(c.HIST_SegCd), '') AS HIST_SegCd,


		SUM(t.ShippedQty) AS ShippedQty,
		SUM(t.NetSalesAmt) AS SalesAmt, 
		SUM(t.GPAmt) AS GPAmt, 
		SUM(t.GPAtFileCostAmt) AS GPAtFileCostAmt, 
		SUM(t.GPAtCommCostAmt) AS GPAtCommCostAmt, 
		SUM(t.ExtChargebackAmt) AS ExtChargebackAmt, 
		SUM(t.ExtDiscAmt) AS ExtDiscAmt, 

		COUNT(*) AS FactCount,
		MAX(T.ID) AS ID_MAX

	FROM         
		BRS_TransactionDW AS t

		INNER JOIN BRS_SalesDay AS d 
		ON d.SalesDate = t.Date 

		INNER JOIN BRS_CustomerFSC_History AS c 
		ON c.ShipTo = t.Shipto   AND
			c.FiscalMonth = d.FiscalMonth

		INNER JOIN BRS_Item AS i 
		ON i.Item = t.Item 

	    INNER JOIN BRS_TransactionDW_Ext AS t2 
		ON t.SalesOrderNumber = t2.SalesOrderNumber AND 
			t.DocType = t2.DocType 


	WHERE     
		(d.FiscalMonth = @nFiscalCurrent )
	--	(d.FiscalMonth BETWEEN 201501 AND 201609 )

	GROUP BY 
		t.Shipto,     
		d.FiscalMonth, 
		t.FreeGoodsEstInd, 
		i.SalesCategory,
		t2.TsTerritoryCd,
		t.Item,
		t.PriceMethod,
		t.OrderSourceCode

	FETCH NEXT FROM c INTO @nFiscalCurrent;

END 

CLOSE c;
DEALLOCATE c;



/*
-- Below needs to be streamlined and possibly moved

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
	HIST_SegCd,

	-- 23 Sep 16	tmc		Add TS territory to snapshot
	HIST_TsTerritoryCd

)
SELECT     
	c.ShipTo, 
	g.FiscalMonth,
	c.TerritoryCd, 
	c.VPA,
	c.Specialty,
	c.MarketClass,
	c.SegCd,

	-- 23 Sep 16	tmc		Add TS territory to snapshot
	c.TsTerritoryCd

FROM         
	BRS_Customer c
	CROSS JOIN BRS_Config g

GO

-- Run only FIRST day of month, after Dimension loaded and SM corrections run


-- Missing Account? - due to setup and bill on last day of month.  Manual fix for now.
-- Fixed to capture Adj Accounts
SELECT DISTINCT    
	t.Shipto, 
	t.FiscalMonth, 
	t.TerritoryCd as HIST_TerritoryCd, 
	t.VPA as HIST_VPA,
	'' as HIST_Specialty,
	'' as HIST_MarketClass,
	'' as HIST_SegCd

FROM         BRS_Transaction t

where 
	(t.Shipto > 0) And 
--	6 May 16	tmc		Fixed missing FSC for adjustments
--	(DocType <> 'AA') And
	(NOT EXISTS (SELECT * FROM BRS_CustomerFSC_History h WHERE h.Shipto = t.Shipto AND  h.FiscalMonth = t.FiscalMonth)) AND
	(t.FiscalMonth between 201609 and 201609) 




-- True up the FSC to match last day (updated Month filter)
SELECT     
	SalesOrderNumberKEY, 
	DocType, 
	LineNumber, 
	SalesDate, 
	t.FiscalMonth, 
	t.Shipto, 
	t.NetSalesAmt,
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
	(t.FiscalMonth between 201609 and 201609) 

-- AND (b.Branch <> 'NWFLD')

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
	(t.FiscalMonth between 201609 and 201609) 

--AND (b.Branch <> 'NWFLD')

-- Next steps:
-- 1. set Monthend end & prior ME dates, after DS published
-- 2. Run this script Summary builds (1 of 2) prior ME adj - about 12 minutes 
--		a) set dates
--		b) Manual trucate first
--		c) run script (about 15 min)
*/


/*

-- run manual until History tables in place, 2 Feb 16

--------------------------------------------------------------------------------
Print 'Building DW Summary (BRS_AGG_IMD_Sales), used by Promo and Datamining...'
--------------------------------------------------------------------------------

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
-- Manual load
	(t.CalMonth BETWEEN 201609 AND 201609)

GROUP BY 
	Item,
	CalMonth, 
	SalesDivision, 
	FreeGoodsEstInd, 
	OrderSourceCode

*/
