-- Added to separate the true GL accounts from 
-- the non-standard adjustments -- Charge back, Free Goods, Medical, tmc 21 Dec 17


BEGIN TRANSACTION
GO
ALTER TABLE hfm.account_master_F0901 ADD
	HFM_SourceCode char(3) NOT NULL CONSTRAINT DF_account_master_F0901_HFM_SourceCode DEFAULT ('JDE')
GO
ALTER TABLE hfm.account_master_F0901 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMCO___company DEFAULT ('') FOR GMCO___company
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMAID__account_id DEFAULT ('') FOR GMAID__account_id
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMANS__free_form_3rd_acct_no DEFAULT ('') FOR GMANS__free_form_3rd_acct_no
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMDL01_description DEFAULT ('') FOR GMDL01_description
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMLDA__account_level_of_detail DEFAULT ('') FOR GMLDA__account_level_of_detail
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMBPC__budget_pattern_code DEFAULT ('') FOR GMBPC__budget_pattern_code
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMPEC__posting_edit DEFAULT ('') FOR GMPEC__posting_edit
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMUSER_user_id DEFAULT ('') FOR GMUSER_user_id
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMPID__program_id DEFAULT ('') FOR GMPID__program_id
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMJOBN_work_station_id DEFAULT ('') FOR GMJOBN_work_station_id
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMUPMJ_date_updated_JDT DEFAULT (0) FOR GMUPMJ_date_updated_JDT
GO
ALTER TABLE hfm.account_master_F0901 ADD CONSTRAINT
	DF_account_master_F0901_GMUPMT_time_last_updated DEFAULT (0) FOR GMUPMT_time_last_updated
GO
ALTER TABLE hfm.account_master_F0901 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

ALTER TABLE hfm.account_master_F0901
	DROP CONSTRAINT DF_account_master_F0901_GMAID__account_id
GO

CREATE TABLE [dbo].zzzSalesorder(
	[SalesOrderNumberKEY] [int] NOT NULL,
	[DocType] [char](2) NOT NULL,
	[LineNumber] [int] NOT NULL,
	[value] [int] NULL,
	[note] [varchar](50),
 CONSTRAINT [zzzSalesorder_pk] PRIMARY KEY NONCLUSTERED 
(
	[SalesOrderNumberKEY] ASC,
	[DocType] ASC,
	[LineNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

UPDATE       BRS_Transaction
SET                GL_BusinessUnit = s.note
FROM            zzzSalesorder AS s INNER JOIN
                         BRS_Transaction ON s.SalesOrderNumberKEY = BRS_Transaction.SalesOrderNumberKEY AND s.DocType = BRS_Transaction.DocType AND 
                         s.LineNumber = BRS_Transaction.LineNumber