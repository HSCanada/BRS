
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

/*
-- ORG
SalesCategory cnt
------------- -----------
MERCH         341

-- NEW
SalesCategory cnt
------------- -----------
MERCH         69888
SMEQU         2833
TEETH         509


*/

-- ORG 517 in MERCH
/*
-- 1% all
SalesCategory cnt
------------- -----------
MERCH         69553
SMEQU         2839
TEETH         513 ??
*/

-- SELECT top 10 * FROM BRS_ItemMarketAdjustFix where ma_heavy_ind = 0
-- SELECT * FROM BRS_ItemMarketAdjustFix order by 	Est12MoSales desc 
-- SELECT * FROM BRS_ItemMarketAdjustFix order by 	ItemCreationDate desc 
-- SELECT count(*) FROM BRS_ItemMarketAdjustFix where SalesCategory = 'TEETH'
-- SELECT * FROM BRS_ItemMarketAdjustFix where SalesCategory = 'TEETH'
-- SELECT * FROM BRS_ItemMarketAdjustFix where item = '5854180'
-- ORG 76206, with EXLUDE 76165

-- SELECT  * FROM BRS_ItemMarketAdjustFix order by CorporateMarketAdjustmentPct desc



-- 1. add 1% to base MA

SELECT  [Label]
      ,[ma_base_factor]
  FROM [dbo].[BRS_ItemLabel] 

/*
-- ORG
Label ma_base_factor
----- ----------------------
      1.092
*     1.092
B     1.092
E     1.092
G     1.092
P     1.123
-- NEW
Label ma_base_factor
----- ----------------------
      1.102
*     1.102
B     1.102
E     1.102
G     1.102
P     1.133

*/

UPDATE [dbo].[BRS_ItemLabel]
SET [ma_base_factor] = 1.102
  WHERE label <> 'P'

UPDATE [dbo].[BRS_ItemLabel]
SET [ma_base_factor] = 1.133
  WHERE label = 'P'


SELECT BRS_ItemSupplier.Supplier, BRS_ItemSupplier.ma_supplier_factor
FROM BRS_ItemSupplier
WHERE (((BRS_ItemSupplier.Supplier) In ('VIDENT','DENTPL','IVOCLA','KULZER','ZAHNDT','MYRSON','ZAHNDL','AMRTOO')))

/*
-- ORG
Supplier ma_supplier_factor
-------- ----------------------
AMRTOO   0
DENTPL   0
IVOCLA   0
KULZER   0
MYRSON   0
VIDENT   0
ZAHNDL   0
ZAHNDT   0

-- NEW

Supplier ma_supplier_factor
-------- ----------------------
AMRTOO   0.01
DENTPL   0.01
IVOCLA   0.01
KULZER   0.01
MYRSON   0.01
VIDENT   0.01
ZAHNDL   0.01
ZAHNDT   0.01
*/

-- 2. add 1% to Teeth (effectively 2%, when base 1% included)
UPDATE  BRS_ItemSupplier
SET        ma_supplier_factor = 0.01
WHERE   (Supplier IN ('VIDENT', 'DENTPL', 'IVOCLA', 'KULZER', 'ZAHNDT', 'MYRSON', 'ZAHNDL', 'AMRTOO'))

