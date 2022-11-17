
-- gp_exception_R5557ALL, tmc, 15 Nov 22
SELECT top 10       d.FiscalMonth, t.SalesDivision, t.Item, t.Shipto, t.SalesOrderNumber, t.DocType, t.LineNumber, t.OrderSourceCode, t.PriceMethod, t.NetSalesAmt, t.GPAtCommCostAmt, t.GPAtFileCostAmt, t.GPAmt, t.ExtChargebackAmt, 
                         t.ShippedQty, t.ExtListPrice, t.ExtPrice, t.ExtDiscAmt, t.VPA, t.OrderTakenBy, t.EnteredBy, t.MajorProductClass, t.ID, t.Date, t.PromotionCode, t.OrderPromotionCode, t.GLBusinessUnit, t.FreeGoodsInvoicedInd, 
                         t.OriginalSalesOrderNumber, t.CreditMinorReasonCode, t.CreditTypeCode
FROM            BRS_TransactionDW AS t INNER JOIN
                         BRS_SalesDay AS d ON t.Date = d.SalesDate INNER JOIN
                         BRS_Item AS i ON t.Item = i.Item INNER JOIN
                         BRS_Customer AS c ON t.Shipto = c.ShipTo INNER JOIN
                         BRS_ItemMPC AS mpc ON i.MajorProductClass = mpc.MajorProductClass
WHERE
d.FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])
--(t.SalesOrderNumber = 15723866)