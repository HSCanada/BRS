﻿
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
**	20 May 20	tmc		Centralize Compudent Handpiece expection here.  
**						If more, add logic to table hfm.eps_code_rule
**	13 Jun 20	tmc		add eps commission map code for synch
**  12 Aug 20	tmc		add denmat *stupid* exception 
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
	,p.[comm_group_eps_cd]



FROM
	BRS_Item AS i

--	LEFT JOIN hfm.exclusive_product_rule AS r 

	INNER JOIN hfm.exclusive_product_rule AS r 
	ON i.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		i.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		i.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		i.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		1 = 1 

	
--	LEFT JOIN hfm.exclusive_product AS p 
	INNER JOIN hfm.exclusive_product AS p 
	ON r.Excl_Code_TargKey = p.Excl_Code  


	INNER JOIN [dbo].[BRS_ItemCategory] cat
	ON i.MinorProductClass = cat.MinorProductClass
WHERE        
	(r.StatusCd = 1) AND 
	(p.[eps_track_ind] = 1) AND
	(i.SalesCategory <> 'PARTS') AND
	-- work-around to remove incorrectly coded products
	(i.Item not In ('1074153','1076903','1070511')) AND
	-- futher sub-define this line for commission to be tighter than financial
	NOT (p.[Excl_Code] = 'DENMAT' AND i.Item NOT In ('1314673','1314675','1900162','1900329','1900426','9393754')) AND
   
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT  * FROM eps.Item where Supplier = 'DENMAT'
-- SELECT  * FROM eps.Item where Supplier = 'ZYRISI'
-- SELECT  * FROM eps.Item where Supplier = 'CAO_LASER'

-- SELECT  distinct Supplier FROM eps.Item
/*
Corporate Brand (Non PPE)
Edge - EDGE_ENDO
BA - BAINTE
Reveal - REVEAL
Ortho Tech - ORTHO_TECHNOLOGIES
Lasers - DENMAT
*/

		  

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
SELECT count (*) FROM eps.Item where 
-- ORG 15 349, 34s
*/