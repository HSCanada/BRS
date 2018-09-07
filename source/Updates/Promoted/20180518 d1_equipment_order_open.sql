-- D1 Equipment order open 
-- 18 May 18, tmc

CREATE SCHEMA [nes] AUTHORIZATION [dbo]
GO

-- DROP TABLE [Integration].[open_order_opordrpt]

CREATE TABLE [Integration].[open_order_opordrpt](
	[est_num] [char](6) NOT NULL,
	[line_number] [int] NOT NULL,
	[d1_branch] [char](10) NULL,
	[order_status] [char](2) NULL,
	[work_order_num] [char](10) NULL,
	[work_order_date] [date] NULL,
	[shipto] [int] NULL,
	[practice_name] [varchar](40) NULL,
	[install_date] [date] NULL,
	[item_status] [char](10) NULL,
	[item] [char](10) NULL,
	[item_description] [varchar](40) NULL,
	[supplier] [char](6) NULL,
	[order_qty] [int] NULL,
	[received_qty] [int] NULL,
	[received_date] [date] NULL,
	[net_sales_amount] [money] NULL,
	[extended_cost_amount] [money] NULL,
	[ess_code] [char](5) NULL,
	[dts_code] [char](5) NULL,
	[cps_code] [char](5) NULL,
	[fsc_code] [char](5) NULL,
 CONSTRAINT [open_order_opordrpt_pk] PRIMARY KEY NONCLUSTERED 
(
	[est_num] ASC,
	[line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

--

-- DROP TABLE [Integration].[open_order_prorepr]

CREATE TABLE [Integration].[open_order_prorepr](
	[work_order_num] [char](10) NOT NULL,
	[d1_branch] [char](10) NULL,
	[rma_code] [char](5) NULL,
	[order_status] [char](2) NULL,

	[order_received_date] [date] NULL,
	[estimate_complete_date] [date] NULL,
	[approved_date] [date] NULL,
	[approved_part_release_date] [date] NULL,
	[order_complete_date] [date] NULL,

	[shipto] [int] NULL,
	[practice_name] [varchar](40) NULL,
	[priv_code] [char](5) NULL,
	[model_number] [varchar](20) NULL,
	[est_num] [char](6) NOT NULL,
	[call_type_code] [char](5) NULL,
	[problem_code] [char](5) NULL,
	[problem_descr] [varchar](20) NULL,
	[cause_code] [char](5) NULL,
	[cause_descr] [varchar](20) NULL,
	[d1_user_id] [char](10) NULL,

 CONSTRAINT [open_order_prorepr_pk] PRIMARY KEY NONCLUSTERED 
(
	[work_order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

--

-- DROP TABLE [Integration].[inventory_valuation_whvalrpt]

CREATE TABLE [Integration].[inventory_valuation_whvalrpt](
	[item] [char](10) NULL,
	[branch_code] [char](10) NULL,
	[tag_number] [varchar](20) NULL,
	[supplier] [char](6) NULL,
	[model_number] [varchar](20) NULL,
	[item_description] [varchar](40) NULL,
	[bin_code] [char](10) NULL,
	[item_class_code] [char](10) NULL,
	[available_qty] [int] NULL,
	[allocation_qty] [int] NULL,
	[reserved_qty] [int] NULL,
	[total_qty] [int] NULL,
	[cost_unit] [char](2) NULL,
	[tag_or_avg_cost] [money] NULL,
	[tag_cost_ind] [char](1) NULL,
	[available_extended_value] [money] NULL,
	[reserved_extended_value] [money] NULL,
	[reservation_quantity_list] [varchar](25) NULL,
	[total_extended_value] [money] NULL,
	[id_key] [integer] identity(1,1) NOT NULL

 CONSTRAINT [inventory_valuation_whvalrpt_pk] PRIMARY KEY NONCLUSTERED 
(
	[id_key]  ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

--

CREATE TABLE [nes].[order_open_prorepr](
	[SalesDate]	 [datetime] NOT NULL,
	[work_order_num] [char](10) NOT NULL,
	[branch_code] [char](10) NOT NULL,
	[rma_code] [char](5) NOT NULL,
	[order_status_code] [char](2) NOT NULL,

	[order_received_date] [date] NULL,
	[estimate_complete_date] [date] NULL,
	[approved_date] [date] NULL,
	[approved_part_release_date] [date] NULL,
	[order_complete_date] [date] NULL,

	[shipto] [int] NOT NULL,
	[privileges_code] [char](5) NOT NULL,
	[model_number] [varchar](20) NOT NULL,
	[est_code] [char](5) NOT NULL,
	[call_type_code] [char](5) NOT NULL,
	[problem_code] [char](5) NOT NULL,
	[cause_code] [char](5) NOT NULL,
	[user_id] [char](10) NOT NULL,
	[fact_id] int identity(1,1) NOT NULL,

	[last_update_date] [date] NULL,

 CONSTRAINT [nes_open_order_prorepr_pk] PRIMARY KEY CLUSTERED 
(
	[SalesDate] ASC,
	[work_order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--	[work_order_num] [char](10) NOT NULL
CREATE TABLE [nes].[order](
	[work_order_num] [char](10) NOT NULL,
	[note] [nvarchar](50) NOT NULL,
	[work_order_key] [int] identity(1,1) NOT NULL,
 CONSTRAINT [nes_work_order_c_pk] PRIMARY KEY CLUSTERED 
(
	[work_order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--	[branch_code] [char](4) NOT NULL,
CREATE TABLE [nes].[branch](
	[branch_code] [char](10) NOT NULL,
	[branch_name] [nvarchar](50) NOT NULL,
 	[branch_key] [int] identity(1,1) NOT NULL,
 CONSTRAINT [nes_branch_c_pk] PRIMARY KEY CLUSTERED 
(
	[branch_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE nes.branch ADD
	Branch char(5) NOT NULL CONSTRAINT DF_branch_Branch DEFAULT ('')
GO

--	[order_status_code] [char](2) NOT NULL,
CREATE TABLE [nes].[order_status](
	[order_status_code] [char](2) NOT NULL,
	[order_status_descr] [nvarchar](50) NOT NULL,
 	[order_status_key] [int] identity(1,1) NOT NULL,

 CONSTRAINT [nes_order_status_c_pk] PRIMARY KEY CLUSTERED 
(
	[order_status_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--	[privileges_code] [char](5) NOT NULL,
CREATE TABLE [nes].[privileges](
	[privileges_code] [char](5) NOT NULL,
	[privileges_descr] [nvarchar](50) NOT NULL,
 	[privileges_key] [int] identity(1,1) NOT NULL,
 CONSTRAINT [nes_privileges_c_pk] PRIMARY KEY CLUSTERED 
(
	[privileges_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE nes.[privileges] ADD
	priority_code char(1) NOT NULL CONSTRAINT DF_privileges_priority_code DEFAULT ('')
GO

--	[call_type_code] [char](5) NOT NULL,
CREATE TABLE [nes].[call_type](
	[call_type_code] [char](5) NOT NULL,
	[call_type_descr] [nvarchar](50) NOT NULL,
 	[call_type_key] [int] identity(1,1) NOT NULL,
 CONSTRAINT [nes_call_type_c_pk] PRIMARY KEY CLUSTERED 
(
	[call_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--	[problem_code] [char](5) NOT NULL,
CREATE TABLE [nes].[problem](
	[problem_code] [char](5) NOT NULL,
	[problem_descr] [nvarchar](50) NOT NULL,
 	[problem_key] [int] identity(1,1) NOT NULL,
 CONSTRAINT [nes_problem_code_c_pk] PRIMARY KEY CLUSTERED 
(
	[problem_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--	[cause_code] [char](5) NOT NULL,
CREATE TABLE [nes].[cause](
	[cause_code] [char](5) NOT NULL,
	[cause_descr] [nvarchar](50) NOT NULL,
	[owner] [nvarchar](50) NOT NULL,
 	[turnaround_time] [int] NOT NULL,
	[order_status_code] [char](2) NOT NULL,
 	[cause_key] [int] identity(1,1) NOT NULL,

 CONSTRAINT [nes_cause_code_c_pk] PRIMARY KEY CLUSTERED 
(
	[cause_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE nes.cause ADD
	work_flow nvarchar(50) NOT NULL CONSTRAINT DF_cause_work_flow DEFAULT ('.')
GO

--	[user_id] [char](10) NOT NULL,
CREATE TABLE [nes].[user_login](
	[user_id] [char](10) NOT NULL,
	[user_name] [nvarchar](50) NOT NULL,
	[branch_code] [char](10) NOT NULL,
	[type_code] [char](4) NOT NULL,
	[user_key] [int] identity(1,1) NOT NULL,
 CONSTRAINT [nes_user_id_c_pk] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

CREATE TABLE [nes].[aging](
	[day_from] [smallint] NOT NULL,
	[day_to] [smallint] NOT NULL,
	[aging_display] [nchar](20) NULL,
	[aging_sort] [smallint] NULL,
	[aging_key] [smallint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [nes_aging_c_pk] PRIMARY KEY CLUSTERED 
(
	[day_from] ASC,
	[day_to] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

CREATE TABLE [nes].[rma](
	[rma_code] [char](5) NOT NULL,
	[rma_name] [nvarchar](50) NOT NULL,
	[rma_key] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [nes_rma_c_pk] PRIMARY KEY CLUSTERED 
(
	[rma_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO



--

BEGIN TRANSACTION
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_BRS_SalesDay FOREIGN KEY
	(
	SalesDate
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_order FOREIGN KEY
	(
	work_order_num
	) REFERENCES nes.[order]
	(
	work_order_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_branch FOREIGN KEY
	(
	branch_code
	) REFERENCES nes.branch
	(
	branch_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_order_status FOREIGN KEY
	(
	order_status_code
	) REFERENCES nes.order_status
	(
	order_status_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_BRS_Customer FOREIGN KEY
	(
	shipto
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_privileges FOREIGN KEY
	(
	privileges_code
	) REFERENCES nes.[privileges]
	(
	privileges_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_BRS_FSC_Rollup FOREIGN KEY
	(
	est_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_call_type FOREIGN KEY
	(
	call_type_code
	) REFERENCES nes.call_type
	(
	call_type_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_problem FOREIGN KEY
	(
	problem_code
	) REFERENCES nes.problem
	(
	problem_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_cause FOREIGN KEY
	(
	cause_code
	) REFERENCES nes.cause
	(
	cause_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE nes.order_open_prorepr ADD CONSTRAINT
	FK_order_open_prorepr_user_login FOREIGN KEY
	(
	user_id
	) REFERENCES nes.[user_login]
	(
	user_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.[user_login] ADD CONSTRAINT
	FK_user_branch FOREIGN KEY
	(
	branch_code
	) REFERENCES nes.branch
	(
	branch_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.cause ADD CONSTRAINT
	FK_cause_order_status FOREIGN KEY
	(
	order_status_code
	) REFERENCES nes.order_status
	(
	order_status_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.rma ADD CONSTRAINT
	FK_rma_code FOREIGN KEY
	(
	rma_code
	) REFERENCES nes.rma
	(
	rma_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
GO

ALTER TABLE nes.order_open_prorepr SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

CREATE TABLE [nes].[inventory_valuation_whvalrpt](
	[SalesDate]	 [datetime] NOT NULL,
	[item] [char](10) NOT NULL,
	[branch_code] [char](10) NOT NULL,
	[tag_number] [varchar](20) NOT NULL,
	[tag_date] date NULL,
	[tag_cost_ind] [char](1) NOT NULL,
	[bin_code] [char](10) NOT NULL,
	[reservation_quantity_list] [varchar](25) NOT NULL,

	[tag_or_avg_cost] [money] NOT NULL,
	[available_extended_value] [money] NOT NULL,
	[reserved_extended_value] [money] NOT NULL,
	[total_extended_value] [money] NOT NULL,

	[available_qty] [int] NOT NULL,
	[allocation_qty] [int] NOT NULL,
	[reserved_qty] [int] NOT NULL,
	[total_qty] [int] NOT NULL,

	[id_key] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [nes_inventory_valuation_whvalrpt_pk] PRIMARY KEY NONCLUSTERED 
(
	[id_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

-- RI
BEGIN TRANSACTION
GO
ALTER TABLE nes.inventory_valuation_whvalrpt ADD CONSTRAINT
	FK_inventory_valuation_whvalrpt_BRS_SalesDay FOREIGN KEY
	(
	SalesDate
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.inventory_valuation_whvalrpt ADD CONSTRAINT
	FK_inventory_valuation_whvalrpt_BRS_Item FOREIGN KEY
	(
	item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.inventory_valuation_whvalrpt ADD CONSTRAINT
	FK_inventory_valuation_whvalrpt_branch FOREIGN KEY
	(
	branch_code
	) REFERENCES nes.branch
	(
	branch_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.inventory_valuation_whvalrpt SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--


---

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	est_code char(5) NOT NULL CONSTRAINT DF_BRS_Customer_est_code DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_FSC_Rollup1 FOREIGN KEY
	(
	est_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

ALTER TABLE nes.branch ADD CONSTRAINT
	FK_branch_BRS_Branch FOREIGN KEY
	(
	Branch
	) REFERENCES dbo.BRS_Branch
	(
	Branch
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

--
-- drop table [nes].[order_open_prorepr_standards]

CREATE TABLE [nes].[order_open_prorepr_standards](
	[cause_code] [char](5) NOT NULL,
	[problem_code] [char](5) NOT NULL,
	[call_type_code] [char](5) NOT NULL,
	[order_status_code] [char](2) NOT NULL,
	[rma_code] [char](5) NOT NULL,
	[id_key] [int] identity(1,1) NOT NULL,
	[est_value_amt] [money] NULL,
	[next_action] [nchar](30) NULL,
 CONSTRAINT [nes_order_open_prorepr_standards_c_pk] PRIMARY KEY CLUSTERED 
(
	[cause_code] ASC,
	[problem_code] ASC,
	[call_type_code] ASC,
	[order_status_code] ASC,
	[rma_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--

BEGIN TRANSACTION
GO
ALTER TABLE nes.order_open_prorepr_standards ADD CONSTRAINT
	FK_order_open_prorepr_standards_cause FOREIGN KEY
	(
	cause_code
	) REFERENCES nes.cause
	(
	cause_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr_standards ADD CONSTRAINT
	FK_order_open_prorepr_standards_problem FOREIGN KEY
	(
	problem_code
	) REFERENCES nes.problem
	(
	problem_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr_standards ADD CONSTRAINT
	FK_order_open_prorepr_standards_call_type FOREIGN KEY
	(
	call_type_code
	) REFERENCES nes.call_type
	(
	call_type_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr_standards ADD CONSTRAINT
	FK_order_open_prorepr_standards_order_status FOREIGN KEY
	(
	order_status_code
	) REFERENCES nes.order_status
	(
	order_status_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr_standards ADD CONSTRAINT
	FK_order_open_prorepr_standards_rma FOREIGN KEY
	(
	rma_code
	) REFERENCES nes.rma
	(
	rma_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.order_open_prorepr_standards SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- STOP
/*
--todo 0 add to EST task, 11 Jun 18

-- fix est code in dev, add branch
UPDATE       BRS_FSC_Rollup
SET                FSCStatusCode = 'S'
WHERE        (Branch = '') AND (TerritoryCd < 'DINB ')

-- update zzzItem from csrrep

UPDATE       BRS_FSC_Rollup
SET                Branch = zzzItem.Note1
FROM            BRS_FSC_Rollup INNER JOIN
                         zzzItem ON BRS_FSC_Rollup.TerritoryCd = zzzItem.Item
UPDATE zzzItem
set Note1 = 'ZCORP'
where Note1 = 'CORP'

SELECT [TerritoryCd]
      ,[FSCName]
      ,[Branch]
      ,[FSCStatusCode]
      ,[AddedDt]
FROM [BRS_FSC_Rollup] where FSCStatusCode= 'S' order by 3

UPDATE       nes.branch
SET                Branch = i.Note1
FROM            zzzItem AS i INNER JOIN
                         nes.branch ON i.Item = nes.branch.branch_code

*/


select 
    s.name +'.'+ o.name as [Name] 
from
    sys.all_objects o
    inner join sys.schemas s on s.schema_id = o.schema_id 
where
    o.type in ('U') -- tables, views, and stored procedures
	AND s.name ='nes'
order by
    s.name

---

-- populate
INSERT INTO 
nes.branch
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO 
[nes].[call_type]
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO 
[nes].[order_status]
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO 
[nes].[cause]
VALUES        ('', N'UNASSIGNED', '', 0, '', '')
GO


INSERT INTO 
[nes].[order]
VALUES        ('', N'UNASSIGNED')
GO


INSERT INTO 
[nes].[privileges]
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO 
[nes].[problem]
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO nes.[user_login]
                         (user_id, user_name, branch_code, type_code)
VALUES        ('', N'UNASSIGNED', '', '')
GO

--

-- populate PROD

SET IDENTITY_INSERT nes.branch ON
go
INSERT INTO 
nes.branch
select * from DEV_BRSales.nes.branch
go
SET IDENTITY_INSERT nes.branch OFF
go

INSERT INTO 
[nes].[call_type]
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO 
[nes].[order_status]
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO 
[nes].[cause]
VALUES        ('', N'UNASSIGNED', '', 0, '', '')
GO


INSERT INTO 
[nes].[order]
VALUES        ('', N'UNASSIGNED')
GO


INSERT INTO 
[nes].[privileges]
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO 
[nes].[problem]
VALUES        ('', N'UNASSIGNED')
GO

INSERT INTO nes.[user_login]
                         (user_id, user_name, branch_code, type_code)
VALUES        ('', N'UNASSIGNED', '', '')
GO


--nes.branch
INSERT INTO [nes].[branch]
           (
		   [branch_code]
           ,[branch_name]
           ,[Branch]
		   )
SELECT 
           [branch_code]
           ,[branch_name]
           ,[Branch]
FROM [DEV_BRSales].[nes].[branch]
GO

-- nes.call_type
INSERT INTO nes.call_type
           (
		   [call_type_code]
           ,[call_type_descr]
		   )
SELECT 
		   [call_type_code]
           ,[call_type_descr]

FROM [DEV_BRSales].nes.call_type
GO

-- nes.order_status
INSERT INTO nes.order_status
           (
		   [order_status_code],
			[order_status_descr]
		   )
SELECT 
		   [order_status_code],
			[order_status_descr]

FROM [DEV_BRSales].nes.order_status
GO

-- nes.cause
INSERT INTO nes.cause
           (
		   [cause_code]
           ,[cause_descr]
           ,[owner]
           ,[turnaround_time]
           ,[order_status_code]
           ,[work_flow]
		   )
SELECT 
		   [cause_code]
           ,[cause_descr]
           ,[owner]
           ,[turnaround_time]
           ,[order_status_code]
           ,[work_flow]

FROM [DEV_BRSales].nes.cause
GO

-- nes.order
INSERT INTO nes.[order]
           (
		   [work_order_num],
			[note]
		   )
SELECT 
		   [work_order_num],
			[note]

FROM [DEV_BRSales].nes.[order]
GO

-- nes.privileges
INSERT INTO nes.privileges
           (
		   [privileges_code]
           ,[privileges_descr]
           ,[priority_code]
		   )
SELECT 
		   [privileges_code]
           ,[privileges_descr]
           ,[priority_code]

FROM [DEV_BRSales].nes.privileges
GO

-- nes.problem
INSERT INTO nes.problem
           (
		   [problem_code],
			[problem_descr]
		   )
SELECT 
		   [problem_code],
			[problem_descr]

FROM [DEV_BRSales].nes.problem
GO

-- nes.user_login
INSERT INTO nes.user_login
           (
		   [user_id]
           ,[user_name]
           ,[branch_code]
           ,[type_code]
		   )
SELECT 
		   [user_id]
           ,[user_name]
           ,[branch_code]
           ,[type_code]

FROM [DEV_BRSales].nes.user_login
GO

-- nes.aging
INSERT INTO nes.aging
           (
		   [day_from]
           ,[day_to]
           ,[aging_display]
           ,[aging_sort]
		   )
SELECT 
		   [day_from]
           ,[day_to]
           ,[aging_display]
           ,[aging_sort]

FROM [DEV_BRSales].nes.aging
GO

-- nes.rma
INSERT INTO nes.rma
           (
		   [rma_code],
			[rma_name]
		   )
SELECT 
		   [rma_code],
			[rma_name]

FROM [DEV_BRSales].nes.rma
GO

-- nes.order_open_prorepr_standards
INSERT INTO nes.order_open_prorepr_standards
           (
           [cause_code]
           ,[problem_code]
           ,[call_type_code]
           ,[order_status_code]
           ,[rma_code]
           ,[est_value_amt]
           ,[next_action]

		   )
SELECT 
           [cause_code]
           ,[problem_code]
           ,[call_type_code]
           ,[order_status_code]
           ,[rma_code]
           ,[est_value_amt]
           ,[next_action]

FROM [DEV_BRSales].nes.order_open_prorepr_standards
GO


---
-- nes.order_open_prorepr_standards

INSERT INTO [dbo].[BRS_FSC_Rollup]
           (
           [TerritoryCd]
           ,[FSCName]
           ,[Branch]
           ,[FSCStatusCode]
           ,[LastReviewDate]
           ,[StatusCd]
           ,[AddedDt]
           ,[FSCRollup]
           ,[CategoryCode]
           ,[NoteTxt]
           ,[FSCNameShort]
           ,[TS_CategoryCd]
           ,[comm_salesperson_key_id]
           ,[group_type]
           ,[order_taken_by]
           ,[Rule_WhereClauseLike]

		   )
SELECT 
           [TerritoryCd]
           ,[FSCName]
           ,[Branch]
           ,[FSCStatusCode]
           ,[LastReviewDate]
           ,[StatusCd]
           ,[AddedDt]
           ,[FSCRollup]
           ,[CategoryCode]
           ,[NoteTxt]
           ,[FSCNameShort]
           ,[TS_CategoryCd]
           ,[comm_salesperson_key_id]
           ,[group_type]
           ,[order_taken_by]
           ,[Rule_WhereClauseLike]

FROM [DEV_BRSales].[dbo].[BRS_FSC_Rollup]
where 
	FSCStatusCode = 'S' AND
	not exists (select * FROM [dbo].[BRS_FSC_Rollup] old where [DEV_BRSales].[dbo].[BRS_FSC_Rollup].TerritoryCd = old.TerritoryCd) 

GO


INSERT INTO [nes].[order_open_prorepr]
           (
           [SalesDate]
           ,[work_order_num]
           ,[branch_code]
           ,[rma_code]
           ,[order_status_code]
           ,[order_received_date]
           ,[estimate_complete_date]
           ,[approved_date]
           ,[approved_part_release_date]
           ,[order_complete_date]
           ,[shipto]
           ,[privileges_code]
           ,[model_number]
           ,[est_code]
           ,[call_type_code]
           ,[problem_code]
           ,[cause_code]
           ,[user_id]
           ,[last_update_date]

		   )
SELECT 
           [SalesDate]
           ,[work_order_num]
           ,[branch_code]
           ,[rma_code]
           ,[order_status_code]
           ,[order_received_date]
           ,[estimate_complete_date]
           ,[approved_date]
           ,[approved_part_release_date]
           ,[order_complete_date]
           ,[shipto]
           ,[privileges_code]
           ,[model_number]
           ,[est_code]
           ,[call_type_code]
           ,[problem_code]
           ,[cause_code]
           ,[user_id]
           ,[last_update_date]

FROM [DEV_BRSales].[nes].[order_open_prorepr]

GO

-- nes.order_open_prorepr_standards

INSERT INTO [nes].[inventory_valuation_whvalrpt]
           (
           [SalesDate]
           ,[item]
           ,[branch_code]
           ,[tag_number]
           ,[tag_date]
           ,[tag_cost_ind]
           ,[bin_code]
           ,[reservation_quantity_list]
           ,[tag_or_avg_cost]
           ,[available_extended_value]
           ,[reserved_extended_value]
           ,[total_extended_value]
           ,[available_qty]
           ,[allocation_qty]
           ,[reserved_qty]
           ,[total_qty]

		   )
SELECT 
           [SalesDate]
           ,[item]
           ,[branch_code]
           ,[tag_number]
           ,[tag_date]
           ,[tag_cost_ind]
           ,[bin_code]
           ,[reservation_quantity_list]
           ,[tag_or_avg_cost]
           ,[available_extended_value]
           ,[reserved_extended_value]
           ,[total_extended_value]
           ,[available_qty]
           ,[allocation_qty]
           ,[reserved_qty]
           ,[total_qty]

FROM [DEV_BRSales].[nes].[inventory_valuation_whvalrpt]
GO

