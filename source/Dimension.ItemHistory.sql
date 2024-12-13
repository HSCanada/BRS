
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[ItemHistory]
AS

/******************************************************************************
**	File: [Dimension].[ItemHistory]
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
**	Date: 06 Dec 24
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
	ih.item_hist_key

	,ih.Item								AS ItemCode
	,ih.FiscalMonth

	,ih.[Supplier]							AS SupplierCode
	,sup.supplier_nm + ' | ' 
		+ RTRIM(sup.Supplier)				AS Supplier

	,ih.[MinorProductClass]
	,RTRIM(cat.major_cd) + ' | ' 
		+ RTRIM(cat.major_desc) AS Major
	,RTRIM(cat.submajor_cd) + ' | ' 
		+ RTRIM(cat.submajor_desc)		AS SubMajor	
	,RTRIM(cat.MinorProductClass) + ' | ' 
		+ RTRIM(cat.minor_desc)			AS Minor

	,ih.label
	,lab.LabelDesc

	,ih.Excl_key
	,excl.Excl_Code
	,excl.Excl_Name
	,excl.BrandEquityCategory
	,excl.ProductCategory
	,excl.EffectivePeriod
	,excl.ExpiredPeriod
	,excl.Excl_Code_Public

FROM            
	BRS_Item AS i 

	INNER JOIN  [dbo].[BRS_ItemHistory] ih
	ON i.Item = ih.Item AND
		(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE ih.FiscalMonth = dd.FiscalMonth)) 

	INNER JOIN BRS_ItemSupplier AS sup
	ON ih.Supplier = sup.Supplier 

	INNER JOIN BRS_ItemCategory AS cat
	ON ih.MinorProductClass = cat.MinorProductClass 

	INNER JOIN [hfm].[exclusive_product] excl
	ON ih.Excl_key = excl.Excl_Key

	INNER JOIN [dbo].[BRS_ItemLabel] lab
	ON ih.Label = lab.Label

WHERE
-- test case
--	i.[ItemKey]in (83572, 104862, 108067, 4128, 4250, 180220, 4128, 4250, 4128, 4250) AND
	(1=1)




GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- integrity check
-- SELECT * FROM BRS_Item WHERE NOT EXISTS (SELECT * FROM [Dimension].[ItemHistory] WHERE ItemCode = BRS_Item.Item)

-- SELECT * FROM [Dimension].[ItemHistory] where itemCode = '7910034'


SELECT top 10 * from [Dimension].[ItemHistory]
SELECT count(*) from [Dimension].[ItemHistory]
