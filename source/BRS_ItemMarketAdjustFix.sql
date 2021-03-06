﻿
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW BRS_ItemMarketAdjustFix
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc:  
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
**	Date: 15 Jan 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	06 Feb 19	tmc		fixed extra join bug on brand resulting in missed exept
**	25 Nov 20	tmc		exclude zero Freight items (internal codes)
**	05 Jan 21	tmc		add economy teeth logic
**  08 Jan 21	tmc		update to add new import format  1.025 = 2.5
**	11 Jan 21	tmc		add PPE exclude with where ME < 1
**	26 May 21	tmc		move logic to BRS_ItemMarketAdjustModel for more flex
**    
*******************************************************************************/

-- Light item excptions
SELECT
--	TOP (10) 
	i.Item

	,i.SalesCategory
	,i.ItemStatus
	,i.MajorProductClass
	,i.ItemCreationDate

	,i.Supplier
	,i.Label
	,i.StockingType
	,i.ma_heavy_ind

	,i.ma_heavy_factor
	,i.ma_heavy_thresh
	,i.ma_base_factor
	,ma_supplier_factor
	,ma_stocking_factor

	,i.FreightAdjPct
	,i.CorporateMarketAdjustmentPct

	,ROUND(i.new_market_adj, 5)					AS new_market_adj
	,(ROUND(i.new_market_adj, 4) - 1.0) * 100.	AS new_market_adj_import
	,i.Est12MoSales

FROM
	BRS_ItemMarketAdjustModel AS i 

WHERE
	-- Correction needed?
	ABS(CorporateMarketAdjustmentPct - i.new_market_adj) > 0.001 AND

	-- exclude PPE overrides
	NOT ((CorporateMarketAdjustmentPct BETWEEN 0.10 AND 0.99) AND i.Supplier <> 'ACESUR') AND

	(1=1) 


GO

-- SELECT SalesCategory, COUNT(*) AS cnt FROM BRS_ItemMarketAdjustFix GROUP BY SalesCategory

-- SELECT top 10 * FROM BRS_ItemMarketAdjustFix where ma_heavy_ind = 0
-- SELECT * FROM BRS_ItemMarketAdjustFix order by 	Est12MoSales desc 

-- SELECT count(*) FROM BRS_ItemMarketAdjustFix where SalesCategory = 'TEETH'
-- SELECT * FROM BRS_ItemMarketAdjustFix where SalesCategory = 'TEETH'
-- SELECT * FROM BRS_ItemMarketAdjustFix where item = '5854180'

-- ORG 76206, with EXLUDE 76165