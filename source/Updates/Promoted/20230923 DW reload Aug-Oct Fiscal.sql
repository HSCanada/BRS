/****** Script for SelectTopNRows command from SSMS  ******/
SELECT        TOP (10) BRS_TransactionDW.SalesOrderNumber
FROM            BRS_TransactionDW INNER JOIN
                         fg.transaction_F5554240 ON BRS_TransactionDW.ID = fg.transaction_F5554240.ID_source_ref
						where CalMonth = 202307


delete from fg.transaction_F5554240 where WKDOCO_salesorder_number = 1371314

delete from BRS_TransactionDW where SalesOrderNumber = 1371314

-- note FG xref fixed via acccess

DELETE 
FROM            BRS_TransactionDW
FROM            BRS_TransactionDW INNER JOIN
                         BRS_SalesDay ON BRS_TransactionDW.Date = BRS_SalesDay.SalesDate
WHERE        (BRS_SalesDay.FiscalMonth = 202310)


DELETE 
FROM            fg.transaction_F5554240
WHERE        [CalMonthRedeem] >= 202308
GO



UPDATE       fg.transaction_F5554240
SET                ID_source_ref = 35834190
FROM
	BRS_TransactionDW 
	INNER JOIN BRS_SalesDay 
	ON BRS_TransactionDW.Date = BRS_SalesDay.SalesDate 
	
	INNER JOIN fg.transaction_F5554240 
	ON BRS_TransactionDW.ID = fg.transaction_F5554240.ID_source_ref
		
WHERE        (BRS_SalesDay.FiscalMonth = 202310)



