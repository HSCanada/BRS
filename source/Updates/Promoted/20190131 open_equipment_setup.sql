--updated 31 Jan 19


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

-- 
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



ALTER TABLE dbo.BRS_Customer ADD
--	bx_setup_date datetime NULL,
	bx_install_date datetime NULL
--	bx_group_id int NULL
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

/*
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
*/

SELECT  [TerritoryCd]
      ,[Branch]
      ,[group_type]
  FROM [dbo].[BRS_FSC_Rollup]
  WHERE [Branch] = 'OTTWA'


-- truncate table [nes].[order_open_prorepr]

-- truncate table [nes].[open_order_opordrpt]


-- Test

-- truncate table [nes].[open_order_opordrpt]

select * from [Integration].[open_order_opordrpt] where [est_num]= 'P32661'
go

select * from [nes].[open_order_opordrpt] where [ets_num]= 'P32661'
go





--- 21 mar 19
-- move to prod -> 22 Apr 19

--drop table nes.bx_role


CREATE TABLE [nes].[bx_role](
	[role_key] [int] IDENTITY(1,1) NOT NULL,
	[role_cd][char](30) NOT NULL,
	[role_descr] [nvarchar](50) NOT NULL,
	bx_active_ind bit NOT NULL CONSTRAINT DF_role_bx_active_ind DEFAULT 0
 CONSTRAINT [nes_bx_role_c_pk] PRIMARY KEY CLUSTERED 
(
	[role_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

INSERT INTO [nes].[bx_role](
	[role_cd],
	[role_descr])
     VALUES
           ('', '')
GO

INSERT INTO [nes].[bx_role](
	[role_cd],
	[role_descr])
     VALUES
           ('design', ''),
           ('coord', ''),
           ('install', ''),
		   ('service',''),
		   ('operations',''),
		   ('finance','')

GO

UPDATE [nes].[bx_role]
SET [bx_active_ind] = 1
WHERE [role_cd] <> ''
GO


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	bx_ess_code char(5) NULL,
	bx_dts_code char(5) NULL,
	bx_cps_code char(5) NULL,
	bx_fsc_code char(5) NULL
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
go

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_FSC_Rollup2 FOREIGN KEY
	(
	bx_cps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_FSC_Rollup3 FOREIGN KEY
	(
	bx_dts_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_FSC_Rollup4 FOREIGN KEY
	(
	bx_ess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_FSC_Rollup5 FOREIGN KEY
	(
	bx_fsc_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	bx_sales_category varchar(6) NULL
GO
ALTER TABLE dbo.BRS_ItemMPC ADD CONSTRAINT
	FK_BRS_ItemMPC_BRS_ItemSalesCategory FOREIGN KEY
	(
	bx_sales_category
	) REFERENCES dbo.BRS_ItemSalesCategory
	(
	SalesCategory
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemMPC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

INSERT INTO [dbo].[BRS_ItemSalesCategory]
([SalesCategory])
VALUES ('DIGIMP'),
('ITSL')
GO


UPDATE [dbo].[BRS_ItemMPC]
SET bx_sales_category = 'DENTRX'
WHERE
MajorProductClass in ('856','858')
GO

UPDATE [dbo].[BRS_ItemMPC]
SET bx_sales_category = 'HITECH'
WHERE
MajorProductClass in ('840','845', '855')
GO

UPDATE [dbo].[BRS_ItemMPC]
SET bx_sales_category = 'EQUIPM'
WHERE
MajorProductClass in ('800')
GO

UPDATE [dbo].[BRS_ItemMPC]
SET bx_sales_category = 'DIGIMP'
WHERE
MajorProductClass in ('373', '850', '826')
GO

UPDATE [dbo].[BRS_ItemMPC]
SET bx_sales_category = 'ITSL'
WHERE
MajorProductClass in ('801')
GO

--


UPDATE dbo.BRS_Employee
Set 
	bx_user_id = 4
WHERE
	SamAccountName = 'craig.faris'
GO

UPDATE dbo.BRS_Employee
Set 
	bx_user_id = 6
WHERE
	SamAccountName = 'tcrowley'
GO

UPDATE dbo.BRS_Employee
Set 
	bx_user_id = 8
WHERE
	SamAccountName = 'gary.winslow'
GO

UPDATE dbo.BRS_Employee
Set 
	bx_user_id = 33
WHERE
	SamAccountName ='Naghmeh.Hafezi'
GO

UPDATE dbo.BRS_Employee
Set 
	bx_user_id = 7
WHERE
	SamAccountName = 'jli'
GO

-- reset group create
-- 
UPDATE       BRS_Customer
SET                bx_setup_date = NULL, bx_install_date=NULL, bx_group_id = NULL, bx_invite_ind = NULL,
					[bx_ess_code] = NULL, [bx_dts_code] = NULL, [bx_cps_code] = NULL, [bx_fsc_code] = NULL
WHERE        (NOT (bx_invite_ind IS NULL))


-- add task table
-- drop table [nes].[bx_task_template]

CREATE TABLE [nes].[bx_task_template](
	[bx_task_id] [int] NOT NULL,
	[bx_title] [nvarchar](100) NULL,
	[bx_description] [nvarchar](1000) NULL,
	[bx_parent_task_id] [int] NOT NULL CONSTRAINT [DF_bx_task_template_parent_task]  DEFAULT ((0)),
	[bx_previous_task_id] [int] NOT NULL CONSTRAINT [DF_bx_task_template_previous_task]  DEFAULT ((0)),
	[role_key] [int] NOT NULL CONSTRAINT [DF_bx_task_template_role_key]  DEFAULT ((1)),
	[milestone_ind] [bit] NOT NULL CONSTRAINT [DF_bx_task_template_milestone_ind]  DEFAULT ((0)),
	[effort_hours] [int] NOT NULL CONSTRAINT [DF_bx_task_template_effort_hours]  DEFAULT ((0)),
	[offset_start_date] [int] NOT NULL CONSTRAINT [DF_bx_task_template_offset_start_date]  DEFAULT ((0)),
	[offset_end_date] [int] NOT NULL CONSTRAINT [DF_bx_task_template_offset_end_date]  DEFAULT ((0)),
	[note] [nvarchar](50) NULL,
	[load_seq] [int] NOT NULL CONSTRAINT [DF_bx_task_template_load_seq]  DEFAULT ((0)),
	[active_ind] [bit] NOT NULL CONSTRAINT [DF_bx_task_template_active_ind]  DEFAULT ((1)),
 CONSTRAINT [bx_task_template_c_pk] PRIMARY KEY CLUSTERED 
(
	[bx_task_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE nes.bx_task_template ADD CONSTRAINT
	FK_bx_task_template_bx_role FOREIGN KEY
	(
	role_key
	) REFERENCES nes.bx_role
	(
	role_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.bx_task_template ADD CONSTRAINT
	FK_bx_task_template_bx_task_template FOREIGN KEY
	(
	bx_parent_task_id
	) REFERENCES nes.bx_task_template
	(
	bx_task_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.bx_task_template ADD CONSTRAINT
	FK_bx_task_template_bx_task_template1 FOREIGN KEY
	(
	bx_previous_task_id
	) REFERENCES nes.bx_task_template
	(
	bx_task_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.bx_task_template SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
go




INSERT INTO [nes].[bx_task_template]
           ([bx_task_id]
           ,[bx_title] )
     VALUES
           (0
           ,'unassigned')
GO


-- 

INSERT INTO nes.bx_task_template
                         (bx_task_id, bx_parent_task_id, bx_previous_task_id, role_key, milestone_ind, effort_hours, offset_start_date, offset_end_date, note, load_seq, active_ind, 
                         bx_task_id_map, bx_title, bx_description, bx_checklist, bx_title_fr, bx_description_fr, bx_checklist_fr)
SELECT        bx_task_id, bx_parent_task_id, bx_previous_task_id, role_key, milestone_ind, effort_hours, offset_start_date, offset_end_date, note, load_seq, active_ind, 
                         bx_task_id_map, bx_title, bx_description, bx_checklist, bx_title_fr, bx_description_fr, bx_checklist_fr
FROM            DEV_BRSales.nes.bx_task_template AS bx_task_template_1
WHERE        (bx_task_id > 0)
ORDER BY bx_task_template_1.load_seq


ALTER TABLE dbo.BRS_Branch
	DROP COLUMN bx_user_id
GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Employee
	DROP CONSTRAINT FK_BRS_Employee_BRS_Branch
GO
ALTER TABLE dbo.BRS_Branch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Employee
	DROP CONSTRAINT DF_BRS_Employee_Branch
GO
ALTER TABLE dbo.BRS_Employee
	DROP COLUMN Branch
GO
ALTER TABLE dbo.BRS_Employee SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

ALTER TABLE dbo.BRS_Branch ADD
	language_cd char(2) NOT NULL CONSTRAINT DF_branch_language_cd DEFAULT 'EN'
GO

UPDATE dbo.BRS_Branch
set language_cd = 'FR'
where
branch in ('QUEBC', 'MNTRL')
go

ALTER TABLE nes.bx_task_template ADD
	bx_checklist nvarchar(2000) NULL,
	bx_title_fr nvarchar(100) NULL,
	bx_description_fr nvarchar(1000) NULL,
	bx_checklist_fr nvarchar(2000) NULL
GO


UPDATE nes.bx_task_template
set 
	bx_description = 'description TBD',
	bx_checklist ='checklist TBD',
	bx_title_fr = LEFT(bx_title,40) + ' <French>',
	bx_description_fr = 'description TBD <French>',
	bx_checklist_fr = 'checklist TBD <French>'

go

--
-- 
INSERT INTO nes.bx_role_branch
                         (Branch, role_key, unique_id)
SELECT        BRS_Branch.Branch, nes.bx_role.role_key, 1 AS unique_id
FROM            BRS_Branch CROSS JOIN
                         nes.bx_role
WHERE        (nes.bx_role.role_key > 1)
ORDER BY BRS_Branch.Branch
go

UPDATE nes.bx_role_branch
SET bx_active_ind = 1
where Branch = 'OTTWA'
go

UPDATE [dbo].[BRS_Employee] 
set bx_user_id =1
where SamAccountName = ''
GO


ALTER TABLE dbo.BRS_FSC_Rollup
	DROP COLUMN bx_user_id
GO

--

-- drop table [nes].[bx_role_branch]

CREATE TABLE [nes].[bx_role_branch](
	[Branch] [char](5) NOT NULL,
	[role_key] [int] NOT NULL,
	[unique_id] [int] NOT NULL CONSTRAINT [DF_bx_role_branch_unique_id]  DEFAULT ((1)),
	[SamAccountName] [nchar](20) NOT NULL CONSTRAINT [DF_role_branch_SameAccountName]  DEFAULT (''),
	[bx_active_ind] [bit] NOT NULL CONSTRAINT [DF_role_branch_bx_active_ind]  DEFAULT ((0)),
	[note] [nvarchar](50) NULL,
 CONSTRAINT [PK_bx_role_branch] PRIMARY KEY CLUSTERED 
(
	[Branch] ASC,
	[role_key] ASC,
	[unique_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--

BEGIN TRANSACTION
GO
ALTER TABLE nes.bx_role_branch ADD CONSTRAINT
	FK_bx_role_branch_BRS_Branch FOREIGN KEY
	(
	Branch
	) REFERENCES dbo.BRS_Branch
	(
	Branch
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.bx_role_branch ADD CONSTRAINT
	FK_bx_role_branch_bx_role FOREIGN KEY
	(
	role_key
	) REFERENCES nes.bx_role
	(
	role_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.bx_role_branch ADD CONSTRAINT
	FK_bx_role_branch_BRS_Employee FOREIGN KEY
	(
	SamAccountName
	) REFERENCES dbo.BRS_Employee
	(
	SamAccountName
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.bx_role_branch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_FSC_Rollup ADD
	SamAccountName nchar(20) NOT NULL CONSTRAINT DF_BRS_FSC_Rollup_SamAccountName DEFAULT ''
GO
ALTER TABLE dbo.BRS_FSC_Rollup ADD CONSTRAINT
	FK_BRS_FSC_Rollup_BRS_Employee FOREIGN KEY
	(
	SamAccountName
	) REFERENCES dbo.BRS_Employee
	(
	SamAccountName
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_FSC_Rollup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

---


UPDATE [nes].[bx_role_branch]
SET [SamAccountName] = 'craig.faris'
where  branch = 'ottwa' AND [role_key] = 2 and [unique_id] = 1
GO

UPDATE [nes].[bx_role_branch]
SET [SamAccountName] = 'JLi'
where  branch = 'ottwa' AND [role_key] = 3 and [unique_id] = 1
GO

UPDATE [nes].[bx_role_branch]
SET [SamAccountName] = 'Naghmeh.Hafezi'
where  branch = 'ottwa' AND [role_key] = 4 and [unique_id] = 1
GO

UPDATE [nes].[bx_role_branch]
SET [SamAccountName] = 'TCrowley'
where  branch = 'ottwa' AND [role_key] = 5 and [unique_id] = 1
GO

UPDATE [nes].[bx_role_branch]
SET [SamAccountName] = 'Jake.Banaszkiewicz'
where  branch = 'ottwa' AND [role_key] = 6 and [unique_id] = 1
GO

UPDATE [nes].[bx_role_branch]
SET [SamAccountName] = 'gary.winslow'
where  branch = 'ottwa' AND [role_key] = 6 and [unique_id] = 1
GO

-- map to prod

BEGIN TRANSACTION
GO
ALTER TABLE nes.bx_task_template ADD
	bx_task_id_map int NULL
GO
ALTER TABLE nes.bx_task_template SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE       nes.bx_task_template
SET                bx_title2 =bx_title, bx_description2 = bx_description, bx_checklist2 =bx_checklist, bx_title_fr2 = bx_title_fr, bx_description_fr2 = bx_description_fr, bx_checklist_fr2 = bx_checklist_fr

