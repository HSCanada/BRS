
SELECT 
    d.FiscalMonth, 
	c.PrivilegesCode,
	c.MarketClass_New,
	t.SalesOrderNumber,
	t.LineNumber,
	t.PromotionCode,
	t.PricingAdjustmentLine,
    t.Shipto, 
    t.Item, 
    (i.SalesCategory)                               AS SalesCategory, 
    t.OrderSourceCode,
    t.OrderTakenBy, 
    t.FreeGoodsInvoicedInd, 

	promo.PromotionTypeTracking,
	ext.PromotionTrackingCode,

    (t.ShippedQty)                                   AS ShippedQty, 
    (t.NetSalesAmt)                                  AS NetSalesAmt, 

    (t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscAmt,
    (t.ExtListPrice)                                 AS ExtListPrice,
    (t.ExtPrice)                                     AS ExtPrice,
	(t.GPAtFileCostAmt),
	(i.CurrentCorporatePrice)
	-- we can lookup historical price for FR fix


FROM         

    BRS_TransactionDW AS t 
    
    INNER JOIN BRS_Item AS i 
    ON t.Item = i.Item 

	INNER JOIN BRS_ItemHistory ih
	on ih.FiscalMonth = t.CalMonth and
	ih.Item = t.Item

    INNER JOIN BRS_SalesDay AS d 
    ON t.Date = d.SalesDate 

	INNER JOIN  [BRS_TransactionDW_Ext] AS ext
	ON t.SalesOrderNumber = ext.SalesOrderNumber AND
	t.DocType = ext.DocType

	INNER JOIN [dbo].[BRS_Promotion] promo
	ON ext.PromotionTrackingCode = promo.PromotionCode

	INNER JOIN BRS_Customer c
	ON t.Shipto = c.ShipTo



WHERE  
	(t.CalMonth between 202401 and 202412) and

	(c.PrivilegesCode like 'T%') and

	(i.SalesCategory in ('MERCH','SMEQU')) and

--	(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt) = 0 and
--	(t.FreeGoodsInvoicedInd = 1) and




--    (t.SalesOrderNumber = 16907668) AND
--	(t.item='7770136' )

--    (t.SalesOrderNumber = 17695598) AND
--	(t.item='5703333' )

	-- test
    -- (ext.PromotionTrackingCode = 'PD') AND
	--
    (1=1)

order by [NetSalesAmt] * [ShippedQty] desc

/*
SELECT     
    d.FiscalMonth, 
    t.Shipto, 
    t.Item, 
    MAX (i.SalesCategory)                               AS SalesCategory, 
    t.OrderSourceCode,
    t.OrderTakenBy, 
    t.FreeGoodsInvoicedInd, 

	CASE 
		WHEN MIN(promo.PromotionTypeTracking) = 'SHOW'
		THEN ext.PromotionTrackingCode  
		ELSE ''
	END													AS PromotionTrackingCode, 

    SUM(t.ShippedQty)                                   AS ShippedQty, 
    SUM(t.NetSalesAmt)                                  AS NetSalesAmt, 

    SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscAmt,
    SUM(t.ExtListPrice)                                 AS ExtListPrice,
    SUM(t.ExtPrice)                                     AS ExtPrice


FROM         

    BRS_TransactionDW AS t 
    
    INNER JOIN BRS_Item AS i 
    ON t.Item = i.Item 

    INNER JOIN BRS_SalesDay AS d 
    ON t.Date = d.SalesDate 

	INNER JOIN  [BRS_TransactionDW_Ext] AS ext
	ON t.SalesOrderNumber = ext.SalesOrderNumber AND
	t.DocType = ext.DocType

	INNER JOIN [dbo].[BRS_Promotion] promo
	ON ext.PromotionTrackingCode = promo.PromotionCode



WHERE     

    (t.SalesOrderNumber = 17695598) AND
	(t.item='5703333' )

	-- test
    -- (ext.PromotionTrackingCode = 'PD') AND
	--
--    ,(1=1)

GROUP BY 
    d.FiscalMonth, 
    t.Shipto, 
    t.Item, 
    t.OrderSourceCode, 
    t.OrderTakenBy, 
    t.FreeGoodsInvoicedInd,
    ext.PromotionTrackingCode

*/

-- ORG 8327 err rows