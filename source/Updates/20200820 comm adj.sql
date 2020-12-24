--finalize adjustment 
-- Add TS and EST, tmc, 16 Dec 20

-- test

-- DELETE FROM [DEV_BRSales].[comm].[transaction_F555115] where fiscalMonth = 202011
-- DELETE FROM [DEV_BRSales].[dbo].[BRS_ItemHistory] where [FiscalMonth]= 202011
-- drop rel pre and add post
-- DELETE FROM [DEV_BRSales].[dbo].[BRS_CustomerFSC_History] where [FiscalMonth]= 202011 and shipto = 1520908

--drop TABLE [Integration].[comm_adjustment_Staging]
CREATE TABLE [Integration].[comm_adjustment_Staging](

	-- ORG Sales order (may have bad data)
	[WSDOC__document_number] [int] NOT NULL

	-- ORG Line No (may get extented)
	,[WSOGNO_original_line_number] [int] NOT NULL

	-- Fiscal mo
	,[FiscalMonth] [int] NOT NULL

	-- transaction_dt
	,[WSDGL__gl_date] [datetime] NOT NULL

	-- Owner
	,[WSVR01_reference] [varchar](25) NOT NULL

	-- Adj Type Actual	
	,[WSSRP6_manufacturer] [char](6) NOT NULL

	-- transaction_amt
	,[transaction_amt] [money] NOT NULL

	-- add costs from Pre- process. 
	,[WS$UNC_sales_order_cost_markup] [money] NOT NULL


	-- Additional Notes	
	,[WSDSC1_description] [varchar](30) NOT NULL

	-- customer_nm
	,[WSVR02_reference_2] [varchar](25) NOT NULL

	-- following may be defaulted

	,[source_cd] [char](3) NOT NULL Default ('IMP')

	--item_id
	,[WSLITM_item_number] [char](10) NOT NULL Default ('')

	-- Shipto
	,[WSSHAN_shipto] [int] NOT NULL Default (0)

	-- FSC
	,[fsc_code] [char](5) NOT NULL Default ('')
	,[fsc_comm_group_cd] [char](6) NOT NULL Default ('')
	,[fsc_comm_amt] [money] NOT NULL Default (0)

	-- ESS / CSS
	,[ess_code] [char](5) NOT NULL Default ('')
	,[ess_comm_group_cd] [char](6) NOT NULL Default ('')
	,[ess_comm_amt] [money] NOT NULL Default (0)

	-- CPS / PMTS
	,[cps_code] [char](5) NOT NULL Default ('')
	,[cps_comm_group_cd] [char](6) NOT NULL Default ('')
	,[cps_comm_amt] [money] NOT NULL Default (0)

	-- EPS
	,[eps_code] [char](5) NOT NULL Default ('')
	,[eps_comm_group_cd] [char](6) NOT NULL Default ('')
	,[eps_comm_amt] [money] NOT NULL Default (0)

	-- ISR
	,[isr_code] [char](5) NOT NULL Default ('')
	,[isr_comm_group_cd] [char](6) NOT NULL Default ('')
	,[isr_comm_amt] [money] NOT NULL Default (0)

	-- EST
	,[est_code] [char](5) NOT NULL Default ('')
	,[est_comm_group_cd] [char](6) NOT NULL Default ('')
	,[est_comm_amt] [money] NOT NULL Default (0)


	-- internal flags
	,ID [integer] NOT NULL Identity(1,1)
	,[comm_note_txt] [varchar](50) NOT NULL DEFAULT ('')
	,[ma_estimate_factor] [float] NOT NULL DEFAULT(1)

	-- default to AA
	,[WSDCTO_order_type] [char](2) NOT NULL Default('AA')

	-- Sales order (clean)
	,[WSDOCO_salesorder_number] [int] NULL

	-- based on ORG, but may be extended due to ESS split
	,[WSLNID_line_number] [int] NULL

	,[gp_ext_amt] [money] NULL

	-- add MA for GP
	,[WSURAT_user_reserved_amount] [money] NULL

	,[ID_legacy] [int] NULL
	,[cust_comm_group_cd] [char](6) NULL
	,[item_comm_group_cd] [char](6) NULL

	,[fsc_salesperson_key_id] [varchar](30) NULL
	,[ess_salesperson_key_id] [varchar](30) NULL
	,[cps_salesperson_key_id] [varchar](30) NULL
	,[eps_salesperson_key_id] [varchar](30) NULL
	,[isr_salesperson_key_id] [varchar](30) NULL
	,[est_salesperson_key_id] [varchar](30) NULL

 CONSTRAINT [comm_adjustment_Staging_c_pk] PRIMARY KEY CLUSTERED 
(
	[FiscalMonth] ASC,
	[WSDOC__document_number] ASC,
	[WSDCTO_order_type] ASC,
	[WSOGNO_original_line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO
--
BEGIN TRANSACTION
GO
ALTER TABLE Integration.comm_adjustment_Staging ADD
	status_code smallint NOT NULL CONSTRAINT DF_comm_adjustment_Staging_status_code DEFAULT -1
GO
ALTER TABLE Integration.comm_adjustment_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

-- drop TABLE [Integration].[comm_customer_rebate_Staging]
CREATE TABLE [Integration].[comm_customer_rebate_Staging](
	[FiscalMonth] [int] NOT NULL,
	[ShipTo] [int] NOT NULL,
	[original_line_number] [int] NOT NULL,
	[SourceCode] [char](3) NOT NULL DEFAULT ('EST'),

	[PracticeName] [varchar](40) NOT NULL DEFAULT (''),
	[rebate_amt] [money] NOT NULL,

	ID [integer] NOT NULL Identity(1,1),
	[comm_note_txt] [varchar](50) NOT NULL DEFAULT (''),

	[fsc_salesperson_key_id] [varchar](30) NULL,
	[fsc_comm_group_cd] [char](6) NOT NULL Default(''),
	[fsc_code] [char](5) NOT NULL Default(''),

	[isr_salesperson_key_id] [varchar](30) NULL,
	[isr_comm_group_cd] [char](6) NOT NULL Default(''),
	[isr_code] [char](5) NOT NULL Default(''),

	[status_code] [smallint] NOT NULL Default(-1)
 
 CONSTRAINT [comm_customer_rebate_c_pk] PRIMARY KEY CLUSTERED 
(
	[ShipTo] ASC,
	[FiscalMonth] ASC,
	[original_line_number] ASC,
	[SourceCode] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO
--
BEGIN TRANSACTION
GO
ALTER TABLE Integration.comm_customer_rebate_Staging ADD
	teeth_share_rt [real] NOT NULL CONSTRAINT [DF_comm_customer_rebate_Staging_teeth_share_rt
teeth_share_rt] DEFAULT (0)
GO
COMMIT


--drop TABLE [comm].[customer_rebate]
CREATE TABLE [comm].[customer_rebate](
	[FiscalMonth] [int] NOT NULL,
	[ShipTo] [int] NOT NULL,
	[original_line_number] [int] NOT NULL,
	[SourceCode] [char](3) NOT NULL,

	[PracticeName] [varchar](40) NOT NULL DEFAULT(''),
	[rebate_amt] [money] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[comm_note_txt] [varchar](50) NOT NULL DEFAULT(''),
	[fsc_salesperson_key_id] [varchar](30) DEFAULT(''),
	[fsc_comm_group_cd] [char](6) NOT NULL DEFAULT(''),
	[fsc_code] [char](5) NOT NULL DEFAULT(''),
	[isr_salesperson_key_id] [varchar](30) NOT NULL DEFAULT(''),
	[isr_comm_group_cd] [char](6) DEFAULT(''),
	[isr_code] [char](5) DEFAULT(''),
	[status_code] [smallint] NOT NULL DEFAULT(-1),
 CONSTRAINT [comm_customer_rebate_prod_c_pk] PRIMARY KEY CLUSTERED 
(
	[ShipTo] ASC,
	[FiscalMonth] ASC,
	[original_line_number] ASC,
	[SourceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX comm_customer_rebate_u_idx_01 ON comm.customer_rebate
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.customer_rebate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.customer_rebate ADD
	teeth_share_rt real NOT NULL CONSTRAINT DF_customer_rebate_teeth_share_rt DEFAULT (0.0)
GO
ALTER TABLE comm.customer_rebate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
-- drop TABLE [Integration].[comm_freegoods_Staging]
CREATE TABLE [Integration].[comm_freegoods_Staging](
	[FiscalMonth] [int] NOT NULL,
	[SalesOrderNumber] [int] NOT NULL,
	[original_line_number] [int] NOT NULL,
	[SourceCode] [char](3) NOT NULL,

	[ShipTo] [int] NOT NULL,
	[PracticeName] [varchar](40) NULL,
	[Item] [char](10) NOT NULL,
	[ItemDescription] [varchar](40) NULL,
	[Supplier] [char](6) NOT NULL,
	[ExtFileCostCadAmt] [money] NOT NULL,

	ID [integer] NOT NULL Identity(1,1),
	[comm_note_txt] [varchar](50) NOT NULL DEFAULT (''),
	[ma_estimate_factor] [float] NOT NULL DEFAULT(1),

	[DocType] [char](2) NOT NULL Default('AA'),
	[cust_comm_group_cd] [char](6) NULL,
	[item_comm_group_cd] [char](6) NULL,

	[fsc_salesperson_key_id] [varchar](30) NULL,
	[ess_salesperson_key_id] [varchar](30) NULL,
	[eps_salesperson_key_id] [varchar](30) NULL,
	[isr_salesperson_key_id] [varchar](30) NULL,

	[fsc_comm_group_cd] [char](6) NOT NULL Default(''),
	[ess_comm_group_cd] [char](6) NOT NULL Default(''),
	[eps_comm_group_cd] [char](6) NOT NULL Default(''),
	[isr_comm_group_cd] [char](6) NOT NULL Default(''),

	[status_code] [smallint] NOT NULL Default(-1)

 CONSTRAINT [comm_freegoods_stage_pk] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC,
	[DocType] ASC,
	[original_line_number] ASC,
	[FiscalMonth] ASC,
	[SourceCode] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX comm_freegoods_Staging_u_idx_01 ON Integration.comm_freegoods_Staging
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Integration.comm_freegoods_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
-- drop TABLE [comm].[freegoods]
CREATE TABLE [comm].[freegoods](
	[FiscalMonth] [int] NOT NULL,
	[SalesOrderNumber] [int] NOT NULL,
	[original_line_number] [int] NOT NULL,
	[SourceCode] [char](3) NOT NULL,

	[ShipTo] [int] NOT NULL,
	[PracticeName] [varchar](40) NOT NULL DEFAULT(''),
	[Item] [char](10) NOT NULL,
	[ItemDescription] [varchar](40) NOT NULL DEFAULT(''),
	[Supplier] [char](6) NOT NULL DEFAULT(''),
	[ExtFileCostCadAmt] [money] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[comm_note_txt] [varchar](50) NOT NULL DEFAULT(''),
	[ma_estimate_factor] [float] NOT NULL DEFAULT(1),
	[DocType] [char](2) NOT NULL DEFAULT('AA'),
	[cust_comm_group_cd] [char](6) NOT NULL DEFAULT(''),
	[item_comm_group_cd] [char](6) NOT NULL DEFAULT(''),
	[fsc_salesperson_key_id] [varchar](30) NOT NULL DEFAULT(''),
	[ess_salesperson_key_id] [varchar](30) NOT NULL DEFAULT(''),
	[eps_salesperson_key_id] [varchar](30) NOT NULL DEFAULT(''),
	[isr_salesperson_key_id] [varchar](30) NOT NULL DEFAULT(''),
	[fsc_comm_group_cd] [char](6) NOT NULL DEFAULT(''),
	[ess_comm_group_cd] [char](6) NOT NULL DEFAULT(''),
	[eps_comm_group_cd] [char](6) NOT NULL DEFAULT(''),
	[isr_comm_group_cd] [char](6) NOT NULL DEFAULT(''),
	[status_code] [smallint] NOT NULL DEFAULT(-1),
 CONSTRAINT [comm_freegoods_stage_pk] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC,
	[DocType] ASC,
	[original_line_number] ASC,
	[FiscalMonth] ASC,
	[SourceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX comm_freegoods_u_idx_01 ON comm.freegoods
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
-- MA default support

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemSalesCategory ADD
	ma_estimate_factor float(53) NOT NULL CONSTRAINT DF_BRS_ItemSalesCategory_ma_estimate_factor DEFAULT 1.0
GO
ALTER TABLE dbo.BRS_ItemSalesCategory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- rebate teeth share percent support
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	total_month_sales_amt float(53) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_total_sales_amt DEFAULT 0,
	merch_month_sales_amt float(53) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_merch_sales_amt DEFAULT 0,
	teeth_month_sales_amt float(53) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_teeth_sales_amt DEFAULT 0
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- XXX pop hisory -> snapshot

UPDATE dbo.BRS_CustomerFSC_History
SET
	total_month_sales_amt = src.total_sales,
	merch_month_sales_amt = src.merch_sales,
	teeth_month_sales_amt = src.teeth_sales
FROM
(
	SELECT
	s.FiscalMonth, s.Shipto, 
	SUM(s.NetSalesAmt) AS total_sales, 
	SUM(CASE WHEN i.SalesCategory = 'MERCH' THEN s.NetSalesAmt ELSE 0 END) AS merch_sales, 
	SUM(CASE WHEN i.SalesCategory = 'TEETH' THEN s.NetSalesAmt ELSE 0 END) AS teeth_sales
	FROM            BRS_Transaction AS s INNER JOIN
							 BRS_Item AS i ON s.Item = i.Item
	WHERE        (s.SalesDivision IN ('AAD', 'AAL', 'AAM', 'AAV')) AND (s.DocType <> 'AA') AND (1 = 1)
	GROUP BY s.FiscalMonth, s.Shipto
	HAVING        (s.FiscalMonth between 201501 and 202012) 
) src
WHERE
	dbo.BRS_CustomerFSC_History.[Shipto] = src.Shipto AND
	dbo.BRS_CustomerFSC_History.[FiscalMonth] = src.FiscalMonth

SELECT
-- distinct i.SalesCategory
 TOP (1000)
 s.FiscalMonth, s.Shipto, s.SalesDivision, i.SalesCategory
 , s.NetSalesAmt as total_sales
 ,CASE WHEN i.SalesCategory = 'MERCH' THEN s.NetSalesAmt  ELSE 0 END as merch_sales
 ,CASE WHEN i.SalesCategory = 'TEETH' THEN s.NetSalesAmt  ELSE 0 END as teeth_sales
FROM            BRS_Transaction AS s INNER JOIN
                         BRS_Item AS i ON s.Item = i.Item
WHERE        (s.FiscalMonth = 202011) AND (s.SalesDivision IN ('AAD', 'AAL', 'AAM', 'AAV')) AND (s.DocType <> 'AA') AND 
 i.SalesCategory = 'TEETH' AND
(1 = 1)
  --



UPDATE [dbo].[BRS_ItemSalesCategory]
   SET [ma_estimate_factor] = 1.085
 WHERE [SalesCategory] in('MERCH', 'VALADD', 'PARTS', 'TEETH', 'SMEQU', 'CAMLOG')
GO

UPDATE [dbo].[BRS_ItemSalesCategory]
   SET [ma_estimate_factor] = 1.03
 WHERE [SalesCategory] in('EQUIPM', 'HITECH', 'DENTRX', 'ITS', 'CEHP', 'OTHER')

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.[group] ADD
	SalesCategory varchar(6) NOT NULL CONSTRAINT DF_group_SalesCategory DEFAULT ''
GO
ALTER TABLE comm.[group] ADD CONSTRAINT
	FK_group_BRS_ItemSalesCategory FOREIGN KEY
	(
	SalesCategory
	) REFERENCES dbo.BRS_ItemSalesCategory
	(
	SalesCategory
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.[group] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- map comm group to sales category for default market Adjustment access

UPDATE [comm].[group]
   SET [SalesCategory] = 'CAMLOG'
 WHERE [comm_group_cd] in('ITMCAM')
GO

UPDATE [comm].[group]
   SET [SalesCategory] = 'DENTRX'
 WHERE [comm_group_cd] in('ITMSOF')
GO

UPDATE [comm].[group]
   SET [SalesCategory] = 'EQUIPM'
 WHERE [comm_group_cd] in('ITMFO1', 'ITMFO2', 'ITMFO3', 'ITMFRT', 'ITMISC', 'FRESEQ', 'SPMFGE', 'SPMFO1', 'SPMFO2', 'SPMFO3')
GO

UPDATE [comm].[group]
   SET [SalesCategory] = 'HITECH'
 WHERE [comm_group_cd] in('DIGCCS', 'DIGCIM', 'DIGIMP', 'DIGLAB', 'ITMCPU', 'ITS', 'DIGCCC', 'DIGOTH')
GO

UPDATE [comm].[group]
   SET [SalesCategory] = 'MERCH'
 WHERE [comm_group_cd] in('DIGMAT', 'ITMEPS', 'ITMSND', 'SPMSND', 'FRESND', 'SPMFGS', 'SPMREB', 'REBSND')
GO

UPDATE [comm].[group]
   SET [SalesCategory] = 'PARTS'
 WHERE [comm_group_cd] in('ITMPAR')
GO

UPDATE [comm].[group]
   SET [SalesCategory] = 'SERVIC'
 WHERE [comm_group_cd] in('ITMSER')
GO


UPDATE [comm].[group]
   SET [SalesCategory] = 'TEETH'
 WHERE [comm_group_cd] in('ITMTEE', 'REBTEE')
GO

--
-- remove unused fields
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup2
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup3
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup4
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup5
GO
ALTER TABLE dbo.BRS_FSC_Rollup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT DF_BRS_TransactionDW_Ext_ESS_code
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT DF_BRS_TransactionDW_Ext_CCS_code
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT DF_BRS_TransactionDW_Ext_CPS_code
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT DF_BRS_TransactionDW_Ext_TSS_code
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT DF_BRS_TransactionDW_Ext_FSC_code
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP COLUMN ESS_code, CCS_code, CPS_code, TSS_code, FSC_code
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_TransactionDW_Ext] ADD
	HIST_ess_salesperson_key_id varchar(30) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_HIST_ess_salesperson_key_id DEFAULT (''),
	HIST_ess_comm_plan_id char(10) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_HIST_ess_comm_plan_id DEFAULT (''),
	HIST_ess_code char(5) NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_HIST_ess_code DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_salesperson_master FOREIGN KEY
	(
	HIST_ess_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_plan FOREIGN KEY
	(
	HIST_ess_comm_plan_id
	) REFERENCES comm.[plan]
	(
	comm_plan_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_FSC_Rollup FOREIGN KEY
	(
	HIST_ess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_TransactionDW_Ext FOREIGN KEY
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
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_CustomerFSC_History FOREIGN KEY
	(
	FiscalMonth,
	ShipTo
	) REFERENCES dbo.BRS_CustomerFSC_History
	(
	FiscalMonth,
	Shipto
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_ItemHistory FOREIGN KEY
	(
	FiscalMonth,
	Item
	) REFERENCES dbo.BRS_ItemHistory
	(
	FiscalMonth,
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group FOREIGN KEY
	(
	cust_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group1 FOREIGN KEY
	(
	item_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group2 FOREIGN KEY
	(
	fsc_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group3 FOREIGN KEY
	(
	ess_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group4 FOREIGN KEY
	(
	eps_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group5 FOREIGN KEY
	(
	isr_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_salesperson_master FOREIGN KEY
	(
	fsc_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_salesperson_master1 FOREIGN KEY
	(
	ess_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_salesperson_master2 FOREIGN KEY
	(
	eps_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_salesperson_master3 FOREIGN KEY
	(
	isr_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.customer_rebate ADD CONSTRAINT
	FK_customer_rebate_BRS_FiscalMonth FOREIGN KEY
	(
	FiscalMonth
	) REFERENCES dbo.BRS_FiscalMonth
	(
	FiscalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.customer_rebate ADD CONSTRAINT
	FK_customer_rebate_BRS_CustomerFSC_History FOREIGN KEY
	(
	FiscalMonth,
	ShipTo
	) REFERENCES dbo.BRS_CustomerFSC_History
	(
	FiscalMonth,
	Shipto
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.customer_rebate ADD CONSTRAINT
	FK_customer_rebate_salesperson_master FOREIGN KEY
	(
	fsc_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.customer_rebate ADD CONSTRAINT
	FK_customer_rebate_salesperson_master1 FOREIGN KEY
	(
	isr_salesperson_key_id
	) REFERENCES comm.salesperson_master
	(
	salesperson_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.customer_rebate ADD CONSTRAINT
	FK_customer_rebate_BRS_FSC_Rollup FOREIGN KEY
	(
	fsc_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.customer_rebate ADD CONSTRAINT
	FK_customer_rebate_BRS_FSC_Rollup1 FOREIGN KEY
	(
	isr_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.customer_rebate ADD CONSTRAINT
	FK_customer_rebate_group FOREIGN KEY
	(
	fsc_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.customer_rebate ADD CONSTRAINT
	FK_customer_rebate_group1 FOREIGN KEY
	(
	isr_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.customer_rebate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--


/*
-- ESS history populate, moved to calc
UPDATE [dbo].[BRS_TransactionDW_Ext]
SET 
      [HIST_ess_salesperson_key_id] = s.ess_key
      ,[HIST_ess_comm_plan_id] = s.ess_plan
      ,[HIST_ess_code] = s.ess_code
FROM
	(SELECT
--	 TOP (10) 
	WSDOCO_salesorder_number, WSDCTO_order_type, MIN(ess_code) ess_code, MIN(ess_salesperson_key_id) ess_key,  MIN(ess_comm_plan_id) ess_plan
	FROM            comm.transaction_F555115
	WHERE        
	(WSDCTO_order_type <> 'AA') AND (ess_code <> '')
	GROUP BY WSDOCO_salesorder_number, WSDCTO_order_type
	) s
	
WHERE 
	s.WSDOCO_salesorder_number = [BRS_TransactionDW_Ext].SalesOrderNumber AND
	s.ess_code <> [BRS_TransactionDW_Ext].[HIST_ess_code]
GO


SELECT
-- TOP (10) 
WSDOCO_salesorder_number, WSDCTO_order_type, MIN(ess_code), MIN(ess_salesperson_key_id), MIN(ess_comm_plan_id)
FROM            comm.transaction_F555115
WHERE        
(WSDCTO_order_type <> 'AA') AND (ess_code <> '')
GROUP BY WSDOCO_salesorder_number, WSDCTO_order_type
*/

insert into [dbo].[BRS_CustomerFSC_History]
(
[FiscalMonth],
[Shipto]

)
SELECT distinct [FiscalMonth]
      ,[ShipTo]
  FROM [comm].[free_goods_redeem]
  
  where not exists( select * from [dbo].[BRS_CustomerFSC_History] s where [comm].[free_goods_redeem].FiscalMonth = s.FiscalMonth and [comm].[free_goods_redeem].Shipto = s.Shipto)
  order by 1
GO

insert into [dbo].[BRS_ItemHistory]
(
[FiscalMonth],
[Item],
[Supplier]

)
SELECT distinct [FiscalMonth]
      ,[Item]
	  ,''
  FROM [comm].[free_goods_redeem]
  
  where not exists( select * from [dbo].[BRS_ItemHistory] s where [comm].[free_goods_redeem].FiscalMonth = s.FiscalMonth and [comm].[free_goods_redeem].Item = s.item)
  order by 1
GO

-- truncate table [comm].[freegoods]
INSERT INTO [comm].[freegoods]
(
[FiscalMonth]
,[Item]
,[SalesOrderNumber]
,[ShipTo]
,[Supplier]
,[ExtFileCostCadAmt]
,[original_line_number]
,[DocType]
,[SourceCode]
)
SELECT        FiscalMonth, Item, SalesOrderNumber, ShipTo, Supplier, ExtFileCostCadAmt, ID, 'AA' AS DocType, 'ACT' as src
FROM            comm.free_goods_redeem
GO

drop table [comm].[free_goods_redeem]

update 
[dbo].[comm_customer_rebate_YTD]
set  [fiscalmonth] = [fiscal_yearmo_num]

update 
[dbo].[comm_customer_rebate_YTD]
set  [hsi_shipto_id] = [cust_account]

update 
[dbo].[comm_customer_rebate_YTD]
set  [hsi_shipto_id] = 1658123
where [hsi_shipto_id] = 1658122

update 
[dbo].[comm_customer_rebate_YTD]
set  [hsi_shipto_id] = 1678207
where [hsi_shipto_id] = 1678206


insert into [dbo].[BRS_CustomerFSC_History]
(
[FiscalMonth],
[Shipto]

)
SELECT distinct [fiscalmonth]
      ,[hsi_shipto_id]
  FROM [dbo].[comm_customer_rebate_YTD]
  
  where 
  [fiscalmonth] >= 201301 AND
  not exists( select * from [dbo].[BRS_CustomerFSC_History] s where [dbo].[comm_customer_rebate_YTD].[fiscalmonth] = s.FiscalMonth and [dbo].[comm_customer_rebate_YTD].[hsi_shipto_id] = s.Shipto)
  order by 1
GO

-- update 2019 customer history - test

-- est
UPDATE [dbo].[BRS_CustomerFSC_History]
set 
	[HIST_est_code] = src.est_code,
	[HIST_est_salesperson_key_id] = src.comm_salesperson_key_id,
	[HIST_est_comm_plan_id] = src.comm_plan_id
FROM
(
SELECT
--	TOP (100)
	BRS_Customer.ShipTo, BRS_Customer.est_code, BRS_FSC_Rollup.comm_salesperson_key_id, comm.salesperson_master.comm_plan_id
FROM            BRS_Customer INNER JOIN
                         BRS_FSC_Rollup ON BRS_Customer.est_code = BRS_FSC_Rollup.TerritoryCd INNER JOIN
                         comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
WHERE
	(BRS_Customer.ShipTo > 0) AND (BRS_Customer.est_code <> 'NA') AND (BRS_Customer.est_code <> '')  AND (1 = 1)
) src
WHERE
	([dbo].[BRS_CustomerFSC_History].FiscalMonth between 201901 AND 202011) AND
	([dbo].[BRS_CustomerFSC_History].Shipto = src.ShipTo) AND
	(1=1)

-- isr
UPDATE [dbo].[BRS_CustomerFSC_History]
set 
	[HIST_TsTerritoryCd] = src.[TsTerritoryCd],
	[HIST_isr_salesperson_key_id] = src.comm_salesperson_key_id,
	[HIST_isr_comm_plan_id] = src.comm_plan_id
FROM
(
SELECT
--	TOP (100)
	BRS_Customer.ShipTo, BRS_Customer.[TsTerritoryCd], BRS_FSC_Rollup.comm_salesperson_key_id, comm.salesperson_master.comm_plan_id
FROM            BRS_Customer INNER JOIN
                         BRS_FSC_Rollup ON BRS_Customer.[TsTerritoryCd] = BRS_FSC_Rollup.TerritoryCd INNER JOIN
                         comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
WHERE
	(BRS_Customer.ShipTo > 0) AND 
	(BRS_Customer.[TsTerritoryCd] <> '**') AND 
	(BRS_Customer.[TsTerritoryCd] <> '')  AND 
	(1 = 1)
) src
WHERE
	([dbo].[BRS_CustomerFSC_History].FiscalMonth between 201901 AND 202011) AND
	([dbo].[BRS_CustomerFSC_History].Shipto = src.ShipTo) AND
	(1=1)

--
UPDATE [dbo].[BRS_CustomerFSC_History]
set 
	[HIST_TsTerritoryCd] = '',
	[HIST_isr_salesperson_key_id] = '',
	[HIST_isr_comm_plan_id] = ''
WHERE
	([dbo].[BRS_CustomerFSC_History].FiscalMonth between 201901 AND 202011) AND
	([HIST_TsTerritoryCd] = '**') AND 
	(1=1)

/*
SELECT        TOP (100) BRS_Customer.ShipTo, BRS_Customer.est_code, BRS_FSC_Rollup.comm_salesperson_key_id, comm.salesperson_master.comm_plan_id
FROM            BRS_Customer INNER JOIN
                         BRS_FSC_Rollup ON BRS_Customer.est_code = BRS_FSC_Rollup.TerritoryCd INNER JOIN
                         comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
WHERE        (BRS_Customer.ShipTo > 0) AND (BRS_Customer.est_code <> 'NA') AND (BRS_Customer.est_code <> '')  AND (1 = 1)
ORDER BY BRS_FSC_Rollup.comm_salesperson_key_id
*/
--
-- update 2019 item history - test
SELECT
 TOP (100) 
d.Item, d.FiscalMonth, d.HIST_comm_group_est_cd, s.comm_group_est_cd
FROM
	BRS_ItemHistory AS d 
	INNER JOIN BRS_Item AS s 
	ON d.Item = s.Item
WHERE
	(d.FiscalMonth >= 201901) AND 
	(d.Item > '') AND
	(s.comm_group_est_cd<>'') AND
	(s.comm_group_est_cd <> d.HIST_comm_group_est_cd) and
	--d.HIST_comm_group_cd <> ''
	--d.HIST_comm_group_cd = 'ITMTEE'
	(1=1)

UPDATE [dbo].[BRS_Item]
set [comm_group_est_cd] = [comm_group_cd]

where [comm_group_cd] in ('ITMPAR', 'ITMSER')

-- update 2019 item history
UPDATE
	BRS_ItemHistory
SET
	[HIST_comm_group_cd] = [comm_group_cd]
	,[HIST_comm_group_cps_cd] = [comm_group_cps_cd]
	,[HIST_comm_group_eps_cd] = [comm_group_eps_cd]
	,[HIST_comm_group_est_cd] = [comm_group_est_cd]
FROM
	BRS_ItemHistory 
	INNER JOIN BRS_Item AS s 
	ON BRS_ItemHistory.Item = s.Item AND
	(BRS_ItemHistory.FiscalMonth >= 202010) AND 
	(BRS_ItemHistory.Item > '') 
GO

