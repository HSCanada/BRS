-- rex item, trevor, 14 Apr 26

-- drop TABLE [nes].[item_rex]

CREATE TABLE [nes].[item_rex](
	[Item] [char](10) NOT NULL,
	[Note1] [nchar](255) NULL,
 CONSTRAINT [item_rex_pk] PRIMARY KEY CLUSTERED 
(
	[Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE nes.item_rex ADD CONSTRAINT
	FK_item_rex_BRS_Item FOREIGN KEY
	(
	Item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE nes.item_rex SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

insert into nes.item_rex
(item,Note1)
select item, 'rex20260413' from zzzitem