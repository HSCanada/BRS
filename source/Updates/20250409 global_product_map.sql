-- global_product_map, tmc, 9 Apr 25


-- drop table [hfm].[global_product_map]

CREATE TABLE [hfm].[global_product_map](

	[subminor_id] [char](9) NOT NULL,

	[subminor_cd] [char](12) NOT NULL,
	[subminor_desc] [nvarchar](50)  NULL,

	[minor_cd] [char](9)  NULL,
	[minor_desc] [nvarchar](50)  NULL,

	[submajor_cd] [char](6)  NULL,
	[submajor_desc] [nvarchar](50)  NULL,

	[major_cd] [char](3)  NULL,
	[major_desc] [nvarchar](50)  NULL,

	[subminor_key] [int] IDENTITY(1,1) NOT NULL,

	[note_txt] [nvarchar](255) NULL,

	[global_product_class] [char](12)  NULL,

 CONSTRAINT [hfm_global_product_map_c_pk] PRIMARY KEY CLUSTERED 
(
	[subminor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--
BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX hfm_global_product_map_u_idx_1 ON hfm.global_product_map
	(
	subminor_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX hfm_global_product_map_idx_2 ON hfm.global_product_map
	(
	global_product_class
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE hfm.global_product_map ADD CONSTRAINT
	FK_global_product_map_global_product FOREIGN KEY
	(
	global_product_class
	) REFERENCES hfm.global_product
	(
	global_product_class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.global_product_map SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

INSERT INTO [hfm].[global_product_map]
           ([subminor_id], [subminor_cd])
     VALUEs ('', '')
GO

--
CREATE TABLE [Integration].[hfm_global_product_map](

	[subminor_id] [char](9) NOT NULL,

	[subminor_cd] [char](12) NOT NULL,
	[subminor_desc] [nvarchar](50)  NULL,

	[minor_cd] [char](9)  NULL,
	[minor_desc] [nvarchar](50)  NULL,

	[submajor_cd] [char](6)  NULL,
	[submajor_desc] [nvarchar](50)  NULL,

	[major_cd] [char](3)  NULL,
	[major_desc] [nvarchar](50)  NULL,

 CONSTRAINT [integration_hfm_global_product_map_c_pk] PRIMARY KEY CLUSTERED 
(
	[subminor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SELECT      top 10  hfm.global_product_map.subminor_id, hfm.global_product_map.global_product_class, BRS_ItemCategory.MinorProductClass, BRS_ItemCategory.global_product_class AS Expr1
FROM            BRS_ItemCategory INNER JOIN
                         hfm.global_product_map ON BRS_ItemCategory.MinorProductClass = hfm.global_product_map.minor_cd

UPDATE        hfm.global_product_map
SET                global_product_class = BRS_ItemCategory.global_product_class
FROM            BRS_ItemCategory INNER JOIN
                         hfm.global_product_map ON BRS_ItemCategory.MinorProductClass = hfm.global_product_map.minor_cd

-- add global to item

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	global_product_class char(12) NOT NULL CONSTRAINT DF_BRS_Item_global_product_class DEFAULT ''
GO
CREATE NONCLUSTERED INDEX BRS_Item_idx_05 ON dbo.BRS_Item
	(
	global_product_class
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_global_product FOREIGN KEY
	(
	global_product_class
	) REFERENCES hfm.global_product
	(
	global_product_class
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--

UPDATE        [dbo].[BRS_Item]
SET                global_product_class = m.global_product_class
FROM             hfm.global_product_map m INNER JOIN
                         [dbo].[BRS_Item] i ON m.subminor_id = i.SubMinorProductCodec AND
						 m.global_product_class is not null




