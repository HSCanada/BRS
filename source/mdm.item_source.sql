﻿
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [mdm].item_source
AS

/******************************************************************************
**	File: 
**	Name: item_source
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
	Item							AS item_code
	,RTRIM(ItemDescription)
	+ ' '  
	+ RTRIM(Strength)				AS description_strength
	,RTRIM(Size)					AS size
	,RTRIM(mpc.MajorProductClass)	AS mpc_code
	,RTRIM(mpc.MajorProductClassDesc)			AS mpcs_description

	,RTRIM(i.[Supplier])				AS supplier
	,RTRIM(sup.CountryGroup)		AS supplier_global
	,ManufPartNumber				AS manuf_part_number
	,CAST(i.ItemCreationDate AS Date) AS item_create_date
	,i.StockingType					AS stocking_type
	,i.CurrentFileCost				AS current_file_cost
	,i.CurrentCorporatePrice		AS current_price


FROM
	BRS_Item AS i

	INNER JOIN [dbo].[BRS_ItemMPC] mpc
	ON i.MajorProductClass = mpc.MajorProductClass

	INNER JOIN [dbo].[BRS_ItemSupplier] sup
	ON i.Supplier = sup.Supplier



WHERE  
	(i.ItemStatus <> 'P') AND      
	(mpc.[mdm_match_ind] = 1) AND
	-- do not re-match codes
	(i.item_usd is null) AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM mdm.item_source

