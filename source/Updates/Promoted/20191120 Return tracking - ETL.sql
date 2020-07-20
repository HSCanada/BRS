-- Return tracking, tmc, 20 Nov 19
-- forked und updated, 9 Apr 20
-- drop table [dbo].[BRSCreditInfo]
-- drop table [Integration].[BRS_CreditInfo]
-- drop table [Integration].[BRSCreditInfo]


CREATE TABLE [Integration].[BRS_CreditInfo](
	[JDEORNO] [int] NOT NULL,
	[ORDOTYCD] [nvarchar](50) NOT NULL,
	[LNNO] [float] NOT NULL,
	[CRMNRECD] [nvarchar](50)  NULL,
	[CRTYCD] [nvarchar](50)  NULL,
	[WJXBFS1] [float]  NULL,
 CONSTRAINT [BRS_CreditInfo_c_pk] PRIMARY KEY CLUSTERED 
(
	[JDEORNO] ASC,
	[ORDOTYCD] ASC,
	[LNNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


-- truncate table [Integration].[BRS_CreditInfo]
/*
INSERT INTO [Integration].[BRSCreditInfo]
(JDEORNO, ORDOTYCD, LNNO, CRMNRECD, CRTYCD, WJXBFS1)
SELECT        JDEORNO, ORDOTYCD, LNNO, ISNULL(CRMNRECD,''), CRTYCD, WJXBFS1
FROM            BRSCreditInfo
*/
/*
-- pop values
INSERT INTO 
	[dbo].[BRS_Creditinfo]
(
	[CreditMinorReasonCode]
	, [CreditTypeCode]
)
SELECT 
	DISTINCT CRMNRECD AS CreditMinorReasonCode
	, CRTYCD AS CreditTypeCode
FROM
	Integration.BRS_CreditInfo s
WHERE 
	NOT EXISTS
	(
		SELECT * 
		FROM [dbo].[BRS_Creditinfo] d 
		WHERE s.CRMNRECD = d.CreditMinorReasonCode AND 
			s.CRTYCD = d.CreditTypeCode)
*/

-- update trans
/*
UPDATE
	BRS_TransactionDW
SET
	CreditMinorReasonCode = s.CRMNRECD
	,CreditTypeCode = s.CRTYCD
FROM
	Integration.BRSCreditInfo AS s 

	INNER JOIN BRS_TransactionDW 
	ON s.JDEORNO = BRS_TransactionDW.SalesOrderNumber AND 
		s.ORDOTYCD = BRS_TransactionDW.DocType AND 
		ROUND(s.LNNO * 1000,0) = BRS_TransactionDW.LineNumber
*/
