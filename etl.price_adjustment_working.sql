
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW etl.price_adjustment_working
AS

/******************************************************************************
**	File: 
**	Name: etl.price_adjustment_working
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
**	Date: 28 Mar 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/


SELECT  
	p.[price_adjustment_key_id]
	,p.[adjustment_name]
	,p.[item_number_short]
	,p.[billto]

	,ISNULL(b2s.ShipToPrimary, 0)	AS ShipToPrimary
	,ISNULL([SalesDivision], '')	AS SalesDivision
	,ISNULL(st.[MarketClass], '')	AS MarketClass
	,ISNULL(st.[SegCd], '')			AS SegCd
	,ISNULL(st.[PracticeName], '')	AS PracticeName

	,p.[marketing_program]
	,p.[PriceMethod]
	,p.[quantity_from]
	,p.[effective_date]
	,p.[expired_date]
	,p.[final_price]				AS locked_price
	,p.[last_landed_cost]

	,i.[item]
	,i.[FamilySetLeader]
	,i.[ItemDescription]
	,i.[Supplier]
	,i.[Size]
	,i.[Strength]
	,i.[ItemStatus]
	,i.[Label]
	,i.[SalesCategory]
	,i.[MajorProductClass]
	,i.[SubMajorProdClass]
	,i.[StockingType]
	,i.[CurrentCorporatePrice]
	,i.[CurrentFileCost]
	,i.[FreightAdjPct]
	,i.[SupplierCost]
	,i.[Currency]

	,ISNULL(s.ShippedQty,0)			AS ShippedQty
	,ISNULL(s.NetSalesAmt,0)		AS NetSalesAmt
	,ISNULL(s.GPAtFileCostAmt,0)	AS GPAtFileCostAmt
	,ISNULL(s.ExtChargebackAmt,0)	AS ExtChargebackAmt

	,h.Supplier						AS ORG_Supplier
	,h.CorporatePrice				AS ORG_CorporatePrice
	,h.SupplierCost					AS ORG_SupplierCost
	,h.Currency						AS ORG_Currency
	,h.FX_per_CAD_pnl_rt			AS ORG_FX_per_CAD_pnl_rt
	,h.FX_per_CAD_mrk_rt			AS ORG_FX_per_CAD_mrk_rt

	,p.[user_id]
	,p.[date_updated]


FROM            

	etl.price_adjustment_detail AS p 

	LEFT OUTER JOIN etl.price_adjustment_item AS i 
	ON p.item_number_short = i.item_number_short 


	LEFT OUTER JOIN etl.price_adjustment_sales AS s 
	ON p.item_number_short = s.item_number_short AND 
		p.billto = s.BillTo AND 
		p.PriceMethod = s.PriceMethod AND 
		p.marketing_program = s.PromotionCodeActive

	LEFT OUTER JOIN BRS_ItemBaseHistory AS h 
	ON h.CalMonth = FORMAT(p.date_updated, 'yyyyMM') AND 
		h.Item = i.item 

	LEFT OUTER JOIN [BRS_CustomerBT] AS b2s
	ON p.[billto] = b2s.[BillTo] AND
		p.[billto] > 0

	LEFT OUTER JOIN [BRS_Customer] AS st
	ON b2s.ShipToPrimary = st.ShipTo

		

WHERE        
--	(i.item_number_short IS NULL) AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM etl.price_adjustment_working 