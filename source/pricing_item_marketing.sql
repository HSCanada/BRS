
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [pricing].item_marketing
AS

/******************************************************************************
**	File: 
**	Name: pricing.item.marketing
**	Desc:  standard item pricing and support view 
**		based on pricing.item.quote	
**		o basic Item DW info
**		o Supplier local currency
**		o Schein Saver deals
**      o add Family tagged (update seperatly)
**
**	Return values:  
**
**	Called by:   Excel
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 14 Jan 25
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
	i.Item
	,i.ItemDescription
	-- TBD flyer page (design this)
	,i.FamilySetLeader
	,i.Supplier
	,sup.supplier_nm
	,sup.CountryGroup
	,i.ManufPartNumber
	,i.Brand
	,i.ItemStatus
	,i.Size
	,i.Strength
	,cat.major_cd
	,cat.major_desc
	,cat.submajor_cd
	,cat.submajor_desc
	,i.StockingType

	,jde_cost.Currency					AS CurrencyCode
	,jde_cost.SupplierCost				AS SupplierCost_LocalCurr
	,i.CurrentFileCost					AS CurrentFileCost_CAD
	-- fx calc
	,CASE 
		WHEN i.FreightAdjPct = 0 
		THEN 1 
		ELSE i.FreightAdjPct 
	END									AS FreightAdjPct
	,i.CorporateMarketAdjustmentPct

	,i.CurrentFileCost *
		(CASE WHEN i.FreightAdjPct = 0 THEN 1 ELSE i.FreightAdjPct END) *
		i.CorporateMarketAdjustmentPct	AS CurrentLandedCost_CAD

	-- DW
	,i.CurrentCorporatePrice
	,i.ItemCreationDate

	,i.ItemKey

	,ISNULL(ext.[tag_01_cd], '') as tag_01_cd
	,ISNULL(ext.[tag_02_cd], '') as tag_02_cd
	,ISNULL(ext.[tag_03_cd], '') as tag_03_cd
	,ISNULL(ext.[tag_04_cd], '') as tag_04_cd
	,ISNULL(ext.[tag_05_cd], '') as tag_05_cd

	,i.Est12MoSales

	,ISNULL(ss.deal_source_cd,'') AS deal_source_cd
	,ss.CalMonthRedeem
	,ss.effDate
	,ss.expired
	,ISNULL(ss.BuyOrg, '') AS buy_txt
	,ISNULL(ss.GetOrg,'' ) AS get_txt
	,ISNULL(ss.RedeemOrg, '') AS redeem_method_txt
	,ISNULL(ss.QuarterOrg, '') AS deal_period

FROM

	BRS_Item AS i 

	INNER JOIN	[dbo].[BRS_ItemSupplier] sup
	ON sup.[Supplier] = i.Supplier

	-- Cost / Sell from JDE direct (local currency)
	LEFT JOIN STAGE_BRS_ItemBaseHistory jde_cost
	ON jde_cost.Item = i.Item and jde_cost.CalMonth = 0

	-- add marketing tags (test read/write)
	LEFT JOIN [pricing].[item_family_marketing_ext] ext
	ON i.FamilySetLeader = ext.[FamilySetLeader]


	INNER JOIN BRS_ItemCategory AS cat 
	ON i.MinorProductClass = cat.MinorProductClass

	-- shein saver deal?
	LEFT JOIN (
		SELECT
			ssi.item
			,ssi.CalMonthRedeem

			,ssi.deal_id
			,ssi.deal_source_cd 
			,ssd.BuyOrg
			,ssd.GetOrg
			,ssd.RedeemOrg
			,ssd.QuarterOrg
			,ssd.NoteOrg
			,ssd.EffDate
			,ssd.Expired

		FROM
			fg.deal_item AS ssi

			INNER JOIN [fg].[deal] ssd
			ON ssd.deal_id = ssi.deal_id

		WHERE
			(CalMonthRedeem =
				(SELECT        PriorFiscalMonth
				FROM            BRS_Config))

	) ss
	ON i.Item = ss.item
 

WHERE
	(i.SalesCategory in ('MERCH', 'SMEQU')) AND
	(i.ItemStatus <> 'P') AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



-- select   top 10 * from [pricing].item_marketing where tag_01_cd <>'' order by Est12MoSales desc
 select   * from [pricing].item_marketing where tag_01_cd <>'' order by Est12MoSales desc

-- select   count (*) from [pricing].item_marketing 

-- select   top 10 * from [pricing].item_marketing where CorporatePrice <> CurrentCorporatePrice order by Est12MoSales desc
--	CorporateMarketAdjustmentPct DESC


