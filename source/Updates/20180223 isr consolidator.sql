-- IRS Consolidator, tmc, 23 Feb 2018

-- add employee

CREATE TABLE [dbo].[BRS_Employee](
	[SamAccountName] [nchar](20) NOT NULL,
	[EmailAddress] [nvarchar](255) NOT NULL,
	[LoginId] [nvarchar](50) NOT NULL,
	[Note] [nvarchar](100) NULL,
	[EmployeeKey] int identity (1,1) NOT NULL,
	[FscRollupCd] [char](5) NULL,
	[IsrRollupCd] [char](5) NULL

 CONSTRAINT [BRS_Employee_c_pk] PRIMARY KEY CLUSTERED 
(
	[SamAccountName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA],
) ON [USERDATA] 

GO

CREATE UNIQUE NONCLUSTERED INDEX [BRS_Employee_u_idx_01]
ON [dbo].[BRS_Employee]([FscRollupCd])
WHERE [FscRollupCd] IS NOT NULL;

CREATE UNIQUE NONCLUSTERED INDEX [BRS_Employee_u_idx_02]
ON [dbo].[BRS_Employee]([IsrRollupCd])
WHERE [IsrRollupCd] IS NOT NULL;

---
ALTER TABLE dbo.BRS_Employee ADD CONSTRAINT
	FK_BRS_Employee_BRS_FSC_Rollup_fsc FOREIGN KEY
	(
	FscRollupCd
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.BRS_Employee ADD CONSTRAINT
	FK_BRS_Employee_BRS_FSC_Rollup_isr FOREIGN KEY
	(
	IsrRollupCd
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO


INSERT INTO BRS_Employee
                         (SamAccountName, EmailAddress, LoginId, fscRollupCd, isrRollupCd, Note)
VALUES        (N'', N'', N'', '', '', N'Unassigned')

-- manually add from Get-ADUser -filter * -Properties SID, GivenName, Surname, EmployeeNumber, Office, MobilePhone, EmailAddress, thumbnailPhoto, Title, Department | where {$_.Enabled -eq “True”} | Export-Csv ./users.txt
-- S:\Business Reporting\Projects\BR Connex\BRS_Employee Load.xlsx


SELECT  
		[TerritoryCd]
      ,[FSCName]
      ,[FSCRollup]
      ,[group_type]
	  ,[Rule_WhereClauseLike]
FROM [DEV_BRSales].[dbo].[BRS_FSC_Rollup]
where [group_type] = 'DDTS' and ISNULL([Rule_WhereClauseLike],'')  =''

UPDATE       BRS_FSC_Rollup
SET                FSCRollup = [TerritoryCd]
where [group_type] = 'DDTS' and [Rule_WhereClauseLike]  <>''

UPDATE       BRS_FSC_Rollup
SET                FSCRollup = 'DTSNM'
where [group_type] = 'DDTS' and ISNULL([Rule_WhereClauseLike],'')  =''

UPDATE       BRS_FSC_Rollup
SET                FSCRollup = 'DTSNT'
WHERE        (TerritoryCd IN ('DTSNT', 'DTSN2', 'DTSN3'))

UPDATE       BRS_FSC_Rollup
SET                FSCRollup = 'DTSJC'
WHERE        (TerritoryCd IN ('DTSJC'))

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSNT'
WHERE        (LoginId = N'CAHSI\Noah.Thompson')

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSJC'
WHERE        (LoginId = N'CAHSI\TCROWLey')

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSFP'
WHERE        (LoginId = N'CAHSI\Gary.Winslow')




SELECT        SamAccountName, EmailAddress, LoginId, IsrRollupCd, Note
FROM            BRS_Employee
WHERE        (IsrRollupCd = 'DTSJC')

SELECT        BRS_FSC_Rollup.TerritoryCd, BRS_FSC_Rollup.FSCRollup, BRS_Employee.LoginId, BRS_Employee.EmployeeKey
FROM            BRS_FSC_Rollup INNER JOIN
                         BRS_Employee ON BRS_FSC_Rollup.FSCRollup = BRS_Employee.FscRollupCd
ORDER BY BRS_FSC_Rollup.TerritoryCd

SELECT        BRS_FSC_Rollup.TerritoryCd, BRS_FSC_Rollup.FSCRollup, BRS_Employee.LoginId, BRS_Employee.EmployeeKey
FROM            BRS_FSC_Rollup INNER JOIN
                         BRS_Employee ON BRS_FSC_Rollup.FSCRollup = BRS_Employee.IsrRollupCd
ORDER BY BRS_FSC_Rollup.TerritoryCd

-- ORG 738
