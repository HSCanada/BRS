
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  VIEW [mdm].item_reference
AS

/******************************************************************************
**	File: 
**	Name: item_reference
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
**	Date: 26 May 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

-- active cust only
-- item
-- 
SELECT
	Item							AS item_code_usd
	,RTRIM(ItemDescription)			
	+ ' '  
	+ RTRIM(Strength)				AS description_strength_usd
	,RTRIM(Size)					AS size_usd
	,RTRIM(mpc.MajorProductClass)	AS mpc_code_usd
	,RTRIM(mpc.MajorProductClassDesc)			AS mpcs_description_usd

	,RTRIM(i.[Supplier])				AS supplier_usd
	,RTRIM(sup.CountryGroup)		AS supplier_global_usd
	,ManufPartNumber				AS manuf_part_number_usd
	,CAST(i.ItemCreationDate AS Date) AS item_create_date_usd
	,i.StockingType					AS stocking_type_usd
	,i.CurrentFileCost				AS current_file_cost_usd
	,i.CurrentCorporatePrice		AS current_price_usd

	,i.SalesCategory


FROM
	usd.BRS_Item AS i

	INNER JOIN [dbo].[BRS_ItemMPC] mpc
	ON i.MajorProductClass = mpc.MajorProductClass

	
	INNER JOIN [usd].[BRS_ItemSupplier] sup
	ON i.Supplier = sup.Supplier




WHERE  
	i.ItemStatus <> 'P' AND
	(mpc.[mdm_match_usd_ind] = 1) AND
	-- MSDS sheets NOT in MPC 904
--	(i.Item NOT LIKE '105%') AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM mdm.item_reference
-- SELECT  * FROM mdm.item_reference a

