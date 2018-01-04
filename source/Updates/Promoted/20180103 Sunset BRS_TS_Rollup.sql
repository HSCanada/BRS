-- Migrate BRS_TS_Rollup to BRS_FSC_Rollup
-- 3 Jan 18

/*
-- 1. transfer RI from [BRS_TS_Rollup] to [dbo].[BRS_FSC_Rollup]
[dbo].[BRS_Customer]
[dbo].[BRS_TransactionDW_Ext]
*/

-- kluge to update new year
insert into [dbo].[BRS_CalMonth]
([CalMonth], [MonthSeq], [YearNum], [PRO_DentalFactor], [PRO_ZahnFactor], [PRO_MedicalFactor])
select 201801 + n-1, 1071+n, 2018, 0, 0, 0
from 
(
	SELECT TOP (12) 
	n = ROW_NUMBER() OVER (ORDER BY [object_id])
	FROM sys.all_objects ORDER BY n
) r



/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_FSC_Rollup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_AGG_CMI_DW_Sales
	DROP CONSTRAINT FK_BRS_AGG_CMI_DW_Sales_BRS_TS_Rollup
GO
ALTER TABLE dbo.BRS_AGG_CMI_DW_Sales
	DROP CONSTRAINT FK_BRS_AGG_CMI_DW_Sales_BRS_TS_Rollup1
GO
ALTER TABLE dbo.BRS_Customer
	DROP CONSTRAINT FK_BRS_Customer_BRS_TS_Rollup
GO
ALTER TABLE dbo.BRS_CustomerFSC_History
	DROP CONSTRAINT FK_BRS_CustomerFSC_History_BRS_TS_Rollup
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT FK_BRS_TransactionDW_Ext_BRS_TS_Rollup
GO
ALTER TABLE dbo.BRS_TS_Rollup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_TS_Rollup FOREIGN KEY
	(
	TsTerritoryCd
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_BRS_TS_Rollup FOREIGN KEY
	(
	HIST_TsTerritoryCd
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_TS_Rollup FOREIGN KEY
	(
	TsTerritoryCd
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_AGG_CMI_DW_Sales ADD CONSTRAINT
	FK_BRS_AGG_CMI_DW_Sales_BRS_TS_Rollup FOREIGN KEY
	(
	HIST_TsTerritoryCd
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_AGG_CMI_DW_Sales ADD CONSTRAINT
	FK_BRS_AGG_CMI_DW_Sales_BRS_TS_Rollup1 FOREIGN KEY
	(
	TAG_TsTerritoryCd
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_AGG_CMI_DW_Sales SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- check data

select * from   [dbo].[BRS_TS_Rollup] d
where not exists 
(
	select * from [dbo].[BRS_FSC_Rollup]  s
	where  d.[TsTerritoryCd] = s.[TerritoryCd]
)


-- add fields (potag)

ALTER TABLE dbo.BRS_FSC_Rollup ADD
	Rule_WhereClauseLike nchar(10) NULL
GO

-- move data

UPDATE       BRS_FSC_Rollup
SET                Rule_WhereClauseLike = '%' + s.PoTag + '%' 
FROM            BRS_TS_Rollup AS s INNER JOIN
                         BRS_FSC_Rollup ON s.TsTerritoryCd = BRS_FSC_Rollup.TerritoryCd
WHERE        (s.PoTag <> '')

UPDATE       BRS_FSC_Rollup
SET                FSCStatusCode = s.StatusCode
FROM            BRS_TS_Rollup AS s INNER JOIN
                         BRS_FSC_Rollup ON s.TsTerritoryCd = BRS_FSC_Rollup.TerritoryCd

SELECT        d.TerritoryCd, d.Rule_WhereClauseLike, s.PoTag, '%TS__%' AS rules, '%' + s.PoTag + '%' newr, len(d.Rule_WhereClauseLike) as l
FROM            BRS_TS_Rollup AS s INNER JOIN
                         BRS_FSC_Rollup AS d ON s.TsTerritoryCd = d.TerritoryCd
WHERE        (s.PoTag <> '')



-- delete fields
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_FSC_Rollup
	DROP CONSTRAINT DF__BRC_FSC_R__Prima__6BAEFA67
GO
ALTER TABLE dbo.BRS_FSC_Rollup
	DROP CONSTRAINT DF__BRC_FSC_R__Excep__6CA31EA0
GO
ALTER TABLE dbo.BRS_FSC_Rollup
	DROP CONSTRAINT DF_BRS_FSC_Rollup_TS_TerritoryCd
GO
ALTER TABLE dbo.BRS_FSC_Rollup
	DROP CONSTRAINT DF_BRS_FSC_Rollup_TS_TerritoryCd1
GO
ALTER TABLE dbo.BRS_FSC_Rollup
	DROP CONSTRAINT DF_BRS_FSC_Rollup_TS_PartnerNote
GO
ALTER TABLE dbo.BRS_FSC_Rollup
	DROP CONSTRAINT DF_BRS_FSC_Rollup_TS_TerritoryCd1_1
GO
ALTER TABLE dbo.BRS_FSC_Rollup
	DROP CONSTRAINT DF_BRS_FSC_Rollup_TS_TerritoryZahnCd1
GO
ALTER TABLE dbo.BRS_FSC_Rollup
	DROP COLUMN PrimaryFSCInd, ExceptionInd, TS_TerritoryCd, TS_StatusCd, TS_Note, TS_TerritoryZahnCd, TS_TerritoryMedCd
GO
ALTER TABLE dbo.BRS_FSC_Rollup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- drop table

/****** Object:  Table [dbo].[BRS_TS_Rollup]    Script Date: 03/01/2018 9:04:38 PM ******/
DROP TABLE [dbo].[BRS_TS_Rollup]
GO



/*
-- 2. update logic
BRS_BE_Dimension_load_proc
BRS_BE_Transaction_DW_load_proc
BRS_TS_Customer

-- done direct in proc
*/

