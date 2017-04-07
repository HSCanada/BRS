
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
	-- Class Contract and Market Program roll to adjustment not BT
	,CASE WHEN sub.billto IS NOT NULL THEN 0 ELSE c.BillTo END AS billto
	,CASE t.PriceMethod 
		WHEN 'P' THEN MIN(ISNULL(sub.adjustment_name,'')) 
		WHEN 'S' THEN 'SPLPRICE' 
		WHEN 'C' THEN MIN(ISNULL(sub.adjustment_name, 'CUSCONTR')) 
		ELSE ''
	END							AS adjustment_name

	,t.PriceMethod				AS price_method

	-- since we are using Marketing program to link sales, 
	-- ONLY show Marketing program if being used as a promo
	,CASE 
		WHEN t.PriceMethod = 'P' 
		THEN ISNULL(marketing_program,'') 
		ELSE ''
	END							AS marketing_program
	,MIN(ii.SalesCategory)		AS SalesCategory

	,SUM(t.ShippedQty)			AS ShippedQty
	,SUM(t.NetSalesAmt)			AS NetSalesAmt
	,SUM(GPAtFileCostAmt)		AS GPAtFileCostAmt
	,SUM(ExtChargebackAmt)		AS ExtChargebackAmt
	,COUNT(*)					AS HitsQty
FROM            
	BRS_Customer AS c 

	INNER JOIN BRS_TransactionDW AS t 
	ON c.ShipTo = t.Shipto 

	INNER JOIN etl.F4101_item_master AS i 
	ON t.Item = i.IMLITM_item_number

	INNER JOIN BRS_Item AS ii 
	ON i.IMLITM_item_number = ii.Item

	-- Class Contract and Market Program roll to adjustment not BT
	LEFT JOIN (
		SELECT        
			billto,
			price_method,
			marketing_program,
			adjustment_name,
			enroll_src
		FROM            
			etl.price_adjustment_customer
		WHERE 
			enroll_src IN ('CLACTR', 'MRKPRG') AND
			(1=1)
	) sub
	ON	c.BillTo = sub.billto AND
		t.PriceMethod = sub.price_method AND
		sub.marketing_program = CASE WHEN t.PriceMethod = 'P' THEN t.PromotionCode ELSE '' END


WHERE        
	-- remove Equipment orders as they do not use Advanced Pricing
	(NOT (t.OrderSourceCode IN ('A', 'L'))) AND 

	-- show sales history for accounts with special pricing
	EXISTS (SELECT * FROM etl.price_adjustment_customer where billto = c.Billto) AND

	-- TODO make this dynamic with function
	(t.CalMonth BETWEEN 201509 AND 201703 )

GROUP BY 
	i.IMITM__item_number_short
	-- Class Contract and Market Program roll to adjustment not BT
	,CASE WHEN sub.billto IS NOT NULL THEN 0 ELSE c.BillTo END
	,t.PriceMethod
	,CASE t.PriceMethod 
		WHEN 'P' THEN (ISNULL(sub.adjustment_name,'')) 
		WHEN 'S' THEN 'SPLPRICE' 
		WHEN 'C' THEN (ISNULL(sub.adjustment_name, 'CUSCONTR')) 
		ELSE ''
	END

	-- since we are using Marketing program to link sales, 
	-- ONLY show Marketing program if being used as a promo
	,CASE WHEN t.PriceMethod = 'P' THEN ISNULL(marketing_program,'') ELSE '' END
	
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT TOP 5 * FROM etl.price_adjustment_sales WHERE billto in( 2613256, 1678299) and marketing_program = 'GS' AND 
--SELECT * FROM etl.price_adjustment_sales WHERE billto in( 2613256) adjustment_name = 'ADC02COR'  AND price_method = 'C'

-- SELECT COUNT(*) FROM etl.price_adjustment_sales 
-- full 1 487 431
-- ORG 565 415
