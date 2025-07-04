-- comm branch, tmc, 8 May 25

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Branch ADD
	BranchNameComm varchar(50) NOT NULL CONSTRAINT DF_BRS_Branch_BranchName1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Branch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

update
BRS_Branch
set BranchNameComm = BranchName

