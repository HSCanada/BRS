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


-- 

-- Add coupa start date to DCC, customer

ALTER TABLE dbo.BRS_Customer ADD
	coupa_start_date date NULL
GO

-- improve subs join pref
CREATE NONCLUSTERED INDEX BRS_Item_idx_04 ON dbo.BRS_Item
	(
	Item_Competitive_Match
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO


-- temp fix subs

UPDATE 
	BRS_Item
SET 
	[Item_Competitive_Conversion_rt] = 1
WHERE        
	(Item_Competitive_Match > '0')


-- Merch Subs to Item dim for performance

SELECT
--	TOP 10
	i.ItemKey,
	i.Item,
	i.SalesCategory,
	i.SalesCategoryRollup,
	i.Major,
	i.SubMajor,
	i.ItemCode,
	i.Size,
	i.Strength,
	i.ItemStatus,
	i.Brand,
	i.CompetitiveMatchKey,
	i.Label,
	i.Current_BasePrice,
	i.FamilySet,
	i.Supplier,

	CASE 
		WHEN isub.ItemKey = 1 
		THEN ''
		ELSE isub.Item
	END										AS SubstItem,
	isub.Current_BasePrice					AS SubsItemBasePrice,
	ISNULL(i.Item_Competitive_Conversion_rt,0) AS SubsItem2Subs_factor

FROM
	Dimension.Item AS i 

	INNER JOIN Dimension.Item AS isub 
	ON i.CompetitiveMatchKey = isub.ItemKey


-- Fact

SELECT
	FactKey, 
	ShipTo, 
	ItemKey, 
	CategoryRollupKey, 
	CalMonth,
	DateKey,
	SalesOrderNumber,
	LineNumber,
	FreeGoodsInvoicedInd,
	Quantity,
	SalesAmt,
	GPAmt, 
	GPAtCommCostAmt,
	ExtChargebackAmt,
	ExtBaseAmt,
	DiscountAmt,
	DiscountLineAmt,
	DiscountOrderAmt,
	SubsQuantity,
	SubsSalesAmt

FROM
	Fact.Sale_brs AS f
