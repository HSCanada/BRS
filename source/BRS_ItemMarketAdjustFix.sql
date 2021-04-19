
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW BRS_ItemMarketAdjustFix
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 15 Jan 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	06 Feb 19	tmc		fixed extra join bug on brand resulting in missed exept
**	25 Nov 20	tmc		exclude zero Freight items (internal codes)
**	05 Jan 21	tmc		add economy teeth logic
**  08 Jan 21	tmc		update to add new import format  1.025 = 2.5
**	11 Jan 21	tmc		add PPE exclude with where ME < 1
**    
*******************************************************************************/

-- Light item excptions
SELECT
--	TOP (10) 
	i.Item, 

	i.SalesCategory, 
	i.ItemStatus, 
	i.MajorProductClass,
	CAST(i.ItemCreationDate AS DATE) AS ItemCreationDate,

	i.Supplier, 
	i.Label, 
	i.StockingType, 
	0 AS ma_heavy_ind,

	ma_heavy_factor,
	ma_heavy_thresh,
	ma_base_factor,
	ma_supplier_factor,
	ma_stocking_factor,


	i.FreightAdjPct, 
	i.CorporateMarketAdjustmentPct,

	ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4) as new_market_adj,
	(ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4)-1.0)*100. as new_market_adj_import,
	i.Est12MoSales


FROM
	BRS_Item AS i 

	INNER JOIN BRS_ItemSupplier AS sup 
	ON i.Supplier = sup.Supplier 
--	AND i.Brand = sup.Supplier 
		
	INNER JOIN BRS_ItemLabel AS lab 
	ON i.Label = lab.Label 
	
	INNER JOIN BRS_ItemStocking AS stk 
	ON i.StockingType = stk.StockingType


	CROSS JOIN [dbo].[BRS_Config] AS cfg


WHERE
	-- model scope

	(i.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	-- no dead codes
	(i.ItemStatus <> 'P') AND 
	-- no MSDS items
	(i.MajorProductClass <> '904') AND

	(i.FreightAdjPct > 0) AND

	-- light items
	FreightAdjPct <= cfg.ma_heavy_thresh AND

	ABS(CorporateMarketAdjustmentPct - ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4)) > 0.001 AND

	-- exclude PPE overrides
	NOT ((CorporateMarketAdjustmentPct BETWEEN 0.10 AND 0.99) AND i.Supplier <> 'ACESUR') AND

	(1=1) 

UNION ALL


-- Heavy item excptions
SELECT
--	TOP (10) 
	i.Item, 

	i.SalesCategory, 
	i.ItemStatus, 
	i.MajorProductClass,
	CAST(i.ItemCreationDate AS DATE) AS ItemCreationDate,

	i.Supplier, 
	i.Label, 
	i.StockingType, 
	1 AS ma_heavy_ind,
	ma_heavy_factor,
	ma_heavy_thresh,
	ma_base_factor,
	ma_supplier_factor,
	ma_stocking_factor,


	i.FreightAdjPct, 
	i.CorporateMarketAdjustmentPct,

	ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor]-ma_heavy_factor),4) as new_market_adj,
	(ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor]-ma_heavy_factor),4)-1.0)*100.0 as new_market_adj_import,
	i.Est12MoSales


FROM
	BRS_Item AS i 
	INNER JOIN BRS_ItemSupplier AS sup 
	ON i.Supplier = sup.Supplier 
--	AND i.Brand = sup.Supplier 
		
	INNER JOIN BRS_ItemLabel AS lab 
	ON i.Label = lab.Label 
	
	INNER JOIN BRS_ItemStocking AS stk 
	ON i.StockingType = stk.StockingType

	CROSS JOIN [dbo].[BRS_Config] AS cfg


WHERE
	-- model scope
	(i.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	-- no dead codes
	(i.ItemStatus <> 'P') AND 
	-- no MSDS items
	(i.MajorProductClass <> '904') AND

	(i.FreightAdjPct > 0) AND

	-- light items
	FreightAdjPct > cfg.ma_heavy_thresh AND

	ABS(CorporateMarketAdjustmentPct - ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor]-ma_heavy_factor),4)) > 0.001 AND

	-- exclude PPE overrides
	NOT ((CorporateMarketAdjustmentPct BETWEEN 0.10 AND 0.99) AND i.Supplier <> 'ACESUR') AND
	(1=1)

UNION ALL

-- Teeth, less economy
SELECT
--	TOP (10) 
	i.Item, 

	i.SalesCategory, 
	i.ItemStatus, 
	i.MajorProductClass,
	CAST(i.ItemCreationDate AS DATE) AS ItemCreationDate,

	i.Supplier, 
	i.Label, 
	i.StockingType, 
	0 AS ma_heavy_ind,

	ma_heavy_factor,
	ma_heavy_thresh,
	ma_base_factor,
	ma_supplier_factor,
	ma_stocking_factor,


	i.FreightAdjPct, 
	i.CorporateMarketAdjustmentPct,

	ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4) as new_market_adj,
	(ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4)-1.0)*100.0 as new_market_adj_import,
	i.Est12MoSales

FROM
	BRS_Item AS i 

	INNER JOIN BRS_ItemSupplier AS sup 
	ON i.Supplier = sup.Supplier 
--	AND i.Brand = sup.Supplier 
		
	INNER JOIN BRS_ItemLabel AS lab 
	ON i.Label = lab.Label 
	
	INNER JOIN BRS_ItemStocking AS stk 
	ON i.StockingType = stk.StockingType


	CROSS JOIN [dbo].[BRS_Config] AS cfg


WHERE
	-- model scope

	(i.SalesCategory IN ('TEETH')) AND 
	-- no dead codes
	(i.ItemStatus <> 'P') AND 
	-- no MSDS items
	(i.MajorProductClass <> '904') AND

	(i.FreightAdjPct > 0) AND

	-- light items
	FreightAdjPct <= cfg.ma_heavy_thresh AND

	ABS(CorporateMarketAdjustmentPct - ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4)) > 0.001 AND

	(Item NOT IN ('1671450', '1672540', '1672583', '1676434', '1676594', '2283013', '2283533', '2284506', '2286569', '2288490', '5441450', '5445743', '5820370', '5821324', '5822060', '5824559', '5828302', '5828531', '5829551', 
                         '5834239', '5835974', '5838393', '5838638', '5838699', '5839986', '5848192', '5848500', '5850813', '5852333', '5855411', '5855412', '5855417', '5855418', '5855419', '5855420', '5855421', '5855422', '5855423', '5855424', 
                         '5855467', '5855468', '5855469', '5855470', '5855471', '5855479', '6528956', '6528959', '8096775', '8099123', '9490170', '9496591', '9496592', '9497429', '9497430', '9497466', '9497467', '9498526', '9498529', '9498881', 
                         '9498887')) AND 
	-- exclude PPE overrides
	NOT ((CorporateMarketAdjustmentPct BETWEEN 0.10 AND 0.99) AND i.Supplier <> 'ACESUR') AND
	(1=1)

UNION ALL

-- Teeth, economy
SELECT
--	TOP (10) 
	i.Item, 

	i.SalesCategory, 
	i.ItemStatus, 
	i.MajorProductClass,
	CAST(i.ItemCreationDate AS DATE) AS ItemCreationDate,

	i.Supplier, 
	i.Label, 
	i.StockingType, 
	0 AS ma_heavy_ind,

	ma_heavy_factor,
	ma_heavy_thresh,
	ma_base_factor,
	-- hard code as eco type not reportable
	0.05							AS ma_supplier_factor,
	ma_stocking_factor,


	i.FreightAdjPct, 
	i.CorporateMarketAdjustmentPct,

	ROUND(([ma_base_factor]+[ma_stocking_factor]+0.05)/FreightAdjPct,4) as new_market_adj,
	(ROUND(([ma_base_factor]+[ma_stocking_factor]+0.05)/FreightAdjPct,4)-1.0)*100. as new_market_adj,
	i.Est12MoSales

FROM
	BRS_Item AS i 

	INNER JOIN BRS_ItemSupplier AS sup 
	ON i.Supplier = sup.Supplier 
--	AND i.Brand = sup.Supplier 
		
	INNER JOIN BRS_ItemLabel AS lab 
	ON i.Label = lab.Label 
	
	INNER JOIN BRS_ItemStocking AS stk 
	ON i.StockingType = stk.StockingType


	CROSS JOIN [dbo].[BRS_Config] AS cfg


WHERE
	-- model scope

	(i.SalesCategory IN ('TEETH')) AND 
	-- no dead codes
	(i.ItemStatus <> 'P') AND 
	-- no MSDS items
	(i.MajorProductClass <> '904') AND

	(i.FreightAdjPct > 0) AND

	-- light items
	FreightAdjPct <= cfg.ma_heavy_thresh AND

	ABS(CorporateMarketAdjustmentPct - ROUND(([ma_base_factor]+[ma_stocking_factor]+0.05)/FreightAdjPct,4)) > 0.001 AND

	(Item IN ('1671450', '1672540', '1672583', '1676434', '1676594', '2283013', '2283533', '2284506', '2286569', '2288490', '5441450', '5445743', '5820370', '5821324', '5822060', '5824559', '5828302', '5828531', '5829551', 
                         '5834239', '5835974', '5838393', '5838638', '5838699', '5839986', '5848192', '5848500', '5850813', '5852333', '5855411', '5855412', '5855417', '5855418', '5855419', '5855420', '5855421', '5855422', '5855423', '5855424', 
                         '5855467', '5855468', '5855469', '5855470', '5855471', '5855479', '6528956', '6528959', '8096775', '8099123', '9490170', '9496591', '9496592', '9497429', '9497430', '9497466', '9497467', '9498526', '9498529', '9498881', 
                         '9498887')) AND 
	-- exclude PPE overrides
	NOT ((CorporateMarketAdjustmentPct BETWEEN 0.10 AND 0.99) AND i.Supplier <> 'ACESUR') AND
	(1=1)

GO



SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- SELECT top 10 * FROM BRS_ItemMarketAdjustFix where ma_heavy_ind = 0
-- SELECT * FROM BRS_ItemMarketAdjustFix order by 	Est12MoSales desc
--where SalesCategory = 'TEETH'

-- SELECT count(*) FROM BRS_ItemMarketAdjustFix where SalesCategory = 'TEETH'
-- SELECT * FROM BRS_ItemMarketAdjustFix where SalesCategory = 'TEETH'
-- SELECT * FROM BRS_ItemMarketAdjustFix where item = '5854180'

-- ORG 76206, with EXLUDE 76165