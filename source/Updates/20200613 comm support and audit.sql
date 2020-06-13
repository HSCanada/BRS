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



