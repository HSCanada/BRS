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

-- goals and spend
ALTER TABLE dbo.BRS_Customer ADD
	isr_target_amt money NOT NULL CONSTRAINT DF_BRS_Customer_isr_goal_amt DEFAULT (0),
	potential_spend_amt money NOT NULL CONSTRAINT DF_BRS_Customer_potential_spend_amt DEFAULT (0)
GO

-- SELECT [CalMonth], count(*) from [dbo].[BRS_TransactionDW] group by [CalMonth]

INSERT INTO BRS_Employee
                         (SamAccountName, EmailAddress, LoginId, fscRollupCd, isrRollupCd, Note)
VALUES        (N'', N'', N'', '', '', N'Unassigned')

-- manually add from Get-ADUser -filter * -Properties SID, GivenName, Surname, EmployeeNumber, Office, MobilePhone, EmailAddress, thumbnailPhoto, Title, Department | where {$_.Enabled -eq “True”} | Export-Csv ./users.txt
-- S:\Business Reporting\Projects\BR Connex\BRS_Employee Load.xlsx

--LoginId = N'CAHSI\Noah.Thompson

-- set top 15

UPDATE
	[dbo].[BRS_ItemCategoryRollup]
SET [top15_ind] = 0


UPDATE
	[dbo].[BRS_ItemCategoryRollup]
SET [top15_ind] = 1
where 
  [CategoryRollup] in ('ANSTHC', 'CEMENT', 'COSMTC', 'CROBRG', 'DENINS', 'DSPSBL', 'ENDODN', 'FINPOL', 'GLOVES', 'HANPCE', 'IMPRES', 'INFCON', 'PRVNTV', 
                         'ROTARY', 'RSTRTV','PRVMBR', 'PRVPBR')


-- Focus begin

CREATE TABLE [dbo].[BRS_CustomerFocus](
	[FocusCd] [nchar](5) NOT NULL,
	[FocusDescr] [nchar](50) NULL,
	[FocusKey] [int] IDENTITY(1,1) NOT NULL,
	[Note] [nvarchar](100) NULL,
	[IsActiveInd] [bit] NOT NULL,
 CONSTRAINT [PK_BRS_CustomerFocus] PRIMARY KEY CLUSTERED 
(
	[FocusCd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [dbo].[BRS_CustomerFocus] ADD  CONSTRAINT [DF_BRS_CustomerFocus_FocusCd]  DEFAULT ('') FOR [FocusCd]
GO

ALTER TABLE [dbo].[BRS_CustomerFocus] ADD  CONSTRAINT [DF_BRS_CustomerFocus_IsActiveInd]  DEFAULT ((1)) FOR [IsActiveInd]
GO

INSERT INTO [dbo].[BRS_CustomerFocus]
	([FocusCd], [FocusDescr])
VALUES ('','Unassigned')
GO

INSERT INTO [dbo].[BRS_CustomerFocus]
	([FocusCd], [FocusDescr])
VALUES ('','Unassigned')
GO

INSERT INTO [dbo].[BRS_CustomerFocus]
	([FocusCd], [FocusDescr])
VALUES 
('AAA',	'1. Regular Accounts'),
('CLS',	'5. Closed'),
('D04K',	'3. Focus Accounts < $10k'),
('D10K',	'3. Focus Accounts < $10k'),
('L10K',	'3. Focus Accounts < $10k'),
('M02K5', '3. Focus Accounts < $10k'),
('M06K',	'3. Focus Accounts < $10k'),
('M2K5',	'3. Focus Accounts < $10k'),
('SPC',	'2. Special Markets'),
('WINBK', '4. Win-Back')

ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_CustomerFocus FOREIGN KEY
	(
	FocusCd
	) REFERENCES dbo.BRS_CustomerFocus
	(
	FocusCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- add credit limits, add users

ALTER TABLE dbo.BRS_CustomerBT ADD
	CreditLimit money NULL
GO

-- Focus End

-- Territory Begin
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


-- SET TS rollup for mapping

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSHS'
WHERE        (LoginId = N'CAHSI\tcrowley')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'MTSHS'
WHERE        (LoginId = N'CAHSI\gary.winslow')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'ZTSMK'
WHERE        (LoginId = N'CAHSI\Madeleine.Khodaverdi')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'ZTSJE'
WHERE        (LoginId = N'CAHSI\Julie.Emery')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'ZTSED'
WHERE        (LoginId = N'CAHSI\Eric.Dorfman')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'MTSWS'
WHERE        (LoginId = N'CAHSI\Willen.Sun')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'MTSSJ'
WHERE        (LoginId = N'CAHSI\Shenila.Jaffer')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'MTSKF'
WHERE        (LoginId = N'CAHSI\Kristina.Fowler')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'MTSKF'
WHERE        (LoginId = N'CAHSI\Kristina.Fowler')
GO	

UPDATE       BRS_Employee
SET                isrRollupCd = 'MTSJD'
WHERE        (LoginId = N'CAHSI\Janet.Dunphy')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSNX'
WHERE        (LoginId = N'CAHSI\Nadia.Xavier')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSNT'
WHERE        (LoginId = N'CAHSI\Noah.Thompson')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSLE'
WHERE        (LoginId = N'CAHSI\Lina.Evraire')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSLB'
WHERE        (LoginId = N'CAHSI\Lori.Bonn')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSGB'
WHERE        (LoginId = N'CAHSI\Grace.Brohman')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSFP'
WHERE        (LoginId = N'CAHSI\Franca.Parente')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSEB'
WHERE        (LoginId = N'CAHSI\Emilia.Bronowicki')
GO

UPDATE       BRS_Employee
SET                isrRollupCd = 'DTSAR'
WHERE        (LoginId = N'CAHSI\Amanda.Russell')
GO

-- test

SELECT        BRS_FSC_Rollup.TerritoryCd, BRS_FSC_Rollup.FSCRollup, BRS_Employee.LoginId, BRS_Employee.EmployeeKey
FROM            BRS_FSC_Rollup INNER JOIN
                         BRS_Employee ON BRS_FSC_Rollup.FSCRollup = BRS_Employee.IsrRollupCd
ORDER BY BRS_FSC_Rollup.TerritoryCd



SELECT        SamAccountName, EmailAddress, LoginId, IsrRollupCd, Note
FROM            BRS_Employee
WHERE        (IsrRollupCd = 'DTSJC')

SELECT        BRS_FSC_Rollup.TerritoryCd, BRS_FSC_Rollup.FSCRollup, BRS_Employee.LoginId, BRS_Employee.EmployeeKey
FROM            BRS_FSC_Rollup INNER JOIN
                         BRS_Employee ON BRS_FSC_Rollup.FSCRollup = BRS_Employee.FscRollupCd
ORDER BY BRS_FSC_Rollup.TerritoryCd







