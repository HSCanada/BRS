
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [mdm].item_source_review
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
**	Date: 09 Jun 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	11 JUl 19	tmc		add US item
*******************************************************************************/

-- active cust only
-- item
-- 
SELECT
	Item							AS item_code
	,[FamilySetLeader]
	,mpc.mdm_phase	
	,mpc.mdm_level					AS mdm_level_mpc

	,CASE CHARINDEX('*', [SubMinorProductCodec])
		WHEN 0 THEN 4
		WHEN 9 THEN 3
		WHEN 8 THEN 3
		WHEN 7 THEN 2
		WHEN 6 THEN 2
		WHEN 5 THEN 1
		WHEN 4 THEN 1
		WHEN 3 THEN 0
		WHEN 2 THEN 0
		WHEN 1 THEN 0
		ELSE 0
	END mdm_level


	,RTRIM(ItemDescription)
	+ ' '  
	+ RTRIM(Strength)				AS description_strength
	,RTRIM(Size)					AS size
	,[SubMinorProductCodec]
	,RTRIM(mpc.MajorProductClass)	AS mpc_code
	,RTRIM(mpc.MajorProductClassDesc)			AS mpcs_description

	,RTRIM(i.[Supplier])				AS supplier
	,RTRIM(sup.CountryGroup)		AS supplier_global
	,ManufPartNumber				AS manuf_part_number
	,CAST(i.ItemCreationDate AS Date) AS item_create_date
	,i.StockingType					AS stocking_type
	,i.CurrentFileCost				AS current_file_cost
	,i.CurrentCorporatePrice		AS current_price
	,i.Est12MoSales
	,i.item_usd
	,i.item_usd_conversion_rt


FROM
	BRS_Item AS i

	INNER JOIN [dbo].[BRS_ItemMPC] mpc
	ON i.MajorProductClass = mpc.MajorProductClass

	INNER JOIN [dbo].[BRS_ItemSupplier] sup
	ON i.Supplier = sup.Supplier



WHERE  
	(i.ItemStatus <> 'P') AND      
	(mpc.[mdm_phase] > 0) AND
-- do not re-match codes
--	(i.item_usd is null) AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM mdm.item_source_review

