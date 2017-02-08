
SELECT        CalMonth, COUNT(DocType) AS Expr1, FreeGoodsInvoicedInd
FROM            BRS_TransactionDW
GROUP BY CalMonth, FreeGoodsInvoicedInd
ORDER BY 1

-- DELETE FROM BRS_TransactionDW WHERE CalMonth between 201501 and 201702

/*
-- test

SELECT        CalMonth, SUM(ShippedQty) AS ShippedQty, SUM(GPAmt) AS GPAmt, SUM(GPAtFileCostAmt) AS GPAtFileCostAmt, SUM(GPAtCommCostAmt) AS GPAtCommCostAmt, 
                         SUM(ExtChargebackAmt) AS ExtChargebackAmt, SUM(NetSalesAmt) AS NetSalesAmt, SUM(ExtPriceORG) AS ExtPriceORG, SUM(ExtListPriceORG) AS ExtListPriceORG
FROM            BRS_TransactionDW
WHERE        (CalMonth BETWEEN 201701 AND 201712)
GROUP BY CalMonth

*/



