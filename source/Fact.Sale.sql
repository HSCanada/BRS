﻿
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
**	22 Aug 19	tmc		cleanup model for CSR discounting
**    
*******************************************************************************/

SELECT        
	t.ID											AS FactKey

	,t.Shipto										AS ShipTo
	,i.ItemKey										AS ItemKey

/*
	,ISNULL(q.QuotePriceKey,0)						AS QuotePriceKey
	,q.EnrollSource
	,CASE WHEN q.QuotePriceKey IS NULL THEN 0 ELSE 1 END AS OnActiveQuoteInd
*/

	,pm.PriceMethodKey
	,d.FiscalMonth									AS FiscalMonth	
	,CAST(t.Date AS date)							AS DateKey
	,t.SalesOrderNumber
	,t.LineNumber
	,t.FreeGoodsInvoicedInd
	
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
	,c.BillTo
	,[DocType]
	,[OrderPromotionCode]
	,[OrderSourceCode]
	,[EnteredBy]
	,[OrderTakenBy]
	,pm.PriceMethod
	

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
			ON 
				h.SalesOrderNumber = d.SalesOrderNumber AND
				h.[DocType] = d.[DocType]
		GROUP BY h.SalesOrderNumber
	) AS hdr
	ON t.SalesOrderNumber = hdr.SalesOrderNumber

/*
	-- match sales to QuotePrice line
	LEFT JOIN
	(
		SELECT
			quot.QuotePriceKey, 
			quot.Adjustment, 
			enr.Billto,
			quot.ItemKey, 
			enr.PJEFTJ_effective_date, 
			enr.PJEXDJ_expired_date, 
			enr.EnrollSource, 
			enr.PriceMethod
		FROM            
			Pricing.price_adjustment_enroll AS enr 

			INNER JOIN Dimension.QuotePrice AS quot 
			ON
			(
				enr.SNAST__adjustment_name = quot.Adjustment AND
				EnrollSource = 'CLACTR'
			)	

		UNION ALL

		SELECT
			quot.QuotePriceKey, 
			quot.Adjustment, 
			enr.Billto,
			quot.ItemKey, 
			enr.PJEFTJ_effective_date, 
			enr.PJEXDJ_expired_date, 
			enr.EnrollSource, 
			enr.PriceMethod
		FROM            
			Pricing.price_adjustment_enroll AS enr 

			INNER JOIN Dimension.QuotePrice AS quot 
			ON
			(
				enr.SNAST__adjustment_name = quot.Adjustment AND
				(EnrollSource <> 'CLACTR' AND quot.BillTo = enr.BillTo)
			)
		) as q
		ON (c.BillTo = q.BillTo) AND
			(i.ItemKey = q.ItemKey) AND
--			remove this as per conversion with Marco (enroll dates are pushed forward)		
--			(t.Date BETWEEN q.PJEFTJ_effective_date AND q.PJEXDJ_expired_date) AND
			(t.PriceMethod = q.PriceMethod)
*/

WHERE        
	(NOT (t.OrderSourceCode IN ('A', 'L'))) AND 
	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE d.FiscalMonth = dd.FiscalMonth)) AND

	-- test

	(1 = 1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM Fact.Sale ORDER BY 1 

/*

-- Test Sales dups
SELECT        FactKey, COUNT(*) AS Expr1
FROM            Fact.Sale
GROUP BY FactKey
HAVING        (COUNT(*) > 1)

SELECT 
TOP 10 
* FROM Fact.Sale 
WHERE SalesOrderNumber = 11164737

SELECT [BillTo]
      ,[PJASN__adjustment_schedule]
      ,[PJEFTJ_effective_date]
      ,[PJEXDJ_expired_date]
      ,[PJUPMJ_date_updated]
      ,[PJUSER_user_id]
      ,[SNAST__adjustment_name]
      ,[EnrollSource]
      ,[PriceMethod]
  FROM [DEV_BRSales].[Pricing].[price_adjustment_enroll] WHERE SNAST__adjustment_name = 'ADC01ASP'

-- join accounts
SELECT
	quot.QuotePriceKey, 
	quot.Adjustment, 
	enr.Billto,
	quot.ItemKey, 
	quot.tempItemCode, 
	enr.PJEFTJ_effective_date, 
	enr.PJEXDJ_expired_date, 
	enr.EnrollSource, 
	enr.PriceMethod
FROM            
	Pricing.price_adjustment_enroll AS enr 

	INNER JOIN Dimension.QuotePrice AS quot 
	ON
	(
		enr.SNAST__adjustment_name = quot.Adjustment AND
		EnrollSource = 'CLACTR'
	)	
-- 2819903 rows in 26s
UNION ALL

SELECT
	quot.QuotePriceKey, 
	quot.Adjustment, 
	enr.Billto,
	quot.ItemKey, 
	quot.tempItemCode, 
	enr.PJEFTJ_effective_date, 
	enr.PJEXDJ_expired_date, 
	enr.EnrollSource, 
	enr.PriceMethod
FROM            
	Pricing.price_adjustment_enroll AS enr 

	INNER JOIN Dimension.QuotePrice AS quot 
	ON
	(
		enr.SNAST__adjustment_name = quot.Adjustment AND
		(EnrollSource <> 'CLACTR' AND quot.BillTo = enr.BillTo)
	)

-- 213361 rows in 4s

-- 3033264 rows in 2:27

*/

-- SELECT count(*) FROM Fact.Sale 
-- org 1 570 012, 28s
-- new 1570012

