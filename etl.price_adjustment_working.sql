
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
	,i.[item]
	,p.[item_number_short]
	,p.[billto]

	,ISNULL(st.ShipTo, 0)			AS ShipToPrimary
	,ISNULL([SalesDivision], '')	AS SalesDivision
	,ISNULL(st.[MarketClass], '')	AS MarketClass
	,ISNULL(st.[SegCd], '')			AS SegCd
	,ISNULL(st.[PracticeName], 'ZZ_NO_CUST')	AS PracticeName
	,ISNULL(st.VPA,'')				AS VPA

	,ISNULL(s.HitsQty,0)			AS HitsQty
	,ISNULL(s.ShippedQty,0)			AS ShippedQty
	,ISNULL(s.NetSalesAmt,0)		AS NetSalesAmt
	,ISNULL(s.GPAtFileCostAmt,0)	AS GPAtFileCostAmt
	,ISNULL(s.ExtChargebackAmt,0)	AS ExtChargebackAmt

	,p.[marketing_program]
	,p.[price_method]
	,p.[quantity_from]
	,p.[effective_date]
	,p.[expired_date]

	,p.[final_price]				AS locked_price
	,i.[CurrentCorporatePrice]		AS CUR_Base
	,i.[FreightAdjPct]				AS CUR_FreightFactor
	,i.[SupplierCost]				AS CUR_SupplierCost
	,i.[Currency]					AS CUR_Currency
	,i.FX_per_CAD_mrk_rt			AS CUR_FX_per_CAD_mrk_rt

	,h.SupplierCost					AS ORG_SupplierCost
	,h.Currency						AS ORG_Currency
	,h.FX_per_CAD_mrk_rt			AS ORG_FX_per_CAD_mrk_rt
	,p.[last_landed_cost]			AS ORG_last_landed_cost



	,i.[FamilySetLeader]
	,i.[ItemDescription]
	,i.[Supplier]
	,i.[ItemStatus]
	,i.[Label]
	,i.[SalesCategory]
	,i.[MajorProductClass]
	,i.[StockingType]

	,p.[user_id]
	,p.[date_updated]


FROM            

	etl.price_adjustment_detail AS p 

	-- map short item to long
	LEFT OUTER JOIN etl.price_adjustment_item AS i 
	ON p.item_number_short = i.item_number_short 

	-- XXX fix sales
	LEFT OUTER JOIN etl.price_adjustment_sales AS s 
	ON p.item_number_short = s.item_number_short AND 
		p.billto = s.BillTo AND 
		p.adjustment_name = s.adjustment_name AND
		p.price_method = s.price_method AND 
		p.marketing_program = s.marketing_program


	-- Cost info as of last update
	LEFT OUTER JOIN BRS_ItemBaseHistory AS h 
	ON h.CalMonth = FORMAT(p.date_updated, 'yyyyMM') AND 
		h.Item = i.item 

	-- Map Billto to Primary shipto
	LEFT OUTER JOIN BRS_CustomerBT AS b2s
	ON p.[billto] = b2s.[BillTo] AND
		p.[billto] > 0

	-- Map Group to Primary shipto
	LEFT OUTER JOIN etl.adjustment_name_primary_customer AS b2sgrp
	ON p.[adjustment_name] = b2sgrp.adjustment_name 

	-- Lookup Primary shipto 
	LEFT OUTER JOIN [BRS_Customer] AS st
	ON ISNULL(b2s.ShipToPrimary, b2sgrp.ShipToPrimary)  = st.ShipTo

WHERE        
--	(i.item_number_short IS NULL) AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
SELECT 
--TOP 10 
* 
FROM etl.price_adjustment_working 
WHERE ORG_FX_per_CAD_mrk_rt IS NULL and PracticeName <> 'ZZ_NO_CUST' AND NetSalesAmt > 0
ORDER BY date_updated
*/

-- SELECT count (*) FROM etl.price_adjustment_working 
--484142

-- SELECT TOP 10 * FROM etl.price_adjustment_sales

/*

drop table etl.adjustment_name_primary_customer

CREATE TABLE [etl].[adjustment_name_primary_customer](
	[adjustment_name] [varchar](8) NOT NULL,
	[ShipToPrimary] [int] NOT NULL,
	[Est12MoTotal] [money] NOT NULL,
 CONSTRAINT [PK_adjustment_name_primary_customer] PRIMARY KEY CLUSTERED 
(
	[adjustment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


WITH cte AS (						
	SELECT  
		a.adjustment_name, 
		c.ShipTo, 
		c.Est12MoTotal, 
		ROW_NUMBER() OVER   (PARTITION BY a.adjustment_name ORDER BY c.Est12MoTotal DESC) AS Rank 
	FROM            
		etl.price_adjustment_customer AS a 

		LEFT OUTER JOIN BRS_CustomerBT AS b 
		ON b.BillTo = a.billto 
	
		LEFT OUTER JOIN BRS_Customer AS c 
		ON c.ShipTo = b.ShipToPrimary
) 
INSERT INTO etl.adjustment_name_primary_customer (adjustment_name, ShipToPrimary, Est12MoTotal)
SELECT adjustment_name, ShipTo, Est12MoTotal FROM cte WHERE Rank  = 1 

adjustment_name ShipTo      Est12MoTotal
--------------- ----------- ---------------------
ADC01ALD        1661490     48560.64					 
*/