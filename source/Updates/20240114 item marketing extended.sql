-- item marketing extended, tmc, 14 Jan 25

/****** Object:  Table [dbo].[BRS_Item]    Script Date: 2025/01/14 1:51:31 PM ******/

truncate table [Pricing].[item_family_marketing_ext]

/****** Object:  Table [Pricing].[item_family_marketing_ext]    Script Date: 2025/01/14 2:08:49 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Pricing].[item_family_marketing_ext]') AND type in (N'U'))
DROP TABLE [Pricing].[item_family_marketing_ext]
GO


CREATE TABLE [pricing].[item_family_marketing_ext](
	[FamilySetLeader] [char](10) NOT NULL,
	[note_descr] [varchar](30) NULL,

	[tag_01_cd] [varchar](10) NULL,
	[tag_02_cd] [varchar](10) NULL,
	[tag_03_cd] [varchar](10) NULL,
	[tag_04_cd] [varchar](10) NULL,
	[tag_05_cd] [varchar](10) NULL,

	ID int not null Identity (1,1)

 CONSTRAINT [pricing_item_family_marketing_ext] PRIMARY KEY CLUSTERED 
(
	[FamilySetLeader] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [PRIMARY]
GO

-- RI, 

BEGIN TRANSACTION
GO
ALTER TABLE Pricing.item_family_marketing_ext ADD CONSTRAINT
	FK_item_family_marketing_ext_BRS_Item FOREIGN KEY
	(
	FamilySetLeader
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Pricing.item_family_marketing_ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- truncate table pricing.item_family_marketing_ext

-- 
INSERT INTO pricing.item_family_marketing_ext
             (FamilySetLeader, note_descr)
values ('', 'unassigned')


INSERT INTO pricing.item_family_marketing_ext
             (FamilySetLeader)
SELECT DISTINCT FamilySetLeader
FROM     BRS_Item where FamilySetLeader <>''


GRANT UPDATE ON [Pricing].[item_family_marketing_ext] TO [pricing_role]