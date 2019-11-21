-- Return tracking, tmc, 20 Nov 19

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD
	CreditMinorReasonCode char(4) NULL,
	CreditTypeCode char(2) NULL
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--

-- drop table [dbo].[zzBRSCreditInfo]

alter TABLE [dbo].[zzBRSCreditInfo] ADD
	id int identity(1,1) NOT NULL

GO

CREATE TABLE [dbo].[zzBRSCreditInfo](
	[JDEORNO] [int] NOT NULL,
	[ORDOTYCD] [nvarchar](50) NOT NULL,
	[CRMJRECD] [nvarchar](50) NULL,
	[CRMNRECD] [nvarchar](50) NULL,
	[CRTYCD] [nvarchar](50) NULL,
	[WJXBFS1] [float] NULL,
	id int identity(1,1) NOT NULL
) ON [USERDATA]
GO




UPDATE       BRS_TransactionDW_Ext
SET                CreditMinorReasonCode = CRMNRECD, CreditTypeCode = CRTYCD
FROM            
BRS_TransactionDW_Ext ss
INNER JOIN
(
	SELECT        s.JDEORNO, s.ORDOTYCD, CRMJRECD, s.CRMNRECD, CRTYCD, WJXBFS1, id
	FROM            zzBRSCreditInfo s

	INNER JOIN (

	SELECT        JDEORNO, ORDOTYCD, [CRMNRECD], MIN(id) AS minid
	FROM            zzBRSCreditInfo
	GROUP BY JDEORNO, ORDOTYCD, [CRMNRECD]
	) as sel
	ON s.ID = sel.minid
) ss2
ON ss.SalesOrderNumber = JDEORNO AND
ss.DocType = ORDOTYCD



 INNER JOIN
                         BRS_TransactionDW_Ext AS BRS_TransactionDW_Ext_1 ON BRS_TransactionDW_Ext.SalesOrderNumber = BRS_TransactionDW_Ext_1.SalesOrderNumber


/*
	SELECT        s.JDEORNO, s.ORDOTYCD, CRMJRECD, s.CRMNRECD, CRTYCD, WJXBFS1, id
	FROM            zzBRSCreditInfo s

	INNER JOIN (

	SELECT        JDEORNO, ORDOTYCD, [CRMNRECD], MIN(id) AS minid
	FROM            zzBRSCreditInfo
	GROUP BY JDEORNO, ORDOTYCD, [CRMNRECD]
	) as sel
	ON s.ID = sel.minid
*/
