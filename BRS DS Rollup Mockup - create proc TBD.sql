
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
--	29 Feb 16	tmc		Updated documentation, pre automation
--	29 Mar 16	tmc		Set month flag to 10 after rebuild (ME adj and logic still TBD)
--	6 May 16	tmc		Fixed missing FSC for adjustments
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts with FG est logic)
**    
*******************************************************************************/
/*
-- TODO:  fix summary hist /vs rebuild logic; add email alert when complete

-- Step 1.  Clear appropriate tables

TRUNCATE TABLE BRS_AGG_CMBGAD_Sales
TRUNCATE TABLE BRS_AGG_ICMBGAD_Sales

*/

Declare @nFiscalTo int, @nFiscalFrom int, @nFiscalCurrent int

-- Get Params
Select
	@nFiscalCurrent 	= FiscalMonth,
	@nFiscalFrom		= FirstFiscalMonth_LY,
	@nFiscalTo			= PriorFiscalMonth
FROM
	BRS_Rollup_Support02 g

-- Echo Params
SELECT 
	FiscalMonth, 
	FirstFiscalMonth_LY, 
	PriorFiscalMonth
FROM 
	BRS_Rollup_Support02 


--------------------------------------------------------------------------------
Print 'Building Core summary (BRS_AGG_CMBGAD_Sales), used by Daily Sales ...'
--------------------------------------------------------------------------------
-- Takes 10min to run, 19 Jan 16


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
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts with FG est logic)
		t.AdjCode, 
--		CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE ISNULL(mpc.AdjCode,'') END  as AdjCode, 

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
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts with FG est logic)
--		LEFT JOIN BRS_ItemMPC as mpc
--		ON mpc.MajorProductClass = t.MajorProductClass

	WHERE     
		(t.FiscalMonth BETWEEN @nFiscalFrom AND @nFiscalTo )
--		(t.FiscalMonth BETWEEN 201301 AND 201312)
	GROUP BY 
		t.FiscalMonth, 
		Branch, 
		t.GLBU_Class, 

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts with FG est logic)
		t.AdjCode,	
--		CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE ISNULL(mpc.AdjCode,'') END, 

		SalesDivision, 
		t.Shipto, 
		t.FreeGoodsEstInd, 
		OrderSourceCode

--------------------------------------------------------------------------------
Print 'Building Item Summary (BRS_AGG_ICMBGAD_Sales), used by Vendor Sales ...'
--------------------------------------------------------------------------------

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

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts with FG est logic)
	t.AdjCode,	
--	CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE ISNULL(mpc.AdjCode,'') END  as AdjCode, 

	SalesDivision, 
	t.FreeGoodsEstInd, 
	OrderSourceCode, 
	SUM(NetSalesAmt) AS SalesAmt, 
	SUM(NetSalesAmt) - SUM(ExtendedCostAmt) AS GPAmt, 
	COUNT(*) AS FactCount

FROM         
	BRS_Transaction AS t

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts with FG est logic)
--	LEFT JOIN BRS_ItemMPC as mpc
--	ON mpc.MajorProductClass = t.MajorProductClass

WHERE     
	(t.FiscalMonth BETWEEN @nFiscalFrom AND @nFiscalTo )
--	(t.FiscalMonth BETWEEN 201401 AND 201412 )

GROUP BY 
	Item,
	FiscalMonth, 
	Shipto, 
	Branch, 
	t.GLBU_Class, 

-- 	19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 recon
--	6 May 16	tmc		Remove X code shawdow track (not used & conflicts with FG est logic)
	t.AdjCode,
--	CASE WHEN  t.DocType = 'AA' THEN t.AdjCode ELSE ISNULL(mpc.AdjCode,'') END, 

	SalesDivision, 
	t.FreeGoodsEstInd, 
	OrderSourceCode, 
	Branch
 
--------------------------------------------------------------------------------
Print 'Mark month stataus as complete'
--------------------------------------------------------------------------------
--	29 Mar 16	tmc		Set month flag to 10 after rebuild (ME adj and logic still TBD)

UPDATE    
	BRS_FiscalMonth
SET              
	StatusCd = 10
WHERE     
	(FiscalMonth = @nFiscalTo)



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
	(t.FiscalMonth between 201608 and 201608) 




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
	(t.FiscalMonth between 201608 and 201608) 

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
	(t.FiscalMonth between 201608 and 201608) 

--AND (b.Branch <> 'NWFLD')

-- Next steps:
-- 1. set Monthend end & prior ME dates, after DS published
-- 2. Run this script Summary builds (1 of 2) prior ME adj - about 12 minutes 
--		a) set dates
--		b) Manual trucate first
--		c) run script (about 15 min)
*/



