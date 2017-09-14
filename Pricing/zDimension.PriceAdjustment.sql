
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[PriceAdjustment]
AS

/******************************************************************************
**	File: 
**	Name: PriceAdjustment
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
**	Date: 16 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	29 Aug 17	tmc		source from Stage to Pricing Production
**    
*******************************************************************************/

SELECT
	AdjustmentNameKey					AS AdjustmentKey
	,ATAST__adjustment_name				AS Adjustment
	,ATUPMJ_date_updated				AS LastUpdatedDate
	,ATUSER_user_id						AS UserId

FROM            
	Pricing.price_adjustment_name_F4071 AS n
WHERE        
	(ATPRFR_preference_type IN ('C', 'IG')) AND 
	(ATPRGR_item_price_group = '') AND 
	(ATCPGP_customer_price_group = '') AND 
	(ATSDGR_order_detail_group = '') AND 
	(ATLBT__level_break_type = 1) AND 
	(1 = 1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT  * FROM Dimension.PriceAdjustment order by 1

-- SELECT  * FROM Dimension.PriceAdjustment WHERE Adjustment = 'AMC01UBC'
