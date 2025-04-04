
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Item]
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc: Item Current
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
--	27 Feb 20	tmc		add additional flags for Private Label analysis
--	03 Mar 20	tmc		add current FileCost & base
--	02 Jun 20	tmc		remove customgroup 1 - 3.  not needed.  
--	08 Oct 20	tmc		Add CategoryRollupPPE for covid analysis
--	23 Mar 21	tmc		Add MELP_code for Cost to Serve project, top 30 Vendor
--	05 Jul 21	tmc		Add Minor to help with 3M marketshare modelling
--	09 Jul 21	tmc		Add Brand Equity data (prior month to current)
--	21 Jul 21	tmc		Add Merch Key vendor category for playbook
--	17 Aug 21	tmc		Add Top15 User version
--	19 Aug 21	tmc		Add comm_group_legacy_cd to help with change analysis
--	29 Sep 21	tmc		Add FamilySet code for analysis
--	25 Oct 21	tmc		Add Rebate Exclude for analysis
--	21 Nov 21	tmc		Add 2 model params for thrive analysis
--	21 Feb 22	tmc		Add globl product for EQ bonus model
--	01 Jun 22	tmc		Add price change fields to track GP uplift
--  06 Jul 22	tmc		Add more price change fields to track GP uplift
--	07 Jul 22	tmc		Add Comm bonus flags
--	19 Jul 22	tmc		Add rebate vpa exclude codes
--  30 Jan 23	tmc		move comm_bonus to item for more control
--	01 Feb 24	tmc		add EPS comm for EPS trakcing and FSC bonus 
--	14 Aug 24	tmc		add glove unit conversion for PPE growth tracking
--	06 Dec 24	tmc		temp remove supplier cost info for speedup
--  16 Dec 24	tmc		patch the above fix, BusSol using (should not be...)
--	14 Jan 25	tmc		add marketing Tags for QuoteTracker
--	31 Jan 25	tmc		add rollup_hsb_code for US PPE HSB tracking
--	05 Mar 25	tmc		add hsb brand equity for fin planning
--	10 Mar 25	tmc		add global item current so we can compare hsb_brand curr
**    
*******************************************************************************/

SELECT         

	i.ItemKey							AS ItemKey
	,RTRIM(i.ItemDescription) + ' ' + RTRIM(i.strength) + ' ' + RTRIM(i.size) + ' | ' + RTRIM(i.Item)	AS Item

	,RTRIM(sc.SalesCategoryName)		AS SalesCategory
	,RTRIM(sc2.SalesCategoryName)		AS SalesCategoryRollup
	,RTRIM(mpc.MPC_Category)			AS Abc_MpcItem
	,RTRIM(cr.[CategoryRollup])
		+ ' | '
		+ RTRIM(cr.category_rollup_desc) 	AS CategoryRollup

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
/*
	-- temp remove due to bad speed: 27m -> 17s
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
*/
	,'zNA'								AS Current_CurrencyCode
	,i.[CurrentFileCost]				AS Current_SupplierCost
	,NULL								AS Current_FxMarketing
	,NULL								AS Current_FxFinance
	,i.FreightAdjPct					As Current_FreightFactor
	,i.CurrentCorporatePrice			AS Current_BasePrice
 	,NULL 								AS Current_LandedCostMrk
	,NULL 								AS Current_PriceGM
--
	,icomp.ItemKey						AS CompetitiveMatchKey
	,i.[Item_Competitive_Conversion_rt]

	,(sf.SupplierFamily)				AS SupplierFamilyCode
	,(sc.SalesCategory)					AS SalesCategoryCode
	,(cr.CategoryRollup)				AS CategoryRollupCode
	,(cr.CategoryClass_Rollup)			AS CategoryClassRollupCode
	,i.comm_group_cd					AS CommGroupCode
	,i.comm_note_txt					AS CommGroupNote
	,i.comm_group_cps_cd				AS CommGroupCpsCode
	,'P'+RTRIM(c.major_cd)					AS MajorCode
	,RTRIM(cr.ClassGroup)				AS ClassGroup	
	,i.size_factor
	,RTRIM(sc_dash.SalesCategoryName)	AS SalesCategoryScorecard
	,mpc.PrivateLabelScopeInd
	,RTRIM(ISNULL(wcs.QV$CLC_classification_code,''))	AS ClassificationCode

	,0									AS PrivateLabelScope_Item
	,i.CurrentFileCost
	,i.[CurrentCorporatePrice]
	,CASE WHEN c.CategoryRollupPPE <> '' THEN c.CategoryRollupPPE ELSE 'NON_PPE' END as ppe_code

	,s.CountryGroup						AS SupplierGlobal
	,s.MELP_code

	,RTRIM(c.MinorProductClass)			AS MinorCode

	-- equity graft on last month results, Branded default should have minor sales
	,ISNULL(equity.BrandEquityCategory, 'Branded')			AS BrandEquityCategory
	,ISNULL(equity.Excl_Code, 'BRANDED') 					AS BrandEquityCode

--	21 Jul 21	tmc		Add Merch Key vendor category for playbook
	,CASE 
		WHEN 
			c.MinorProductClass like '004-01%' OR 
			c.MinorProductClass like '004-04%' OR 
			c.MinorProductClass like '012-45%' OR 
			c.MinorProductClass = '003-01-10' 
		THEN 1
		ELSE 0
	END									AS KeySupplierMerchInd
	,i.comm_group_eps_cd				AS CommGroupEpsCode
	,mpc.top15_desc
	,i.comm_group_legacy_cd

	,i.FamilySetLeader				AS FamilySetCode
	,mpc.rebate_exclude_ind				AS RebateExcludeInd
	,CASE WHEN i.adhoc_model_code <> '' THEN i.adhoc_model_code ELSE 'Other' END adhoc_model_code
	,CASE WHEN i.adhoc_model_code2 <> '' THEN i.adhoc_model_code2 ELSE 'Other' END adhoc_model_code2
	,CASE WHEN i.adhoc_model_code3 <> '' THEN i.adhoc_model_code3 ELSE 'Other' END adhoc_model_code3
	,CASE WHEN i.adhoc_model_code4 <> '' THEN i.adhoc_model_code4 ELSE 'Other' END adhoc_model_code4
	,CASE WHEN i.adhoc_model_code5 <> '' THEN i.adhoc_model_code5 ELSE 'Other' END adhoc_model_code5

	,i.pchg_active_ind 
	,i.pchg_active_dt
	,i.pchg_price_old
	,i.pchg_price_new
	,i.pchg_note
	,i.pchg_brand_equiv
	,CASE WHEN i.pchg_adhoc_model_code1 <> '' THEN i.pchg_adhoc_model_code1 ELSE 'zOther' END pchg_adhoc_model_code1
	,CASE WHEN i.pchg_adhoc_model_code2 <> '' THEN i.pchg_adhoc_model_code2 ELSE 'zOther' END pchg_adhoc_model_code2
	,mpc.pchg_mpc_active_ind

	,CASE WHEN i.comm_bonus1_cd <> '' THEN i.comm_bonus1_cd ELSE 'zOther' END AS comm_bonus1_cd
	,'zObs'	 AS  mpc_comm_bonus1_cd

	,CASE WHEN i.comm_bonus2_cd <> '' THEN i.comm_bonus2_cd ELSE 'zOther' END AS comm_bonus2_cd
	,'zObs'		 AS  mpc_comm_bonus2_cd

	,CASE WHEN i.comm_bonus3_cd <> '' THEN i.comm_bonus3_cd ELSE 'zOther' END AS comm_bonus3_cd
	,'zObs'		 AS  mpc_comm_bonus3_cd

	,CASE WHEN c.minor_adhoc_model_code1 <> '' THEN c.minor_adhoc_model_code1 ELSE 'zOther' END AS minor_adhoc_model_code1
	,CASE WHEN c.minor_adhoc_model_code2 <> '' THEN c.minor_adhoc_model_code2 ELSE 'zOther' END AS minor_adhoc_model_code2
	,i.comm_group_eps_cd

	,ISNULL(i.size_unit_rate, 0) AS size_unit_rate
	,ISNULL(i.size_unit_rate_note, '') AS size_unit_rate_note

	,ISNULL(ext.[tag_01_cd], '') as tag_01_cd
	,ISNULL(ext.[tag_02_cd], '') as tag_02_cd
	,ISNULL(ext.[tag_03_cd], '') as tag_03_cd
	,ISNULL(ext.[tag_04_cd], '') as tag_04_cd
	,ISNULL(ext.[tag_05_cd], '') as tag_05_cd

-- globl groups xxx

,ISNULL(glob.global_product_class,'')					as glob_prod_curr_class
,ISNULL( glob.level_num, 0)								as glob_prod_curr_level
,ISNULL( glob.counting_sku_ind, 0)						as glob_prod_curr_counting_sku_ind
,ISNULL(SUBSTRING(glob.global_product_class,1,3),'')	as glob_prod_curr_class3
,ISNULL(SUBSTRING(glob.global_product_class,1,6),'')	as glob_prod_curr_class6
,ISNULL(SUBSTRING(glob.global_product_class,1,9),'')	as glob_prod_curr_class9
,rtrim(glob.global_product_class) + ' | ' 
	+ glob.global_product_class_descr					as glob_prod_curr_descr

,ISNULL(glob.rollup_hsb_code, '')						AS glob_prod_curr_rollup_hsb_code

-- add for comm model (remove), 31 Mar 25
,rtrim(glob.global_product_class) + ' | ' 
	+ glob.global_product_class_descr					as global_product


--


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

	LEFT JOIN [Pricing].[item_family_marketing_ext] AS ext
	ON i.FamilySetLeader = ext.[FamilySetLeader]


	INNER JOIN [comm].[group] commgrp
	ON i.comm_group_cd = commgrp.comm_group_cd
/*
	-- temp remove for pref reasons, 6 Dec 24
	LEFT OUTER JOIN BRS_ItemBaseHistory AS b 
	ON b.Item = i.Item AND b.CalMonth = 0
*/

	LEFT JOIN BRS_ItemSupplier AS sbrand 
	ON i.brand = sbrand.Supplier 

	LEFT JOIN [Pricing].[item_wcs_unique_fields_file_F5656] wcs
	ON i.Item =wcs.QVLITM_item_number

	LEFT JOIN [hfm].[global_product] glob
	ON c.global_product_class = glob.global_product_class

	LEFT JOIN [hfm].[exclusive_product_rule_item] equity
	ON i.Item = equity.Item

/*
	-- equity graft on last month results (bad design, use history dim)
	LEFT JOIN 
	(
		SELECT [Item]
			,excl.BrandEquityCategory
			,excl.Excl_Code

		FROM [dbo].[BRS_ItemHistory] ih
			INNER JOIN [hfm].[exclusive_product] excl
			ON ih.Excl_key = excl.Excl_Key
		WHERE 
			FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])
	) equity
	ON i.Item = equity.Item
*/

WHERE
-- test case
--	i.[ItemKey]in (83572, 104862, 108067, 4128, 4250, 180220, 4128, 4250, 4128, 4250) AND
	(1=1)




GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Item where item like '100%' or rollup_hsb_code <>''

-- SELECT top 10 * FROM Dimension.Item where itemcode = '1000179'

/*
select * from [dbo].[BRS_Item] i 
where not exists (select * from Dimension.Item d where d.itemCode = i.item)

where i.item = '1127015'
*/

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

-- SELECT top 10 * FROM Dimension.Item where item like '100%'
 -- SELECT count(*) FROM Dimension.Item where CompetitiveMatchKey > 1
-- ORG 252 122
-- prd = 9933
-- dev = 9434

/*
-- finance vs opts vs comm consistency check
SELECT        CommGroupEpsCode, BrandEquityCategory, BrandEquityCode, ppe_code, Label, COUNT(*) AS Expr1
FROM            Dimension.Item
GROUP BY CommGroupEpsCode, BrandEquityCategory, BrandEquityCode, ppe_code, Label
*/

-- SELECT * FROM Dimension.Item where itemKey  = '14249' 
-- SELECT * FROM Dimension.Item where item = '9493402'

-- SELECT top 10 * FROM Dimension.Item where pchg_active_ind = 1
-- SELECT top 10 * FROM Dimension.Item where pchg_mpc_active_ind = 1

