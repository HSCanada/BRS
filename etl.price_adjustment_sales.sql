
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW etl.price_adjustment_sales
AS

/******************************************************************************
**	File: 
**	Name: etl.price_adjustment_sales
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
**	Date: 26 Mar 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
	i.IMITM__item_number_short
	,c.BillTo
	,t.PriceMethod
	,CASE WHEN t.PriceMethod = 'P' THEN t.PromotionCode ELSE '' END AS pm
	,SUM(t.ShippedQty) AS ShippedQty
	,SUM(t.NetSalesAmt) AS NetSalesAmt

FROM            
	BRS_Customer AS c 
	INNER JOIN BRS_TransactionDW AS t 
	ON c.ShipTo = t.Shipto 

	INNER JOIN
	etl.F4101_item_master AS i 
	ON t.Item = i.IMLITM_item_number

	INNER JOIN zzzShipto 
	ON c.BillTo = zzzShipto.ST 

WHERE        
	(NOT (t.OrderSourceCode IN ('A', 'L'))) AND 
	(t.CalMonth BETWEEN 201408 AND 201602)
GROUP BY 
	i.IMITM__item_number_short,
	c.BillTo,
	t.PriceMethod,
	CASE WHEN t.PriceMethod = 'P' THEN t.PromotionCode ELSE '' END



GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM etl.price_adjustment_sales