
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[CustomerPriceEnroll]
AS

/******************************************************************************
**	File: 
**	Name: CustomerPriceEnroll
**	Desc:  Customer Map - Class Contract, Special, Contract
**			Class = 1toMany BT; Special & Contract = 1to1 BT
**		
**			TODO - source this from Prod tables (us ID)
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
--	4 Aug 17	tmc		remove multi-enroll:  Class Cont -> Contract -> Special
*******************************************************************************/

-- Class Contract Map

SELECT        
	pj.PJAN8__billto				AS BillTo
	,sn.SNAST__adjustment_name		AS Adjustment
	,pj.PJASN__adjustment_schedule	AS SalesPlan
	,pj.PJEFTJ_effective_date		AS EffectiveDate
	,pj.PJEXDJ_expired_date			AS ExpiredDate
	,atn.AdjustmentNameKey			AS AdjustmentKey
	-- magic number 13 = C = Contract
	,13								AS PriceMethodKey 
	,'CLACTR'						AS EnrollSource
FROM            
	Integration.F40314_preference_price_adjustment_schedule_Staging AS pj

	INNER JOIN [Integration].[F4070_price_adjustment_schedule_Staging]  AS sn
	ON pj.PJASN__adjustment_schedule = sn.SNASN__adjustment_schedule

	INNER JOIN Integration.F4071_price_adjustment_name_Staging AS atn
	ON sn.SNAST__adjustment_name = atn.ATAST__adjustment_name

WHERE 
	atn.ATPRFR_preference_type= 'IG' AND
	atn.ATPRGR_item_price_group = '' AND
	atn.ATCPGP_customer_price_group	 = '' AND
	atn.ATSDGR_order_detail_group = '' AND
	atn.ATLBT__level_break_type = 1 AND 
	1=1

UNION ALL

-- Contract

SELECT 
	p.ADAN8__billto					AS BillTo
	,MIN(p.ADAST__adjustment_name)	AS AdjustmentName
	-- No Sales Plan for Special Pricing
	,''								AS SalesPlan
	,MIN(p.ADEFTJ_effective_date)	AS EffectiveDate
	,MAX(p.ADEXDJ_expired_date)		AS ExpiredDate
	,MIN(n.AdjustmentNameKey)		AS AdjustmentNameKey
	-- magic number 13 = C = Contract
	,13								AS PriceMethodKey 
	,'CUSCONTR'					AS EnrollSource

FROM            
	Integration.F4072_price_adjustment_detail_Staging  p

	INNER JOIN Integration.F4071_price_adjustment_name_Staging n
	ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

WHERE
	n.ATPRFR_preference_type IN ('C') AND
	p.ADAST__adjustment_name = 'CUSCONTR' AND
	ADAN8__billto > 0 AND
	p.ADBSCD_basis = 5 AND
	p.ADMNQ__quantity_from = 1 AND

/*
	-- remove reference were class contract to avoid double counting. bad data 
	NOT EXISTS (SELECT * 
				FROM [Integration].[F40314_preference_price_adjustment_schedule_Staging] b 
				WHERE b.PJAN8__billto = p.ADAN8__billto
				) AND
*/

	(1=1)
GROUP BY
	p.ADAN8__billto

UNION ALL

-- Special Pricing

SELECT 
	p.ADAN8__billto					AS BillTo
	,MIN(p.ADAST__adjustment_name)	AS AdjustmentName
	-- No Sales Plan for Special Pricing
	,''								AS SalesPlan
	,MIN(p.ADEFTJ_effective_date)	AS EffectiveDate
	,MAX(p.ADEXDJ_expired_date)		AS ExpiredDate
	,MIN(n.AdjustmentNameKey)		AS AdjustmentNameKey
	-- magic number 21 = S = Special
	,21 AS PriceMethodKey 
	,'SPLPRICE'					AS EnrollSource

FROM            
	Integration.F4072_price_adjustment_detail_Staging  p

	INNER JOIN Integration.F4071_price_adjustment_name_Staging n
	ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

WHERE
	n.ATPRFR_preference_type IN ('C') AND
	p.ADAST__adjustment_name = 'SPLPRICE' AND
	ADAN8__billto > 0 AND
	p.ADBSCD_basis = 5 AND
	p.ADMNQ__quantity_from = 1 AND

	-- remove reference were class contract to avoid double counting. bad data 
	NOT EXISTS (SELECT * 
				FROM [Integration].[F40314_preference_price_adjustment_schedule_Staging] b 
				WHERE b.PJAN8__billto = p.ADAN8__billto 
				) AND


	(1=1)
GROUP BY
	p.ADAN8__billto


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT count (*) FROM Dimension.CustomerPriceEnroll order by 1
-- SELECT * FROM Dimension.CustomerPriceEnroll 

-- SELECT Billto, Count(*) FROM Dimension.CustomerPriceEnroll  group by BillTo having count(*) > 1 order by 2 desc

-- SELECT * FROM Dimension.CustomerPriceEnroll  where BillTo = 1582560


/*



*/