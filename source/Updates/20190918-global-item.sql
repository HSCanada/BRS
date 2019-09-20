--20190918-global-item

CREATE TABLE [hfm].[global_product](
	[global_product_class] [char](12) NOT NULL,
	[global_product_class_descr] [nvarchar](75) NOT NULL,
	[parent] [char](12) NOT NULL,
	[level_num] [smallint] NOT NULL,
	[active_ind] [bit] NOT NULL,
	[note] [nvarchar](100) NULL,
	[global_product_class_key] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [global_product_class_c_pk] PRIMARY KEY CLUSTERED 
(
	[global_product_class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [hfm].[global_product] ADD  CONSTRAINT [DF_global_product_level_num]  DEFAULT ((0)) FOR [level_num]
GO

ALTER TABLE [hfm].[global_product] ADD  CONSTRAINT [DF_global_product_active_ind]  DEFAULT ((0)) FOR [active_ind]
GO

BEGIN TRANSACTION
GO
ALTER TABLE hfm.global_product ADD CONSTRAINT
	FK_global_product_global_product FOREIGN KEY
	(
	parent
	) REFERENCES hfm.global_product
	(
	global_product_class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.global_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


ALTER TABLE [hfm].[global_product] CHECK CONSTRAINT FK_global_product_global_product
GO

INSERT INTO [hfm].[global_product]
(
[global_product_class]
,[global_product_class_descr]
,[parent]
) 
VALUES (
'', 'undefined', ''
)

-- add xref to product 

BEGIN TRANSACTION
GO
ALTER TABLE hfm.global_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemCategory ADD
	global_product_class char(12) NOT NULL CONSTRAINT DF_BRS_ItemCategory_global_product_class DEFAULT ''
GO
ALTER TABLE dbo.BRS_ItemCategory ADD CONSTRAINT
	FK_BRS_ItemCategory_global_product FOREIGN KEY
	(
	global_product_class
	) REFERENCES hfm.global_product
	(
	global_product_class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemCategory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- move to prod

-- load from excel via access
