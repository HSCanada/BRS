
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
--	02 Aug 17	tmc		added Brand
**    
*******************************************************************************/

SELECT         

	i.ItemKey						AS ItemKey
	,i.ItemDescription				AS Item
	,sc.SalesCategoryName			AS SalesCategory
	,mpc.MPC_Category				AS Abc_MpcItem
	,mpc.MajorProductClassDesc		AS Major
	,c.submajor_desc				AS SubMajor	
	,c.minor_desc					AS Minor
	,i.FamilySetLeader				AS FamilySet
	,i.Item							AS ItemCode
	,i.ItemStatus					AS Status
	,i.Brand
	,i.Label
	,i.GLCategory					AS StockingCode
	,mpc.CategoryManager			AS CategorySpecialist
/*
	,ISNULL(b.Currency, '')			AS Currency
	,ISNULL(b.SupplierCost,0)		AS SupplierCost
	,ISNULL(i.FreightAdjPct,0)		As FreightFactor
	,ISNULL(b.FX_per_CAD_mrk_rt,0)	AS FxMarketing
	,ISNULL(b.FX_per_CAD_pnl_rt,0)	AS FxFinance
	,ISNULL(b.CorporatePrice, 0)	AS BasePrice
*/
	,s.SupplierKey
	,icomp.ItemKey					AS CompetitiveMatchKey
	,c.CategoryRollup

FROM            
	BRS_Item AS i 

	INNER JOIN BRS_ItemSupplier AS s 
	ON i.Supplier = s.Supplier 

	INNER JOIN BRS_ItemCategory AS c 
	ON i.MinorProductClass = c.MinorProductClass 

	INNER JOIN BRS_ItemSalesCategory AS sc 
	ON i.SalesCategory = sc.SalesCategory 

	INNER JOIN BRS_ItemMPC AS mpc 
	ON i.MajorProductClass = mpc.MajorProductClass 

	INNER JOIN BRS_Item AS icomp 
	ON i.Item_Competitive_Match = icomp.Item

	-- handle null case
/*
	LEFT OUTER JOIN BRS_ItemBaseHistory AS b 
	ON b.Item = i.Item AND b.CalMonth = 0
*/


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Item
