
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[Sale]
AS

/******************************************************************************
**	File: 
**	Name: Sale
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
**	Date: 14 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	14 Sep 17	tmc		Simplified model
**    
*******************************************************************************/

SELECT        
	t.ID											AS FactKey
	,d.FiscalMonth									AS FiscalMonth	
	,CAST(t.Date AS date)							AS DateKey
	,t.SalesOrderNumber
	,t.LineNumber
	,t.Shipto										AS ShipTo
	,c.BillTo
	,i.ItemKey										AS ItemKey
	,pm.PriceMethodKey
	,t.FreeGoodsInvoicedInd

	-- TBD !!
	,0												AS QuotePriceKey

	,(t.ShippedQty)									AS Quantity
	,(t.NetSalesAmt)								AS SalesAmt
	,(GPAmt + ISNULL(t.ExtChargebackAmt,0))			AS GPAmt
	,(t.GPAtFileCostAmt)							AS GPAtFileCostAmt
	,(t.GPAtCommCostAmt)							AS GPAtCommCostAmt
	,(t.ExtChargebackAmt)							AS ExtChargebackAmt

	,(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)  AS ExtBaseAmt
	,(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)  AS DiscountAmt
	,(t.ExtListPrice  + 0          -  NetSalesAmt)  AS DiscountLineAmt
	,(0               + t.ExtPrice -  NetSalesAmt)  AS DiscountOrderAmt
	-- Lookup fields for Salesorder dimension
	,hdr.IDMin										AS FactKeyFirst
	,[DocType]
	,[OrderPromotionCode]
	,[OrderSourceCode]
	,[EnteredBy]
	,[OrderTakenBy]
	,pm.PriceMethod
	,enroll.EnrollSource
	,enroll.SNAST__adjustment_name

FROM            
	BRS_TransactionDW AS t 

	INNER JOIN BRS_SalesDay AS d 
	ON d.SalesDate = t.Date 

	INNER JOIN BRS_Item AS i 
	ON i.Item = t.Item 

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_PriceMethod AS pm 
	ON t.PriceMethod = pm.PriceMethod 

	-- identify first sales order (for sales order dimension)
	INNER JOIN 
	(
		SELECT
			h.SalesOrderNumber, 
			MIN(d.ID) AS IDMin
		FROM
			BRS_TransactionDW_Ext AS h INNER JOIN

			BRS_TransactionDW AS d 
			ON h.SalesOrderNumber = d.SalesOrderNumber
		GROUP BY h.SalesOrderNumber
	) AS hdr
	ON t.SalesOrderNumber = hdr.SalesOrderNumber

	LEFT JOIN [Pricing].[price_adjustment_enroll] AS enroll
	ON (c.BillTo = enroll.BillTo) AND
		(t.Date between enroll.PJEFTJ_effective_date and enroll.PJEXDJ_expired_date) AND
		(t.PriceMethod = enroll.PriceMethod) 
/*
	LEFT JOIN [Dimension].[QuotePrice] AS quote
	ON enroll.SNAST__adjustment_name = quote.[Adjustment] AND
		i.ItemKey = quote.[ItemKey] AND
		c.BillTo = enroll.[Billto]
*/


WHERE        
	(NOT (t.OrderSourceCode IN ('A', 'L'))) AND 
	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE d.FiscalMonth = dd.FiscalMonth)) AND
	(1 = 1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*

SELECT        FactKey, COUNT(*) AS Expr1
FROM            Fact.Sale
GROUP BY FactKey
HAVING        (COUNT(*) > 1)

*/
-- SELECT top 10 * FROM Fact.Sale ORDER BY 1 

-- SELECT count(*) FROM Fact.Sale 
-- org 1570012, 28s
-- new 1570012

