
-- test case
SELECT   
t.SalesOrderNumber, t.DocType, t.LineNumber, t.CalMonth,
t.Date, t.Shipto

, t.Item, t.ShippedQty, t.NetSalesAmt, t.GPAmt, t.GPAtFileCostAmt, t.GPAtCommCostAmt, t.ExtChargebackAmt, 

t.ExtDiscAmt, t.ID, t.EnteredBy, t.OrderTakenBy, t.OrderSourceCode, t.CustomerPOText1, t.PriceMethod, t.PromotionCode, t.OrderPromotionCode, t.VPA, 
t.LineTypeOrder, t.SalesDivision, t.MajorProductClass, t.ChargebackContractNumber, t.InvoiceNumber, t.BackorderInd, t.FreeGoodsEstInd,  t.FreeGoodsInvoicedInd, t.FreeGoodsRedeemedInd, t.ExtPrice, t.ExtListPrice, t.CreditMinorReasonCode, t.CreditTypeCode, t.GEP_Order_Flag_ind
, h.CorporatePrice
, h.CorporatePrice * t.ShippedQty ext_price_calc

FROM     BRS_TransactionDW AS t LEFT OUTER JOIN
             BRS_ItemBaseHistory AS h ON t.CalMonth = h.CalMonth AND t.Item = h.Item
WHERE   
(FreeGoodsInvoicedInd = 1) and
--(t.ExtPrice = 0) AND
(h.CorporatePrice > 0) AND

(t.SalesOrderNumber in(16854633, 17040186, 17241831)) AND
h.CalMonth in(202401, 202403, 202405)
order by 4


--
UPDATE  BRS_TransactionDW
SET      
	-- patch the free goods missing ext price base on historical base
--	ExtPrice = h.CorporatePrice * t.ShippedQty
	 ExtListPrice = h.CorporatePrice * t.ShippedQty

	-- archive old data
--	,ExtPriceORG = ExtPrice
	,ExtListPriceORG = ExtListPrice

FROM     
BRS_TransactionDW t 

LEFT OUTER JOIN BRS_ItemBaseHistory AS h 

ON t.CalMonth = h.CalMonth AND t.Item = h.Item
WHERE   
-- fixed are Free goods with missing extprice and historical base non-zero
(t.FreeGoodsInvoicedInd = 1) AND 
(t.ExtListPrice = 0) AND 
(h.CorporatePrice > 0) AND 

(t.CalMonth between 202201 and 202412)
-- subset to test
--(t.SalesOrderNumber IN (16854633, 17040186, 17241831)) AND (h.CalMonth IN (202401, 202403, 202405))
GO


--

UPDATE  BRS_TransactionDW
SET      
	-- patch the free goods missing ext price base on historical base
--	ExtPrice = h.CorporatePrice * t.ShippedQty
	 ExtListPrice = ExtListPriceORG,
	 ExtPrice = ExtPriceORG
FROM     
BRS_TransactionDW t 

WHERE   

-- subset to test
(t.SalesOrderNumber IN (16854633, 17040186, 17241831)) 
GO



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
-- priv code
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

	(FreeGoodsInvoicedInd = 1) and
	(t.SalesOrderNumber in(16854633, 17040186, 17241831)) AND

    --(d.FiscalMonth between  @dtFrom and @dtTo) AND
	-- test
    -- (ext.PromotionTrackingCode = 'PD') AND
	--
    (1=1)

GROUP BY 
    d.FiscalMonth, 
    t.Shipto, 
    t.Item, 
    t.OrderSourceCode, 
    t.OrderTakenBy, 
    t.FreeGoodsInvoicedInd,
    ext.PromotionTrackingCode


	--check for missing update after...



SELECT   
t.SalesOrderNumber, t.DocType, t.LineNumber, t.CalMonth,
t.Date, t.Shipto
, t.Item, t.ShippedQty, t.NetSalesAmt, t.GPAmt, t.GPAtFileCostAmt, t.GPAtCommCostAmt, t.ExtChargebackAmt, 
t.ExtDiscAmt, t.ID, t.EnteredBy, t.OrderTakenBy, t.OrderSourceCode, t.CustomerPOText1, t.PriceMethod, t.PromotionCode, t.OrderPromotionCode, t.VPA, 
t.LineTypeOrder, t.SalesDivision, t.MajorProductClass, t.ChargebackContractNumber, t.InvoiceNumber, t.BackorderInd, t.FreeGoodsEstInd,  t.FreeGoodsInvoicedInd, t.FreeGoodsRedeemedInd, t.ExtPrice, t.ExtListPrice, t.CreditMinorReasonCode, t.CreditTypeCode, t.GEP_Order_Flag_ind

FROM     BRS_TransactionDW AS t 
WHERE   
(FreeGoodsInvoicedInd = 1) and
(calmonth between 202401 and 202602) and
t.ExtListPrice = 0

--(t.ExtPrice = 0) AND

order by 4
