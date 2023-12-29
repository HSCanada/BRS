/****** Script for SelectTopNRows command from SSMS  ******/
SELECT         fg.transaction_F5554240.CalMonthRedeem, BRS_TransactionDW.CalMonth, count(*)
FROM            BRS_TransactionDW INNER JOIN
                         fg.transaction_F5554240 ON BRS_TransactionDW.ID = fg.transaction_F5554240.ID_source_ref
WHERE        (BRS_TransactionDW.CalMonth >= 202310)
GROUP BY fg.transaction_F5554240.CalMonthRedeem, BRS_TransactionDW.CalMonth
order by 2

-- clear FG
delete from fg.transaction_F5554240 where CalMonthRedeem >= 202309
GO

-- clear DW
delete from BRS_TransactionDW where CalMonth >= 202310
GO


-- make metric stage (work-around lot load DW from Client, backend scripting down & YE in 1 day

-- drop table [dbo].[STAGE_BRS_TransactionDW2]
CREATE TABLE [dbo].[STAGE_BRS_TransactionDW2](
	[JDEORNO] [int] NOT NULL,
	[ORDOTYCD] [char](2) NOT NULL,
	[LNNO] [float] NOT NULL,
	[CMID] [int] NULL,
	[PDID] [int] NULL,
	[PDDT] [datetime] NULL,
	[CUID] [int] NULL,
	[ADNOID] [int] NULL,
	[ITID] [int] NULL,
	[ITLONO] [char](10) NULL,
	[ENBYNA] [char](10) NULL,
	[ORTKBYID] [char](10) NULL,
	[ORSCCD] [char](1) NULL,
	[RF1TT] [nvarchar](30) NULL,
	[PRMDCD] [char](1) NULL,
	[SPCDID] [char](10) NULL,
	[LNTY] [char](2) NULL,
	[HSDCDID] [char](3) NULL,
	[MJPRCLID] [char](3) NULL,
	[CBCONTRNO] [char](10) NULL,
	[GLBUNO] [char](12) NULL,
	[ORFISHDT] [nvarchar](30) NULL,
	[IVNO] [int] NULL,
	[PMID] [int] NULL,
	[OPMID] [int] NULL,
	[OORNO] [int] NULL,
	[OORTY] [char](2) NULL,
	[OORLINO] [float] NULL,
	[PCADLINO] [nchar](30) NULL,
	[BTADNO] [int] NULL,
	[ESSCD] [char](5) NULL,
	[CCSCD] [char](5) NULL,
	[ESTCD] [int] NULL,
	[TSSCD] [char](5) NULL,
	[CAGREPCD] [char](5) NULL,
	[EQORDNO] [char](6) NULL,
	[EQORDTYCD] [char](2) NULL,
	[metrics] [char](2) NULL,
	[WJXBFS1] [int] NULL,
	[WJXBFS2] [money] NULL,
	[WJXBFS3] [money] NULL,
	[WJXBFS4] [money] NULL,
	[WJXBFS5] [money] NULL,
	[WJXBFS6] [money] NULL,
	[WJXBFS7] [money] NULL,
	[WJXBFS8] [money] NULL,
 CONSTRAINT [STAGE_BRS_TransactionDW2_PK] PRIMARY KEY NONCLUSTERED 
(
	[JDEORNO] ASC,
	[ORDOTYCD] ASC,
	[LNNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- truncate table [dbo].[STAGE_BRS_TransactionDW2]

-- copy stage2 to 1

truncate table STAGE_BRS_TransactionDW

INSERT INTO STAGE_BRS_TransactionDW
                         (JDEORNO, ORDOTYCD, LNNO, CMID, PDID, PDDT, CUID, ADNOID, ITID, ITLONO, ENBYNA, ORTKBYID, ORSCCD, RF1TT, PRMDCD, SPCDID, LNTY, HSDCDID, MJPRCLID, CBCONTRNO, GLBUNO, ORFISHDT, IVNO, PMID, 
                         OPMID, OORNO, OORTY, OORLINO, PCADLINO, BTADNO, ESSCD, CCSCD, ESTCD, TSSCD, CAGREPCD, EQORDNO, EQORDTYCD, WJXBFS1, WJXBFS2, WJXBFS3, WJXBFS4, WJXBFS5, WJXBFS6, WJXBFS7, WJXBFS8)
SELECT         JDEORNO, ORDOTYCD, LNNO, CMID, PDID, PDDT, CUID, ADNOID, ITID, ITLONO, ENBYNA, ORTKBYID, ORSCCD, RF1TT, PRMDCD, SPCDID, LNTY, HSDCDID, MJPRCLID, CBCONTRNO, GLBUNO, ORFISHDT, IVNO, 
                         PMID, OPMID, OORNO, OORTY, OORLINO, PCADLINO, BTADNO, ESSCD, CCSCD, ESTCD, TSSCD, CAGREPCD, EQORDNO, EQORDTYCD, WJXBFS1, WJXBFS2, WJXBFS3, WJXBFS4, WJXBFS5, WJXBFS6, WJXBFS7, 
                         WJXBFS8
FROM            STAGE_BRS_TransactionDW2


 Exec BRS_BE_Transaction_DW_load_proc @bClearStage=0, @bDebug=0
