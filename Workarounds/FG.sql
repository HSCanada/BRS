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

-- check bad SO

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


-- Check flag - FreeGoodsRedeemedInd
SELECT     CalMonth, COUNT( CalMonth), sum(GPAtFileCostAmt)
FROM         BRS_TransactionDW
WHERE     (FreeGoodsRedeemedInd = 1)
AND    (CalMonth >= 201701)
GROUP BY CalMonth

