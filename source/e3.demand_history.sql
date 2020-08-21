
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW e3.demand_history
AS

/******************************************************************************
**	File: 
**	Name: e3.demand_history
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
**	Date: 20 Aug 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
--	TOP (1000) 
	d.SalesDay
	,i.Item
	,d.IWHSE__warehouse_id
	,d.IDEM52_demand_forecast_weekly
	,d.PIX_seasonal_index
	,dim.IDMPRF_item_demand_profile_id
	,dim.IVNDR__vendor_id
	,dim.ISUBV__subvendor_id
	,dim.IBUYR__buyer_id

FROM
	e3.demand_E3ITEMA AS d 

	INNER JOIN e3.demand_E3ITEMA_dimension AS dim 
	ON d.demand_dim_id = dim.demand_dim_id 

	INNER JOIN BRS_Item AS i 
	ON d.ItemKey = i.ItemKey
WHERE
	i.Item > ''

GO


-- SELECT top 100 * FROM e3.demand_history

