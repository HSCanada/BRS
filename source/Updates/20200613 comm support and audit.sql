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
USE [DEV_BRSales]
GO

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