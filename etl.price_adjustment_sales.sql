
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
	i.IMITM__item_number_short	AS item_number_short
	-- NOTE Ai:  Group Class Contract and Market enrollment to Price method, not BT
	,CASE WHEN sub.ADAN8__billto IS NULL THEN 0 ELSE c.BillTo END AS BillTo

	,MIN(ii.SalesCategory)		AS SalesCategory
	,t.PriceMethod
	,CASE 
		WHEN t.PriceMethod = 'P' 
		THEN t.PromotionCode 
		ELSE '' 
	END							AS PromotionCodeActive
	,SUM(t.ShippedQty)			AS ShippedQty
	,SUM(t.NetSalesAmt)			AS NetSalesAmt
	,SUM(GPAtFileCostAmt)		AS GPAtFileCostAmt
	,SUM(ExtChargebackAmt)		AS ExtChargebackAmt
FROM            
	BRS_Customer AS c 

	INNER JOIN BRS_TransactionDW AS t 
	ON c.ShipTo = t.Shipto 

	INNER JOIN etl.F4101_item_master AS i 
	ON t.Item = i.IMLITM_item_number

	INNER JOIN BRS_Item AS ii 
	ON i.IMLITM_item_number = ii.Item

	-- NOTE Aii:  identify Billto specific accounts so that 
	-- Class Contract and Market Adjustment can be consolidated
	LEFT JOIN (
		SELECT DISTINCT       
			ADAN8__billto	
		FROM            
			etl.F4072_price_adjustment_detail p

			INNER JOIN etl.F4071_price_adjustment_name n
			ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

		WHERE
			-- C means Customer Contract OR Special Price
			n.ATPRFR_preference_type IN ('C') AND

			ADAN8__billto > 0 AND
			-- 5 means pricing set, not % rate
			p.ADBSCD_basis = 5 AND
			(1=1)
	) sub
	ON c.BillTo = sub.ADAN8__billto



WHERE        
	-- remove Equipment orders as they do not use Advanced Pricing
	(NOT (t.OrderSourceCode IN ('A', 'L'))) AND 
	EXISTS (SELECT * FROM etl.price_adjustment_customer where billto = c.Billto) AND

	-- TODO make this dynamic with function
	(t.CalMonth BETWEEN 201508 AND 201702 )

GROUP BY 
	i.IMITM__item_number_short
	,CASE WHEN sub.ADAN8__billto IS NULL THEN 0 ELSE c.BillTo END
	,t.PriceMethod
	-- since we are using Marketing program to link sales, 
	-- ONLY show Marketing program if being used as a promo
	,CASE WHEN t.PriceMethod = 'P' THEN t.PromotionCode ELSE '' END
	
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM etl.price_adjustment_sales

