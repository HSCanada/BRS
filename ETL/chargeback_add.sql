/*

--work-around fix, 1 Feb 17

UPDATE    BRS_Transaction
SET              ExtChargebackAmt = w.ExtChargebackAmt
FROM         BRS_TransactionDW AS w INNER JOIN
                      BRS_Transaction ON w.SalesOrderNumber = BRS_Transaction.SalesOrderNumberKEY AND w.DocType = BRS_Transaction.DocType AND
                      w.LineNumber = BRS_Transaction.LineNumber AND w.Date = BRS_Transaction.SalesDate AND w.Shipto = BRS_Transaction.Shipto AND
                      w.Item = BRS_Transaction.Item AND w.LineTypeOrder = BRS_Transaction.LineTypeOrder
WHERE     (BRS_Transaction.FiscalMonth between 201702 and 201702) AND (ISNULL(BRS_Transaction.ExtChargebackAmt,0) <> w.ExtChargebackAmt)

*/
SELECT     BRS_Transaction.*
FROM         BRS_Transaction
WHERE     (ExtChargebackAmt IS NULL) AND (FiscalMonth between 201701 and 201701) AND DocType <> 'AA' AND GLBU_Class <> 'FREIG'


-- PRE (58462 row(s) affected); post = (0 row(s) affected)


-- TEST NEW DW CB LOAD SAME !!