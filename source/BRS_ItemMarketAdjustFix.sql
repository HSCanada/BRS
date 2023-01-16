
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
**	04 Feb 22	tmc		add excption logic for Med 200 codes
**	16 Mar 22	tmc		fix PPE potial problem by lowering thersh to 0.001
**	28 Nov 22	tmc		added minor and sub-minor
**	16 Jan 23	tmc		added Med EQ flag 
**    
*******************************************************************************/

-- Light item excptions
SELECT
--	TOP (10) 
	i.Item

	,i.SalesCategory
	,i.ItemStatus
	,i.MajorProductClass
	,i.[MinorProductClass]
	,i.[SubMinorProductCodec] AS [SubMinorProductClass]
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
	,[ma_exception_factor]


	,i.FreightAdjPct
	,i.CorporateMarketAdjustmentPct

	,ROUND(i.new_market_adj+[ma_exception_factor], 5)					AS new_market_adj
	,(ROUND(i.new_market_adj+[ma_exception_factor], 4) - 1.0) * 100.	AS new_market_adj_import
	,i.Est12MoSales
	,CASE WHEN SUBSTRING(i.[MinorProductClass],8,20) = '79' THEN 1 ELSE 0 END		AS med_eq_code_ind

FROM
	BRS_ItemMarketAdjustModel AS i 

WHERE
	-- Correction needed?
	ABS(CorporateMarketAdjustmentPct - (i.new_market_adj+[ma_exception_factor])) > 0.001 AND
--	ABS(CorporateMarketAdjustmentPct - i.new_market_adj) > 0.001 AND

	-- exclude PPE overrides
	NOT ((CorporateMarketAdjustmentPct BETWEEN 0.001 AND 0.99) AND i.Supplier <> 'ACESUR') AND
--	NOT ((CorporateMarketAdjustmentPct BETWEEN 0.10 AND 0.99) AND i.Supplier <> 'ACESUR') AND

	(1=1) 

	-- test
	--OR [ma_exception_factor] <> 0.0



GO

-- SELECT SalesCategory, COUNT(*) AS cnt FROM BRS_ItemMarketAdjustFix GROUP BY SalesCategory

-- SELECT top 10 * FROM BRS_ItemMarketAdjustFix where ma_heavy_ind = 0
-- SELECT * FROM BRS_ItemMarketAdjustFix order by 	Est12MoSales desc 
-- SELECT count(*) FROM BRS_ItemMarketAdjustFix where SalesCategory = 'TEETH'
-- SELECT * FROM BRS_ItemMarketAdjustFix where SalesCategory = 'TEETH'
-- SELECT * FROM BRS_ItemMarketAdjustFix where item = '5854180'
-- ORG 76206, with EXLUDE 76165

-- SELECT  * FROM BRS_ItemMarketAdjustFix order by CorporateMarketAdjustmentPct desc
