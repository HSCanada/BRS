-- comm new datafeed setup, tmc, 14 Nov 19

-- delete  FROM [comm].[transaction_F555115] where FiscalMonth = 0

-- item history - add missing codes
insert into [dbo].[BRS_ItemHistory]
(FiscalMonth, Item, Supplier) 

SELECT
FiscalMonth, WSLITM_item_number, WS$SPC_supplier_code
FROM
comm.transaction_F555115 AS t

INNER JOIN
	(SELECT
		max(ID) as max_id
	FROM            comm.transaction_F555115 AS t

	where not exists (
		select * from [dbo].[BRS_ItemHistory] h
		where h.FiscalMonth = t.FiscalMonth AND
			h.Item = t.WSLITM_item_number
	)
	group by FiscalMonth, WSLITM_item_number
	) as  sel
	ON t.id = sel.max_id

-- item add RI

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_ItemHistory FOREIGN KEY
	(
	FiscalMonth,
	WSLITM_item_number
	) REFERENCES dbo.BRS_ItemHistory
	(
	FiscalMonth,
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- customer history - check

SELECT
FiscalMonth, WSSHAN_shipto, fsc_code, WSAC10_division_code
FROM
comm.transaction_F555115 AS t

INNER JOIN
	(SELECT
		max(ID) as max_id
	FROM            comm.transaction_F555115 AS t

	where not exists (
		select * from [dbo].[BRS_CustomerFSC_History] h
		where h.FiscalMonth = t.FiscalMonth AND
			h.Shipto = t.WSSHAN_shipto
	)
	group by FiscalMonth, WSSHAN_shipto
	) as  sel
	ON t.id = sel.max_id


--

-- customer add RI

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_CustomerFSC_History FOREIGN KEY
	(
	FiscalMonth,
	WSSHAN_shipto
	) REFERENCES dbo.BRS_CustomerFSC_History
	(
	FiscalMonth,
	Shipto
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- setup spmk customer

INSERT INTO [comm].[group]
           ([comm_group_cd]
           ,[comm_group_desc]
           ,[source_cd]
           ,[active_ind]
		   )
     VALUES
           ('SPMALL'
           ,'Special Market Customer'
           ,'JDE'
           ,1
           )
GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_group FOREIGN KEY
	(
	comm_status_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

---

-- drop table [comm].[plan_group_rate]

CREATE TABLE [comm].[plan_group_rate](
	[comm_plan_id] [char](10) NOT NULL,
	[item_comm_group_cd] [char](6) NOT NULL,
	[cust_comm_group_cd] [char](6) NOT NULL,

	[disp_comm_group_cd] [char](6) NOT NULL,
	[comm_rt] [float] NOT NULL,
	[active_ind] [bit] NOT NULL,
	[creation_dt] [date] NOT NULL,
	[note_txt] [varchar](50) NULL,
	[show_ind] [bit] NOT NULL,
	[calc_key] [int] identity(1,1) NOT NULL
 CONSTRAINT [commission_plan_c_pk] PRIMARY KEY CLUSTERED 
(
	[comm_plan_id] ASC,
	[item_comm_group_cd] ASC,
	[cust_comm_group_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT ('') FOR [disp_comm_group_cd]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT ((0)) FOR [comm_rt]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT ((0)) FOR [active_ind]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  CONSTRAINT [DF_comm_plan_group_rate_show_ind]  DEFAULT ((0)) FOR [show_ind]
GO


---

INSERT INTO   [comm].[plan_group_rate] (
comm_plan_id, [item_comm_group_cd], [cust_comm_group_cd], [note_txt]
)
VALUES (
'', '', '', 'unassigned'
)
GO

         
INSERT INTO   [comm].[plan_group_rate] (
comm_plan_id, [item_comm_group_cd], [cust_comm_group_cd] 
)
select *  from
(SELECT  distinct [comm_plan_id] FROM [comm].[plan] where comm_plan_id <> '') s

cross join

(SELECT [comm_group_cd] as item_comm_group_cd FROM [comm].[group] where [source_cd] in ('JDE', 'IMP')) s2

cross join

(SELECT  distinct [comm_status_cd] as cust_comm_group_cd FROM [dbo].[BRS_Customer]) s3

GO

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD CONSTRAINT
	FK_plan_group_rate_plan FOREIGN KEY
	(
	comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.plan_group_rate ADD CONSTRAINT
	FK_plan_group_rate_group FOREIGN KEY
	(
	item_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.plan_group_rate ADD CONSTRAINT
	FK_plan_group_rate_group1 FOREIGN KEY
	(
	cust_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.plan_group_rate ADD CONSTRAINT
	FK_plan_group_rate_group2 FOREIGN KEY
	(
	disp_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	eps_comm_rt float(53) NULL,
	eps_comm_amt money NULL,
	fsc_calc_key int NULL,
	ess_calc_key int NULL,
	cps_calc_key int NULL,
	eps_calc_key int NULL
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
