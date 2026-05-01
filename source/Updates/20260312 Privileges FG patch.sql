/*
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
*/

-- fix FG with missing ExtListPrice 
UPDATE  BRS_TransactionDW
SET      
	-- patch the free goods missing ext price base on historical base
	 ExtListPrice = h.CorporatePrice * t.ShippedQty

	-- archive old data
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

(t.CalMonth between 202601 and 202603)
--(t.CalMonth between 202201 and 202412)
-- subset to test
--(t.SalesOrderNumber IN (16854633, 17040186, 17241831)) AND (h.CalMonth IN (202401, 202403, 202405))
GO

/*
-- revert
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

*/

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

*/

-- test FG for missing ExtListPrice 

SELECT   
t.SalesOrderNumber, t.DocType, t.LineNumber, t.CalMonth,
t.Date, t.Shipto
, t.Item, t.ShippedQty, t.NetSalesAmt, t.GPAmt, t.GPAtFileCostAmt, t.GPAtCommCostAmt, t.ExtChargebackAmt, 
t.ExtDiscAmt, t.ID, t.EnteredBy, t.OrderTakenBy, t.OrderSourceCode, t.CustomerPOText1, t.PriceMethod, t.PromotionCode, t.OrderPromotionCode, t.VPA, 
t.LineTypeOrder, t.SalesDivision, t.MajorProductClass, t.ChargebackContractNumber, t.InvoiceNumber, t.BackorderInd, t.FreeGoodsEstInd,  t.FreeGoodsInvoicedInd, t.FreeGoodsRedeemedInd, t.ExtPrice, t.ExtListPrice, t.CreditMinorReasonCode, t.CreditTypeCode, t.GEP_Order_Flag_ind

FROM     BRS_TransactionDW AS t 
WHERE   
(FreeGoodsInvoicedInd = 1) and
(calmonth between 202603 and 202603) and
--(calmonth between 202401 and 202602) and
t.ExtListPrice = 0

--(t.ExtPrice = 0) AND

order by 4


-- is free goods FreeGoodsRedeemedInd being used?
select top 10 * from [dbo].[BRS_TransactionDW] where FreeGoodsRedeemedInd = 1


SELECT   comm.freegoods.FiscalMonth, comm.freegoods.SalesOrderNumber, comm.freegoods.SourceCode, comm.freegoods.ShipTo, comm.freegoods.Item, comm.freegoods.Supplier, comm.freegoods.ExtFileCostCadAmt, comm.freegoods.ID, i.Excl_Code, i.MajorProductClass, c.VPA, c.MarketClass_New
FROM     comm.freegoods INNER JOIN
             BRS_Item AS i ON comm.freegoods.Item = i.Item INNER JOIN
             BRS_Customer AS c ON comm.freegoods.ShipTo = c.ShipTo
WHERE   (comm.freegoods.FiscalMonth >= 202501)


-- review est vs redeem, good
SELECT   fg.FiscalMonth, fg.SalesOrderNumber, fg.SourceCode, fg.ShipTo, fg.Item, fg.Supplier, i.Excl_Code, i.MajorProductClass, c.VPA, c.MarketClass_New, SUM(fg.ExtFileCostCadAmt) AS ExtFileCostCadAmt
FROM     comm.freegoods fg INNER JOIN
             BRS_Item AS i ON fg.Item = i.Item INNER JOIN
             BRS_Customer AS c ON fg.ShipTo = c.ShipTo
where   (fg.FiscalMonth between 202501 and 202602) and i.supplier <> 'DECMAT'
GROUP BY fg.FiscalMonth, fg.SalesOrderNumber, fg.SourceCode, fg.ShipTo, fg.Item, fg.Supplier, i.Excl_Code, i.MajorProductClass, c.VPA, c.MarketClass_New

-- map comm ACT to DW redeem, attemp -- too messy
SELECT   TOP (100) BRS_TransactionDW.SalesOrderNumber, BRS_TransactionDW.DocType, BRS_TransactionDW.LineNumber, BRS_TransactionDW.CalMonth, BRS_TransactionDW.Shipto, BRS_TransactionDW.Item, BRS_TransactionDW.ShippedQty, BRS_TransactionDW.NetSalesAmt, BRS_TransactionDW.FreeGoodsInvoicedInd, 
             BRS_TransactionDW.FreeGoodsEstInd, BRS_TransactionDW.FreeGoodsRedeemedInd, fg.ExtFileCostCadAmt, BRS_TransactionDW.GPAtFileCostAmt
FROM     comm.freegoods AS fg INNER JOIN
             BRS_TransactionDW ON fg.SalesOrderNumber = BRS_TransactionDW.SalesOrderNumber AND fg.ShipTo = BRS_TransactionDW.Shipto AND fg.Item = BRS_TransactionDW.Item
WHERE   (fg.FiscalMonth BETWEEN 202501 AND 202602) AND (fg.SourceCode = 'ACT') AND (BRS_TransactionDW.FreeGoodsInvoicedInd = 1)




SELECT   TOP (100) t.SalesOrderNumber, t.DocType, t.LineNumber, t.CalMonth, i.Supplier, i.Label, t.MajorProductClass, t.Item
FROM     BRS_TransactionDW AS t INNER JOIN
             BRS_Item AS i ON t.Item = i.Item
WHERE   
	(t.FreeGoodsInvoicedInd = 1) AND 
	(NOT (i.Supplier IN ('SIRONC', 'BAINTE', 'ROSSCH', 'IMPEXW', 'SABLEI', 'HENGLB', 'GLHEAL', 'PROCGA', 'USENDO', 'HENSCH', 'ORTHOT', 'SOUDEN', 'FKGDCH'))) AND 
	(i.Label <> 'P') AND 
	(t.MajorProductClass IN ('001', '002', '003', '004', '005', '006', '007', '008', '010', '011', 
			'012', '013', '017', '019', '020', '021', '022', '023', '025', '054', '057', '058', 
			'124', '125', '300', '316', '320', '340', '364', '370', '083', '082', '076', '084', 
			'355', '024', '073', '071', '372')) AND 
	(t.DocType <> 'SN') AND 
	(NOT (t.Item IN ('9394930', '1381736', '9395540'))) AND
	(t.CalMonth BETWEEN 202602 AND 202602) AND 
	(1=1)
GO


UPDATE   BRS_TransactionDW
SET        FreeGoodsRedeemedInd = 1
FROM     BRS_TransactionDW INNER JOIN
             BRS_Item AS i ON BRS_TransactionDW.Item = i.Item
WHERE   (BRS_TransactionDW.FreeGoodsInvoicedInd = 1) AND (NOT (i.Supplier IN ('SIRONC', 'BAINTE', 'ROSSCH', 'IMPEXW', 'SABLEI', 'HENGLB', 'GLHEAL', 'PROCGA', 'USENDO', 'HENSCH', 'ORTHOT', 'SOUDEN', 'FKGDCH'))) AND (i.Label <> 'P') AND (BRS_TransactionDW.MajorProductClass IN ('001', '002', '003', '004', '005', '006', '007', '008', '010', 
             '011', '012', '013', '017', '019', '020', '021', '022', '023', '025', '054', '057', '058', '124', '125', '300', '316', '320', '340', '364', '370', '083', '082', '076', '084', '355', '024', '073', '071', '372')) AND (BRS_TransactionDW.DocType <> 'SN') AND (NOT (BRS_TransactionDW.Item IN ('9394930', '1381736', '9395540'))) AND 
             (BRS_TransactionDW.CalMonth BETWEEN 202412 AND 202603) AND (1 = 1)
GO



SELECT   comm.freegoods.FiscalMonth, comm.freegoods.SalesOrderNumber, comm.freegoods.SourceCode, comm.freegoods.ShipTo, comm.freegoods.Item, comm.freegoods.Supplier, comm.freegoods.ExtFileCostCadAmt, comm.freegoods.ID, i.Excl_Code, i.MajorProductClass, c.VPA, c.MarketClass_New
FROM     comm.freegoods INNER JOIN
             BRS_Item AS i ON comm.freegoods.Item = i.Item INNER JOIN
             BRS_Customer AS c ON comm.freegoods.ShipTo = c.ShipTo
WHERE   (comm.freegoods.FiscalMonth >= 202501)
