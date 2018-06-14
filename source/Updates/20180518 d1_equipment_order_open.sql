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

---

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
	[fix_message] [nvarchar](50) NOT NULL,
	[order_status_code] [char](2) NOT NULL,
 	[cause_key] [int] identity(1,1) NOT NULL,

 CONSTRAINT [nes_cause_code_c_pk] PRIMARY KEY CLUSTERED 
(
	[cause_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--	[user_id] [char](10) NOT NULL,
CREATE TABLE [nes].[user](
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


---

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
	FK_order_open_prorepr_user FOREIGN KEY
	(
	user_id
	) REFERENCES nes.[user]
	(
	user_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE nes.[user] ADD CONSTRAINT
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

ALTER TABLE nes.order_open_prorepr SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

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

INSERT INTO nes.[user]
                         (user_id, user_name, branch_code, type_code)
VALUES        ('', N'UNASSIGNED', '', '')
GO

--

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

-- pop from Tony D1 list
INSERT INTO [nes].[order]
([work_order_num], [note])
SELECT 
DISTINCT [work_order_num], ''
FROM [Integration].[open_order_prorepr] s
WHERE NOT EXISTS(
  SELECT * FROM [nes].[order] o where o.work_order_num = s.work_order_num
)

GO

INSERT INTO [nes].[user]
SELECT 
DISTINCT [d1_user_id], '', '', ''
FROM [Integration].[open_order_prorepr] s
WHERE NOT EXISTS(
  SELECT * FROM [nes].[user] u where u.user_id = s.d1_user_id
)
GO

-- add these codes TODO
SELECT distinct [cause_code] from Integration.open_order_prorepr s
where not exists (
select * from [nes].[cause] c where s.[cause_code] = c.[cause_code]
)

-- TRUNCATE TABLE nes.order_open_prorepr

INSERT INTO nes.order_open_prorepr
                         (work_order_num, branch_code, rma_code, order_status_code, order_received_date, estimate_complete_date, approved_date, order_complete_date, shipto, 
                         privileges_code, model_number, est_code, call_type_code, problem_code, cause_code, user_id, approved_part_release_date, SalesDate, [last_update_date])
SELECT
s.work_order_num, s.d1_branch, s.rma_code, s.order_status, 

s.order_received_date, 
s.estimate_complete_date, 
s.approved_date, 

s.order_complete_date, 

s.shipto, 
                         s.priv_code, s.model_number, s.est_num, s.call_type_code, s.problem_code, s.cause_code, s.d1_user_id, s.approved_part_release_date, 
                         BRS_Config.SalesDate,
COALESCE ( 
	s.order_complete_date, 
	s.approved_part_release_date,
	s.approved_date, 
	s.estimate_complete_date, 
	s.order_received_date
)

FROM            Integration.open_order_prorepr AS s CROSS JOIN
                         BRS_Config


/*
--todo 0 add to EST task, 11 Jun 18


fix est code in dev, add branch

branch split by EST Branch (see Tony list)

fix uers list 

Add Prive priorty

1. Priv wiht PMA
2. Priv only
3. rest


Add Aging bucket for table time (
5
10
15
30
60
90

)

build summary idea

oRG cause, total

***

resp (Cord, EST, Cust)
  Cause (with buckets)


****

*/