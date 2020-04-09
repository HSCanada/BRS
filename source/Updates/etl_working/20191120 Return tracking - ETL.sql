-- Return tracking, tmc, 20 Nov 19
-- forked und updated, 9 Apr 20

-- truncate table [Integration].[BRSCreditInfo]

INSERT INTO [Integration].[BRSCreditInfo]
(JDEORNO, ORDOTYCD, LNNO, CRMNRECD, CRTYCD, WJXBFS1)
SELECT        JDEORNO, ORDOTYCD, LNNO, ISNULL(CRMNRECD,''), CRTYCD, WJXBFS1
FROM            BRSCreditInfo


-- pop values

INSERT INTO [dbo].[BRS_Creditinfo]
([CreditMinorReasonCode], [CreditTypeCode])
SELECT DISTINCT CRMNRECD AS CreditMinorReasonCode, CRTYCD AS CreditTypeCode
FROM            Integration.BRSCreditInfo s
where not exists(select * from [dbo].[BRS_Creditinfo] d where s.CRMNRECD = d.CreditMinorReasonCode AND s.CRTYCD = d.CreditTypeCode)

-- update trans

UPDATE BRS_TransactionDW
	SET CreditMinorReasonCode = s.CRMNRECD,
	CreditTypeCode = s.CRTYCD

FROM
	Integration.BRSCreditInfo AS s 

	INNER JOIN BRS_TransactionDW 
	ON s.JDEORNO = BRS_TransactionDW.SalesOrderNumber AND 
		s.ORDOTYCD = BRS_TransactionDW.DocType AND 
		ROUND(s.LNNO * 1000,0) = BRS_TransactionDW.LineNumber


