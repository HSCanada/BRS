
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [pricing].item_quote
AS

/******************************************************************************
**	File: 
**	Name: pricing.item.quote
**	Desc:  small EQ quote pricing for Marketing
**		
**
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
**	Date: 28 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	14 Sep 17	tmc		Simplified model
**    
*******************************************************************************/

SELECT        	i.Item	,i.ItemDescription	,i.Size	,i.Strength	,i.ManufPartNumber	,cat.submajor_desc	,i.Supplier	,i.comm_group_cd	,i.comm_note_txt	,i.Brand	,i.CurrentFileCost	,CASE WHEN i.FreightAdjPct = 0 THEN 1 ELSE i.FreightAdjPct END as FreightAdjPct	,i.CorporateMarketAdjustmentPct	,i.CurrentFileCost *		(CASE WHEN i.FreightAdjPct = 0 THEN 1 ELSE i.FreightAdjPct END) *		i.CorporateMarketAdjustmentPct as CurrentLandedCost	,i.CurrentCorporatePrice	,i.Est12MoSales

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
	INNER JOIN BRS_ItemCategory AS cat 
	ON i.MinorProductClass = cat.MinorProductClass

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
 

WHERE	(i.MajorProductClass IN ('011','023')) AND 
	(i.ItemStatus <> 'P') AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



select  
-- top 10
* from [pricing].item_quote
ORDER BY 1
--	CorporateMarketAdjustmentPct DESC
	FreightAdjPct DESC


/*
SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config]

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

FROM            fg.deal_item AS ssi

INNER JOIN [fg].[deal] ssd
ON ssd.deal_id = ssi.deal_id

WHERE        (CalMonthRedeem =
                             (SELECT        PriorFiscalMonth
                               FROM            BRS_Config))

*/