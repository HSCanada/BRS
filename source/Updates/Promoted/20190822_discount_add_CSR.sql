-- Add CSR discount to Quote Tracker, tmc, 22 Aug 19

-- drop table [Pricing].[entered_by]

CREATE TABLE [Pricing].[entered_by](
	[entered_by_code] [char](10) NOT NULL,
	[entered_by] [nvarchar](30) NOT NULL,
	[entered_by_key] [int] NOT NULL Identity(1,1),
	[note] nvarchar(30) NULL

 CONSTRAINT [PK_entered_by] PRIMARY KEY CLUSTERED 
(
	[entered_by_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [Pricing].[entered_by] ADD  CONSTRAINT [DF_entered_by_entered_by]  DEFAULT ('') FOR [entered_by]
GO

BEGIN TRANSACTION
GO
ALTER TABLE Pricing.entered_by ADD
	branch_code char(5) NOT NULL CONSTRAINT DF_entered_by_branch_code DEFAULT ''
GO
ALTER TABLE Pricing.entered_by ADD CONSTRAINT
	FK_entered_by_BRS_Branch FOREIGN KEY
	(
	branch_code
	) REFERENCES dbo.BRS_Branch
	(
	Branch
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Pricing.entered_by SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

INSERT INTO [Pricing].[entered_by]
([entered_by_code], [entered_by])
VALUES ('', 'Unassigned')
GO

INSERT INTO [Pricing].[entered_by]
([entered_by_code] )
select distinct [EnteredBy] from [dbo].[BRS_TransactionDW]
GO

update [Pricing].[entered_by]
set [entered_by] =[entered_by_code]
where [entered_by_code] <> ''

-- RI

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_entered_by FOREIGN KEY
	(
	EnteredBy
	) REFERENCES Pricing.entered_by
	(
	entered_by_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT






