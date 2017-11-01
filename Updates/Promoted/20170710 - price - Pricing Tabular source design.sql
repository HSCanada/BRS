SELECT        TOP (10) t.ID AS FactKey, fsc.FscKey, fsa.FsaKey, t.Date, t.SalesOrderNumber, t.LineNumber, dt.DocTypeKey, t.Shipto, c.BillTo, cg.CustGrpKey, vpa.VpaKey, t.Item, 
                         i.ID AS ItemKey, os.OrderSourceCodeKey, pm.PriceMethodKey, prom.PromotionId AS PromotionKey, t.FreeGoodsInvoicedInd, t.ShippedQty, t.NetSalesAmt, t.GPAmt, 
                         t.GPAtCommCostAmt, t.ExtChargebackAmt, t.ExtPrice, t.ExtListPrice
FROM            BRS_TransactionDW AS t INNER JOIN
                         BRS_SalesDay AS d ON d.SalesDate = t.Date INNER JOIN
                         BRS_Item AS i ON i.Item = t.Item INNER JOIN
                         BRS_Customer AS c ON t.Shipto = c.ShipTo INNER JOIN
                         BRS_DocType AS dt ON t.DocType = dt.DocType INNER JOIN
                         BRS_FSC_Rollup AS fsc ON c.TerritoryCd = fsc.TerritoryCd INNER JOIN
                         BRS_OrderSource AS os ON t.OrderSourceCode = os.OrderSourceCode INNER JOIN
                         BRS_PriceMethod AS pm ON t.PriceMethod = pm.PriceMethod INNER JOIN
                         BRS_Promotion AS prom ON t.PromotionCode = prom.PromotionCode AND t.OrderPromotionCode = prom.PromotionCode INNER JOIN
                         BRS_CustomerGroup AS cg ON c.CustGrpWrk = cg.CustGrp INNER JOIN
                         BRS_Customer_FSA AS fsa ON c.FSA = fsa.FSA INNER JOIN
                         BRS_CustomerVPA AS vpa ON c.VPA = vpa.VPA
WHERE        (NOT (t.OrderSourceCode IN ('A', 'L'))) AND (t.CalMonth BETWEEN 201605 AND 201605) AND (1 = 1)
