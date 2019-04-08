
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [eps].[Item]
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
**	Date: 28 Mar 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

-- item
-- 
SELECT
	Item							AS Item_Number
	,RTRIM(ItemDescription)			AS Item_Description
	,RTRIM(MajorProductClass)		AS Major_Product_Class
	,RTRIM(cat.major_desc)			AS Major_Product_Class_Description
	,RTRIM(i.MinorProductClass)		AS Sub_Minor_Prod_Class
	,RTRIM(cat.minor_desc)			AS Sub_Minor_Prod_Class_Description
	,RTRIM(p.[Excl_Code])			AS Supplier
	,RTRIM(P.Excl_Name)				AS Supplier_Description
	,CAST(i.ItemCreationDate AS Date) AS Item_Create_Date
	,i.ItemStatus					AS Item_Status
	,i.StockingType					AS Stocking_Type


FROM
	BRS_Item AS i

	INNER JOIN hfm.exclusive_product_rule AS r 
	ON i.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		i.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		i.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		i.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		1 = 1 
	
	INNER JOIN hfm.exclusive_product AS p 
	ON r.Excl_Code_TargKey = p.Excl_Code  

	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON i.MinorProductClass = cat.MinorProductClass
WHERE        
	(r.StatusCd = 1) AND 
	(p.[eps_track_ind] = 1) AND
	(i.SalesCategory <> 'PARTS') AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM eps.Item where Supplier = 'BAINTE'
/*
-- dup test
SELECT [Item_Number], COUNT (*) 
FROM eps.Item 
GROUP BY [Item_Number]
having COUNT (*) > 1
*/

-- eps_item.txt

/*
SET NOCOUNT ON;
SELECT * FROM eps.Item
*/