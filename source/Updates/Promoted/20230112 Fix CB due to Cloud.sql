-- Fix CB due to Cloud, tmc, 12 Jan 24
			UPDATE    
				BRS_Transaction
			SET              
				ExtChargebackAmt = w.ExtChargebackAmt,
				[GL_Object_ChargeBack] = '4730',
				[GL_Subsidiary_ChargeBack] = ''
--			SELECT *  
			FROM         
				BRS_TransactionDW AS w 
				INNER JOIN BRS_Transaction 
				ON w.SalesOrderNumber = BRS_Transaction.SalesOrderNumberKEY AND 
					w.DocType = BRS_Transaction.DocType AND
					w.LineNumber = BRS_Transaction.LineNumber AND 
					w.Date = BRS_Transaction.SalesDate AND 
					w.Shipto = BRS_Transaction.Shipto AND
					w.Item = BRS_Transaction.Item AND 
					w.LineTypeOrder = BRS_Transaction.LineTypeOrder
			WHERE     
				-- XXX TBD 18 Dec 2017 missing?
				(ISNULL(BRS_Transaction.ExtChargebackAmt,0) <> w.ExtChargebackAmt)  AND
				BRS_Transaction.FiscalMonth = 202212 AND
/*
				EXISTS
				(
					Select * 
					From STAGE_BRS_TransactionDW s
					Where 
						w.SalesOrderNumber = s.JDEORNO And
						w.DocType = s.ORDOTYCD And
						w.LineNumber = ROUND(s.LNNO * 1000,0) 
				) AND
*/
				(1 = 1)
