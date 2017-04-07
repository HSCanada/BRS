
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW etl.price_adjustment_detail
AS

/******************************************************************************
**	File: 
**	Name: etl.price_adjustment_detail
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

--------------------------------------------------------------------------------
-- Pricing Details - Class Contract, Marketing programs, Special, Contract
--------------------------------------------------------------------------------

SELECT        
	ADATID_price_adjustment_key_id			AS price_adjustment_key_id
	,ADAST__adjustment_name					AS adjustment_name
	,n.ATPRFR_preference_type				AS preference_type

	,CASE 
		WHEN ADITM__item_number_short = 0 
		THEN im.IMITM__item_number_short 
		ELSE ADITM__item_number_short 
	END										AS item_number_short

	,ADAN8__billto							AS billto
	,ADSDV1_sales_detail_value_01			AS marketing_program
	,CASE ADAST__adjustment_name
		WHEN 'SPLPRICE' THEN	'S'
		WHEN 'PRPRICE'	THEN	'P'
		ELSE					'C'
	END 									AS price_method
	,ADMNQ__quantity_from					AS quantity_from
	,ADEFTJ_effective_date					AS effective_date
	,ADEXDJ_expired_date					AS expired_date

	,ADFVTR_factor_value					AS final_price
	,ADURAT_user_reserved_amount			AS last_landed_cost

	,ADLEDG_cost_method						AS cost_method
	,ADUSER_user_id							AS user_id
	,ADPID__program_id						AS program_id
	,DATEADD (day , ADUPMJ_date_updated_JDT%1000-1, 
		DATEADD(year,ADUPMJ_date_updated_JDT/1000, 0 ) ) 
											AS date_updated

FROM            
	etl.F4072_price_adjustment_detail p

	INNER JOIN etl.F4071_price_adjustment_name n
	ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

	LEFT JOIN etl.F4094_item_customer_keyid_master_file Ki
	ON ki.KIICID_itemcustomer_key_id = p.ADICID_itemcustomer_key_id

	LEFT JOIN etl.F4101_item_master im
	ON im.IMLITM_item_number = ki.KIPRGR_item_price_group

WHERE
	n.ATPRFR_preference_type IN ('C', 'IG') AND
	p.ADBSCD_basis = 5 AND
--	ADAST__adjustment_name = 'PRPRICE' AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 15 * FROM etl.price_adjustment_detail WHERE preference_type <>'IG' AND  PriceMethod <> 'S'

-- SELECT COUNT(*) FROM etl.price_adjustment_detail
-- org 484 142 
