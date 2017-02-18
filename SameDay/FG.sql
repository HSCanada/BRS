/*
1. FG redeem.  Act vs est vs Redeem
2. Test Order disc NOT order promo in JDE

DEV

3. worth building AGG?

*/

TRUNCATE TABLE STAGE_BRS_FreeGoodsRedeem


-- ADD From Tony excel.


INSERT INTO BRS_FreeGoodsRedeem
                      (Item, SalesOrderNumber, FiscalMonth, ExtFileCostAmt, ShipTo, Supplier)
SELECT     Item, SalesOrderNumber, FiscalMonth, ExtFileCostAmt, ShipTo, Supplier
FROM         STAGE_BRS_FreeGoodsRedeem_Load

SELECT     STAGE_BRS_FreeGoodsRedeem_Load.SalesOrderNumber
FROM         STAGE_BRS_FreeGoodsRedeem_Load LEFT OUTER JOIN
                      BRS_TransactionDW_Ext ON STAGE_BRS_FreeGoodsRedeem_Load.SalesOrderNumber = BRS_TransactionDW_Ext.SalesOrderNumber
WHERE     (BRS_TransactionDW_Ext.SalesOrderNumber IS NULL)


-- Update flag - FreeGoodsRedeemedInd
UPDATE    BRS_TransactionDW
SET               FreeGoodsRedeemedInd = 1
FROM         BRS_FreeGoodsRedeem INNER JOIN
                      BRS_TransactionDW ON BRS_FreeGoodsRedeem.SalesOrderNumber = BRS_TransactionDW.SalesOrderNumber AND 
                      BRS_FreeGoodsRedeem.Item = BRS_TransactionDW.Item
WHERE     (BRS_FreeGoodsRedeem.FiscalMonth BETWEEN 201701 AND 201712) AND (BRS_TransactionDW.ShippedQty <> 0) AND (BRS_TransactionDW.NetSalesAmt = 0) AND 
                      (BRS_TransactionDW.FreeGoodsRedeemedInd <> 1)

/*
-- Update flag - FreeGoodsInvoicedInd
UPDATE    BRS_TransactionDW
SET               FreeGoodsRedeemedInd = 1
FROM         BRS_FreeGoodsRedeem INNER JOIN
                      BRS_TransactionDW ON BRS_FreeGoodsRedeem.SalesOrderNumber = BRS_TransactionDW.SalesOrderNumber AND 
                      BRS_FreeGoodsRedeem.Item = BRS_TransactionDW.Item
WHERE     (BRS_FreeGoodsRedeem.FiscalMonth >= 201610) AND (BRS_TransactionDW.ShippedQty <> 0) AND (BRS_TransactionDW.NetSalesAmt = 0) AND 
                      (BRS_TransactionDW.FreeGoodsRedeemedInd <> 1)
*/


-- Check flag - FreeGoodsRedeemedInd
SELECT     CalMonth, SUM( NetSalesAmt), sum(GPAtFileCostAmt)
FROM         BRS_TransactionDW
WHERE     (FreeGoodsRedeemedInd = 1)
AND    (CalMonth >= 201608)
GROUP BY CalMonth



-- ADD to DW proc

-- Update flag - FreeGoodsInvoicedInd
UPDATE    BRS_TransactionDW
SET               FreeGoodsInvoicedInd = 1

-- Select SalesOrderNumber, DocType, LineNumber, CalMonth, Item, MajorProductClass, ShippedQty, NetSalesAmt, FreeGoodsInvoicedInd, ExtListPrice / ShippedQty as unit_list, -GPAtFileCostAmt / ShippedQty as unit_cost
-- FROM         
--    BRS_TransactionDW

WHERE     
    (ShippedQty <> 0) AND 
    (NetSalesAmt = 0) AND 
    (ABS(GPAtFileCostAmt) > 0.02) AND  
    (FreeGoodsInvoicedInd <>1 ) AND
    (CalMonth between 201701 and 201701 ) AND 
    (1=1)

-- Update flag - FreeGoodsInvoicedInd rev
UPDATE    BRS_TransactionDW
SET               FreeGoodsInvoicedInd = 0

-- Select SalesOrderNumber, DocType, LineNumber, CalMonth, Item, MajorProductClass, ShippedQty, NetSalesAmt, FreeGoodsInvoicedInd, ExtListPrice / ShippedQty as unit_list, -GPAtFileCostAmt / ShippedQty as unit_cost
-- FROM         
--    BRS_TransactionDW

WHERE     
    (ShippedQty <> 0) AND 
    (NetSalesAmt = 0) AND 
    not (ABS(GPAtFileCostAmt) > 0.02) AND  
    NOT (FreeGoodsInvoicedInd <> 1 ) AND
    (CalMonth between 201701 and 201712 ) AND 
    (1=1)

-- 201212 - 201612

-- Check flag - FreeGoodsInvoicedInd
SELECT     CalMonth, SUM( NetSalesAmt), sum(GPAtFileCostAmt)
FROM         BRS_TransactionDW
WHERE     (FreeGoodsInvoicedInd = 1)
AND    (CalMonth >= 201608)
GROUP BY CalMonth
