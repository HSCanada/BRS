
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[Sale_brs]
AS

/******************************************************************************
**	File: 
**	Name: Sales for Business Solutions model
**	Desc:  
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
**	Date: 27 Sep 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
** 17 Jan 18	tmc		Add SubSavings metrics
-- 21 Jan 19	tmc		Add Brand Key for Business Review
-- 15 Feb 19	tmc		Add Price Method Key for PAR
-- 08 Jun 20	tmc		Make CalMonth logic table driven so fails 100% no maint
-- 09 Aug 21	tmc		Add hs_branded_baseline_ind for HSB reporting 
**    
*******************************************************************************/

SELECT        
	t.ID											AS FactKey

	,t.Shipto										AS ShipTo
	,i.ItemKey										AS ItemKey
	,icr.[CategoryRollupKey]						AS [CategoryRollupKey]
	,sup.SupplierKey								AS BrandKey

	,d.CalMonth										AS CalMonth	
	,CAST(t.Date AS date)							AS DateKey
	,t.SalesOrderNumber
	,t.LineNumber
	,t.FreeGoodsInvoicedInd
	,pm.PriceMethodKey

	
	,(t.ShippedQty)									AS Quantity
	,(t.NetSalesAmt)								AS SalesAmt
	,(GPAmt + ISNULL(t.ExtChargebackAmt,0))			AS GPAmt
	,(t.GPAtCommCostAmt)							AS GPAtCommCostAmt
	,(t.ExtChargebackAmt)							AS ExtChargebackAmt

	,(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)  AS ExtBaseAmt
	,(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)  AS DiscountAmt
	,(t.ExtListPrice  + 0          -  NetSalesAmt)  AS DiscountLineAmt
	,(0               + t.ExtPrice -  NetSalesAmt)  AS DiscountOrderAmt

	
	-- Substitute logic
	-- divide by 0 smart logic
	,ISNULL(t.ShippedQty/NULLIF(i.Item_Competitive_Conversion_rt,0),0)					AS SubsQuantity
	,(t.NetSalesAmt) * (isub.CurrentCorporatePrice / NULLIF(i.CurrentCorporatePrice,0)) AS SubsSalesAmt

	-- Lookup fields for Salesorder dimension
	,hdr.IDMin										AS sales_order_key
	,c.BillTo
	,t.[DocType]
	,[OrderPromotionCode]
	,[OrderSourceCode]
	,[EnteredBy]
	,[OrderTakenBy]

	,t.GLBusinessUnit
	,bu.hs_branded_baseline_ind
	

FROM            
	BRS_TransactionDW AS t 

	INNER JOIN BRS_SalesDay AS d 
	ON d.SalesDate = t.Date 

	INNER JOIN BRS_Item AS i 
	ON i.Item = t.Item 

	INNER JOIN [dbo].[BRS_ItemCategory] AS ic
	ON i.[MinorProductClass] = ic.[MinorProductClass]

	INNER JOIN [dbo].[BRS_ItemCategoryRollup] AS icr
	ON ic.[CategoryRollup] = icr.[CategoryRollup]

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_PriceMethod AS pm 
	ON t.PriceMethod = pm.PriceMethod

	
	INNER JOIN BRS_Item AS isub 
	ON i.Item_Competitive_Match = isub.Item

	INNER JOIN [dbo].[BRS_ItemSupplier] sup
	ON i.Brand = sup.Supplier

	INNER JOIN [dbo].[BRS_SalesDay] AS dday
	ON t.[Date] = dday.SalesDate

	-- HSB baseline
	INNER JOIN [dbo].[BRS_BusinessUnit] as bu
	ON t.GLBusinessUnit = bu.BusinessUnit


	-- identify first sales order (for sales order dimension)
	INNER JOIN 
	(
		SELECT
			d.SalesOrderNumber, 
			d.[DocType],
			MIN(d.ID) AS IDMin
		FROM
			BRS_TransactionDW AS d

			INNER JOIN [dbo].[BRS_SalesDay] AS dday2
			ON d.[Date] = dday2.SalesDate

		WHERE	
			(EXISTS (SELECT * FROM [Dimension].[CalendarMonth] dd WHERE dday2.CalMonth = dd.CalMonth)) AND
--			Test
--			(d.SalesOrderNumber = 13178603) AND
			--
			(1=1)
		GROUP BY 
			d.SalesOrderNumber,
			d.[DocType]
	) AS hdr
	ON t.SalesOrderNumber = hdr.SalesOrderNumber AND
		t.DocType = hdr.DocType


WHERE        
	(EXISTS (SELECT * FROM [Dimension].[CalendarMonth] dd WHERE dd.CalMonth = t.CalMonth)) AND
--	test
--	(t.SalesOrderNumber = 13178603) AND
	--
	(1 = 1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM Fact.Sale_brs
-- SELECT * FROM Fact.Sale_brs where SalesOrderNumber = 1131213
 -- SELECT SalesOrderNumber, GLBusinessUnit, sum(SalesAmt) FROM Fact.Sale_brs where SalesOrderNumber = 1131213 group by SalesOrderNumber, GLBusinessUnit-- 

 -- SELECT count(*) FROM Fact.Sale_brs
 -- ORG=NEW 7 451 208

-- 1 month test
-- 1.03; 2 259 017 RAW
-- 1.17; 2 259 017 new

-- 25 month test
-- 4.29; 8 399 287

-- SELECT CalMonth, count (*) FROM Fact.Sale_brs Group by CalMonth order by 1

-- fail afer 2 min

-- select top 10 * from [Fact].[Sale_brs]