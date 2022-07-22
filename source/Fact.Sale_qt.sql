
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[Sale_qt]
AS

/******************************************************************************
**	File: 
**	Name: Sales Quote Tracker
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
**	Date: 22 Jan 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	30 Jan 19	tmc		Add SalesCategory to allow Merch, less free goods for speed
**	22 Aug 19	tmc		Fixed join now that Salesorder+DocType is PK, add csr
**	31 Oct 19	tmc		Add Historical Market Segment
**	12 Dec 19	tmc		add return codes lookup and original doctype
**	16 Aug 20	tmc		add Exclusives 
**	18 Mar 21	tmc		add promo tracking sales
**	29 Sep 21	tmc		add backorder for show analyis
**	20 Jul 22	tmc		add PO Field to help with GSP analysis
**	21 Jul 22	tmc		move filter logic from SSAS model to query.  add P&G FG
**    
*******************************************************************************/

SELECT
--    top 10      
	t.ID											AS FactKey

	,c.BillTo										AS BillTo
	,t.Shipto										AS ShipTo
	,i.ItemKey										AS ItemKey
	,csr.[entered_by_key]
	,ISNULL( mc.[MarketClassKey], 1)				AS MarketClassKey
	,ISNULL(excl.Excl_key,0)						AS EpsKey
	,ISNULL(cred.[credit_key], 1)					AS CreditKey

/*
	-- quote link - phase 2
	,ISNULL(q.QuotePriceKey,0)						AS QuotePriceKey
	,CASE WHEN q.QuotePriceKey IS NULL THEN 0 ELSE 1 END AS OnActiveQuoteInd
	,q.EnrollSource
*/

	,pm.PriceMethodKey
	,ISNULL(promo.[promotion_key], 1)				AS PromotionKey
	,d.FiscalMonth									AS FiscalMonth	
	,CAST(t.Date AS date)							AS DateKey
	,CAST(ISNULL(torg.Date, '1980-01-01') as date)	AS ReturnOriginalDateKey

	,t.SalesOrderNumber
	,t.LineNumber

	,t.OriginalSalesOrderNumber
	,t.OriginalOrderLineNumber
	,CASE WHEN t.OriginalSalesOrderNumber = t.SalesOrderNumber THEN 0 ELSE 1 END AS ReturnValidInd

	,t.FreeGoodsInvoicedInd
	
	,(t.ShippedQty)									AS Quantity
	,(t.NetSalesAmt)								AS SalesAmt
	,(t.GPAmt + ISNULL(t.ExtChargebackAmt,0))		AS GPAmt
	,(t.GPAtCommCostAmt)							AS GPAtCommCostAmt
	,(t.ExtChargebackAmt)							AS ExtChargebackAmt

	,(t.ExtListPrice  + t.ExtPrice -  t.NetSalesAmt)  AS ExtBaseAmt
	,(t.ExtListPrice  + t.ExtPrice -2*t.NetSalesAmt)  AS DiscountAmt
	,(t.ExtListPrice  + 0          -  t.NetSalesAmt)  AS DiscountLineAmt
	,(0               + t.ExtPrice -  t.NetSalesAmt)  AS DiscountOrderAmt
	-- Lookup fields for Salesorder dimension
	,hdr.IDMin										AS FactKeyFirst
	,IDMin											AS sales_order_key
	,t.[DocType]
	,t.[OrderPromotionCode]
	,t.[OrderSourceCode]
	,t.[EnteredBy]
	,t.[OrderTakenBy]
	,pm.PriceMethod
	,i.SalesCategory
	,hdr.PromotionTrackingCode
	-- add backorder for show analyis

--	,CASE WHEN  t.Date = t.OrderFirstShipDate THEN 0 ELSE 1 END backorder_ind
	,CASE WHEN  NOT t.DocType like 'S%' OR t.Date = t.OrderFirstShipDate THEN 0 ELSE 1 END backorder_ind
	,CAST(t.OrderFirstShipDate AS date)							AS OrderFirstShipDateKey
	,hdr.[CustomerPOText1]


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

	INNER JOIN [Pricing].[entered_by] csr
	ON t.EnteredBy = csr.[entered_by_code]

	LEFT JOIN [dbo].[BRS_Promotion] as promo
	ON t.PromotionCode = promo.PromotionCode AND
		t.PriceMethod = 'P'

	LEFT JOIN BRS_CustomerFSC_History AS h
	ON h.ShipTo = t.Shipto   AND
		h.FiscalMonth = d.FiscalMonth

	LEFT JOIN [dbo].[BRS_CustomerMarketClass] mc
	ON mc.MarketClass = h.HIST_MarketClass

	LEFT JOIN [dbo].[BRS_Creditinfo] cred
	ON t.CreditMinorReasonCode = cred.CreditMinorReasonCode AND
	t.CreditTypeCode = cred.CreditTypeCode

	LEFT JOIN BRS_TransactionDW AS torg
	ON torg.SalesOrderNumber =  t.OriginalSalesOrderNumber AND
		torg.DocType = t.OriginalOrderDocumentType AND
		torg.LineNumber = t.OriginalOrderLineNumber

	INNER JOIN [dbo].[BRS_ItemHistory] as ih
	ON t.Item = ih.[Item] AND
		d.[FiscalMonth] = ih.[FiscalMonth]

	LEFT JOIN [hfm].[exclusive_product] as excl
	ON ih.Excl_key = excl.Excl_Key

	-- identify first sales order (for sales order dimension)
	INNER JOIN 
	(
		SELECT
			h.SalesOrderNumber 
			,MIN(d.ID) AS IDMin
			,MIN(h.[PromotionTrackingCode]) AS PromotionTrackingCode
			,MIN(d.[CustomerPOText1]) AS [CustomerPOText1]
		FROM
			BRS_TransactionDW_Ext AS h INNER JOIN

			BRS_TransactionDW AS d 
			ON h.SalesOrderNumber = d.SalesOrderNumber AND
				h.DocType = d.DocType
		GROUP BY h.SalesOrderNumber
	) AS hdr
	ON t.SalesOrderNumber = hdr.SalesOrderNumber

/*
	-- quote link - phase 2

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
-- no quotes on Astea, remove filter so that we can allign to discount merch reporting
--	(NOT (t.OrderSourceCode IN ('A', 'L'))) AND 

	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE d.FiscalMonth = dd.FiscalMonth)) AND

	(i.SalesCategory in( 'MERCH', 'SMEQU', 'TEETH')) AND
	-- Free goods is a rabbit hole.  just allowing GSP in for now, tmc, 21 Jul 22
	(t.FreeGoodsInvoicedInd = 0 OR i.Supplier= 'PROCGA' ) AND
	-- test
	--t.SalesOrderNumber = 1113586 AND
	(1 = 1)

GO

-- 2m21s prod
-- 1m12s qa
-- SELECT top 10 * FROM Fact.Sale_qt 

-- SELECT count(*) FROM Fact.Sale_qt
-- 8671158 60s

/*

SELECT sum(SalesAmt) FROM Fact.Sale_qt 
where 
FiscalMonth between 201901 and 201909 AND
SalesCategory = 'MERCH' and
(1=1)

QA 195588758.32

*/
/*

-- Test Sales dups
SELECT        FactKey, COUNT(*) AS Expr1
FROM            Fact.Sale
GROUP BY FactKey
HAVING        (COUNT(*) > 1)

SELECT 
TOP 10 
* FROM Fact.Sale 
WHERE FactKey = 25127039

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

/*
-- backorder test
select top 100 SalesOrderNumber, DocType, LineNumber,  CalMonth,   Date, OrderFirstShipDate,
CASE WHEN  NOT DocType like 'S%' OR Date = OrderFirstShipDate THEN 0 ELSE 1 END backorder_ind
from BRS_TransactionDW where CalMonth = 202109 and DocType like 'S%'
*/


-- SELECT count(*) FROM Fact.Sale_qt where fiscalmonth = 202109
-- 218196 @ 1m54
-- 7 670 103, 12s

-- SELECT top 100 * FROM Fact.Sale_qt where fiscalmonth >= 201901 and doctype = 'CM' and ReturnValidInd =0
-- SELECT top 100 * FROM Fact.Sale_qt where fiscalmonth >= 201901 

-- why do we care about first ship date on credit? what problems? just just the order date.  full stop.


