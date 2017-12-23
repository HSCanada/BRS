
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_MK_Scorecard_Category]
AS

/******************************************************************************
**	File: 
**	Name: BRS_MK_Scorecard_Category
**	Desc:  
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 16 Feb 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT     
	icr.CategoryRollup, 
	MIN(icr.category_rollup_desc) AS category_rollup_desc, 
	MIN(mpc.CategoryManager) AS CategoryManager, 
	MIN(icr.CategoryClass_Rollup) AS CategoryClass_Rollup, 
	MIN(icr.MajorProductClassPrimary) AS MajorProductClassPrimary, 
	COUNT(i.Item) AS SkuCount
FROM         

	BRS_ItemCategoryRollup AS icr 

	INNER JOIN BRS_ItemCategory AS ic 
	ON icr.CategoryRollup = ic.CategoryRollup 

	INNER JOIN BRS_Item AS i 
	ON ic.MinorProductClass = i.MinorProductClass 

	INNER JOIN BRS_ItemMPC AS mpc 
	ON icr.MajorProductClassPrimary = mpc.MajorProductClass

WHERE     
	(i.ItemStatus <> 'P')
GROUP BY 
	icr.CategoryRollup

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_MK_Scorecard_Category
