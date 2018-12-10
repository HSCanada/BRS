-- update 

ALTER TABLE nes.[privileges] ADD
	pma_ind char(1) NOT NULL CONSTRAINT DF_privileges_pma_ind DEFAULT ''
GO

--

UPDATE       nes.[privileges]
SET                pma_ind = 'Y'
WHERE        (privileges_descr LIKE N'%pma%')

---
INSERT INTO [nes].[order]
([work_order_num], note)
SELECT DISTINCT 'ZNORD' + Branch AS Expr1, ''
FROM            nes.branch
WHERE        (Branch <> '')
GO

INSERT INTO [nes].[order]
([work_order_num], note)
VALUES ('ZNORDZCORP', '')
GO

UPDATE       nes.order_open_prorepr
SET                
work_order_num = 'ZNORD' + BRS_FSC_Rollup.Branch

--SELECT 'ZNORD' + BRS_FSC_Rollup.Branch
FROM            nes.order_open_prorepr INNER JOIN
                         BRS_FSC_Rollup ON nes.order_open_prorepr.est_code = BRS_FSC_Rollup.TerritoryCd
WHERE        (nes.order_open_prorepr.model_number LIKE '%PLEASE IGNORE%') 
GO
---

ALTER TABLE dbo.BRS_Item ADD
	Item_Competitive_Conversion_rt float(53) NULL
GO
ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	DF_BRS_Item_Item_Competitive_Conversion_rt DEFAULT 1 FOR Item_Competitive_Conversion_rt
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)

--- 2prod
ALTER TABLE dbo.BRS_ItemCategoryRollup ADD
	CategoryBrandCount smallint NOT NULL CONSTRAINT DF_BRS_ItemCategoryRollup_CategoryBrandCount DEFAULT 0
GO
ALTER TABLE dbo.BRS_ItemCategoryRollup SET (LOCK_ESCALATION = TABLE)
