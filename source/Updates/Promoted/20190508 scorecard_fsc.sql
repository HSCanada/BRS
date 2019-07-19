-- goal to pre new comm backend for scorecord reporting


-- IN PROD BEGIN ----->

BEGIN TRANSACTION
GO
ALTER TABLE comm.[group] ADD
	comm_group_scorecard_cd char(6) NOT NULL CONSTRAINT DF_group_comm_group_scorecard_cd DEFAULT ''
GO
ALTER TABLE comm.[group] ADD CONSTRAINT
	FK_group_group2 FOREIGN KEY
	(
	comm_group_scorecard_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.[group] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- set "cerec" group

UPDATE comm.[group]
SET comm_group_scorecard_cd = 'DIGIMP'
WHERE
comm_group_cd in ('DIGIMP', 'DIGCCS', 'DIGOTH', 'DIGCIM', 'DIGCCC', 'DIGLAB') 
GO

-- addd DO NOT USE code
INSERT INTO comm.[group]
                         (comm_group_cd, [comm_group_desc])
VALUES        ('ZZZZZZ', 'zzzExclude')
GO

-- addd ok -- inlucde 
INSERT INTO comm.[group]
                         (comm_group_cd, [comm_group_desc])
VALUES        ('SCRCRD', 'Scorecard Include - other')
GO


UPDATE comm.[group]
SET comm_group_scorecard_cd = 'ZZZZZZ'
WHERE
comm_group_cd NOT in ('DIGIMP', 'DIGMAT', 'FRESEQ', 'FRESND', 'ITMCAM', 'ITMCPU', 'ITMEQ0', 'ITMFO1', 'ITMFO2', 'ITMFO3', 'ITMFRT', 'ITMISC', 'ITMPAR', 'ITMSER', 'ITMSND', 'ITMSOF', 'ITMTEE', 'REBSND', 'REBTEE', 'SFFFIN', 'SPMFGE', 'SPMFGS', 'SPMFO1', 'SPMFO2', 'SPMFO3', 'SPMREB', 'SPMSND'  ) AND
comm_group_scorecard_cd = ''
GO

UPDATE comm.[group]
SET comm_group_scorecard_cd = 'SCRCRD'
WHERE
comm_group_scorecard_cd = ''
GO

SELECT [employee_num]
      ,[tracker_ind]
  FROM [comm].[salesperson_master] WHERE tracker_ind = 1


-- run  source/Dimension.CommissionGroup.sql

-- IN PROD END ---<


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemSalesCategory ADD
	SalesCategoryScorecard varchar(6) NOT NULL CONSTRAINT DF_BRS_ItemSalesCategory_SalesCategoryScorecard DEFAULT ''
GO
ALTER TABLE dbo.BRS_ItemSalesCategory ADD CONSTRAINT
	FK_BRS_ItemSalesCategory_BRS_ItemSalesCategory3 FOREIGN KEY
	(
	SalesCategoryScorecard
	) REFERENCES dbo.BRS_ItemSalesCategory
	(
	SalesCategory
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemSalesCategory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE dbo.BRS_ItemSalesCategory
SET [SalesCategoryScorecard] = [SalesCategoryRollup]
go

UPDATE dbo.BRS_ItemSalesCategory
SET [SalesCategoryScorecard] = [SalesCategory]
where [SalesCategory] = 'HITECH'
go


-- IN PROD BEGIN (7 Jun 19) ----->

CREATE SCHEMA [strat] AUTHORIZATION [dbo]
go



CREATE TABLE [strat].[tracker](
	[ShipTo] [int] NOT NULL,
	[FiscalMonth] [int] NOT NULL,
	[strat_code] [char](3) NOT NULL,
	[note] [nchar](50) NULL,
 CONSTRAINT [PK_tracker] PRIMARY KEY CLUSTERED 
(
	[ShipTo] ASC,
	[FiscalMonth] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


-- drop table [strat].[tracker_code]

CREATE TABLE [strat].[tracker_code](
	[strat_code] [char](3) NOT NULL,
	[strat_description] [nchar](30) NULL,
	[note] [nchar](50) NULL,
 CONSTRAINT [PK_tracker_code] PRIMARY KEY CLUSTERED 
(
	[strat_code] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

INSERT INTO [strat].[tracker_code]
(strat_code, strat_description)
VALUES ('', 'unassigned')
GO

INSERT INTO [strat].[tracker_code]
(strat_code, strat_description)
VALUES ('PAT', 'practice analysis took'),
('BDM', 'business discovery meeting')
GO

--

BEGIN TRANSACTION
GO
ALTER TABLE strat.tracker ADD CONSTRAINT
	FK_tracker_BRS_Customer FOREIGN KEY
	(
	ShipTo
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE strat.tracker ADD CONSTRAINT
	FK_tracker_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE strat.tracker ADD CONSTRAINT
	FK_tracker_tracker_code FOREIGN KEY
	(
	strat_code
	) REFERENCES strat.tracker_code
	(
	strat_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE strat.tracker SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE strat.tracker ADD
	date_complete date NULL
GO
ALTER TABLE strat.tracker SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

-- fix PK
BEGIN TRANSACTION
GO
ALTER TABLE strat.tracker
	DROP CONSTRAINT PK_tracker
GO
ALTER TABLE strat.tracker ADD CONSTRAINT
	PK_tracker_1 PRIMARY KEY CLUSTERED 
	(
	ShipTo,
	FiscalMonth,
	strat_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE strat.tracker SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

-- IN PROD END ---<

-- BRP -> PAR logic here, 15 Jul 19

ALTER TABLE strat.tracker ADD
	ID int identity(1,1) NOT NULL
GO

ALTER TABLE strat.tracker_code ADD
	strat_key int identity(1,1) NOT NULL
GO

update [strat].[tracker]
set [strat_code] = 'PAR'
where [strat_code] = 'BRP'

