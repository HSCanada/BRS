
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Price]
AS

/******************************************************************************
**	File: 
**	Name: Price
**	Desc: Pricing Details - Class Contract, Special, Contract @ 1 rate
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
**    
*******************************************************************************/

--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------

SELECT

	p.ADATID_price_adjustment_key_id		AS PriceAdjustmentKey
	,n.AdjustmentNameKey					AS AdjustmentKey
	,im3.ItemKey							AS ItemKey
	,p.ADFVTR_factor_value					AS FinalPrice

	,ISNULL(h.Supplier,'')					AS Last_Supplier
	,ISNULL(h.SupplierCost,0)				AS Last_SupplierCost
	,ISNULL(h.Currency,'')					AS Last_Currency
	,ISNULL(h.FX_per_CAD_mrk_rt,0)			AS Last_FxMarketing
	,im3.FreightAdjPct						AS Last_FreightFactor

	,p.ADEFTJ_effective_date				AS EffectiveDate
	,p.ADEXDJ_expired_date					AS ExpiredDate
	,DATEADD (day , p.ADUPMJ_date_updated_JDT%1000-1, 
		DATEADD(year, p.ADUPMJ_date_updated_JDT/1000, 0 ) ) 
											AS LastUpdatedDate
	,p.ADUSER_user_id						AS UserId
	,p.ADAN8__billto						AS BillTo_Pricing

FROM            
	Integration.F4072_price_adjustment_detail_Staging p

	INNER JOIN Integration.F4071_price_adjustment_name_Staging n
	ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

	LEFT JOIN Integration.F4094_item_customer_keyid_master_file_Staging Ki
	ON ki.KIICID_itemcustomer_key_id = p.ADICID_itemcustomer_key_id

	LEFT JOIN Integration.F4101_item_master_Staging im
	ON im.IMLITM_item_number = ki.KIPRGR_item_price_group

	INNER JOIN [Integration].[F4101_item_master_Staging] im2
	ON im2.IMITM__item_number_short =	CASE 
											WHEN p.ADITM__item_number_short = 0 
											THEN im.IMITM__item_number_short 
											ELSE p.ADITM__item_number_short 
										END
										
	INNER JOIN [dbo].[BRS_Item] as im3
	ON im3.Item = im2.IMLITM_item_number			

	-- Cost info as of last update.  Use Jan 2015 (julian 115006) for historical if older, hack
	LEFT OUTER JOIN BRS_ItemBaseHistory AS h 
	ON h.CalMonth = iif( p.ADUPMJ_date_updated_JDT >= 115006, 
							FORMAT(	DATEADD (day , p.ADUPMJ_date_updated_JDT%1000-1, 
								DATEADD(year, p.ADUPMJ_date_updated_JDT/1000, 0 ) ) , 'yyyyMM'
							),
							201501
						) AND 
		h.Item = im3.item 
	

WHERE
	n.ATPRFR_preference_type IN ('C', 'IG') AND
	p.ADBSCD_basis = 5 AND
	ADAST__adjustment_name <> 'PRPRICE' AND
	ADMNQ__quantity_from = 1 AND

--	ADITM__item_number_short <> 0 AND -- temp

	(1=1)       


UNION ALL

SELECT 
0		AS PriceAdjustmentKey
,0		AS AdjustmentKey 
,1		AS ItemKey     
,0.0	AS FinalPrice                              
,''		AS Last_Supplier 
,0.0	AS Last_SupplierCost     
,''		AS Last_Currency 
,0.0	AS Last_FxMarketing
,0.0	AS Last_FreightFactor  
,NULL	AS EffectiveDate 
,NULL	AS ExpiredDate 
,NULL	AS LastUpdatedDate         
,''		AS UserId     
,0		AS BillTo_Pricing


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
SELECT 
 top 10
* FROM Dimension.Price
order by 1 asc



SELECT 
distinct last_currency
 FROM Dimension.Price
where last_fxmarketing = -1
*/


-- Select * from Integration.F4072_price_adjustment_detail_Staging where ADAST__adjustment_name like 'AMC%'