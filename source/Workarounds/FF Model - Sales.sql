-- MA model - sales

SELECT top 10
	Item							AS Item_Number
,[ItemKey]
,[Supplier]
,[FamilySetLeader]
,[Label]
,[SalesCategory]
,[CurrentFileCost]
,[FreightAdjPct]
,[CorporateMarketAdjustmentPct]

	,RTRIM(ItemDescription)			AS Item_Description
	,RTRIM(MajorProductClass)		AS Major_Product_Class
	,RTRIM(cat.major_desc)			AS Major_Product_Class_Description
	,RTRIM(i.MinorProductClass)		AS Sub_Minor_Prod_Class
	,RTRIM(cat.minor_desc)			AS Sub_Minor_Prod_Class_Description
	,RTRIM(p.[Excl_Code])			AS [Excl_Code]
	,CAST(i.ItemCreationDate AS Date) AS Item_Create_Date
	,i.ItemStatus					AS Item_Status
	,i.StockingType					AS Stocking_Type


FROM
	BRS_Item AS i

	LEFT JOIN hfm.exclusive_product_rule AS r 
	ON i.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		i.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		i.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		i.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		1 = 1 
	
	LEFT JOIN hfm.exclusive_product AS p 
	ON r.Excl_Code_TargKey = p.Excl_Code  

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON i.MinorProductClass = cat.MinorProductClass
WHERE        
	i.Item > '0' AND
--	(r.StatusCd = 1) AND 
--	(p.[eps_track_ind] = 1) AND
--	(i.SalesCategory <> 'PARTS') AND
	(1=1)
