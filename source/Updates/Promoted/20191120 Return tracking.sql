-- Return tracking, tmc, 20 Nov 19

BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_TransactionDW] ADD
	CreditMinorReasonCode char(4) NULL,
	CreditTypeCode char(2) NULL
GO
COMMIT

-- load table to 
-- drop table [dbo].[zzBRSCreditInfo]

--

CREATE TABLE [Integration].[BRSCreditInfo](
	[JDEORNO] [int] NOT NULL,
	[ORDOTYCD] [nvarchar](50) NOT NULL,
	[LNNO] [float] NOT NULL,
	[CRMNRECD] [nvarchar](50) NOT NULL,
	[CRTYCD] [nvarchar](50) NOT NULL,
	[WJXBFS1] [float] NOT NULL
) ON [USERDATA]
GO


--
-- truncate table [Integration].[BRSCreditInfo]

INSERT INTO [Integration].[BRSCreditInfo]
(JDEORNO, ORDOTYCD, LNNO, CRMNRECD, CRTYCD, WJXBFS1)
SELECT        JDEORNO, ORDOTYCD, LNNO, CRMNRECD, CRTYCD, WJXBFS1
FROM            zzBRSCreditInfo


-- drop table [dbo].[BRS_Creditinfo]
CREATE TABLE [dbo].[BRS_Creditinfo](
	[CreditMinorReasonCode] [char](4) NOT NULL,
	[CreditTypeCode] [char](2) NOT NULL,
	[CreditMinorReason] [nvarchar](30) NOT NULL,
	[CreditType] [nvarchar](30) NOT NULL,
	[credit_key] int NOT NULL Identity(1,1)
 CONSTRAINT [BRS_Creditinfo_c_pk] PRIMARY KEY CLUSTERED 
(
	[CreditMinorReasonCode] ASC,
	[CreditTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [dbo].[BRS_Creditinfo] ADD  CONSTRAINT [DF_BRS_Creditinfo_CreditMinorReason]  DEFAULT ('') FOR [CreditMinorReason]
GO

ALTER TABLE [dbo].[BRS_Creditinfo] ADD  CONSTRAINT [DF_BRS_Creditinfo_CreditType]  DEFAULT ('') FOR [CreditType]
GO

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX BRS_Creditinfo_u_idx_01 ON dbo.BRS_Creditinfo
	(
	credit_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_Creditinfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- pop initial
INSERT INTO [dbo].[BRS_Creditinfo]
           ([CreditMinorReasonCode]
           ,[CreditTypeCode]
           ,[CreditMinorReason]
           ,[CreditType])
     VALUES
           (''
           ,''
           ,'unassigned'
           ,'unassigned')
GO

-- pop values

INSERT INTO [dbo].[BRS_Creditinfo]
([CreditMinorReasonCode], [CreditTypeCode])
SELECT DISTINCT CRMNRECD AS CreditMinorReasonCode, CRTYCD AS CreditTypeCode
FROM            Integration.BRSCreditInfo s
where not exists(select * from [dbo].[BRS_Creditinfo] d where s.CRMNRECD = d.CreditMinorReasonCode AND s.CRTYCD = d.CreditTypeCode)


-- add RI
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_BRS_Creditinfo FOREIGN KEY
	(
	CreditMinorReasonCode,
	CreditTypeCode
	) REFERENCES dbo.BRS_Creditinfo
	(
	CreditMinorReasonCode,
	CreditTypeCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

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


