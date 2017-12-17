
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

-- add entity 

insert into [hfm].[entity]
(Entity,EntityDescr,EntityParent,LevelNum,ActiveInd,Note)
select Entity,EntityDescr,EntityParent,LevelNum,ActiveInd,Note from DEV_BRSales.[hfm].[entity] s
where not exists (
	select * from [hfm].[entity] d
	where d.Entity = s.Entity)

-- add new cc from dev

insert into [hfm].[cost_center]
(CostCenter,CostCenterDescr,CostCenterParent,LevelNum,ActiveInd,Note,Entity)
select CostCenter,CostCenterDescr,CostCenterParent,LevelNum,ActiveInd,Note,Entity from DEV_BRSales.[hfm].[cost_center] s where not exists (
	select * from [hfm].[cost_center] d
	where d.CostCenter = s.CostCenter)

-- update cc from dev

-- update 
SELECT        b.BusinessUnit, b.GLBU_Class, m.HFM_CostCenter, m.HFM_Account, c.GLBU_ClassUS_L1
FROM            hfm.account_master_F0901 AS m INNER JOIN
                         BRS_BusinessUnit AS b ON m.GMMCU__business_unit = b.BusinessUnit INNER JOIN
                         BRS_BusinessUnitClass AS c ON b.GLBU_Class = c.GLBU_Class
WHERE        (c.GLBU_ClassUS_L1 <> '')

SELECT        n.BU, n.text, BRS_BusinessUnit.BusinessUnit
FROM            zzzBU AS n LEFT OUTER JOIN
                         BRS_BusinessUnit ON n.BU = BRS_BusinessUnit.BusinessUnit
WHERE        (BRS_BusinessUnit.BusinessUnit IS NULL)



UPDATE       hfm.account_master_F0901
SET                HFM_CostCenter = n.HFM_CostCenter
FROM            DEV_BRSales.hfm.account_master_F0901 AS n INNER JOIN
                         hfm.account_master_F0901 ON n.GMMCU__business_unit = hfm.account_master_F0901.GMMCU__business_unit AND n.HFM_CostCenter <> ISNULL(hfm.account_master_F0901.HFM_CostCenter, N'')

UPDATE       [dbo].[BRS_BusinessUnit]
SET                CostCenter = n.[CostCenter]
FROM            DEV_BRSales.[dbo].[BRS_BusinessUnit] AS n INNER JOIN
                         [dbo].[BRS_BusinessUnit] b ON n.BusinessUnit = b.BusinessUnit AND n.CostCenter <> ISNULL(b.CostCenter, N'')


/*
 1. cost_center rows
 2. account_master_F0901![HFM_CostCenter]


CREATE TABLE [dbo].[zzzBU](
	[BU] [char](20) NOT NULL,
	[text] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_zzzBU] PRIMARY KEY CLUSTERED 
(
	[BU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
 */

UPDATE       hfm.cost_center
SET                Entity = d.[Entity]
FROM            DEV_BRSAles.hfm.cost_center d INNER JOIN
                         hfm.cost_center ON d.CostCenter = hfm.cost_center.CostCenter


SELECT        cl.GLBU_ClassUS_L1, b.BusinessUnit, b.BusinessUnitName, cl.GLBU_Class, c.CostCenter, c.Entity
FROM            hfm.cost_center AS c INNER JOIN
                         BRS_BusinessUnit AS b ON c.CostCenter = b.CostCenter INNER JOIN
                         BRS_BusinessUnitClass AS cl ON b.GLBU_Class = cl.GLBU_Class
WHERE        (cl.GLBU_ClassUS_L1 IN ( 'ZZZZZ')) 

UPDATE       hfm.cost_center
SET                Entity = N''
FROM            hfm.cost_center INNER JOIN
                         BRS_BusinessUnit AS b ON hfm.cost_center.CostCenter = b.CostCenter INNER JOIN
                         BRS_BusinessUnitClass AS cl ON b.GLBU_Class = cl.GLBU_Class
WHERE        (cl.GLBU_ClassUS_L1 IN ('ZZZZZ')) AND (hfm.cost_center.Entity IS NULL)


-- update account map

UPDATE       hfm.account_master_F0901
SET                HFM_CostCenter = s.HFM_CostCenter, HFM_Account = s.HFM_Account, LastUpdated = s.LastUpdated
FROM            DEV_BRSales.hfm.account_master_F0901 AS s INNER JOIN
                         hfm.account_master_F0901 ON s.GMMCU__business_unit = hfm.account_master_F0901.GMMCU__business_unit AND 
                         s.GMOBJ__object_account = hfm.account_master_F0901.GMOBJ__object_account AND s.GMSUB__subsidiary = hfm.account_master_F0901.GMSUB__subsidiary


