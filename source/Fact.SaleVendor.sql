
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[SaleVendor]
AS

/******************************************************************************
**	File: 
**	Name: [Fact].[SaleVendor] (i)
**	Desc:  used for Planning Cube (BI backend)
** (i) add financial info here and rename later
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 14 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	20 Sep 17	tmc		fixed ambiguous market class join 
--	22 Sep 17	tmc		added static content as per Jen testing
--	3 Oct 17	tmc		Merge supplier family to use Supplier dimension
--  25 Oct 24	tmc		add ID to help with recon
--	19 Nov 24	tmc		add BT for analysis
--	28 Nov 24	tmc		swap out backend for financial BI cube (more detail)
--  29 Nov 24	tmc		add facts for Planning
--	05 Dec 24	tmc	    add dimensions for Planning 
--	06 Dec 24	tmc		migrate needed info from [hfm].global_cube_proc 
--	04 Feb 25	tmc		add alias for old model work-around
**    
*******************************************************************************/


SELECT        
	-- for dev speedup
	-- top 100

	-- Metrics ->

	-- ID
	t.ID							AS ID_DS
	-- not all DS trans map to the DW (freight, adj, etc)
	,ISNULL(t.ID_DW, 0)				AS ID_DW

	-- Orders and flags ->
	,t.SalesOrderNumber
	,t.LineNumber
	,t.DocType
	-- xref used for salesorder dimension
	,ISNULL(t.[ID_DS_xref], 0)		AS ID_DS_xref
	-- doctype in source_key
	,t.source_key

	,t.FreeGoodsEstInd
	,t.FreeGoodsInvoicedInd

	,t.OrderPromotionCode
	,t.PromotionCode
	,t.OrderSourceCode
	,t.EnteredBy
	,t.OrderTakenBy
	,t.[CustomerPOText1]
	,t.EquipmentOrderType
	,t.EquipmentOrderNumber

	-- metrics core
	,t.NetSalesAmt
	,t.GPAmt
	,t.GPExclCBAmt
	-- flip sign as the Cube model is neg but legacy is pos
	,-t.ext_chargeback				AS ExtChargebackAmt
	-- keep max name for consistency (is trans level)
	,t.ShippedQty
	,t.QuantityUnit
	-- Metrics <-


	-- Time ->
	,t.FiscalMonth
	-- cal month in day
	,t.day_key
	-- Time <-

	-- Customer Historic ->
	,t.ShipTo
	-- for BT metric counting (multisite lines by billto)
	,t.BillTo
	,t.cust_hist_key

		-- pull this from the customer historical
		,t.HIST_MarketClassKey
		,t.SalesDivision_key
		,t.HIST_BranchKey

		-- add FSC, ISR, terr? or commm model NO, use commModel (Gary reservation, 5 Dec 24)
		-- add the current / hist FSC code to the dim for auditing but now reporting
		-- Customer Historic? YES <-

	-- Item Historic ->
	,t.ItemKey
	,t.item_hist_key
		,t.HIST_SupplierKey
		,t.MinorProductClassKey

	,t.Excl_Key
	-- Item Historic <-

	-- GPS new dim to to GLBU rules
	-- *** MISSING FROM EXCEL MODEL.   ADD TBD ***
	,ISNULL(t.GpsKey, 0) AS GpsKey
	-- *** MISSING FROM EXCEL MODEL.   ADD TBD ***

	-- this is at the fact level due to Equpment CadCAm unit sales
	-- product A & B need to be sold on same order to be counted C
	,ISNULL(t.global_product_class_key,0) AS global_product_class_key

		-- adj ->
	,t.AdjBatchNum
	,t.[AdjNum]
	,t.[AdjCode]
	,t.[AdjNote]
	,t.[AdjRemark]
	,t.[AdjSource]
	,t.[AdjOwner]
	,t.AdjGLDocType
	,t.AdjCodeKey
	,t.AdjType
	,t.AdjCodeDesc
	,t.AdjLevel
	,t.AdjClass
		
		-- adj <-

	,t.promoline_promotion_key

		-- GL ->
		-- DS GLBU
		,t.GLBU_ClassKey

		-- hfm sales, cost, cb
		,ISNULL(t.hfm_gl_account_sales_key, 0) AS hfm_gl_account_sales_key
		,ISNULL(t.hfm_gl_account_cost_key, 0) AS hfm_gl_account_cost_key
		,ISNULL(t.hfm_gl_account_cb_key, 0) AS hfm_gl_account_cb_key
		/*
		,ISNULL(t.ACCOUNT_sales_key, 0) AS ACCOUNT_sales_key
		,ISNULL(t.ACCOUNT_cost_key, 0) AS ACCOUNT_cost_key
		,ISNULL(t.ACCOUNT_cb_key, 0) AS ACCOUNT_cb_key

		-- Planning Entity / Accounts for Cube
		,ISNULL(t.ENTITY_sales_key, 0) AS ENTITY_sales_key
		,ISNULL(t.ENTITY_cost_key, 0) AS ENTITY_cost_key
		,ISNULL(t.ENTITY_cb_key, 0) AS ENTITY_cb_key
		*/
		-- GL <-

		-- add alias for old model work-around

		, t.ID			AS ID_MAX
		, t.GPExclCBAmt AS TotalGPExclCBAmt
		, t.GPAmt		AS TotalGPAmt
		, t.NetSalesAmt AS TotalSalesAmt


FROM        
	[hfm].global_cube AS t


WHERE        
	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE t.FiscalMonth = dd.FiscalMonth)) AND

	(t.FreeGoodsEstInd = 0) AND 


	(1 = 1)


GO


-- BI test
-- select top 10 * from [Fact].[SaleVendor] where FiscalMonth = 202410

-- select count (*) from [Fact].[SaleVendor] where FiscalMonth = 202410
-- ORG 8 776 614 @ 21s

/*


-- Testing

-- adhoc look at the data
SELECT HIST_MarketClassKey, count (*) 
FROM [Fact].[SaleVendor] 
WHERE        
	(FiscalMonth BETWEEN 202101 AND 202101) AND 
--	(FreeGoodsEstInd = 0) AND 
	(1 = 1)
GROUP BY HIST_MarketClassKey
ORDER BY 1



-- row count testing2 -- success

SELECT        
	HIST_MarketClass, 
	MIN([MarketClassKey]) as MarketClassKey,
	COUNT(*) AS line_count
FROM            
	BRS_AGG_ICMBGAD_Sales AS t

	INNER JOIN [dbo].[BRS_CustomerMarketClass] mc
	ON t.HIST_MarketClass = mc.[MarketClass]
WHERE        
	(FiscalMonth BETWEEN 201701 AND 201712) AND 
	(FreeGoodsEstInd = 0) AND 
	(1 = 1)
GROUP BY HIST_MarketClass

-- ORG 1682277
-- NEW 1682277


-- find missing data - failed

SELECT        COUNT(*) AS line_count
FROM            [Fact].[SaleVendor] AS t
WHERE        
--	(FiscalMonth BETWEEN 201401 AND 201707) AND 
--	(FreeGoodsEstInd = 0) AND 
	(1 = 1)

GROUP BY FiscalMonth

-- ORG 1682277 
-- NEW1 292271 - fail
-- NEW2 1682277 - partial success (not full join)
-- NEW3 1682277 - success!


*/

/*
-- BI test - Legacy (ORG)
-- note: set DB to BRSales (Prod) and set results to text output

SELECT    
	MIN(FiscalMonth) as FiscalMonth
	,COUNT (*)  AS line_count
	,SUM(TotalSalesAmt) TotalSalesAmt
	,SUM(TotalGPAmt) TotalGPAmt
	,SUM(TotalGPExclCBAmt) TotalGPExclCBAmt
	,SUM(ExtChargebackAmt)  ExtChargebackAmt

FROM            [Fact].[SaleVendor] AS t
WHERE        
	FiscalMonth =  202410
GO

*/


-- ORG 178 678 @ 25s
-- NEW 178 678 @ 25s

/*
-- test1 - 202508 - PASSED

-- ORG @ 25m
FiscalMonth line_count  TotalSalesAmt         TotalGPAmt            TotalGPExclCBAmt      ExtChargebackAmt
----------- ----------- --------------------- --------------------- --------------------- ---------------------
202408      178678      38770645.5091         16225771.1266         14973246.0366         1252525.09

-- NEW @ <1s
FiscalMonth line_count  TotalSalesAmt         TotalGPAmt            TotalGPExclCBAmt      ExtChargebackAmt
----------- ----------- --------------------- --------------------- --------------------- ---------------------
202408      222284      38 770 645.5091         16 225 771.1266         14 973 246.0366         1 252 525.09

-- test2 - 202509 - PASSED

-- ORG @ 33s
FiscalMonth line_count  TotalSalesAmt         TotalGPAmt            TotalGPExclCBAmt      ExtChargebackAmt
----------- ----------- --------------------- --------------------- --------------------- ---------------------
202409      199967      42346158.9682         17548271.7334         16095516.6334         1452755.10

-- New <1s
FiscalMonth line_count  TotalSalesAmt         TotalGPAmt            TotalGPExclCBAmt      ExtChargebackAmt
----------- ----------- --------------------- --------------------- --------------------- ---------------------
202409      249992      42 346 158.9682         17 548 271.7334         16 095 516.6334         1 452 755.10

-- test3 - 202510 - PASSED
FiscalMonth line_count  TotalSalesAmt         TotalGPAmt            TotalGPExclCBAmt      ExtChargebackAmt
----------- ----------- --------------------- --------------------- --------------------- ---------------------
202410      245699      55090770.7526         22261845.1337         20088684.8937         2173160.24

FiscalMonth line_count  TotalSalesAmt         TotalGPAmt            TotalGPExclCBAmt      ExtChargebackAmt
----------- ----------- --------------------- --------------------- --------------------- ---------------------
202410      313988      55 090 770.7526         22 261 845.1337         20 088 684.8937         2 173 160.24

-- test4 - 202511 -- PASSED (out of scope)

FiscalMonth line_count  TotalSalesAmt         TotalGPAmt            TotalGPExclCBAmt      ExtChargebackAmt
----------- ----------- --------------------- --------------------- --------------------- ---------------------
NULL        0           NULL                  NULL                  NULL                  NULL

FiscalMonth line_count  TotalSalesAmt         TotalGPAmt            TotalGPExclCBAmt      ExtChargebackAmt
----------- ----------- --------------------- --------------------- --------------------- ---------------------
NULL        0           NULL                  NULL                  NULL                  NULL




*/

-- Select top 1000 * from [Fact].[SaleVendor] where FiscalMonth = 202410 and ExtChargebackAmt <> 0
/*
and ( 
		hfm_gl_account_sales_key  is null OR
		hfm_gl_account_cost_key  is null  OR
		hfm_gl_account_cb_key  is null OR
		ACCOUNT_sales_key  is null OR
		ACCOUNT_cost_key  is null OR
		ACCOUNT_cb_key  is null OR
		ENTITY_sales_key  is null OR
		ENTITY_cost_key  is null OR
		ENTITY_cb_key  is null OR

		AdjCodeKey  is null )
*/

/*
SELECT        FiscalMonth, HIST_BranchKey, HIST_MarketClassKey, HIST_SupplierKey, GLBU_ClassKey, AdjCodeKey, ShipTo, ItemKey, TotalSalesAmt, TotalGPAmt, TotalGPExclCBAmt, ExtChargebackAmt, ID_DS, BillTo
FROM            Fact.SaleVendor
*/

-- BI source
/*
SELECT   

	top 10 
	ID_DS
	,ID_DW

	,SalesOrderNumber
	,LineNumber
	,source_key

	,FreeGoodsEstInd
	,FreeGoodsInvoicedInd

	,NetSalesAmt
	,GPAmt
	,GPExclCBAmt
	,ExtChargebackAmt
	,ShippedQty
	,QuantityUnit

	,FiscalMonth
	,day_key


-- xx
	,ShipTo
	,Billto
	,cust_hist_key
		,HIST_MarketClassKey
		,SalesDivision_key
		,HIST_BranchKey


	,ItemKey
	,item_hist_key
		,HIST_SupplierKey
		,MinorProductClassKey
	,global_product_class_key
	,Excl_Key
	,GpsKey

	,AdjCodeKey

	,GLBU_ClassKey

	-- phase 2 (9 new dim)
	,hfm_gl_account_sales_key
	,hfm_gl_account_cost_key
	,hfm_gl_account_cb_key


FROM
	Fact.SaleVendor
WHERE
	-- test
--	SalesOrderNumber <> 0 AND
	FiscalMonth = 202410 AND
--	[ID_DS_xref] = 0
	(1=1)
	--


-- SELECT   distinct FiscalMonth FROM 	Fact.SaleVendor

*/

select top 10 * from Fact.SaleVendor
GO
