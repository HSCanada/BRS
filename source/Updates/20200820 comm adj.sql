--finalize adjustment 
-- Add TS and EST, tmc, 16 Dec 20

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

-- ESS history populate, TBD add logic to ME snapshot proc

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

/*
SELECT
-- TOP (10) 
WSDOCO_salesorder_number, WSDCTO_order_type, MIN(ess_code), MIN(ess_salesperson_key_id), MIN(ess_comm_plan_id)
FROM            comm.transaction_F555115
WHERE        
(WSDCTO_order_type <> 'AA') AND (ess_code <> '')
GROUP BY WSDOCO_salesorder_number, WSDCTO_order_type
*/



