
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

-- correct 2m per year
UPDATE    
    BRS_TransactionDW
SET              
    ExtListPrice    = CASE WHEN LineTypeOrder = 'CP'                    THEN NetSalesAmt ELSE ExtListPriceORG END
    , ExtPrice        = CASE WHEN OrderSourceCode IN ('A', 'L', 'K')    THEN NetSalesAmt ELSE ExtPriceORG END
WHERE     
    (CalMonth between 201701 and 201712)


--- Add Discount Base, Order, Line to summary table...  TBD



-- reset
UPDATE    
    BRS_TransactionDW
SET              
    ExtListPrice    = ExtListPriceORG
    , ExtPrice        = ExtPriceORG 
WHERE     
    (CalMonth between 201608 and 201608)

--
SELECT 
    t.CalMonth, 
    t.Date,
--    t.Item,
    t.OrderSourceCode, 
    t.PriceMethod, 

    SUM(t.NetSalesAmt) AS NetSalesAmt, 

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
    (t.CalMonth between 201212 and 201212) AND 
--    (t.SalesOrderNumber = 9531088 ) AND
    (t.FreeGoodsInvoicedInd = 0) AND
    (t.LineTypeOrder <> 'CP') AND
    (s.AdvancedPricingInd = 1) AND
--    (t.ExtPrice <> t.NetSalesAmt) and
    (1=1)
GROUP BY 
    t.CalMonth, 
    t.Date,
--    t.Item,
    t.OrderSourceCode, 
    t.PriceMethod 
HAVING
    SUM(t.ExtListPrice  + t.ExtPrice -  NetSalesAmt) <> 0
ORDER BY 2


-- update History, 3 min
UPDATE    BRS_TransactionDW 
SET              ExtDiscAmt = ExtListPrice  + ExtPrice -2.0*NetSalesAmt
WHERE     (CalMonth between 201601 and 201612)


