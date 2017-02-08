/*
-- rename DW fields to ORG

EXECUTE sp_rename N'dbo.BRS_TransactionDW.ExtPrice', N'Tmp_ExtPriceORG', 'COLUMN' 
EXECUTE sp_rename N'dbo.BRS_TransactionDW.ExtListPrice', N'Tmp_ExtListPriceORG_1', 'COLUMN' 
EXECUTE sp_rename N'dbo.BRS_TransactionDW.Tmp_ExtPriceORG', N'ExtPriceORG', 'COLUMN' 
EXECUTE sp_rename N'dbo.BRS_TransactionDW.Tmp_ExtListPriceORG_1', N'ExtListPriceORG', 'COLUMN' 

-- Add replacemnts under statndard names *BUT* with new logic, 13 min

ALTER TABLE dbo.BRS_TransactionDW ADD
	ExtPrice money NOT NULL CONSTRAINT DF_BRS_TransactionDW_ExtPriceNEW DEFAULT ((0)),
	ExtListPrice money NOT NULL CONSTRAINT DF_BRS_TransactionDW_ExtListPriceNEW DEFAULT ((0))
GO


ALTER TABLE dbo.BRS_OrderSource ADD
	AdvancedPricingInd bit NOT NULL CONSTRAINT DF_BRS_OrderSource_AdvancedPricingInd DEFAULT 0
GO

UPDATE    BRS_OrderSource
SET              AdvancedPricingInd =0 

UPDATE    BRS_OrderSource
SET              AdvancedPricingInd =1 
WHERE     (NOT (OrderSourceCode IN ('A', 'L', 'K', ' '))) 



-- reset
UPDATE    
    BRS_TransactionDW
SET              
    ExtListPrice    = ExtListPriceORG
    , ExtPrice        = ExtPriceORG 
WHERE     
    (CalMonth between 201201 and 201712)

-- correct 2m per year
UPDATE    
    BRS_TransactionDW
SET              
    ExtListPrice    = CASE WHEN LineTypeOrder IN ('CP', 'CE')          THEN NetSalesAmt ELSE ExtListPriceORG END	
    , ExtPrice        = CASE WHEN OrderSourceCode IN ('A', 'L', 'K')    THEN NetSalesAmt ELSE ExtPriceORG END
WHERE     
    (CalMonth between 201201 and 201712)


-- update History, 3 min
UPDATE    BRS_TransactionDW 
SET              ExtDiscAmt = ExtListPrice  + ExtPrice -2.0*NetSalesAmt
WHERE     
    (CalMonth between 201201 and 201712)



--
SELECT 
    t.CalMonth, 

--	t.[SalesOrderNumber],
--	t.[DocType],

--    t.Date,
--    t.Item,
--    t.OrderSourceCode, 
--    t.PriceMethod, 

    SUM(t.NetSalesAmt) AS NetSalesAmt, 
    SUM(t.GPAmt) AS GPAmt, 

    SUM(t.ExtPriceORG) AS ExtPriceORG, 
    SUM(t.ExtPrice) AS ExtPrice, 

    SUM(t.ExtListPriceORG)  AS ExtListPriceORG,
    SUM(t.ExtListPrice)  AS ExtListPrice,

    SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)    AS ExtBase,
    SUM(t.ExtListPrice  + 0          -  NetSalesAmt)    AS ExtDiscLine,
    SUM(0               + t.ExtPrice -  NetSalesAmt)    AS ExtDiscOrder,

    SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscTotal_CALC,
    SUM(t.ExtDiscAmt)                                   AS ExtDiscTotal_ACT,

    SUM(t.ExtListPrice  + 0          -  NetSalesAmt) / SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt) as disc_line_pct,
    SUM(0               + t.ExtPrice -  NetSalesAmt) / SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt) as disc_order_pct,
    SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt) / SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt) as disc_total_pct
FROM         
    BRS_TransactionDW AS t 
    
    INNER JOIN BRS_OrderSource AS s 
    ON t.OrderSourceCode = s.OrderSourceCode
WHERE     
--    (t.CalMonth between 201607 and 201607) AND 
--    (t.SalesOrderNumber = 9531088 ) AND
--    (t.FreeGoodsInvoicedInd = 0) AND
--    (t.LineTypeOrder = 'CL') AND
--    (s.AdvancedPricingInd = 1) AND
--	(t.PriceMethod = 'Q') AND
--    (t.ExtPrice <> t.NetSalesAmt) and
    (1=1)
GROUP BY 
    t.CalMonth

--	t.[SalesOrderNumber],
--	t.[DocType],
--    t.Date,
--    t.Item,
--    t.OrderSourceCode, 
--    t.PriceMethod 
HAVING
    SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt) <> 0
ORDER BY 1 desc



---

ALTER TABLE BRS_AGG_CMI_DW_Sales ADD
	ExtBase money NOT NULL CONSTRAINT DF_BRS_AGG_CMI_DW_Sales_ExtBase DEFAULT (0),
	ExtDiscLine money NOT NULL CONSTRAINT DF_BRS_AGG_CMI_DW_Sales_ExtDiscLine DEFAULT (0),
	ExtDiscOrder money NOT NULL CONSTRAINT DF_BRS_AGG_CMI_DW_Sales_ExtDiscOrder DEFAULT (0)
GO

ALTER TABLE BRS_AGG_IMD_Sales ADD
	ExtBase money NOT NULL CONSTRAINT DF_BRS_AGG_IMD_Sales_ExtBase DEFAULT (0),
	ExtDiscLine money NOT NULL CONSTRAINT DF_BRS_AGG_IMD_Sales_ExtDiscLine DEFAULT (0),
	ExtDiscOrder money NOT NULL CONSTRAINT DF_BRS_AGG_IMD_Sales_ExtDiscOrder DEFAULT (0)
GO
*/

-----------------------------------------------------------------------------------

-- 1. Exception Select
SELECT TOP 10
	t.[SalesOrderNumber],
--	t.[LineNumber],

	t.[DocType],
    t.FreeGoodsInvoicedInd,
    s.AdvancedPricingInd,
    t.OrderSourceCode, 
    t.LineTypeOrder,
    t.PriceMethod,
	t.[OrderPromotionCode],

    SUM(t.NetSalesAmt) AS NetSalesAmt, 
	SUM(t.GPAmt)		AS GPAmt,

    SUM(t.ExtPriceORG) AS ExtPriceORG, 
    SUM(t.ExtPrice) AS ExtPrice, 

    SUM(t.ExtListPriceORG)  AS ExtListPriceORG,
    SUM(t.ExtListPrice)  AS ExtListPrice,

    SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)    AS ExtBase,
    SUM(t.ExtListPrice  + 0          -  NetSalesAmt)    AS ExtDiscLine,
    SUM(0               + t.ExtPrice -  NetSalesAmt)    AS ExtDiscOrder,

    SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscTotal_CALC,
    SUM(t.ExtDiscAmt)                                   AS ExtDiscTotal_ACT

FROM         
    BRS_TransactionDW AS t 
    
    INNER JOIN BRS_OrderSource AS s 
    ON t.OrderSourceCode = s.OrderSourceCode
WHERE     
    (t.CalMonth between 201606 and 201612) AND 
--	(t.SalesOrderNumber=9193714) AND
    (t.FreeGoodsInvoicedInd <> 1) AND
    (t.DocType NOT IN('SL', 'CO')) AND
    (t.LineTypeOrder NOT IN ('CP','CL')) AND
--    (s.AdvancedPricingInd = 0) AND
--    (t.ExtPriceORG) = 0 AND
--	(t.NetSalesAmt <> 0) AND
	(t.PriceMethod = 'Q') AND
--	(NetSalesAmt) <> (ExtListPrice) AND
    (1=1)
GROUP BY 
	t.[SalesOrderNumber],
--	t.[LineNumber],
	t.[DocType],
    t.FreeGoodsInvoicedInd,
    s.AdvancedPricingInd,
    t.OrderSourceCode, 
    t.LineTypeOrder,
    t.PriceMethod,
	t.[OrderPromotionCode]
ORDER BY 16 ASC

-- 2 Show Detail
SELECT 
	t.[SalesOrderNumber],
	t.[LineNumber],

	t.[DocType],
    t.FreeGoodsInvoicedInd,
    s.AdvancedPricingInd,
    t.OrderSourceCode, 
    t.LineTypeOrder,
    t.PriceMethod,
	t.[OrderPromotionCode],

    SUM(t.NetSalesAmt) AS NetSalesAmt, 
	SUM(t.GPAmt)		AS GPAmt,

    SUM(t.ExtPriceORG) AS ExtPriceORG, 
    SUM(t.ExtPrice) AS ExtPrice, 

    SUM(t.ExtListPriceORG)  AS ExtListPriceORG,
    SUM(t.ExtListPrice)  AS ExtListPrice,

    SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)    AS ExtBase,
    SUM(t.ExtListPrice  + 0          -  NetSalesAmt)    AS ExtDiscLine,
    SUM(0               + t.ExtPrice -  NetSalesAmt)    AS ExtDiscOrder,

    SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscTotal_CALC,
    SUM(t.ExtDiscAmt)                                   AS ExtDiscTotal_ACT

FROM         
    BRS_TransactionDW AS t 
    
    INNER JOIN BRS_OrderSource AS s 
    ON t.OrderSourceCode = s.OrderSourceCode
WHERE     
    (t.CalMonth between 201606 and 201612) AND 
	(t.SalesOrderNumber=9627267) AND
--    (t.FreeGoodsInvoicedInd <> 1) AND
--    (t.DocType <>'SL') AND
--    (t.LineTypeOrder NOT IN ('CP','CL')) AND
--    (s.AdvancedPricingInd = 1) AND
--    (t.ExtPriceORG) = 0 AND
--	(t.NetSalesAmt <> 0) AND
--	(t.PriceMethod = 'Q') AND
--	(NetSalesAmt) <> (ExtListPrice) AND
    (1=1)
GROUP BY 
	t.[SalesOrderNumber],
	t.[LineNumber],
	t.[DocType],
    t.FreeGoodsInvoicedInd,
    s.AdvancedPricingInd,
    t.OrderSourceCode, 
    t.LineTypeOrder,
    t.PriceMethod,
	t.[OrderPromotionCode]
ORDER BY 16 DESC


-- Price lookup
SELECT        CalMonth, Item, CorporatePrice
FROM            BRS_ItemBaseHistory
WHERE        (Item = '6317801')

SELECT top 10
	t.[SalesOrderNumber],
	t.[OrderPromotionCode],
    t.FreeGoodsInvoicedInd,

    SUM(t.NetSalesAmt) AS NetSalesAmt, 
	SUM(t.GPAmt)		AS GPAmt,

    SUM(t.ExtPriceORG) AS ExtPriceORG, 
    SUM(t.ExtPrice) AS ExtPrice, 

    SUM(t.ExtListPriceORG)  AS ExtListPriceORG,
    SUM(t.ExtListPrice)  AS ExtListPrice,

    SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)    AS ExtBase,
    SUM(t.ExtListPrice  + 0          -  NetSalesAmt)    AS ExtDiscLine,
    SUM(0               + t.ExtPrice -  NetSalesAmt)    AS ExtDiscOrder,

    SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscTotal_CALC,
    SUM(t.ExtDiscAmt)                                   AS ExtDiscTotal_ACT

FROM         
    BRS_TransactionDW AS t 
    
    INNER JOIN BRS_OrderSource AS s 
    ON t.OrderSourceCode = s.OrderSourceCode

	INNER JOIN [zzzShipto] as c
	ON t.Shipto = c.ST
	
WHERE     
    (t.CalMonth between 201601 and 201601) AND
    (t.FreeGoodsInvoicedInd =0 ) AND
--	(t.SalesOrderNumber = 9552509) AND
    (1=1)
GROUP BY 
	t.[SalesOrderNumber],
    t.FreeGoodsInvoicedInd,
	t.[OrderPromotionCode]
HAVING 
--	SUM(0               + t.ExtPrice -  NetSalesAmt) <>0 AND
	1=1
ORDER BY 
ExtDiscLine DESC


/*
SELECT     
    t.Shipto, 
    i.SalesCategory										AS SalesCategory, 
    t.OrderSourceCode,
    t.FreeGoodsInvoicedInd, 
	p.PromotionTrackingCode                             AS PromotionTrackingCode, 
    t.DocType, 
    t.LineTypeOrder,
	t.PriceMethod,


    SUM(t.ShippedQty)                                   AS ShippedQty, 
    SUM(t.NetSalesAmt)                                  AS NetSalesAmt, 
	SUM(t.GPAmt)										AS GPAmt,

    SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscAmt,
    SUM(t.ExtListPriceORG)								AS ExtListPriceORG,
    SUM(t.ExtListPrice)                                 AS ExtListPrice,
    SUM(t.ExtPriceORG)									AS ExtPriceORG, 
    SUM(t.ExtPrice)                                     AS ExtPrice,

    SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt)    AS ExtBase,
    SUM(t.ExtListPrice  + 0          -  NetSalesAmt)    AS ExtDiscLine,
    SUM(0               + t.ExtPrice -  NetSalesAmt)    AS ExtDiscOrder,

    SUM(t.ExtListPrice  + t.ExtPrice -2*NetSalesAmt)    AS ExtDiscTotal_CALC,
    SUM(t.ExtDiscAmt)                                   AS ExtDiscTotal_ACT
	

FROM         
    BRS_TransactionDW AS t 
    
    INNER JOIN BRS_Item AS i 
    ON t.Item = i.Item 

    INNER JOIN BRS_SalesDay AS d 
    ON t.Date = d.SalesDate 

    INNER JOIN BRS_Promotion AS p 
    ON t.OrderPromotionCode = p.PromotionCode

	INNER JOIN [zzzShipto] as c
	ON t.Shipto = c.ST

WHERE     
    (d.FiscalMonth between  201601 and 201612) AND
    (1=1)


GROUP BY 
    t.Shipto, 
    t.OrderSourceCode, 
    t.OrderTakenBy, 
    t.FreeGoodsInvoicedInd,
    p.PromotionTrackingCode,
    i.[SalesCategory], 
    t.DocType, 
    t.LineTypeOrder,
	t.PriceMethod

*/
