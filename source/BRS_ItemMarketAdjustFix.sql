
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
--	06 Feb 19	tmc		fixed extra join bug on brand resulting in missed exept
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

	ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4) as new_market_adj



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

	-- light items
	FreightAdjPct <= cfg.ma_heavy_thresh AND

	ABS(CorporateMarketAdjustmentPct - ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor])/FreightAdjPct,4)) > 0.001 AND

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

	ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor]-ma_heavy_factor),4) as new_market_adj


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

	-- light items
	FreightAdjPct > cfg.ma_heavy_thresh AND

	ABS(CorporateMarketAdjustmentPct - ROUND(([ma_base_factor]+[ma_stocking_factor]+[ma_supplier_factor]-ma_heavy_factor),4)) > 0.001 

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- SELECT top 10 * FROM BRS_ItemMarketAdjustFix where ma_heavy_ind = 1
-- SELECT * FROM BRS_ItemMarketAdjustFix where item = '5650053'

SELECT count(*) FROM BRS_ItemMarketAdjustFix
