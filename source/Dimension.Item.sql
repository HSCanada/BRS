
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
--	20 Sep 17	tmc		add GM 
--	07 Dec 17	tmc		add Commission info
--	27 Feb 18	tmc		add sized & strength for ISR consolidator
**    
*******************************************************************************/

SELECT         

	i.ItemKey							AS ItemKey
	,i.ItemDescription + ' | ' + i.Item	AS Item

	,RTRIM(sc.SalesCategoryName) + ' | ' 
		+ sc.SalesCategory				AS SalesCategory
	,mpc.MPC_Category					AS Abc_MpcItem
	,cr.category_rollup_desc 			AS CategoryRollup
	,mpc.MajorProductClassDesc	+ ' | ' 
		+ c.major_cd					AS Major
	,c.submajor_desc			+ ' | ' 
		+ c.submajor_cd					AS SubMajor	
	,c.minor_desc				+ ' | ' 
		+ c.MinorProductClass			AS Minor

	,RTRIM(s.Supplier) + ' | ' 
		+ s.supplier_nm					AS Supplier
	,s.Supplier_Category				AS Abc_SupplierItem
	,RTRIM(sf.SupplierFamily) + ' | ' 
		+ sf.supplier_family_nm			AS SupplierFamily
	,sf.buying_group_cd					AS BuyingGroup
	,sf.classificiation_cd				AS VendorClassification
	
	,ifs.ItemDescription + ' | ' 
		+ i.FamilySetLeader				AS FamilySet
	,i.Item								AS ItemCode
	,i.[Size]
	,i.[Strength]
	,i.ItemStatus
	,i.[ManufPartNumber]
	,i.Brand
	,i.Label
	,i.GLCategory						AS StockingCode
	,mpc.CategoryManager				AS CategorySpecialist

	,s.Supplier							AS Current_SupplierCode
	,ISNULL(b.Currency, '')				AS Current_CurrencyCode
	,ISNULL(b.SupplierCost,0)			AS Current_SupplierCost
	,ISNULL(b.FX_per_CAD_mrk_rt,0)		AS Current_FxMarketing
	,ISNULL(b.FX_per_CAD_pnl_rt,0)		AS Current_FxFinance
	,ISNULL(i.FreightAdjPct,0)			As Current_FreightFactor
	,ISNULL(b.CorporatePrice, 0)		AS Current_BasePrice

 	,(ISNULL(b.SupplierCost,0) 
		* ISNULL(b.FX_per_CAD_mrk_rt,0) 
		* ISNULL(i.FreightAdjPct,0))	AS Current_LandedCostMrk
	,CASE 
		WHEN ISNULL(b.CorporatePrice, 0) > 0 
		THEN 1-(ISNULL(b.SupplierCost,0) 
			* ISNULL(b.FX_per_CAD_mrk_rt,0) 
			* ISNULL(i.FreightAdjPct,0))
			/ISNULL(b.CorporatePrice, 0)
		ELSE 0
	END 								AS Current_PriceGM

	,icomp.ItemKey						AS CompetitiveMatchKey

	,(sf.SupplierFamily)				AS SupplierFamilyCode
	,(sc.SalesCategory)					AS SalesCategoryCode
	,(cr.CategoryRollup)				AS CategoryRollupCode
	,(cr.CategoryClass_Rollup)			AS CategoryClassRollupCode
	,i.comm_group_cd					AS CommGroupCode
	,i.comm_note_txt					AS CommGroupNote
	,i.comm_group_cps_cd				AS CommGroupCpsCode
	,i.[custom_comm_group1_cd]			AS CustomCommGroup1Code
	,i.[custom_comm_group2_cd]			AS CustomCommGroup2Code
	,i.[custom_comm_group3_cd]			AS CustomCommGroup3Code

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
