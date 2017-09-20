
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Item]
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
**	Date: 14 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	10 Jul 17	tmc		updated ABC group
**	02 Aug 17	tmc		added Brand
**	14 Sep 17	tmc		Simplified model
**    
*******************************************************************************/

SELECT         

	i.ItemKey						AS ItemKey
	,i.ItemDescription + ' | ' + i.Item	AS Item

	,RTRIM(sc.SalesCategoryName) + ' | ' + sc.SalesCategory	AS SalesCategory
	,mpc.MPC_Category				AS Abc_MpcItem
	,cr.category_rollup_desc 		AS CategoryRollup
	,mpc.MajorProductClassDesc	+ ' | ' + c.major_cd	AS Major
	,c.submajor_desc			+ ' | ' + c.submajor_cd	AS SubMajor	
	,c.minor_desc				+ ' | ' + c.MinorProductClass AS Minor

	,RTRIM(s.Supplier) + ' | ' + s.supplier_nm	AS Supplier
	,s.Supplier_Category			AS Abc_SupplierItem
	,RTRIM(sf.SupplierFamily) + ' | ' + sf.supplier_family_nm	AS SupplierFamily
	,sf.buying_group_cd				AS BuyingGroup
	,sf.classificiation_cd			AS VendorClassification
	
	,ifs.ItemDescription + ' | ' + i.FamilySetLeader	AS FamilySet
	,i.Item							AS ItemCode
	,i.ItemStatus					
	,i.Brand
	,i.Label
	,i.GLCategory					AS StockingCode
	,mpc.CategoryManager			AS CategorySpecialist

	,s.Supplier						AS Current_SupplierCode
	,ISNULL(b.Currency, '')			AS Current_CurrencyCode
	,ISNULL(b.SupplierCost,0)		AS Current_SupplierCost
	,ISNULL(b.FX_per_CAD_mrk_rt,0)	AS Current_FxMarketing
	,ISNULL(b.FX_per_CAD_pnl_rt,0)	AS Current_FxFinance
	,ISNULL(i.FreightAdjPct,0)		As Current_FreightFactor
	,ISNULL(b.CorporatePrice, 0)	AS Current_BasePrice

	,icomp.ItemKey					AS CompetitiveMatchKey

	,(sf.SupplierFamily)			AS SupplierFamilyCode
	,(sc.SalesCategory)				AS SalesCategoryCode
	,(cr.CategoryRollup)			AS CategoryRollupCode

FROM            
	BRS_Item AS i 

	INNER JOIN BRS_ItemSupplier AS s 
	ON i.Supplier = s.Supplier 

	INNER JOIN BRS_ItemSupplierFamily AS sf 
	ON s.SupplierFamily = sf.SupplierFamily

	INNER JOIN BRS_ItemCategory AS c 
	ON i.MinorProductClass = c.MinorProductClass 


	INNER JOIN [BRS_ItemCategoryRollup] as cr
	ON c.CategoryRollup = cr.CategoryRollup 


	INNER JOIN BRS_ItemSalesCategory AS sc 
	ON i.SalesCategory = sc.SalesCategory 

	INNER JOIN BRS_ItemMPC AS mpc 
	ON i.MajorProductClass = mpc.MajorProductClass 

	INNER JOIN BRS_Item AS icomp 
	ON i.Item_Competitive_Match = icomp.Item

	INNER JOIN BRS_Item AS ifs
	ON i.FamilySetLeader = ifs.Item

	LEFT OUTER JOIN BRS_ItemBaseHistory AS b 
	ON b.Item = i.Item AND b.CalMonth = 0

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Item
-- SELECT Count(*) FROM Dimension.Item

-- SELECT * FROM Dimension.Item where Current_FxMarketing = -1

-- integrity check
-- SELECT * FROM BRS_Item WHERE NOT EXISTS (SELECT * FROM Dimension.Item WHERE ItemCode = BRS_Item.Item)
