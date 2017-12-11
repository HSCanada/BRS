-- Exec   [BRS_BE_Transaction_DW_load_proc] 0

UPDATE    BRS_Transaction
SET              ExtChargebackAmt = w.ExtChargebackAmt
FROM         BRS_TransactionDW AS w INNER JOIN
                      BRS_Transaction ON w.SalesOrderNumber = BRS_Transaction.SalesOrderNumberKEY AND w.DocType = BRS_Transaction.DocType AND
                      w.LineNumber = BRS_Transaction.LineNumber AND w.Date = BRS_Transaction.SalesDate AND w.Shipto = BRS_Transaction.Shipto AND
                      w.Item = BRS_Transaction.Item AND w.LineTypeOrder = BRS_Transaction.LineTypeOrder
WHERE     (BRS_Transaction.FiscalMonth between 201712and 201712) AND (ISNULL(BRS_Transaction.ExtChargebackAmt,0) <> w.ExtChargebackAmt)  
