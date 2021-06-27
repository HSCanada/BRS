
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW BRS_ItemMarketAdjustFix_dcc
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc:  based on BRS_ItemMarketAdjustFix
**		DA = 1 + (DP/FC + CB)/FF - CA
** [@[new_divisional_adj]] = (1-[@[new_corprorate_adj]] +(+[@CurrentDccPrice]+[@UnitChargeback]) / ([@CurrentFileCost]*[@FreightAdjPct])) 
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
**    
*******************************************************************************/

-- Light item excptions
SELECT
--	TOP (10) 
	i.Item

	,i.SalesCategory
	,i.ItemStatus
	,i.MajorProductClass
	,i.ItemCreationDate

	,i.Supplier
	,i.Label
	,i.StockingType
	,i.ma_heavy_ind

	,i.ma_heavy_factor
	,i.ma_heavy_thresh
	,i.ma_base_factor
	,ma_supplier_factor
	,ma_stocking_factor

	,i.FreightAdjPct
	,i.CorporateMarketAdjustmentPct
	-- set 0 to 1, which is the correct default
	,ISNULL(NULLIF(i.DivisionalMarketAdjustmentPct,0),1)	AS DivisionalMarketAdjustmentPct
	,i.CurrentFileCost
	,i.CurrentCorporatePrice
	,dcc.CurrentPrice AS CurrentDccPrice
	,dcc.[UnitChargeback]

	,i.new_market_adj	AS new_corprorate_adj
	,CASE 
		-- negative margin?
		WHEN dcc.CurrentPrice < (CurrentFileCost * (FreightAdjPct * i.new_market_adj) - [UnitChargeback])
		-- correct
		-- [@[new_divisional_adj]] = (1-[@[new_corprorate_adj]] +(+[@CurrentDccPrice]+[@UnitChargeback]) / ([@CurrentFileCost]*[@FreightAdjPct])) 
		THEN 1.0 - i.new_market_adj + (dcc.CurrentPrice + dcc.[UnitChargeback]) /(i.CurrentFileCost*i.FreightAdjPct)  
		-- no correction
		ELSE 1
	END					AS new_divisional_adj
	,CASE 
		-- negative margin?
		WHEN dcc.CurrentPrice < (CurrentFileCost * (FreightAdjPct * i.new_market_adj) - [UnitChargeback])
		-- correct
		THEN ROUND(1.0 - i.new_market_adj + (dcc.CurrentPrice + dcc.[UnitChargeback]) /(i.CurrentFileCost*i.FreightAdjPct) -1.0, 4) * 100.0
		-- no correction
		ELSE 0.0
	END					AS new_divisional_adj_import

--	,(ROUND(i.new_market_adj, 4) - 1.0) * 100. AS new_market_adj_import
	,i.Est12MoSales

FROM
	BRS_ItemMarketAdjustModel AS i 

	INNER JOIN [Pricing].[item_price_dcc] dcc
	ON i.Item = dcc.item

WHERE
	-- Correction needed?
--	ABS(CorporateMarketAdjustmentPct - i.new_market_adj) > 0.001 AND

	-- exclude PPE overrides
--	NOT ((CorporateMarketAdjustmentPct BETWEEN 0.10 AND 0.99) AND i.Supplier <> 'ACESUR') AND

	(1=1) 


GO

-- revew
--
-- SELECT top 10 * FROM BRS_ItemMarketAdjustFix_dcc order by est12mosales desc
-- SELECT SalesCategory, COUNT(*) AS cnt FROM BRS_ItemMarketAdjustFix_dcc GROUP BY SalesCategory

-- test
--
-- SELECT * FROM BRS_ItemMarketAdjustFix_dcc where DivisionalMarketAdjustmentPct <> 1
-- SELECT * FROM BRS_ItemMarketAdjustFix_dcc where CorporateMarketAdjustmentPct = 0
-- SELECT * FROM BRS_ItemMarketAdjustFix_dcc where Item in('1071261', '1073380', '1074226', '1075465') 

/*
SELECT top 10 * FROM BRS_ItemMarketAdjustFix_dcc
where CurrentDccPrice < (CurrentFileCost * (FreightAdjPct * new_corprorate_adj) - [UnitChargeback])
order by est12mosales desc
*/

-- output
-- SELECT * FROM BRS_ItemMarketAdjustFix_dcc where DivisionalMarketAdjustmentPct <> new_divisional_adj AND CorporateMarketAdjustmentPct >= 1





