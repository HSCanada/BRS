
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW BRS_ItemMarketAdjustModel
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc:  based on BRS_ItemMarketAdjustFix
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
**	Date: 26 May 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	04 Feb 22	tmc		add excption logic for Med 200 codes
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
	[ma_exception_factor],

	i.FreightAdjPct, 
	i.CorporateMarketAdjustmentPct,

	i.DivisionalMarketAdjustmentPct,
	i.CurrentFileCost,
	i.CurrentCorporatePrice,

	([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct as new_market_adj,
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

	INNER JOIN [dbo].[BRS_ItemCategory] AS cat
	ON i.MinorProductClass = cat.MinorProductClass

	CROSS JOIN [dbo].[BRS_Config] AS cfg


WHERE
	-- model scope
	(i.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	-- no dead codes
	(i.ItemStatus <> 'P') AND 
	-- no MSDS items
	(i.MajorProductClass <> '904') AND
	-- remove 20* MPC

	(i.FreightAdjPct > 0) AND

	-- light items
	FreightAdjPct <= cfg.ma_heavy_thresh AND

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
	[ma_exception_factor],

	i.FreightAdjPct, 
	i.CorporateMarketAdjustmentPct,

	i.DivisionalMarketAdjustmentPct,
	i.CurrentFileCost,
	i.CurrentCorporatePrice,

	ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor]-ma_heavy_factor),4) as new_market_adj,
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

	INNER JOIN [dbo].[BRS_ItemCategory] AS cat
	ON i.MinorProductClass = cat.MinorProductClass

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
	[ma_exception_factor],

	i.FreightAdjPct, 
	i.CorporateMarketAdjustmentPct,

	i.DivisionalMarketAdjustmentPct,
	i.CurrentFileCost,
	i.CurrentCorporatePrice,

	ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4) as new_market_adj,
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

	INNER JOIN [dbo].[BRS_ItemCategory] AS cat
	ON i.MinorProductClass = cat.MinorProductClass

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

	(Item NOT IN ('1671450', '1672540', '1672583', '1676434', '1676594', '2283013', '2283533', '2284506', '2286569', '2288490', '5441450', '5445743', '5820370', '5821324', '5822060', '5824559', '5828302', '5828531', '5829551', 
                         '5834239', '5835974', '5838393', '5838638', '5838699', '5839986', '5848192', '5848500', '5850813', '5852333', '5855411', '5855412', '5855417', '5855418', '5855419', '5855420', '5855421', '5855422', '5855423', '5855424', 
                         '5855467', '5855468', '5855469', '5855470', '5855471', '5855479', '6528956', '6528959', '8096775', '8099123', '9490170', '9496591', '9496592', '9497429', '9497430', '9497466', '9497467', '9498526', '9498529', '9498881', 
                         '9498887')) AND 
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
	[ma_exception_factor],


	i.FreightAdjPct, 
	i.CorporateMarketAdjustmentPct,

	i.DivisionalMarketAdjustmentPct,
	i.CurrentFileCost,
	i.CurrentCorporatePrice,

	ROUND(([ma_base_factor]+[ma_stocking_factor]+0.05)/FreightAdjPct,4) as new_market_adj,
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

	INNER JOIN [dbo].[BRS_ItemCategory] AS cat
	ON i.MinorProductClass = cat.MinorProductClass

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

	(Item IN ('1671450', '1672540', '1672583', '1676434', '1676594', '2283013', '2283533', '2284506', '2286569', '2288490', '5441450', '5445743', '5820370', '5821324', '5822060', '5824559', '5828302', '5828531', '5829551', 
                         '5834239', '5835974', '5838393', '5838638', '5838699', '5839986', '5848192', '5848500', '5850813', '5852333', '5855411', '5855412', '5855417', '5855418', '5855419', '5855420', '5855421', '5855422', '5855423', '5855424', 
                         '5855467', '5855468', '5855469', '5855470', '5855471', '5855479', '6528956', '6528959', '8096775', '8099123', '9490170', '9496591', '9496592', '9497429', '9497430', '9497466', '9497467', '9498526', '9498529', '9498881', 
                         '9498887')) AND 
	(1=1)

GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT SalesCategory, COUNT(*) AS cnt FROM BRS_ItemMarketAdjustModel GROUP BY SalesCategory

-- SELECT top 10 * FROM BRS_ItemMarketAdjustModel where ma_heavy_ind = 0

-- SELECT count(*) FROM BRS_ItemMarketAdjustModel 

-- ORG 76965

