-- MA model - sales


-- MA model - item
SELECT 

	top 10

	[ItemKey]
	,Item							AS Item_Number
	,[FamilySetLeader]
	,[Label]
	,i.ItemStatus					AS Item_Status
	,i.StockingType					AS Stocking_Type
	,[Supplier]

	,[SalesCategory]
	,[CurrentFileCost]
	,[FreightAdjPct]
	,CASE WHEN [CorporateMarketAdjustmentPct] = 0 THEN 1 ELSE [CorporateMarketAdjustmentPct] END AS [CorporateMarketAdjustmentPct]
	,[CurrentCorporatePrice]

	,RTRIM(ItemDescription)			AS Item_Description
	,RTRIM(MajorProductClass)		AS Major_Product_Class
	,RTRIM(cat.major_desc)			AS Major_Product_Class_Description
	,RTRIM(i.MinorProductClass)		AS Sub_Minor_Prod_Class
	,RTRIM(cat.minor_desc)			AS Sub_Minor_Prod_Class_Description
	,CAST(i.ItemCreationDate AS Date) AS Item_Create_Date


FROM
	BRS_Item AS i

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON i.MinorProductClass = cat.MinorProductClass
WHERE        
	i.Item > '0' AND
--	[CorporateMarketAdjustmentPct] = 0 AND
--	i.[ItemKey] = 155418 AND
--	(p.[eps_track_ind] = 1) AND
--	(i.SalesCategory <> 'PARTS') AND
	(1=1)



/*

SELECT
	TOP (10) 
	i.ItemKey, 
	t.FreeGoodsInvoicedInd, 
	2018 as fiscal_year,
	SUM(t.ShippedQty) AS ShippedQty, 
	SUM(t.NetSalesAmt) AS SalesAmt, 
	SUM(t.GPAtFileCostAmt) AS GPAtFileCostAmt, 
	SUM(t.GPAtCommCostAmt) AS GPAtCommCostAmt, 
	SUM(t.ExtChargebackAmt) AS ExtChargebackAmt,
	MIN([ID])	as id_min
FROM            
	BRS_TransactionDW AS t 

	INNER JOIN BRS_Item AS i 
	ON t.Item = i.Item
WHERE        
	(t.Date BETWEEN CONVERT(DATETIME, '2017-12-31 00:00:00', 102) AND CONVERT(DATETIME, '2018-12-01 00:00:00', 102))
GROUP BY 
	i.ItemKey, 
	t.FreeGoodsInvoicedInd

*/
