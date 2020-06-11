-- tranaction audit create, tmc, 8 Jun 20

-- drop table [comm].[transaction_F555115_audit]

CREATE TABLE [comm].[transaction_F555115_audit](
	[FiscalMonth] [int] NOT NULL,
	[source_cd] [char](3) NOT NULL Default(''),
	[AdjOwner] [char](6) NOT NULL Default(''),
	[SalesDivision] [char](3) NOT NULL Default(''),

	[summarized_transaction_amt] [money] NOT NULL Default(0),
	[summarized_gp_ext_amt] [money] NOT NULL Default(0),

	[summarized_fsc_comm_amt] [money] NOT NULL Default(0),
	[summarized_ess_comm_amt] [money] NOT NULL Default(0),
	[summarized_cps_comm_amt] [money] NOT NULL Default(0),
	[summarized_eps_comm_amt] [money] NOT NULL Default(0),

	[ID] [int] IDENTITY(1,1) NOT NULL,

	[note_txt] nvarchar(50) NULL
 CONSTRAINT [comm_transaction_F555115_audit_c_pk] PRIMARY KEY CLUSTERED 
(
	[FiscalMonth] ASC,
	[source_cd] ASC,
	[SalesDivision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115_audit ADD CONSTRAINT
	FK_transaction_F555115_audit_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115_audit ADD CONSTRAINT
	FK_transaction_F555115_audit_source FOREIGN KEY
	(
	source_cd
	) REFERENCES comm.source
	(
	source_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115_audit ADD CONSTRAINT
	FK_transaction_F555115_audit_BRS_SalesDivision FOREIGN KEY
	(
	SalesDivision
	) REFERENCES dbo.BRS_SalesDivision
	(
	SalesDivision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115_audit SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- test
SELECT        FiscalMonth, source_cd, WSAC10_division_code, SUM(transaction_amt) AS Expr2, SUM(gp_ext_amt) AS Expr1
FROM            comm.transaction_F555115
WHERE        (source_cd = 'JDE')
GROUP BY FiscalMonth, source_cd, WSAC10_division_code
HAVING        (FiscalMonth = 202005)

select * from [comm].[transaction_F555115_audit]

--
-- use source to ID post
SELECT        source_cd, WSAC10_division_code, WSVR01_reference, SUM(transaction_amt) AS Expr2, SUM(gp_ext_amt) AS Expr1
FROM            comm.transaction_F555115
WHERE        (source_cd = 'IMP') AND (FiscalMonth >= 201901)
GROUP BY source_cd, WSAC10_division_code, WSVR01_reference

-- use comm to calc pay
SELECT        source_cd, WSAC10_division_code, WSVR01_reference, SUM(transaction_amt) AS Expr2, SUM(gp_ext_amt) AS Expr1, sum([fsc_comm_amt]) as cmm,  count(*)
FROM            comm.transaction_F555115
WHERE        (source_cd = 'PAY') AND (FiscalMonth >= 201901)
GROUP BY source_cd, WSAC10_division_code, WSVR01_reference


