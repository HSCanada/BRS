
-- add entity
-- 30 Nov 17

CREATE TABLE [hfm].[entity](
	[Entity] [nvarchar](30) NOT NULL,
	[EntityDescr] [nvarchar](75) NOT NULL,
	[EntityParent] [nvarchar](30) NOT NULL,
	[LevelNum] [smallint] NOT NULL,
	[ActiveInd] [bit] NOT NULL,
	[Note] [nvarchar](100) NULL,
	[EntityKey] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [entity_c_pk] PRIMARY KEY CLUSTERED 
(
	[Entity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

/****** Object:  Index [cost_center_u_idx]    Script Date: 11/30/2017 10:57:26 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [hfm_entity_u_idx] ON [hfm].[entity]
(
	[EntityKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

ALTER TABLE [hfm].[entity] ADD  CONSTRAINT [DF_entity_LevelNum]  DEFAULT ((0)) FOR [LevelNum]
GO

ALTER TABLE [hfm].[entity] ADD  CONSTRAINT [DF_entity_ActiveInd]  DEFAULT ((0)) FOR [ActiveInd]
GO

ALTER TABLE [hfm].[entity]  WITH CHECK ADD  CONSTRAINT [FK_entity_entity1] FOREIGN KEY([EntityParent])
REFERENCES [hfm].[entity] ([Entity])
GO

ALTER TABLE [hfm].[entity] CHECK CONSTRAINT [FK_entity_entity1]
GO

INSERT INTO hfm.entity
                         (Entity, EntityDescr, EntityParent)
VALUES        (N'', N'Unassigned', '')


BEGIN TRANSACTION
GO
ALTER TABLE hfm.cost_center ADD
	Entity nvarchar(30) NULL
GO
ALTER TABLE hfm.cost_center ADD CONSTRAINT
	FK_cost_center_entity FOREIGN KEY
	(
	Entity
	) REFERENCES hfm.entity
	(
	Entity
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.cost_center SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
