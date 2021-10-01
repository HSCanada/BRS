
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [msg].[Item]
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc:  based on dimension.item
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
**	Date: 28 Jul 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	17 Aug 21	tmc		Add top15 and eps commission code
**    
*******************************************************************************/

SELECT         

	RTRIM(i.Item)						AS ITEM_NUMBER
	,RTRIM(c.submajor_cd)				AS SUB_MAJOR_CLASS_ID
	,'.'								AS Product_Type
	,RTRIM(s.Supplier)					AS SUPPLIER_CODE
	,'.'								AS Tier
	,RTRIM(c.major_cd)					AS MAJOR_PROD_CLASS_ID
	,RTRIM(c.MinorProductClass)			AS MINOR_CLASS_ID
	,i.Brand							AS Manufacturer
	,i.[ItemDescription]				AS ITEM_DESCRIPTION
	,RTRIM(i.[Size])					AS STRENGTH
	,RTRIM(i.[Strength])				AS SIZE
	,RTRIM(i.Brand)						AS BrandCode
	,i.ItemKey
	,s.supplier_nm						AS SUPPLIER
	,wcs.QV$CLC_classification_code		AS CLASSIFICATION
	,RTRIM(ISNULL(wcs.QV$CLC_classification_code,''))	AS ClassificationCode
	,RTRIM(mpc.MajorProductClassDesc)	AS MAJOR_PROD_CLASS
	,RTRIM(c.submajor_desc)				AS SUB_MAJOR_CLASS	
	,RTRIM(c.minor_desc)				AS MINOR_CLASS
	,'.'								AS SUB_MINOR_CLASS_ID
	,'.'								AS SUB_MINOR_CLASS
	,RTRIM(i.ItemStatus)				AS ItemStatus
	,RTRIM(i.Label)						AS Label
	,RTRIM(i.GLCategory)				AS StockingCode
	,(i.SalesCategory)					AS SalesCategoryCode
	,CASE WHEN c.CategoryRollupPPE <> '' THEN c.CategoryRollupPPE ELSE 'NON_PPE' END as ppe_code
	,s.CountryGroup						AS SupplierGlobal
	-- equity graft on last month results, Branded default should have minor sales
	,ISNULL(equity.BrandEquityCategory, 'Branded')			AS BrandEquityCategory
	,ISNULL(equity.Excl_Code, 'BRANDED') 					AS BrandEquityCode
	,i.comm_group_eps_cd
	,mpc.top15_desc

FROM            
	BRS_Item AS i 

	INNER JOIN BRS_ItemSupplier AS s 
	ON i.Supplier = s.Supplier 

	LEFT JOIN [Pricing].[item_wcs_unique_fields_file_F5656] wcs
	ON i.Item =wcs.QVLITM_item_number

	INNER JOIN BRS_ItemCategory AS c 
	ON i.MinorProductClass = c.MinorProductClass 

	INNER JOIN BRS_ItemMPC AS mpc 
	ON i.MajorProductClass = mpc.MajorProductClass 

	-- equity graft on last month results
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


WHERE
	BrandEquityCategory in('CorporateBrand', 'Exclusive', 'Owned') AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*
-- finance vs opts vs comm consistency check
SELECT        CommGroupEpsCode, BrandEquityCategory, BrandEquityCode, ppe_code, Label, COUNT(*) AS Expr1
FROM            Dimension.Item
GROUP BY CommGroupEpsCode, BrandEquityCategory, BrandEquityCode, ppe_code, Label
*/

--select top 10 * from msg.item where ITEM_NUMBER in('1900426', '9393754')

-- select  * from msg.item 	where SalesCategoryCode not in('MERCH','SMEQU','TEETH') order by SalesCategoryCode

-- export
-- camsg_Item_20210806.txt
-- select  * from msg.item 	

