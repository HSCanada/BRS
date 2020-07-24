-- open equpment deposit backend, tmc, 23 Jul 20

-- create table

-- drop table [nes].[open_order_deposit_R560960]
CREATE TABLE [nes].[open_order_deposit_R560960](
	[SalesDateLastWeekly] [datetime] NOT NULL
	,TerritoryCd [char](5) NOT NULL

	,customer_and_essname_lookup [varchar](255) NOT NULL
	,Past_Due_Deposit [money] NOT NULL
	,Past_Due_Order [money] NOT NULL
	,Current_Month_Deposit [money] NOT NULL
	,Current_Month_Order [money] NOT NULL
	,Month_Plus1_Deposit [money] NOT NULL
	,Month_Plus1_Order [money] NOT NULL
	,Month_Plus2_Deposit [money] NOT NULL
	,Month_Plus2_Order [money] NOT NULL
	,Month_Plus3_Deposit [money] NOT NULL
	,Month_Plus3_Order [money] NOT NULL
	,note [varchar](255) NULL
	,[id] [int] IDENTITY(1,1) NOT NULL
 CONSTRAINT [open_order_deposit_R560960_c_pk] PRIMARY KEY CLUSTERED 
(
	[SalesDateLastWeekly] ASC
	,TerritoryCd ASC
	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

-- Add RI
BEGIN TRANSACTION
GO
ALTER TABLE nes.open_order_deposit_R560960 ADD CONSTRAINT
	FK_open_order_deposit_R560960_BRS_SalesDay FOREIGN KEY
	(
	SalesDateLastWeekly
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_deposit_R560960 ADD CONSTRAINT
	FK_open_order_deposit_R560960_BRS_FSC_Rollup FOREIGN KEY
	(
	TerritoryCd
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_deposit_R560960 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add dummy first entry
INSERT INTO [nes].[open_order_deposit_R560960]
           ([SalesDateLastWeekly]
           ,[TerritoryCd]
           ,[customer_and_essname_lookup]
           ,[Past_Due_Deposit]
           ,[Past_Due_Order]
           ,[Current_Month_Deposit]
           ,[Current_Month_Order]
           ,[Month_Plus1_Deposit]
           ,[Month_Plus1_Order]
           ,[Month_Plus2_Deposit]
           ,[Month_Plus2_Order]
           ,[Month_Plus3_Deposit]
           ,[Month_Plus3_Order]
           ,[note])
     VALUES
           ('2012-01-01'
           ,''
           ,''
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,'unassigned')
GO

-- add data - manual pop from access 
-- See S:\BR\RegularReports\Weekly\Equipment_Sales_Pipeline\data

