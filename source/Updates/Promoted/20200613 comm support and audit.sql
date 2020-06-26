-- comm support and audit, tmc, 13 jun 20


CREATE TABLE [comm].[item_group_rule](
	[MinorProductClass] [char](9) NOT NULL,
	[Supplier] [char](6) NOT NULL,
	[comm_group_cd] [char](6) NOT NULL,
	[comm_note_txt] [varchar](10) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[confidence_rt] [float] NOT NULL,
 CONSTRAINT [PK_item_group_rule] PRIMARY KEY CLUSTERED 
(
	[MinorProductClass] ASC,
	[Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [comm].[item_group_rule] ADD  CONSTRAINT [DF_item_group_rule_MinorProductClass]  DEFAULT ('') FOR [MinorProductClass]
GO

ALTER TABLE [comm].[item_group_rule] ADD  CONSTRAINT [DF_item_group_rule_Supplier]  DEFAULT ('') FOR [Supplier]
GO

ALTER TABLE [comm].[item_group_rule] ADD  CONSTRAINT [DF_item_group_rule_comm_group_cd]  DEFAULT ('') FOR [comm_group_cd]
GO

ALTER TABLE [comm].[item_group_rule] ADD  CONSTRAINT [DF_item_group_rule_confidence_rt]  DEFAULT ((0)) FOR [confidence_rt]
GO

ALTER TABLE [comm].[item_group_rule]  WITH CHECK ADD  CONSTRAINT [FK_item_group_rule_BRS_ItemCategory] FOREIGN KEY([MinorProductClass])
REFERENCES [dbo].[BRS_ItemCategory] ([MinorProductClass])
GO

ALTER TABLE [comm].[item_group_rule] CHECK CONSTRAINT [FK_item_group_rule_BRS_ItemCategory]
GO

ALTER TABLE [comm].[item_group_rule]  WITH CHECK ADD  CONSTRAINT [FK_item_group_rule_BRS_ItemSupplier] FOREIGN KEY([Supplier])
REFERENCES [dbo].[BRS_ItemSupplier] ([Supplier])
GO

ALTER TABLE [comm].[item_group_rule] CHECK CONSTRAINT [FK_item_group_rule_BRS_ItemSupplier]
GO

ALTER TABLE [comm].[item_group_rule]  WITH CHECK ADD  CONSTRAINT [FK_item_group_rule_group] FOREIGN KEY([comm_group_cd])
REFERENCES [comm].[group] ([comm_group_cd])
GO

ALTER TABLE [comm].[item_group_rule] CHECK CONSTRAINT [FK_item_group_rule_group]
GO

--

INSERT INTO [comm].[item_group_rule]
           ([MinorProductClass]
           ,[Supplier]
           ,[comm_group_cd]
           ,[comm_note_txt]
           ,[confidence_rt])
     VALUES
           (''
           ,''
           ,''
           ,'unassigned'
           ,0)
GO

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_FiscalMonth ADD
	me_status_cd smallint NOT NULL CONSTRAINT DF_BRS_FiscalMonth_me_status_cd DEFAULT 0
GO
ALTER TABLE dbo.BRS_FiscalMonth SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add eps cps current codes
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	eps_code char(5) NOT NULL CONSTRAINT DF_BRS_Customer_eps_code DEFAULT '',
	cps_code char(5) NOT NULL CONSTRAINT DF_BRS_Customer_cps_code DEFAULT ''
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_FSC_Rollup6 FOREIGN KEY
	(
	eps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_FSC_Rollup7 FOREIGN KEY
	(
	cps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- link eps comm to hfm exclusives
BEGIN TRANSACTION
GO
ALTER TABLE hfm.exclusive_product ADD
	comm_group_eps_cd char(6) NOT NULL CONSTRAINT DF_exclusive_product_comm_group_eps_cd DEFAULT ''
GO
ALTER TABLE hfm.exclusive_product ADD CONSTRAINT
	FK_exclusive_product_group FOREIGN KEY
	(
	comm_group_eps_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.exclusive_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- populate eps map
UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSBAI'
 WHERE [Excl_Code] = 'BAINTE'
GO

UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSCAO'
 WHERE [Excl_Code] = 'CAO_LASER'
GO

UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSCHA'
 WHERE [Excl_Code] = 'CHANNELS'
GO

UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSDEN'
 WHERE [Excl_Code] = 'DENMAT'
GO

UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSEDG'
 WHERE [Excl_Code] = 'EDGE_ENDO'
GO

UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSMIL'
 WHERE [Excl_Code] = 'MILESTONE'
GO

UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSORT'
 WHERE [Excl_Code] = 'ORTHO_TECHNOLOGIES'
GO
UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSOST'
 WHERE [Excl_Code] = 'OSSTELL'
GO
UPDATE [hfm].[exclusive_product]
   SET [comm_group_eps_cd] = 'EPSREV'
 WHERE [Excl_Code] = 'REVEAL'
GO

-- email alert

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Config ADD
	notify_operator_id int NOT NULL CONSTRAINT DF_BRS_Config_operator_id DEFAULT 0
GO
ALTER TABLE dbo.BRS_Config SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

update dbo.BRS_Config
set notify_operator_id = 2

-- fix ** terr -> Medical
UPDATE [dbo].[BRS_FSC_Rollup]
set comm_salesperson_key_id = 'HouseNDZK'
WHERE TerritoryCd = '**'

-- stage tables

-- item

-- drop table [Integration].[Item]

CREATE TABLE [Integration].[comm_item_Staging](
	[Item] [char](10) NOT NULL,
	[fsc_comm_group_cd] [char](6) NOT NULL,
	[fsc_comm_note_txt] [varchar](50) NOT NULL,
CONSTRAINT [comm_item_c_pk] PRIMARY KEY CLUSTERED 
(
	[Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

-- customer
-- drop table [Integration].[comm_customer_Staging]

CREATE TABLE [Integration].[comm_customer_Staging](
	[ShipTo] [int] NOT NULL,
	[merch_comm_cd] [char](6) NOT NULL,
	[equip_comm_cd] [char](6) NOT NULL,
	[comm_note_txt] [varchar](50) NOT NULL
 CONSTRAINT [comm_customer_c_pk] PRIMARY KEY CLUSTERED 
(
	[ShipTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--
-- drop TABLE [comm].[special_market_map] 

CREATE TABLE [comm].[special_market_map] (
	[merch_comm_cd] [char](6) NOT NULL,
	[equip_comm_cd] [char](6) NOT NULL,
	[cust_comm_group_cd] [char](6) NOT NULL,
	[note_txt] [varchar](50) NOT NULL,
 CONSTRAINT [special_market_map_c_pk] PRIMARY KEY CLUSTERED 
(
	[merch_comm_cd] ASC,
	[equip_comm_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.special_market_map ADD CONSTRAINT
	FK_special_market_map_group FOREIGN KEY
	(
	cust_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.special_market_map SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


INSERT INTO [comm].[special_market_map]
           ([merch_comm_cd]
           ,[equip_comm_cd]
           ,[cust_comm_group_cd]
		   ,[note_txt]
           )
     VALUES
           ('','','', '')
           ,('Half','Half','SPMALL','')
           ,('Half','Full','SPMSND','')
           ,('None','None','SPMALL','')
           ,('Full','Half','','undefined')
           ,('Full','Full','','')
GO


--
-- rebate
CREATE TABLE [Integration].[comm_customer_rebate_Staging](
	[FiscalMonth] [char](6) NOT NULL,
	[ShipTo] [int] NOT NULL,
	[fsc_code] [char](5) NOT NULL,
	[rebate_amt] [money] NOT NULL,
	[comm_note_txt] [varchar](50) NOT NULL Default('')

 CONSTRAINT [comm_customer_rebate_c_pk] PRIMARY KEY CLUSTERED 
(
	[FiscalMonth] ASC,
	[ShipTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- salesperson

-- DROP TABLE [Integration].[salesperson_master_Staging]
-- drop TABLE [Integration].[comm_salesperson_master_Staging]

CREATE TABLE [Integration].[comm_salesperson_master_Staging](
	[FiscalMonth] [int] NOT NULL,
	[employee_num] [int] NOT NULL,
	[master_salesperson_cd] [char](6) NOT NULL,
	[salesperson_nm] [varchar](30) NOT NULL,
	[comm_plan_id] [char](10) NOT NULL,
	[territory_start_dt] [datetime] NOT NULL,
	[CostCenter] [nvarchar](30) NOT NULL,
	[salary_draw_amt] [money] NOT NULL,
	[deficit_amt] [money] NOT NULL,
	[comm_note_txt] [varchar](50) NULL,
	[email_ind] char(1) NOT NULL,
	[salesperson_key_id] [char](30) NULL,
 CONSTRAINT [comm_salesperson_master_stage_pk] PRIMARY KEY CLUSTERED 
(
	[employee_num] ASC,
	[master_salesperson_cd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE comm.salesperson_master ADD
	salary_draw_amt money NOT NULL CONSTRAINT DF_salesperson_master_salary_draw_amt DEFAULT 0,
	deficit_amt money NOT NULL CONSTRAINT DF_salesperson_master_deficit_amt DEFAULT 0,
	FiscalMonth int NOT NULL CONSTRAINT DF_salesperson_master_FiscalMonth DEFAULT 0
GO
ALTER TABLE comm.salesperson_master ADD CONSTRAINT
	FK_salesperson_master_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.salesperson_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
--
ALTER TABLE comm.salesperson_master
	DROP CONSTRAINT FK_salesperson_master_cost_center
GO



-- drop TABLE [Integration].[free_goods_redeem]
-- drop TABLE [Integration].[comm_freegoods_Staging]

CREATE TABLE [Integration].[comm_freegoods_Staging](
	[FiscalMonth] [int] NOT NULL,
	[SourceCode] [varchar](10) NOT NULL,
	[Supplier] [char](6) NOT NULL,
	[ShipTo] [int] NOT NULL,
	[PracticeName] [varchar](40) NULL,
	[SalesOrderNumber] [int] NOT NULL,
	[Item] [char](10) NOT NULL,
	[ItemDescription] [varchar](40) NULL,
	[Currency] [char](3) NOT NULL DEFAULT(''),
	[ExtFileCostAmt] [money] NOT NULL,
	[PromoNote] [varchar](100) NOT NULL DEFAULT(''),
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[stage_status] [varchar](50) NULL,
 CONSTRAINT [comm_freegoods_stage_pk] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


-- adjust
-- drop table [Integration].[F555115_commission_sales_adjustment_Staging]
-- drop TABLE [Integration].[comm_adjustment_Staging]

CREATE TABLE [Integration].[comm_adjustment_Staging](
	[FiscalMonth] [int] NOT NULL,
	[owner_cd] [char](6) NOT NULL,
	[line_number_org] [int] NOT NULL,

	[fsc_code] [char](5) NOT NULL Default(''),
	[eps_code] [char](5) NOT NULL Default(''),
	[shipto] [int] NOT NULL Default(0),
	[customer_name] [varchar](25) NULL Default(''),
	[ess_code] [char](5) NOT NULL Default(''),
	[cps_code] [char](5) NOT NULL Default(''),

	[salesorder_number] [int] NOT NULL Default(0),
	[item_number] [char](10) NOT NULL Default(''),
	[adjustment_type] [varchar](30) NOT NULL Default(''),

	[adj_cost_amt] [money] NOT NULL Default(0),
	[adj_sales_amt] [money] NOT NULL Default(0),

	[comm_note_txt] [varchar](30) NOT NULL Default(''),
	[internal_note_txt] [varchar](255) NOT NULL Default(''),

	[fsc_comm_group_cd] [char](6) NOT NULL Default(''),
	[fsc_comm_amt] [money] NOT NULL Default(0),

	[eps_comm_group_cd] [char](6) NOT NULL Default(''),
	[eps_comm_amt] [money] NOT NULL Default(0),

	[ess_comm_group_cd] [char](6) NOT NULL Default(''),
	[ess_comm_amt] [money] NOT NULL Default(0),

	[cps_comm_group_cd] [char](6) NOT NULL Default(''),
	[cps_comm_amt] [money] NOT NULL Default(0),

 CONSTRAINT [comm_adjustment_Staging_c_pk] PRIMARY KEY CLUSTERED 
(
	[FiscalMonth] ASC,
	[line_number_org] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO
--
INSERT INTO comm.transaction_F555115_audit
                         (FiscalMonth, SalesDivision, source_cd, AdjOwner, summarized_transaction_amt)
SELECT        BRS_FiscalMonth.FiscalMonth, div.SalesDivision, 'JDE' AS src, '380' AS ownr, - 1 AS val
FROM            BRS_FiscalMonth CROSS JOIN
                             (SELECT DISTINCT SalesDivision
                               FROM            comm.transaction_F555115_audit AS transaction_F555115_audit_1) AS div
WHERE        (BRS_FiscalMonth.FiscalMonth > 202005)
GO

--

-- DROP INDEX comm_salesperson_master_Staging_u_idx_01 ON Integration.comm_salesperson_master_Staging

CREATE UNIQUE NONCLUSTERED INDEX comm_salesperson_master_Staging_u_idx_01
ON Integration.comm_salesperson_master_Staging([salesperson_key_id])
WHERE [salesperson_key_id] IS NOT NULL;


ALTER TABLE comm.hr_employee
	DROP CONSTRAINT FK_hr_employee_cost_center
GO
