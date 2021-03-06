/*
   26-Mar-192:41:43 PM
   User: 
   Server: CAHSIONNLSQL1
   Database: DEV_BRSales
   Application: 
*/

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Branch ADD
	EPS_code char(5) NOT NULL CONSTRAINT DF_BRS_Branch_FSC_code1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Branch ADD CONSTRAINT
	FK_BRS_Branch_BRS_FSC_Rollup3 FOREIGN KEY
	(
	EPS_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Branch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


INSERT INTO [dbo].[BRS_FSC_Rollup]
           ([TerritoryCd]
           ,[FSCName]
           ,[Branch]
           ,[group_type]
		   )
     VALUES
--           ('EPONT', 'CHRIS NICOLSON', '', 'DEPS')
           ('EPQUE', 'MARILYNE PETRYKA', '', 'DEPS')
GO


UPDATE [BRS_FSC_Rollup]
SET [FSCName] = '** DO NOT USE **', [group_type] = 'DEPS'
WHERE [TerritoryCd] = 'EPWES'
GO


UPDATE [dbo].[BRS_Branch]
   SET 
      [EPS_code] = 'EPONT'
 WHERE [Branch] IN ('LONDN', 'OTTWA', 'TORNT')
GO

UPDATE [dbo].[BRS_Branch]
   SET 
      [EPS_code] = 'EPQUE'
 WHERE [Branch] IN ('MNTRL', 'QUEBC')
GO

