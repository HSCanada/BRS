
-- add calendar map, tmc, 10 Oct 19

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDay ADD
	CalMonth int NOT NULL CONSTRAINT DF_BRS_SalesDay_CalMonth DEFAULT 0
GO
ALTER TABLE dbo.BRS_SalesDay ADD CONSTRAINT
	FK_BRS_SalesDay_BRS_CalMonth FOREIGN KEY
	(
	CalMonth
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_SalesDay SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


UPDATE       BRS_SalesDay
SET                CalMonth = CAST(FORMAT(SalesDate,'yyyyMM') AS INT)
WHERE SalesDate <= '20191231'


