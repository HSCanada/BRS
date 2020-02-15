
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
--  18 Jul 18	tmc		add MPC code and removed CategoryRollup_L1 (need?)
--  27 Sep 18	tmc		update for business review requirements
--  06 Feb 19	tmc		add ClassGroup for PCW project
--	15 Feb 19	tmc		add size_factor
--  12 Jul 19	tmc		add  PrivateLabelScopeInd for FSC scorecard corp %
--	15 Dec 19	tmc		add size & strenge to descr and size ind for returns
**    
*******************************************************************************/

SELECT         

	i.ItemKey							AS ItemKey
	,RTRIM(i.ItemDescription) + ' ' + RTRIM(i.strength) + ' ' + RTRIM(i.size) + ' | ' + RTRIM(i.Item)	AS Item

	,RTRIM(sc.SalesCategoryName)		AS SalesCategory
	,RTRIM(sc2.SalesCategoryName)		AS SalesCategoryRollup
	,RTRIM(mpc.MPC_Category)			AS Abc_MpcItem
	,RTRIM(cr.category_rollup_desc) 	AS CategoryRollup

	,CASE
		WHEN cr.top15_ind = 1
		THEN RTRIM(cr.category_rollup_desc) + ' - ' + FORMAT( cr.[CategorySharePercent],'P1')
		ELSE 'Other'
	END									AS Top15
	,RTRIM(c.major_cd) + ' | ' 
		+ RTRIM(mpc.MajorProductClassDesc) AS Major
	,RTRIM(c.submajor_cd) + ' | ' 
		+ RTRIM(c.submajor_desc)		AS SubMajor	
	,RTRIM(c.MinorProductClass) + ' | ' 
		+ RTRIM(c.minor_desc)			AS Minor

	,s.supplier_nm + ' | ' 
		+ RTRIM(s.Supplier)				AS Supplier
	,s.Supplier_Category				AS Abc_SupplierItem
	,sf.supplier_family_nm + ' | ' 
		+ RTRIM(sf.SupplierFamily)		AS SupplierFamily
	,sf.buying_group_cd					AS BuyingGroup
	,sf.classificiation_cd				AS VendorClassification
	
	,ifs.ItemDescription + ' | ' 
		+ i.FamilySetLeader				AS FamilySet
	,i.Item								AS ItemCode
	,RTRIM(i.[Size])					AS Size
	,RTRIM(i.[Strength])				AS Strength
	,CASE WHEN i.[Strength] = '' then 0 else 1 end as StrengthInd
	,RTRIM(i.ItemStatus)				AS ItemStatus
	,RTRIM(i.[ManufPartNumber])			AS ManufPartNumber
	,RTRIM(i.Brand)						AS BrandCode
	,RTRIM(sbrand.supplier_nm)			AS Brand
	,RTRIM(i.Label)						AS Label
	,RTRIM(i.GLCategory)				AS StockingCode
	,RTRIM(mpc.CategoryManager)			AS CategorySpecialist

	,RTRIM(s.Supplier)					AS Current_SupplierCode
	,RTRIM(ISNULL(b.Currency, ''))		AS Current_CurrencyCode
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
	,i.[Item_Competitive_Conversion_rt]

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
	,RTRIM(c.major_cd)					AS MajorCode
	,RTRIM(cr.ClassGroup)				AS ClassGroup	
	,i.size_factor
	,RTRIM(sc_dash.SalesCategoryName)	AS SalesCategoryScorecard
	,mpc.PrivateLabelScopeInd
	,RTRIM(ISNULL(wcs.QV$CLC_classification_code,''))	AS ClassificationCode



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

--	INNER JOIN [BRS_ItemCategoryRollup] as cr_isr
--	ON cr.[CategoryRollup_L1] = cr_isr.CategoryRollup 

	INNER JOIN BRS_ItemSalesCategory AS sc 
	ON i.SalesCategory = sc.SalesCategory 

	INNER JOIN BRS_ItemSalesCategory AS sc2 
	ON sc.SalesCategoryRollup = sc2.SalesCategory 

	INNER JOIN BRS_ItemSalesCategory AS sc_dash 
	ON sc.SalesCategoryScorecard = sc_dash.SalesCategory 

	INNER JOIN BRS_ItemMPC AS mpc 
	ON i.MajorProductClass = mpc.MajorProductClass 

	INNER JOIN BRS_Item AS icomp 
	ON i.Item_Competitive_Match = icomp.Item

	INNER JOIN BRS_Item AS ifs
	ON i.FamilySetLeader = ifs.Item

	LEFT OUTER JOIN BRS_ItemBaseHistory AS b 
	ON b.Item = i.Item AND b.CalMonth = 0

	LEFT JOIN BRS_ItemSupplier AS sbrand 
	ON i.brand = sbrand.Supplier 

	LEFT JOIN [Pricing].[item_wcs_unique_fields_file_F5656] wcs
	ON i.Item =wcs.QVLITM_item_number

WHERE
-- test case
--	i.[ItemKey]in (83572, 104862, 108067, 4128, 4250, 180220, 4128, 4250, 4128, 4250) AND
	(1=1)




GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- SELECT * FROM Dimension.Item where Current_FxMarketing = -1

-- integrity check
-- SELECT * FROM BRS_Item WHERE NOT EXISTS (SELECT * FROM Dimension.Item WHERE ItemCode = BRS_Item.Item)

-- select SalesCategoryName, LEFT(SalesCategoryName, LEN(SalesCategoryName)-2), SalesCategory from BRS_ItemSalesCategory WHERE SalesCategory <> ''

/*

select SalesCategoryName, SalesCategory from BRS_ItemSalesCategory WHERE SalesCategory <> ''

update 
BRS_ItemSalesCategory
set SalesCategoryName = LEFT(SalesCategoryName, LEN(SalesCategoryName)-2)
WHERE SalesCategory <> ''
*/

-- SELECT top 10 * FROM Dimension.Item where ManufPartNumber = '' 
-- SELECT ManufPartNumber, count(*) FROM Dimension.Item group by (ManufPartNumber) order by 2 desc


