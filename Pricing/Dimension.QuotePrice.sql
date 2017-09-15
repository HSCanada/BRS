
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[QuotePrice]
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
--	30 Aug 17	tmc		source from Stage to Pricing Production
**	14 Sep 17	tmc		Simplified model

*******************************************************************************/

--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------

SELECT

	p.ADATID_price_adjustment_key_id		AS QuotePriceKey
	,p.ADAST__adjustment_name				AS Adjustment
	,p.ADAN8__billto						AS Billto
	,im3.ItemKey							AS ItemKey
	,p.ADFVTR_factor_value					AS FinalPrice

	,ISNULL(h.Supplier,'')					AS Last_SupplierCode
	,ISNULL(h.Currency,'')					AS Last_CurrencyCode
	,ISNULL(h.SupplierCost,0)				AS Last_SupplierCost
	,ISNULL(h.FX_per_CAD_mrk_rt,0)			AS Last_FxMarketing
	,ISNULL(h.FX_per_CAD_pnl_rt,0)			AS Last_FxFinance
	,im3.FreightAdjPct						AS Last_FreightFactor
	,ISNULL(h.[CorporatePrice],0)			AS Last_BasePrice

	,p.ADEFTJ_effective_date				AS EffectiveDate
	,p.ADEXDJ_expired_date					AS ExpiredDate
	,p.ADUPMJ_date_updated					AS LastUpdatedDate
	,p.ADUSER_user_id						AS UserId

FROM            
	[Pricing].[price_adjustment_detail_F4072] p

	INNER JOIN [Pricing].[price_adjustment_name_F4071] n
	ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

	LEFT JOIN [Pricing].item_master_F4101 im
	ON p.ADITM__item_number_short = im.IMITM__item_number_short

	LEFT JOIN [dbo].[BRS_Item] as im3
	ON im3.Item = im.IMLITM_item_number			

	-- link date to fiscal instead of IIF
	LEFT OUTER JOIN BRS_ItemBaseHistory AS h 
	ON h.CalMonth = iif( p.ADUPMJ_date_updated >= '2015-01-01', 
							FORMAT(p.ADUPMJ_date_updated , 'yyyyMM'
							),
							201501
						) AND 
		h.Item = im3.item 


WHERE
	n.ATPRFR_preference_type IN ('C', 'IG') AND
	p.ADBSCD_basis = 5 AND
	p.ADAST__adjustment_name <> 'PRPRICE' AND
	p.ADMNQ__quantity_from = 1 AND

--	ADITM__item_number_short <> 0 AND -- temp

	(1=1)       


UNION ALL

SELECT 
0		AS QuotePriceKey
,''		AS Adjustment 
,0		AS Billto
,1		AS ItemKey     
,0.0	AS FinalPrice                              
,''		AS Last_SupplierCode 
,''		AS Last_CurrencyCode
,0.0	AS Last_SupplierCost     
,0.0	AS Last_FxMarketing
,0.0	AS Last_FxFinance
,0.0	AS Last_FreightFactor  
,0.0	AS Last_BasePrice

,'1980-01-01'	AS EffectiveDate 
,'1980-01-01'	AS ExpiredDate 
,'1980-01-01'	AS LastUpdatedDate         
,''				AS UserId     



GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
SELECT 
top 10
* FROM Dimension.QuotePrice
--WHERE Adjustment = 'SPLPRICE'
WHERE Adjustment = 'CUSCONTR'
order by 1 asc

-- 1s clean
-- 45s with history
-- 6s new



*/


