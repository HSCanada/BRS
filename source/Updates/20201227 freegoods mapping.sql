-- freegoods mapping, tmc, 27 Dec 20
--
--drop TABLE [Integration].[comm_adjustment_Staging]
CREATE TABLE [Integration].[comm_adjustment_Staging](

	-- ORG Sales order (may have bad data)
	[WSDOC__document_number] [int] NOT NULL

	-- ORG Line No (may get extented)
	,[WSOGNO_original_line_number] [int] NOT NULL

	-- Fiscal mo
	,[FiscalMonth] [int] NOT NULL

	-- transaction_dt (based on FiscalMonth, last day)
	,[WSDGL__gl_date] [datetime]  NULL

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

	-- user to indicate valid GP source when loading:
	-- Gross Profit (GP)
	-- File Cost (CF)
	-- Commissionable Cost (CC)
	,[gp_code] [char](2) NOT NULL

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
-- post prod add, 24 Dec 20

BEGIN TRANSACTION
GO
ALTER TABLE comm.freegoods ADD
	fsc_code char(5) NOT NULL CONSTRAINT DF_freegoods_fsc_code DEFAULT '',
	ess_code char(5) NOT NULL CONSTRAINT DF_freegoods_ess_code DEFAULT '',
	eps_code char(5) NOT NULL CONSTRAINT DF_freegoods_eps_code DEFAULT '',
	isr_code char(5) NOT NULL CONSTRAINT DF_freegoods_isr_code DEFAULT ''
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_FSC_Rollup FOREIGN KEY
	(
	fsc_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_FSC_Rollup1 FOREIGN KEY
	(
	ess_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_FSC_Rollup2 FOREIGN KEY
	(
	eps_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_BRS_FSC_Rollup3 FOREIGN KEY
	(
	isr_code
	) REFERENCES dbo.BRS_FSC_Rollup
	(
	TerritoryCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE comm.plan_group_rate ADD
	fg_comm_group_cd char(6) NOT NULL CONSTRAINT DF_plan_group_rate_fg_comm_group_cd DEFAULT ''
GO
ALTER TABLE comm.plan_group_rate ADD CONSTRAINT
	FK_plan_group_rate_group3 FOREIGN KEY
	(
	fg_comm_group_cd
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
ALTER TABLE Integration.comm_freegoods_Staging ADD
	fg_fsc_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_freegoods_Staging_fg_fsc_comm_group_cd DEFAULT (''),
	fg_ess_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_freegoods_Staging_fg_ess_comm_group_cd DEFAULT (''),
	fg_eps_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_freegoods_Staging_fg_eps_comm_group_cd DEFAULT (''),
	fg_isr_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_freegoods_Staging_fg_isr_comm_group_cd DEFAULT ('')
GO
ALTER TABLE Integration.comm_freegoods_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE comm.freegoods ADD
	fg_fsc_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_freegoods_fg_fsc_comm_group_cd DEFAULT (''),
	fg_ess_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_freegoods_fg_ess_comm_group_cd DEFAULT (''),
	fg_eps_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_freegoods_fg_eps_comm_group_cd DEFAULT (''),
	fg_isr_comm_group_cd char(6) NOT NULL CONSTRAINT DF_comm_freegoods_fg_isr_comm_group_cd DEFAULT ('')
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group6 FOREIGN KEY
	(
	fg_eps_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group7 FOREIGN KEY
	(
	fg_ess_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group8 FOREIGN KEY
	(
	fg_fsc_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods ADD CONSTRAINT
	FK_freegoods_group9 FOREIGN KEY
	(
	fg_isr_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.freegoods SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
--
BEGIN TRANSACTION
GO
ALTER TABLE Integration.comm_freegoods_Staging ADD
	fsc_comm_plan_id char(10) NOT NULL CONSTRAINT DF_comm_freegoods_Staging_fsc_comm_plan_id DEFAULT '',
	ess_comm_plan_id char(10) NOT NULL CONSTRAINT DF_comm_freegoods_Staging_ess_comm_plan_id DEFAULT '',
	eps_comm_plan_id char(10) NOT NULL CONSTRAINT DF_comm_freegoods_Staging_eps_comm_plan_id DEFAULT '',
	isr_comm_plan_id char(10) NOT NULL CONSTRAINT DF_comm_freegoods_Staging_isr_comm_plan_id DEFAULT ''
GO
ALTER TABLE Integration.comm_freegoods_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- reset
UPDATE [comm].[plan_group_rate] SET [fg_comm_group_cd] = ''

-- add exclude EQ plans

UPDATE [comm].[plan_group_rate]
   SET 
      [fg_comm_group_cd] = 'FRESND'
 WHERE
	LEFT([comm_plan_id],3) not in ('ESS', 'CCS', 'CPS', 'EST') AND
	[source_cd] = 'JDE' AND
	[cust_comm_group_cd] NOT in( 'SPMSND', 'SPMALL') AND
	[disp_comm_group_cd] in('ITMSND','ITMEPS','DIGMAT','ITMCAM')
GO

UPDATE [comm].[plan_group_rate]
   SET 
      [fg_comm_group_cd] = 'SPMFGS'
 WHERE
	LEFT([comm_plan_id],3) not in ('ESS', 'CCS', 'CPS', 'EST') AND
	[source_cd] = 'JDE' AND
	[cust_comm_group_cd] in( 'SPMSND', 'SPMALL') AND
	[disp_comm_group_cd] in('SPMSND','ITMSND','ITMEPS','DIGMAT','ITMCAM') 
GO


UPDATE [comm].[plan_group_rate]
   SET 
      [fg_comm_group_cd] = 'FRESEQ'
 WHERE
	LEFT([comm_plan_id],3) not in ('ESS', 'CCS', 'CPS', 'EST') AND
	[source_cd] = 'JDE' AND
	[cust_comm_group_cd] NOT in( 'SPMEQU', 'SPMALL') AND
	[disp_comm_group_cd] in('ITMFO1','ITMFO2','ITMFO3','ITMPAR','ITMEQ0')
GO

UPDATE [comm].[plan_group_rate]
   SET 
      [fg_comm_group_cd] = 'SPMFGE'
 WHERE
	LEFT([comm_plan_id],3) not in ('ESS', 'CCS', 'CPS', 'EST') AND
	[source_cd] = 'JDE' AND
	[cust_comm_group_cd] in( 'SPMEQU', 'SPMALL') AND
	[disp_comm_group_cd] in('SPMFO1','SPMFO2','SPMFO3','ITMFO1','ITMFO2','ITMFO3','ITMPAR','ITMEQ0')
GO

-- ess, small EQ only

UPDATE [comm].[plan_group_rate]
   SET 
      [fg_comm_group_cd] = 'FRESEQ'
 WHERE
	LEFT([comm_plan_id],3) in ('ESS') AND
	[source_cd] = 'JDE' AND
	[disp_comm_group_cd] in('ITMFO1','ITMFO2','ITMFO3','ITMPAR','ITMEQ0')
GO



