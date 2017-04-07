
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW etl.price_adjustment_item
AS

/******************************************************************************
**	File: 
**	Name: etl.price_adjustment_item
**	Desc:  
**
**              
**	Return values:  
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 27 Mar 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/


SELECT        
	i.item
	,FamilySetLeader
	,IMITM__item_number_short AS item_number_short
	,ItemDescription
	,i.Supplier
	,Size
	,Strength
	,[ItemStatus]
	,[Label]
	,[ItemCreationDate]
	,[SalesCategory]
	,[MajorProductClass]
	,[SubMajorProdClass]
	,[StockingType]
	,[CurrentCorporatePrice]
	,[CurrentFileCost]
	,[FreightAdjPct]
	,[SupplierCost]
	,[Currency]
	,FX_per_CAD_pnl_rt		
	,FX_per_CAD_mrk_rt		


FROM            
	BRS_Item as i

	INNER JOIN etl.F4101_item_master AS ii
	ON i.Item = ii.IMLITM_item_number 

	LEFT JOIN BRS_ItemBaseHistory AS b
	ON [CalMonth] = 0 AND
		b.[Item] = i.Item


WHERE 
	EXISTS (SELECT * FROM etl.price_adjustment_detail where item_number_short = ii.IMITM__item_number_short) AND
	1=1


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM etl.price_adjustment_item