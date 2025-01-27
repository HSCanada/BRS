-- market_segment_reclass, tmc, 21 Jan 25

-- update Current  Market&Seg, Current Old -> Current New

SELECT   TOP (10) ShipTo, BillTo, SalesDivision, MarketClass_New, SegCd_New, MarketClass, SegCd FROM     BRS_Customer

SELECT   count(*)  FROM     BRS_Customer
-- org 138 979

-- Update 1 of 2
-- UPDATE  BRS_Customer  SET        MarketClass = MarketClass_New, SegCd = SegCd_New
-- updates = 138979

-- test
SELECT   TOP (10) ShipTo, BillTo, SalesDivision, MarketClass_New, SegCd_New, MarketClass, SegCd FROM     BRS_Customer where MarketClass_New <> MarketClass


-- update History Market&Seg, Current Old -> History Old, where SalesDiv NOT changed

-- review
SELECT   TOP (10) c.ShipTo, c.BillTo, c.PracticeName, c.SalesDivision, c.MarketClass, c.SegCd, h.FiscalMonth, h.HIST_SalesDivision, h.HIST_MarketClass, h.HIST_SegCd, h.HIST_MarketClass_Old, h.HIST_SegCd_Old
FROM     BRS_Customer AS c INNER JOIN
             BRS_CustomerFSC_History AS h ON c.ShipTo = h.Shipto
WHERE   
(h.FiscalMonth BETWEEN 202401 AND 202412) AND 
(c.SalesDivision = h.HIST_SalesDivision) AND
--(c.SalesDivision <> h.HIST_SalesDivision) AND
--(c.ShipTo = 4271748) AND 
(1 = 1)
GO

SELECT   TOP (100) c.ShipTo, c.BillTo, c.PracticeName, c.vpa, c.[CustGrpWrkNote], c.SalesDivision, c.MarketClass, c.SegCd, h.FiscalMonth, h.HIST_SalesDivision, h.HIST_MarketClass, h.HIST_SegCd, h.HIST_MarketClass_Old, h.HIST_SegCd_Old
FROM     BRS_Customer AS c INNER JOIN
             BRS_CustomerFSC_History AS h ON c.ShipTo = h.Shipto
WHERE   
(h.FiscalMonth BETWEEN 202401 AND 202412) AND 
(c.SalesDivision = h.HIST_SalesDivision) AND
(
	(c.MarketClass <> h.HIST_MarketClass) OR
	(c.SegCd <> h.HIST_SegCd) 
) AND
-- (c.[CustGrpWrkNote] <>'zInvalidAccounts-Cyber-20250121TC') AND
--(c.SalesDivision <> h.HIST_SalesDivision) AND
--(c.ShipTo = 4271748) AND 
(1 = 1)
GO

SELECT   count(*)
FROM     BRS_Customer AS c INNER JOIN
             BRS_CustomerFSC_History AS h ON c.ShipTo = h.Shipto
WHERE   
(h.FiscalMonth BETWEEN 202401 AND 202412) AND 
(c.SalesDivision = h.HIST_SalesDivision) AND
(
	(c.MarketClass <> h.HIST_MarketClass) OR
	(c.SegCd <> h.HIST_SegCd) 
) AND
--(c.SalesDivision <> h.HIST_SalesDivision) AND
--(c.ShipTo = 4271748) AND 
(1 = 1)

-- diff = 738 766


-- update (2 of 2)
UPDATE  BRS_CustomerFSC_History
SET
	HIST_MarketClass = c.MarketClass
	, HIST_SegCd = c.SegCd
	, HIST_MarketClass_Old = HIST_MarketClass
	, HIST_SegCd_Old = HIST_SegCd
FROM     BRS_Customer AS c INNER JOIN
             BRS_CustomerFSC_History ON c.ShipTo = BRS_CustomerFSC_History.Shipto AND c.SalesDivision = BRS_CustomerFSC_History.HIST_SalesDivision
WHERE   (BRS_CustomerFSC_History.FiscalMonth BETWEEN 202401 AND 202412) AND (c.MarketClass <> BRS_CustomerFSC_History.HIST_MarketClass) AND (1 = 1) OR
             (BRS_CustomerFSC_History.FiscalMonth BETWEEN 202401 AND 202412) AND (1 = 1) AND (c.SegCd <> BRS_CustomerFSC_History.HIST_SegCd)
-- updated 738 766



--- Free Goods fix for Jan - Apr PL Free goods ADD backck to DS (Gary to fix offsetting ADJ entries)   

-- impacted DS lines
SELECT   
-- TOP (10) 
	FiscalMonth, SalesOrderNumberKEY, GLBU_Class, branch, DocType, LineNumber, SalesOrderNumber, t.item, i.label, AdjCode, FreeGoodsEstInd, AdjNum, AdjNote, t.NetSalesAmt, t.ExtendedCostAmt
FROM     
	BRS_Transaction t 
	LEFT JOIN [dbo].[BRS_Item] i
	ON t.Item = i.Item
where 
(t.FiscalMonth between 202401 and 202404) AND
(t.[AdjCode] = 'XXXFGE') AND
(ISNULL(i.Label, '')='P') AND
(t.DocType <> 'AA') AND
(1=1)
order by ExtendedCostAmt desc
-- ORG 20 883

-- FG PL summary
SELECT   t.FiscalMonth,  t.AdjCode, SUM(t.ExtendedCostAmt) AS gp 
FROM     BRS_Transaction AS t LEFT OUTER JOIN
             BRS_Item AS i ON t.Item = i.Item
WHERE   (1 = 1) AND (ISNULL(i.Label, '') = 'P') AND (t.DocType <> 'AA')
GROUP BY t.FiscalMonth, t.AdjCode
HAVING   (t.FiscalMonth BETWEEN 202401 AND 202404) AND (t.AdjCode = 'XXXFGE')


SELECT   
-- TOP (10) 
	FiscalMonth, SalesOrderNumberKEY, GLBU_Class, branch, Shipto, t.item, DocType, LineNumber, SalesOrderNumber, t.item, i.label, AdjCode, FreeGoodsEstInd, AdjNum, AdjNote, t.NetSalesAmt, t.ExtendedCostAmt, t.ExtChargebackAmt
FROM     
	BRS_Transaction t 
	LEFT JOIN [dbo].[BRS_Item] i
	ON t.Item = i.Item
where 
(t.FiscalMonth between 202401 and 202404) AND
--(t.[AdjCode] = 'AA-005') AND
(t.[AdjNum] = 'AA-005') AND

(t.DocType = 'AA') AND
(1=1)
order by ExtendedCostAmt desc




-- DS code
/*
		-- exclude private label FG as of 4 Apr 24
		CASE WHEN NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 AND ISNULL(i.Label, '')<>'P' THEN 1 ELSE 0 END AS FreeGoodsEstInd,
		CASE WHEN NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 AND ISNULL(i.Label, '')<>'P' THEN 'XXXFGE' ELSE '' END AS AdjCode,
		--	13 Dec 16	tmc		Extend FG tag to adjust note (consistent reporting)
		CASE WHEN NetSalesAmt = 0 AND dt.FreeGoodsEstInd = 1 and buc.FreeGoodsEstInd = 1 AND mpc.FreeGoodsEstInd = 1 AND ISNULL(i.Label, '')<>'P' THEN 'XXXFGE' ELSE '' END AS AdjNote
*/

UPDATE  BRS_Transaction
SET        FreeGoodsEstInd = 0, AdjCode ='', AdjNote ='tc&gw pl retrofix, 21Jan25'
FROM     BRS_Transaction LEFT OUTER JOIN
             BRS_Item AS i ON BRS_Transaction.Item = i.Item
WHERE   (BRS_Transaction.FiscalMonth BETWEEN 202401 AND 202404) AND (BRS_Transaction.AdjCode = 'XXXFGE') AND (ISNULL(i.Label, '') = 'P') AND (BRS_Transaction.DocType <> 'AA') AND (1 = 1)
-- ORG 20 883
-- upd 20 883 !

SELECT   
 TOP (10) 
	FiscalMonth, FreeGoodsEstInd, AdjCode, AdjNote
FROM     
	BRS_Transaction t 
	LEFT JOIN [dbo].[BRS_Item] i
	ON t.Item = i.Item
where 
(t.FiscalMonth between 202401 and 202404) AND
(t.[AdjCode] = 'XXXFGE') AND
(ISNULL(i.Label, '')='P') AND
(t.DocType <> 'AA') AND
(1=1)


-- impacted DS lines for Gary 
SELECT   t.FiscalMonth, t.GLBU_Class, t.Branch, SUM(t.NetSalesAmt) AS Expr1, SUM(t.ExtendedCostAmt) AS ExtendedCostAmt
FROM     BRS_Transaction AS t LEFT OUTER JOIN
             BRS_Item AS i ON t.Item = i.Item
WHERE   (t.AdjCode = 'XXXFGE') AND (ISNULL(i.Label, '') = 'P') AND (t.DocType <> 'AA') AND (1 = 1)
GROUP BY t.FiscalMonth, t.GLBU_Class, t.Branch
HAVING   (t.FiscalMonth BETWEEN 202401 AND 202404)