SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_DS_Cube_proc 
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Cube_proc
**	Desc: BRS_DS_Cube_proc with Acquisition rates added for DSL
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
--	21 Dec 15	tmc		Change Prior Estimate (P) to (E)stimate -- CY Est removed
--						Set NSA sales to 0 GP for Transactions (already adj in AGG)
--	23 Dec 15	tmc		Change E & P back -- needed for ME transition from Est to Act adj
--  19 Jan 16	tmc		Added Shadow adjustments to sales to track X codes for 380 report recon
--	24 Feb 16	tmc		Added Prior Month Estimate to catch an estimate gap between day 1 and ME final adj load
--	05 Apr 16	tmc		Add Global Free Goods Estimate logic 
--	06 May 16	tmc		Remove X code shawdow track (not used & conflicts with FG est logic)
--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
--	26 May 16	tmc		Fixed bug where FG EST and ACT are double-counted (see 17 May 16)
--	14 Oct 16	tmc		Add Acq rate logic: Sum(amount * rate) (0 rate where null)
--  19 Jan 17   tmc     Merged prior Acq notes rom BRS_DS_Cube_proc into *THIS* proc
--  22 Jan 17   tmc     Refactored to accomodate same date YoY sales
--	31 Jan 17	tmc		Fixed GP MTD issue where Chargeback missing
--	05 Apr 17	tmc		Adding Monthend mode (FiscalMonth=PriorFiscalMonth)
--	29 May 20	tmc		replace seg with DCC plugin
--	13 Aug 20	tmc		add specialist to seg
--	18 Jul 22	tmc		refactored Mulitsite to show DCC and 123 for Elite
--	09 Sep 22	tmc		refactored Mulitsite to show CLP and Alitma for Midmarket
--  15 Dec 22	tmc		break out Heartland dental
--  25 Jun 24	tmc		add PPE KEY

**    
*******************************************************************************/

BEGIN
	SET NOCOUNT ON;  

Declare @dtSalesDate datetime, @nFiscalMonthBeginDt datetime 

Declare @nFiscalMonth int, @nFirstFiscalMonth int
Declare @nPriorFiscalMonth int

Declare @nWorkingDaysMonth int, @nDayNumber int

Declare @dtSalesDate_LY datetime 
Declare @nFiscalMonth_LY int, @nFirstFiscalMonth_LY int


SET NOCOUNT ON

if (@bDebug <> 0)
	SET NOCOUNT OFF;

if (@bDebug <> 0)
	Print 'BRS_DS_Cube_proc - DEBUG MODE.'
 
Select
	@dtSalesDate    		= SalesDate,
	@dtSalesDate_LY			= SalesDate_LY,

	@nFiscalMonth			= FiscalMonth,
	@nFiscalMonth_LY		= FiscalMonth_LY,
	@nPriorFiscalMonth		= PriorFiscalMonth,

	@nFirstFiscalMonth  	= YearFirstFiscalMonth,
	@nFirstFiscalMonth_LY	= YearFirstFiscalMonth_LY,

	@nDayNumber				= DayNumber,
	@nWorkingDaysMonth		= MonthWorkingDays

FROM
	BRS_Rollup_Support01 g


--PRINT '1. Current Day CY - Actual from Detail - (CY.DAY.ACT) - OK'

SELECT     
	'CY' AS TimePeriod, 
	'DAY' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 
	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 

	t.AdjCode,

	t.SalesDivision, 
	'A' AS TrxSrc, 

	-- Use Current Seg as MTD is dynamic
	cc.MarketClass, 
	
	--- XXX
	-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'CY.DAY.ACT' AS Status,

	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL([ExtChargebackAmt],0))) END AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID) as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.NetSalesAmt * ISNULL(af.Aqu_sales_rt, 0) ) AS SalesAcqAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM( (NetSalesAmt - (ExtendedCostAmt - ISNULL([ExtChargebackAmt],0))) * ISNULL(af.Aqu_sales_rt, 0) )   END AS GPAcqAmt

FROM         
	BRS_Transaction AS t 

	INNER JOIN BRS_Customer AS cc
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	-- PPE
	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = cat.CategoryRollupPPE
	--
	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (t.FiscalMonth >= 201609) OR ((t.FiscalMonth = 201608) AND (t.Branch = 'NWFLD')) )

WHERE
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	t.FiscalMonth = @nFiscalMonth AND
	t.SalesDate = @dtSalesDate AND

	--	Current Day ALWAYS used the Free Goods estimate as actuals are not availible, 17 May 16	tmc		
	(t.FreeGoodsEstInd =  0 ) AND

	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,cc.MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]



UNION ALL


--PRINT '2. Current Day PY - Actual from Detail - (PY.DAY.ACT) - OK' 

SELECT     
	'PY' AS TimePeriod, 
	'DAY' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	c.HIST_MarketClass AS MarketClass, 
	-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,



	'PY.DAY.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM( GPAmt ) END AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * ISNULL(af.Aqu_sales_rt, 0) ) AS SalesAcqAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM( (GPAmt) * ISNULL(af.Aqu_sales_rt, 0) )   END AS GPAcqAmt

FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_CustomerFSC_History AS c 
	ON c.ShipTo = t.Shipto   AND
		c.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE


	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	m.FiscalMonth = @nFiscalMonth AND
	m.SalesDate = @dtSalesDate AND

	--	Current Day ALWAYS used the Free Goods estimate as actuals are not availible, 17 May 16	tmc
	(t.FreeGoodsEstInd =  0 ) AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision
	,c.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
	,ppe.[CategoryRollupPPE]

UNION ALL

--PRINT '3. Current Day CY - Estimate from LY Aggregate - (CY.DAY.EST) - OK'
SELECT     
	'CY' AS TimePeriod, 
	'DAY' AS DAY, 
	'' AS MTD, -- avoid double day counting, tmc, 29 Jan 15
	'' AS QTD, -- avoid double day counting, tmc, 29 Jan 15
	'' AS YTD, -- avoid double day counting, tmc, 30 Jan 15
	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'E' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,


	'CY.DAY.EST' AS Status,
                      
	SUM(t.SalesAmt * a.MTDEst_rt) * (1.0 / @nWorkingDaysMonth) AS SalesAmt, 
	SUM(t.GPAmt * a.MTDEst_rt) * (1.0 / @nWorkingDaysMonth) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 1 * 1024 as UniqueID,	

	-- Add Acquistion rate logic: value * rate (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * a.MTDEst_rt * ISNULL(af.Aqu_sales_rt, 0)) * (1.0 / @nWorkingDaysMonth) AS SalesAcqAmt, 
	SUM(t.GPAmt * a.MTDEst_rt * ISNULL(af.Aqu_sales_rt, 0)) * (1.0 / @nWorkingDaysMonth) AS GPAcqAmt


FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE


	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE     
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	m.FiscalMonth = @nFiscalMonth AND
	(a.MTDEstInd = 1) AND


--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL

--PRINT '4. Current Day PY - Pro-rated from LY Aggregate - (PY.DAY.PRO) - OK'

SELECT     
	'PY' AS TimePeriod, 
	'DAY' AS DAY, 
	'' AS MTD, -- avoid double day counting, tmc, 29 Jan 15
	'' AS QTD, -- avoid double day counting, tmc, 29 Jan 15
	'' AS YTD, -- avoid double day counting, tmc, 30 Jan 15
	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'P' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
	-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,


	'PY.DAY.PRO' AS Status,

	SUM(t.SalesAmt) * (1.0 / @nWorkingDaysMonth) AS SalesAmt, 
	SUM(t.GPAmt) * (1.0 / @nWorkingDaysMonth) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 3 * 1024 as UniqueID,	

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * ISNULL(af.Aqu_sales_rt, 0)) * (1.0 / @nWorkingDaysMonth) AS SalesAcqAmt, 
	SUM(t.GPAmt * ISNULL(af.Aqu_sales_rt, 0)) * (1.0 / @nWorkingDaysMonth) AS GPAcqAmt 

FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE     
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	m.FiscalMonth = @nFiscalMonth AND
	(a.MTDEstInd = 1) AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL


--PRINT '5. MTD CY - Actual from Detail - (CY.MTD.ACT) - OK'
SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 
	t.AdjCode,

	t.SalesDivision, 
	'A' AS TrxSrc, 

	-- Use Current Seg as MTD is dynamic
	cc.MarketClass, 
	-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'CY.MTD.ACT' AS Status,

	SUM(t.NetSalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM( NetSalesAmt - (ExtendedCostAmt - ISNULL([ExtChargebackAmt],0))) END AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID) as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.NetSalesAmt * ISNULL(af.Aqu_sales_rt, 0) ) AS SalesAcqAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM( (NetSalesAmt - (ExtendedCostAmt - ISNULL([ExtChargebackAmt],0))) * ISNULL(af.Aqu_sales_rt, 0) )   END AS GPAcqAmt

FROM         
	BRS_Transaction AS t 

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class


	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = t.FiscalMonth

	-- PPE
	INNER JOIN [dbo].[BRS_Item] i
	ON i.Item = t.Item

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON cat.[MinorProductClass] = i.[MinorProductClass]

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = cat.CategoryRollupPPE

	--

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (t.FiscalMonth >= 201609) OR ((t.FiscalMonth = 201608) AND (t.Branch = 'NWFLD')) )


WHERE
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	@nFiscalMonth <> @nPriorFiscalMonth AND

	t.SalesDate < @dtSalesDate AND 
		t.FiscalMonth = @nFiscalMonth AND

	--	Current Day ALWAYS used the Free Goods estimate as actuals are not availible, 17 May 16	tmc
	(t.FreeGoodsEstInd =  0 ) AND

	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,cc.MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL


--PRINT '6. MTD PY - Actual from LY Detail - (PY.MTD.ACT) - OK'
SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	c.HIST_MarketClass AS MarketClass, 
	-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'PY.MTD.ACT' AS Status,
	                      
	SUM(t.SalesAmt) AS SalesAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM(GPAmt) END AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * ISNULL(af.Aqu_sales_rt, 0) ) AS SalesAcqAmt, 
	CASE WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 ELSE SUM( (GPAmt) * ISNULL(af.Aqu_sales_rt, 0) )   END AS GPAcqAmt

FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_CustomerFSC_History AS c 
	ON c.ShipTo = t.Shipto   AND
		c.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_DS_GLBU_Rollup AS glru
	ON	t.GLBU_Class = glru.GLBU_Class

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE


	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE 
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	m.SalesDate < @dtSalesDate AND 
	m.FiscalMonth = @nFiscalMonth AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
--  MUST use estimates for this case 
	(t.FreeGoodsEstInd =  0 ) AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,c.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL


-- MONTHEND MODE - BEGIN

--PRINT '5m. ME CY - Actual from Summary - (CY.ME.ACT)'
SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	t.FiscalMonth, 
	t.Branch,
	t.GLBU_Class, 
	t.AdjCode,

	t.SalesDivision, 
	'A' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'CY.ME.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	SUM(t.GPAmt) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * ISNULL(af.Aqu_sales_rt, 0)) AS SalesAcqAmt, 
	SUM(t.GPAmt * ISNULL(af.Aqu_sales_rt, 0)) AS GPAcqAmt

FROM         
	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = t.FiscalMonth

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (t.FiscalMonth >= 201609) OR ((t.FiscalMonth = 201608) AND (t.Branch = 'NWFLD')) )



WHERE
	-- Enabled when IN monthend mode
	(@nFiscalMonth = @nPriorFiscalMonth) AND

	(t.FiscalMonth = @nFiscalMonth) AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)

GROUP BY 
	t.FiscalMonth
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL


--PRINT '6m. ME PY - Actual from LY Summary - (PY.ME.ACT)'
SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	MIN(m.FiscalMonth_LY) AS FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'PY.ME.ACT' AS Status,
	                      
	SUM(t.SalesAmt) AS SalesAmt, 
	SUM(t.GPAmt) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * ISNULL(af.Aqu_sales_rt, 0)) AS SalesAcqAmt, 
	SUM(t.GPAmt * ISNULL(af.Aqu_sales_rt, 0)) AS GPAcqAmt

FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE 
	-- Enabled when IN monthend mode
	(@nFiscalMonth = @nPriorFiscalMonth) AND

	m.FiscalMonth = @nFiscalMonth AND 

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL


-- MONTHEND MODE - END

-- 7. MTD CY - Estimate from LY Aggregate - (CY.MTD.EST) - OK

SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'E' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'CY.MTD.EST' AS Status,
	                      
	SUM(t.SalesAmt * a.MTDEst_rt) * ((@nDayNumber * 1.0) / @nWorkingDaysMonth) AS SalesAmt, 
	SUM(t.GPAmt * a.MTDEst_rt) * ((@nDayNumber * 1.0) / @nWorkingDaysMonth) AS GPAmt, 


	@dtSalesDate AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 2 * 1024 as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * a.MTDEst_rt  * ISNULL(af.Aqu_sales_rt, 0)) * ((@nDayNumber * 1.0) / @nWorkingDaysMonth) AS SalesAcqAmt, 
	SUM(t.GPAmt * a.MTDEst_rt  * ISNULL(af.Aqu_sales_rt, 0)) * ((@nDayNumber * 1.0) / @nWorkingDaysMonth) AS GPAcqAmt 


FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode 

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE     
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	m.FiscalMonth = @nFiscalMonth AND

	(a.MTDEstInd = 1) AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL

--PRINT '8. MTD PY - Pro-rated from LY Aggregate - (PY.MTD.PRO) - OK'

SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'MTD' AS MTD, 
	'QTD' AS QTD, 
	'YTD' AS YTD, 

	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'P' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'PY.MTD.PRO' AS Status,

	SUM(t.SalesAmt) * (@nDayNumber * 1.0 / @nWorkingDaysMonth) AS SalesAmt, 
	SUM(t.GPAmt) * (@nDayNumber * 1.0 / @nWorkingDaysMonth) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) * 7 + 4 * 1024 as UniqueID,	

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * ISNULL(af.Aqu_sales_rt, 0)) * (@nDayNumber * 1.0 / @nWorkingDaysMonth) AS SalesAcqAmt, 
	SUM(t.GPAmt * ISNULL(af.Aqu_sales_rt, 0)) * (@nDayNumber * 1.0 / @nWorkingDaysMonth) AS GPAcqAmt 

FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN dbo.BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE     
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	m.FiscalMonth = @nFiscalMonth AND

	(a.MTDEstInd = 1) AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)

GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL


--PRINT '9. YTD CY - Actual from Aggregate - (CY.YTD.ACT) - OK'

SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'' AS MTD, 
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth THEN 'QTD' ELSE '' END AS QTD, 
	'YTD' AS YTD, 

	MIN(t.FiscalMonth) as FiscalMonth,
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'CY.YTD.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	SUM(t.GPAmt) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * ISNULL(af.Aqu_sales_rt, 0)) AS SalesAcqAmt, 
	SUM(t.GPAmt * ISNULL(af.Aqu_sales_rt, 0)) AS GPAcqAmt

FROM         
	BRS_AGG_CMBGAD_Sales AS t 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = t.FiscalMonth

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (t.FiscalMonth >= 201609) OR ((t.FiscalMonth = 201608) AND (t.Branch = 'NWFLD')) )


WHERE
	t.FiscalMonth < @nFiscalMonth AND 
		t.FiscalMonth >= @nFirstFiscalMonth AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)


GROUP BY 
	CASE WHEN (((t.FiscalMonth % 100 - 1) / 3) + 1) = (((@nFiscalMonth % 100 - 1) / 3) + 1) AND 
		t.FiscalMonth <= @nFiscalMonth THEN 'QTD' ELSE '' END

	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL


--PRINT '10. LYTD PY - Actual from Aggregate - (PY.YTD.ACT) - OK'

SELECT     
	'PY' AS TimePeriod, 
	'' AS DAY, 
	'' AS MTD, 
	CASE WHEN (((m.FiscalMonth_LY % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		m.FiscalMonth_LY <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END AS QTD, 
	'YTD' AS YTD, 

	MIN(m.FiscalMonth_LY) AS FiscalMonth, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'A' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'PY.YTD.ACT' AS Status,

	SUM(t.SalesAmt) AS SalesAmt, 
	SUM(t.GPAmt) AS GPAmt, 

	@dtSalesDate AS SalesDate,
	MIN(t.ID_MAX) as UniqueID,

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * ISNULL(af.Aqu_sales_rt, 0)) AS SalesAcqAmt, 
	SUM(t.GPAmt * ISNULL(af.Aqu_sales_rt, 0)) AS GPAcqAmt


FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate_LY

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE
	m.FiscalMonth < @nFiscalMonth AND 
	m.FiscalMonth >= @nFirstFiscalMonth AND


--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)


GROUP BY 
	CASE WHEN (((m.FiscalMonth_LY % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		m.FiscalMonth_LY <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

UNION ALL

--	24 Feb 16	tmc		Added Prior Month Estimate to catch an estimate gap between day 1 and ME final adj load

-- 11. MTD-1 CY - Estimate from LY Aggregate - (CY.PMTD.EST) - FIX from LY to MTD-1
SELECT     
	'CY' AS TimePeriod, 
	'' AS DAY, 
	'' AS MTD, 
--  PM logic:  pull the last year's monthend - 1 data and set the appropriate quarter logic
	CASE WHEN (((m.FiscalMonth_LY % 100 - 1) / 3) + 1) = (((@nFiscalMonth_LY % 100 - 1) / 3) + 1) AND 
		m.FiscalMonth_LY <= @nFiscalMonth_LY THEN 'QTD' ELSE '' END AS QTD, 
	'YTD' AS YTD, 

	m.FiscalMonth_LY, 
	t.Branch, 
	t.GLBU_Class, 
	t.AdjCode,
	t.SalesDivision, 
	'F' AS TrxSrc, 

	t.HIST_MarketClass AS MarketClass, 
-- new front
	CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
--	CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END as SegCd,
	ppe.[CategoryRollupPPE],
	MIN(ppe.[ppe_key]) as ppe_key,

	'CY.PMTD.EST' AS Status,
	                      
	SUM(t.SalesAmt * a.MTDEst_rt)  AS SalesAmt, 
	SUM(t.GPAmt * a.MTDEst_rt)  AS GPAmt, 


	@dtSalesDate AS SalesDate,
	-- id x 7  to avoid collision between CD & MTD Estimate (using same data source by design -- prorate and per day)
	MIN(t.ID_MAX) * 7 + 5 * 1024 as UniqueID,	

	-- Add Acquistion rate logic: Sum(amount * rate) (0 rate where null), tmc, 13 Oct 16
	SUM(t.SalesAmt * a.MTDEst_rt * ISNULL(af.Aqu_sales_rt, 0))  AS SalesAcqAmt, 
	SUM(t.GPAmt * a.MTDEst_rt * ISNULL(af.Aqu_sales_rt, 0))  AS GPAcqAmt 


FROM         
	BRS_AGG_CDBGAD_Sales AS t 

    INNER JOIN BRS_DS_Day_Yoy AS m 
    ON t.SalesDate = m.SalesDate

	INNER JOIN BRS_Customer AS cc 
	ON t.Shipto = cc.ShipTo 

	INNER JOIN BRS_AdjCode AS a 
	ON t.AdjCode = a.AdjCode 

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = m.FiscalMonth_LY

	INNER JOIN [dbo].[BRS_DS_PPE] ppe
	on ppe.[CategoryRollupPPE] = t.CategoryRollupPPE

	-- Add Acquistion rates, tmc, 13 Oct 16
	LEFT JOIN BRS_Aqu_Sales_Factor AS af
	ON t.ShipTo = af.ShipTo AND 
		t.GLBU_Class = af.GLBU_Class  AND 
		af.Aqu_cd = 'DSL' AND
		( (m.FiscalMonth_LY >= 201609) OR ((m.FiscalMonth_LY = 201608) AND (t.Branch = 'NWFLD')) )

WHERE    
	-- Enabled when NOT in monthend mode
	(@nFiscalMonth <> @nPriorFiscalMonth) AND

	-- Note (Month - 1) logic is ok for Jan -> N/A, as the year is reset and no estimates are needed, tmc, 24 Feb 16
	m.FiscalMonth = (@nFiscalMonth-1) AND

	(a.MTDEstInd = 1) AND

--	17 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(t.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE t.FreeGoodsEstInd END ) AND

	(1=1)


GROUP BY 
	m.FiscalMonth_LY
	,t.Branch
	,t.GLBU_Class
	,t.AdjCode
	,t.SalesDivision

	,t.HIST_MarketClass
	-- new back
	,(CASE WHEN cc.MarketClass In ('ELITE','MIDMKT') AND cc.VPA in ('123DENNC', '123DNST', '123DENTA', 'ALT03', 'CENLAPT', 'DENCORP')  THEN cc.CustGrpWrk ELSE cc.MarketClass END) 
--	,CASE WHEN cc.MarketClass = 'ELITE' THEN cc.CustGrpWrk ELSE cc.MarketClass END
	,ppe.[CategoryRollupPPE]

END

GO

-- BRS_DS_Cube_proc 


-- Prod
-- BRS_DS_Cube_proc 0
-- DEV 17 325 in 2m50s
-- DEV 17 325 in   35s

-- Dev
-- Exec BRS_DS_Cube_proc @bDebug=1

-- Select SalesDate, SalesDate_LY, FiscalMonth, PriorFiscalMonth, FiscalMonth_LY, YearFirstFiscalMonth, YearFirstFiscalMonth_LY, DayNumber, MonthWorkingDays FROM BRS_Rollup_Support01 g
-- select top 10 * from BRS_AGG_CDBGAD_Sales

-- Exec BRS_DS_Cube_proc 0
-- Exec BRS_DS_Cube_proc 0
--
-- Exec BRS_DS_Cube_proc @month_factor=2
-- Exec BRS_DS_Cube_proc @month_factor=1