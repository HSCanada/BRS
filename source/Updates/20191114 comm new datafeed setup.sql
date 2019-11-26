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
	[source_cd] [char](3) NOT NULL,

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
	[cust_comm_group_cd] ASC,
	[source_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT ('') FOR [disp_comm_group_cd]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT ('') FOR [source_cd]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT ((0)) FOR [comm_rt]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT ((0)) FOR [active_ind]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  DEFAULT (getdate()) FOR [creation_dt]
GO

ALTER TABLE [comm].[plan_group_rate] ADD  CONSTRAINT [DF_comm_plan_group_rate_show_ind]  DEFAULT ((0)) FOR [show_ind]
GO


--

INSERT INTO   [comm].[plan_group_rate] (
comm_plan_id, [item_comm_group_cd], [cust_comm_group_cd], [source_cd], [note_txt]
)
VALUES (
'', '', '', '', 'unassigned'
)
GO

         
INSERT INTO   [comm].[plan_group_rate] (
comm_plan_id, [item_comm_group_cd], [cust_comm_group_cd], [source_cd]
)
select *  from
(SELECT  distinct [comm_plan_id] FROM [comm].[plan] ) s

cross join

( SELECT [comm_group_cd] as item_comm_group_cd FROM [comm].[group] where [source_cd] in ('JDE', 'IMP', 'PAY') ) s2


cross join

(SELECT  distinct [comm_status_cd] as cust_comm_group_cd FROM [dbo].[BRS_Customer]) s3

cross join

( SELECT [source_cd] FROM [comm].[source] where [source_cd] in ('JDE', 'IMP', 'PAY') ) s4

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

ALTER TABLE comm.plan_group_rate ADD CONSTRAINT
	FK_plan_group_rate_source FOREIGN KEY
	(
	source_cd
	) REFERENCES comm.[source]
	(
	source_cd
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

-- ID used to uniquely identify header for RI, tmc, 19 Nov 19
BEGIN TRANSACTION
GO
ALTER TABLE [Integration].F555115_commission_sales_extract_Staging ADD
	ID int Identity(1,1) NOT NULL
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add RI for calc audit logic, tmc, 25 Nov 19

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX plan_group_rate_u_idx_01 ON comm.plan_group_rate
	(
	calc_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.plan_group_rate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan_group_rate FOREIGN KEY
	(
	fsc_calc_key
	) REFERENCES comm.plan_group_rate
	(
	calc_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan_group_rate1 FOREIGN KEY
	(
	ess_calc_key
	) REFERENCES comm.plan_group_rate
	(
	calc_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan_group_rate2 FOREIGN KEY
	(
	cps_calc_key
	) REFERENCES comm.plan_group_rate
	(
	calc_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_plan_group_rate3 FOREIGN KEY
	(
	eps_calc_key
	) REFERENCES comm.plan_group_rate
	(
	calc_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

---

-- Territory fixes to allign reporting to commissions

-- qa patch
update [dbo].[BRS_CustomerFSC_History]
set HIST_TerritoryCd = 'MZ6MM'
where FiscalMonth = 201812 and Shipto = 3783864

-- allign FSC territory with Commission assignment from Jan 2018 to current.  Avoid dups, 20 Nov 19

-- run this
UPDATE       BRS_CustomerFSC_History
SET                HIST_TerritoryCd = s.fsc_min
FROM            BRS_CustomerFSC_History INNER JOIN
                             (SELECT        CAST(fiscal_yearmo_num AS int) AS FiscalMonth, hsi_shipto_id, MIN(salesperson_cd) AS fsc_min
                               FROM            CommBE.dbo.comm_transaction
                               WHERE        (source_cd = 'jde') AND (fiscal_yearmo_num BETWEEN '201801' AND '201912') AND (record_id NOT IN (54108565, 55191867, 55976312, 55976313, 
                                                         57216489, 57216490, 57216491, 57815920)) AND (1 = 1)
                               GROUP BY fiscal_yearmo_num, hsi_shipto_id) AS s ON BRS_CustomerFSC_History.FiscalMonth = s.FiscalMonth AND 
                         BRS_CustomerFSC_History.Shipto = s.hsi_shipto_id AND BRS_CustomerFSC_History.HIST_TerritoryCd <> s.fsc_min AND 
                         BRS_CustomerFSC_History.HIST_SalesDivision <> 'AZA' AND s.fsc_min <> '' AND 1 = 1
GO



-- based on this, BUT ensure no dups -- see below

SELECT        Shipto, h.HIST_SalesDivision, h.FiscalMonth, HIST_TerritoryCd, s.fsc_min
FROM            BRS_CustomerFSC_History h
INNER JOIN (
	SELECT        cast(fiscal_yearmo_num as int) as FiscalMonth, hsi_shipto_id, min(salesperson_cd) fsc_min
	FROM            CommBE.dbo.comm_transaction
	WHERE        (source_cd = 'jde') AND
			(fiscal_yearmo_num between '201801' AND '201912') AND
			(record_id not in (54108565, 55191867, 55976312, 55976313, 57216489, 57216490, 57216491, 57815920)) AND
			(1=1)
	GROUP BY fiscal_yearmo_num, hsi_shipto_id
	) s
	ON h.FiscalMonth = s.FiscalMonth AND
		h.Shipto = s.hsi_shipto_id AND
		h.HIST_TerritoryCd <> s.fsc_min AND
		h.HIST_SalesDivision <> 'AZA' AND
		s.fsc_min <> '' AND
		(1=1)
		
/*
-- dups to fix
fiscal_yearmo_num hsi_shipto_id fsc_min fsc_max cnt				exclude ID (see below)
----------------- ------------- ------- ------- -----------
201901            3765608       CZ1LR   CZ25T   195				54108565
201904            1681547       CZ1LE   CZ94O   50				55191867
201905            1666262       CZ25T   CZ2LB   40				55976312, 55976313
201908            1674212       CZ1EE   CZ25T   21				57216489, 57216490, 57216491
201910            1529773       WZ2AE   WZ324   160				57815920
*/

-- manual ID dups and add above

SELECT        fiscal_yearmo_num, hsi_shipto_id, salesperson_cd, record_id
FROM            CommBE.dbo.comm_transaction
WHERE        (source_cd = 'jde') AND
        (fiscal_yearmo_num = '201910') AND
		hsi_shipto_id = 1529773
order by 3

-- add cust ccomm to history, tmc, 21 Nov 19

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	HIST_cust_comm_group_cd char(6) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_cust_comm_group_cd DEFAULT ''
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_group FOREIGN KEY
	(
	HIST_cust_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

UPDATE
	BRS_CustomerFSC_History
SET
	HIST_cust_comm_group_cd = c.comm_status_cd
FROM
	BRS_CustomerFSC_History h
	INNER JOIN BRS_Customer c
	ON h.Shipto = c.ShipTo AND
	h.FiscalMonth between 201801 and 201912
go

-- load adj?

SELECT  [FiscalMonth]
      ,[source_cd]
	  ,count(*)

  FROM comm.[transaction_F555115]
  where FiscalMonth >=201801
  group by FiscalMonth, source_cd
  order by 1, 2


-- build adj

-- drop table comm.transfer_rule

BEGIN TRANSACTION
GO
CREATE TABLE comm.transfer_rule
	(
	FiscalMonth int NOT NULL,
	SalesOrderNumber int NOT NULL,
	DocType char(2) NOT NULL,
	fsc_code char(5) NOT NULL,
	ess_code char(5) NOT NULL,

	xfer_key int NOT NULL IDENTITY (1, 1),
	xfer_type char(1) NOT NULL,
	new_fsc_code char(5) NOT NULL,
	new_ess_code char(5) NOT NULL,
	xfer_date date NOT NULL,
	ShipTo int NOT NULL,
	xfer_branch_ind bit NOT NULL,
	comment nvarchar(50) NULL
	)  ON USERDATA
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	PK_transfer_rule PRIMARY KEY CLUSTERED 
	(
	FiscalMonth,
	SalesOrderNumber,
	DocType,
	fsc_code,
	ess_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE comm.transfer_rule SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_SalesOrderNumber DEFAULT 0 FOR SalesOrderNumber
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_DocType DEFAULT '' FOR DocType
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_fsc_code DEFAULT '' FOR fsc_code
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_ess_code DEFAULT '' FOR ess_code
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_xfer_type DEFAULT '' FOR xfer_type
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_new_fsc_code DEFAULT '' FOR new_fsc_code
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_new_ess_code DEFAULT '''' FOR new_ess_code
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_xfer_date DEFAULT getdate() FOR xfer_date
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_ShipTo DEFAULT 0 FOR ShipTo
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	DF_transfer_rule_xfer_branch_ind DEFAULT 0 FOR xfer_branch_ind
GO
ALTER TABLE comm.transfer_rule SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
--
BEGIN TRANSACTION
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	transfer_rule_u_idx_01 UNIQUE NONCLUSTERED 
	(
	xfer_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE comm.transfer_rule SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
-- rule RI
BEGIN TRANSACTION
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	FK_transfer_rule_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	FK_transfer_rule_BRS_TransactionDW_Ext FOREIGN KEY
	(
	SalesOrderNumber,
	DocType
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	SalesOrderNumber,
	DocType
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	FK_transfer_rule_BRS_FSC_Rollup FOREIGN KEY
	(
	fsc_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	FK_transfer_rule_BRS_FSC_Rollup1 FOREIGN KEY
	(
	ess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	FK_transfer_rule_BRS_FSC_Rollup2 FOREIGN KEY
	(
	new_fsc_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	FK_transfer_rule_BRS_FSC_Rollup3 FOREIGN KEY
	(
	new_ess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transfer_rule ADD CONSTRAINT
	FK_transfer_rule_BRS_Customer FOREIGN KEY
	(
	ShipTo
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transfer_rule SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- init

INSERT INTO [comm].[transfer_rule]
           ([FiscalMonth]
           ,[SalesOrderNumber]
           ,[DocType]
           ,[fsc_code]
           ,[ess_code]
           ,[xfer_type]
           ,[new_fsc_code]
           ,[new_ess_code]
           ,[xfer_date]
           ,[ShipTo]
           ,[xfer_branch_ind]
           ,[comment])
     VALUES
           (0
           ,0
           ,'AA'
           ,''
           ,''
           ,''
           ,''
           ,''
           ,'1980-01-01'
           ,0
           ,0
           ,'unassigned')
GO

--

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	xfer_key int NULL,
	xfer_fsc_code_org char(5) NULL,
	xfer_ess_code_org char(5) NULL
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_transfer_rule FOREIGN KEY
	(
	xfer_key
	) REFERENCES comm.transfer_rule
	(
	xfer_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup8 FOREIGN KEY
	(
	xfer_fsc_code_org
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_FSC_Rollup9 FOREIGN KEY
	(
	xfer_ess_code_org
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

-- add rules from access.
--<manual step>


insert into [comm].[transfer_rule] (
	[FiscalMonth]
	,[SalesOrderNumber]
	,[DocType]
	,[fsc_code]
	,[ess_code]
	,[xfer_type]
	,[new_fsc_code]
	,[new_ess_code]
	,[xfer_date]
	,[ShipTo]
	,[xfer_branch_ind]
	,[comment]
)

select s2.FiscalMonth, s1.* from 

(SELECT 
      [SalesOrderNumber]
      ,[DocType]
      ,[fsc_code]
      ,[ess_code]
      ,[xfer_type]
      ,[new_fsc_code]
      ,[new_ess_code]
      ,[xfer_date]
      ,[ShipTo]
      ,[xfer_branch_ind]
      ,[comment]
  FROM [comm].[transfer_rule]
  where [FiscalMonth] = 201910 AND [SalesOrderNumber] = 0 ) s1

  cross join

  (select [FiscalMonth] from [dbo].[BRS_FiscalMonth] where [FiscalMonth] between 201801 and 201912 and [FiscalMonth] <> 201910) s2

  -- ensure Oct 2018 calc has full coverage


-- set display - FSC
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup1_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'FSC%')

-- set display - FSC - SM
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup1_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'FSC%')


-- set display - ESS
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup2_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'ESS%')

-- set display - CSS
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup3_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'CCS%')

-- set display - ESP
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'EPS%') AND
	g.comm_group_cd like 'EPS%'

-- set display - CPS
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'CPS%') AND
	g.comm_group_cd like 'CPS%'


/****** Script for SelectTopNRows command from SSMS  ******/

SELECT  
	[FiscalMonth]
    ,[source_cd]
	,fsc_comm_group_cd
	,count(*) as total
     ,count([fsc_calc_key]) as fsc
      ,count([ess_calc_key]) as ess
      ,count([cps_calc_key]) as cps
      ,count([eps_calc_key]) as eps
FROM [comm].[transaction_F555115]
where FiscalMonth = 201801 and
[fsc_calc_key] IS NULL AND
(1=1)
group by FiscalMonth, source_cd, fsc_comm_group_cd
order by 1,2,3


-- detail
SELECT  
	* 
FROM [comm].[transaction_F555115]
where FiscalMonth = 201801 and
[fsc_calc_key] IS NULL AND
(1=1)
order by fsc_code



-- todo;  set SM map for ALL and Merch based on filters.  

print 'rule set - init values to unassigned'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = ''
FROM            comm.[group] 

-- SM pass first, suspect that Dig will not work

print 'rule set - FSC, SM'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup1_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'FSC%') AND (g.comm_group_sm_cd LIKE 'SPM%') AND (1 = 1)

-- ESS
print 'rule set - ESS, SM'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup1_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'ESS%') AND (g.comm_group_sm_cd LIKE 'SPM%') AND (1 = 1)

-- CCS
print 'rule set - CCS, SM'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup1_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'CCS%') AND (g.comm_group_sm_cd LIKE 'SPM%') AND (1 = 1)

-- CPS
print 'rule set - CPS, SM'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup1_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'CPS%') AND (g.comm_group_sm_cd LIKE 'SPM%') AND (1 = 1)

-- EPS
print 'rule set - EPS, SM'
UPDATE       comm.plan_group_rate
SET                disp_comm_group_cd = g.comm_group_rollup1_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate ON g.comm_group_cd = comm.plan_group_rate.item_comm_group_cd
WHERE        (comm.plan_group_rate.comm_plan_id LIKE 'EPS%') AND (g.comm_group_sm_cd LIKE 'SPM%') AND (1 = 1)


/*
SELECT        g.comm_group_cd, g.comm_group_rollup1_cd, r.comm_plan_id, g.comm_group_sm_cd, r.disp_comm_group_cd
FROM            comm.[group] AS g INNER JOIN
                         comm.plan_group_rate AS r ON g.comm_group_cd = r.item_comm_group_cd
WHERE        (r.comm_plan_id like 'FSC%') AND
g.comm_group_sm_cd like 'SPM%' AND
--g.comm_group_sm_cd not like 'SPMF%' AND
--g.comm_group_sm_cd like 'SPMF%' AND
(1=1)
order by 2, 4

*/
