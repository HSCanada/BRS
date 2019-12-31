
-- add default to make partial loading easier
BEGIN TRANSACTION
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_SalesDate DEFAULT '' FOR SalesDate
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_AdjNum DEFAULT '' FOR AdjNum
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_AdjCode DEFAULT '' FOR AdjCode
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_AdjNote DEFAULT '' FOR AdjNote
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_AdjNoteRemark DEFAULT '' FOR AdjNoteRemark
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_AdjSource DEFAULT '' FOR AdjSource
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_AdjOwner DEFAULT '' FOR AdjOwner
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_ValueAmt DEFAULT 0 FOR ValueAmt
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_GL_BusinessUnit DEFAULT '' FOR GL_BusinessUnit
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_GL_Object DEFAULT '' FOR GL_Object
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_GL_Subsidiary DEFAULT '' FOR GL_Subsidiary
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD CONSTRAINT
	DF_account_adjustment_F0911_GL_DocType DEFAULT '' FOR GL_DocType
GO
ALTER TABLE Integration.account_adjustment_F0911 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


INSERT INTO [dbo].[BRS_DocType]
           ([DocType]
           ,[DocTypeDescr]
           ,[SourceCd]
           ,[StatusCd]
           ,[FreeGoodsEstInd])
     VALUES
           ('RA'
           ,'return auth'
           ,'ADJ'
           ,1
           ,0)
GO

UPDATE [dbo].[BRS_DocType]
   SET [SourceCd] = 'ADJ'
 WHERE  DocType = 'CI'
GO

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnit ADD
	Branch char(5) NOT NULL CONSTRAINT DF_BRS_BusinessUnit_Branch DEFAULT '',
	SalesDivision char(3) NOT NULL CONSTRAINT DF_BRS_BusinessUnit_SalesDivision DEFAULT ''
GO
ALTER TABLE dbo.BRS_BusinessUnit ADD CONSTRAINT
	FK_BRS_BusinessUnit_BRS_Branch FOREIGN KEY
	(
	Branch
	) REFERENCES dbo.BRS_Branch
	(
	Branch
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_BusinessUnit ADD CONSTRAINT
	FK_BRS_BusinessUnit_BRS_SalesDivision FOREIGN KEY
	(
	SalesDivision
	) REFERENCES dbo.BRS_SalesDivision
	(
	SalesDivision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_BusinessUnit SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE [dbo].[BRS_Branch]
set [AccountingCode] = ''
where Branch = 'NWFLD'


--
UPDATE       BRS_BusinessUnit
SET           Branch = b.Branch
FROM            BRS_BusinessUnit INNER JOIN
                         BRS_Branch AS b ON SUBSTRING(BRS_BusinessUnit.BusinessUnit, 11, 2) = b.AccountingCode AND b.AccountingCode > '00'
--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDivision ADD
	AccountingCode char(2) NOT NULL CONSTRAINT DF_BRS_SalesDivision_AccountingCode DEFAULT ''
GO
ALTER TABLE dbo.BRS_SalesDivision SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

update dbo.BRS_SalesDivision set AccountingCode = '01' where SalesDivision = 'AAD'
update dbo.BRS_SalesDivision set AccountingCode = '17' where SalesDivision = 'AAL'
update dbo.BRS_SalesDivision set AccountingCode = '25' where SalesDivision = 'AAM'
update dbo.BRS_SalesDivision set AccountingCode = '40' where SalesDivision = 'AAV'


/*
select  SUBSTRING([GLBusinessUnit],5,2), SalesDivision, count(*) from [dbo].[BRS_TransactionDW] where [CalMonth] = 201912
group by SUBSTRING([GLBusinessUnit],5,2), SalesDivision 
order by 3 desc
*/

--

UPDATE       BRS_BusinessUnit
SET           SalesDivision = b.SalesDivision
FROM            BRS_BusinessUnit INNER JOIN
                         BRS_SalesDivision AS b ON SUBSTRING(BRS_BusinessUnit.BusinessUnit, 5, 2) = b.AccountingCode AND b.AccountingCode > '00'

--

BEGIN TRANSACTION
GO
ALTER TABLE Integration.account_adjustment_F0911 ADD
	GLBU_Class_ORG char(5) NULL
GO
ALTER TABLE Integration.account_adjustment_F0911 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

