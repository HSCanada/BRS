-- updated 31 Jan 19


CREATE TABLE [nes].[order_ets](
	[ets_num] [char](6) NOT NULL,
	[note] [nvarchar](50) NOT NULL,
	[ets_key] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [nes_ets_c_pk] PRIMARY KEY CLUSTERED 
(
	[ets_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

CREATE TABLE [nes].[item_status](
	[item_status][char](10) NOT NULL,
	[note] [nvarchar](50) NOT NULL,
	[item_status_key] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [nes_item_status_c_pk] PRIMARY KEY CLUSTERED 
(
	[item_status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

CREATE TABLE [nes].[group_type](
	[group_type][char](4) NOT NULL,
	[note] [nvarchar](50) NOT NULL,
	[group_type_key] [int] IDENTITY(1,1) NOT NULL,
	bx_active_ind bit NOT NULL CONSTRAINT DF_group_type_bx_active_ind DEFAULT 0
 CONSTRAINT [nes_group_type_c_pk] PRIMARY KEY CLUSTERED 
(
	[group_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--
INSERT INTO [nes].[group_type] 
(
	[group_type]
	,[note]
)
SELECT
	distinct [group_type], '' as note
FROM
	[dbo].[BRS_FSC_Rollup]  s
WHERE NOT EXISTS (SELECT * FROM [nes].[group_type] d where d.[group_type] = s.[group_type])
order by 1

GO

UPDATE [nes].[group_type]
set bx_active_ind = 1
WHERE [group_type] IN ('AAES', 'AAFS', 'DEST')
GO

-- XXX
ALTER TABLE [dbo].[BRS_FSC_Rollup] ADD CONSTRAINT
	FK_BRS_FSC_Rollup_group_type FOREIGN KEY
	(
	group_type
	) REFERENCES nes.group_type
	(
	group_type
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

--
ALTER TABLE dbo.BRS_Branch ADD
	bx_active_ind bit NOT NULL CONSTRAINT DF_BRS_Branch_bx_active_ind DEFAULT 0
GO


UPDATE BRS_Branch
	SET bx_active_ind = 1
WHERE [Branch]= 'OTTWA'
GO

ALTER TABLE [dbo].BRS_Branch ADD
	bx_user_id int NULL
GO


ALTER TABLE [nes].[order_status] ADD
	bx_active_ind bit NOT NULL CONSTRAINT DF_nex_order_status_bx_active_ind DEFAULT 0
GO

UPDATE [nes].[order_status]
SET bx_active_ind = 1
WHERE[order_status_code] in ('QA', 'QP', 'WO')


ALTER TABLE dbo.BRS_Config ADD
	bx_order_thresh money NOT NULL CONSTRAINT DF_BRS_Config_bx_order_thresh DEFAULT 0
GO

UPDATE dbo.BRS_Config
SET bx_order_thresh = 10000
GO


ALTER TABLE [dbo].[BRS_Employee] ADD
	bx_user_id int NULL
GO

ALTER TABLE dbo.BRS_Employee ADD
	Branch char(5) NOT NULL CONSTRAINT DF_BRS_Employee_Branch DEFAULT ''
GO

ALTER TABLE dbo.BRS_Employee ADD CONSTRAINT
	FK_BRS_Employee_BRS_Branch FOREIGN KEY
	(
	Branch
	) REFERENCES dbo.BRS_Branch
	(
	Branch
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO


ALTER TABLE dbo.BRS_FSC_Rollup ADD
	bx_user_id int NULL
GO

ALTER TABLE dbo.BRS_Customer ADD
	bx_setup_date datetime NULL,
	bx_group_id int NULL
GO


ALTER TABLE dbo.BRS_Customer ADD
	bx_invite_ind int NULL
GO


ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_bx_setup_date FOREIGN KEY
	(
	bx_setup_date
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- drop table nes.[open_order_opordrpt]

CREATE TABLE nes.[open_order_opordrpt](
	[SalesDate] [Datetime] NOT NULL,
	[ets_num] [char](6) NOT NULL,
	[line_number] [int] NOT NULL,

	[d1_branch] [char](10) NOT NULL,
	[order_status] [char](2) NOT NULL,
	[work_order_num] [char](10) NOT NULL,
	[work_order_date] [Datetime] NOT NULL,
	[shipto] [int] NOT NULL,
	[install_date] [Datetime] NOT NULL,
	[item_status] [char](10) NOT NULL,
	[item] [char](10) NOT NULL,
	[supplier] [char](6) NOT NULL,

	[ess_code] [char](5) NOT NULL,
	[dts_code] [char](5) NOT NULL,
	[cps_code] [char](5) NOT NULL,
	[fsc_code] [char](5) NOT NULL,

	[order_qty] [int] NOT NULL,
	[received_qty] [int] NULL,
	[received_date] [datetime] NULL,

	[net_sales_amount] [money] NOT NULL,
	[extended_cost_amount] [money] NOT NULL

 CONSTRAINT [open_order_opordrpt_pk] PRIMARY KEY NONCLUSTERED 
(
	[SalesDate] ASC,
	[ets_num] ASC,
	[line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


ALTER TABLE nes.open_order_opordrpt ADD
	fact_id int NOT NULL IDENTITY(1,1)
GO



BEGIN TRANSACTION
GO

ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_SalesDay FOREIGN KEY
	(
	SalesDate
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_SalesDay2 FOREIGN KEY
	(
	[work_order_date]
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_SalesDay3 FOREIGN KEY
	(
	[install_date]
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_SalesDay4 FOREIGN KEY
	(
	[received_date]
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_order_ets FOREIGN KEY
	(
	ets_num
	) REFERENCES nes.order_ets
	(
	ets_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_branch FOREIGN KEY
	(
	d1_branch
	) REFERENCES nes.branch
	(
	branch_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_order_status FOREIGN KEY
	(
	order_status
	) REFERENCES nes.order_status
	(
	order_status_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_order FOREIGN KEY
	(
	work_order_num
	) REFERENCES nes.[order]
	(
	work_order_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_Customer FOREIGN KEY
	(
	shipto
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_Item FOREIGN KEY
	(
	item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_ItemSupplier FOREIGN KEY
	(
	supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_FSC_Rollup FOREIGN KEY
	(
	ess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_FSC_Rollup1 FOREIGN KEY
	(
	dts_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_FSC_Rollup2 FOREIGN KEY
	(
	cps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_BRS_FSC_Rollup3 FOREIGN KEY
	(
	fsc_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.open_order_opordrpt ADD CONSTRAINT
	FK_open_order_opordrpt_item_status FOREIGN KEY
	(
	item_status
	) REFERENCES [nes].[item_status]
	(
	item_status
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE nes.open_order_opordrpt SET (LOCK_ESCALATION = TABLE)
GO
COMMIT






--- pop 


UPDATE [dbo].[BRS_FSC_Rollup]
	SET [bx_user_id] = 33
WHERE 
	[Branch] = 'OTTWA' AND
	[group_type] = 'AAFS'
GO


UPDATE [dbo].[BRS_FSC_Rollup]
	SET [bx_user_id] = 4
WHERE 
	[Branch] = 'OTTWA' AND
	[group_type] = 'AAES'
GO


UPDATE BRS_Branch
	SET [bx_user_id] = 50
WHERE [Branch]= 'OTTWA'
GO


SELECT  [TerritoryCd]
      ,[Branch]
      ,[group_type]
      ,[bx_user_id]
  FROM [DEV_BRSales].[dbo].[BRS_FSC_Rollup]
  WHERE [Branch] = 'OTTWA'


-- truncate table [nes].[order_open_prorepr]

-- truncate table [nes].[open_order_opordrpt]


-- Test

-- truncate table [nes].[open_order_opordrpt]

select * from [Integration].[open_order_opordrpt] where [est_num]= 'P32661'
go

select * from [nes].[open_order_opordrpt] where [ets_num]= 'P32661'
go


UPDATE       BRS_Customer
SET                bx_setup_date = NULL, bx_group_id = NULL, bx_invite_ind = NULL
WHERE        (NOT (bx_group_id IS NULL))