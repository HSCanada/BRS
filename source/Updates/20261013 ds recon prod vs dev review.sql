SELECT TOP (1000) [FiscalMonth]
      ,[SalesOrderNumberKEY]
      ,[DocType]
      ,[LineNumber]
      ,[SalesOrderNumber]
      ,[Branch]
      ,[BranchORG]
      ,[GLBU_Class]
      ,[NetSalesAmt]
      ,[ExtendedCostAmt]
      ,[Item]
      ,[Shipto]
      ,[SalesDivision]
      ,[AdjCode]
      ,[AdjNum]
      ,[AdjNote]
      ,[TerritoryCd]
      ,[TerritoryORG]
      ,[InvoiceNumber]
      ,[SalesDate]
      ,[ID]
      ,[OrderSourceCode]
      ,[CustomerPOText1]
      ,[MajorProductClass]
      ,[SalesOrderBillTo]
      ,[ARInvoiceDocType]
      ,[MarketSegment]
      ,[PracticeType]
      ,[LineTypeOrder]
      ,[GLClass]
      ,[AdditionalWarehouse]
      ,[Warehouse]
      ,[GL_BusinessUnit]
      ,[GL_Object_Sales]
      ,[GL_Object_Cost]
      ,[Specialty]
      ,[SpecialtyORG]
      ,[VPA]
      ,[VPAORG]
      ,[StatusCd]
      ,[FreeGoodsEstInd]
      ,[UserAreaTxt]
      ,[ExtChargebackAmt]
      ,[GL_Subsidiary_Sales]
      ,[GL_Subsidiary_Cost]
      ,[GL_Subsidiary_ChargeBack]
      ,[GL_Object_ChargeBack]
      ,[GpsKey]
      ,[gl_account_sales_key]
      ,[gl_account_cost_key]
      ,[gl_account_chargeback_key]
      ,[Excl_Key]
      ,[global_product_class_key]
      ,[GpsKeyORG]
      ,[global_product_class_keyORG]
      ,[ExtChargebackAmtORG]
      ,[d1_prorepair_ind]
  FROM [DEV_BRSales].[dbo].[BRS_Transaction] order by ID desc
  -- last ID in DEV = 45607666 


  --
  SELECT 
  -- top 10 
  [FiscalMonth]
      ,[SalesOrderNumberKEY]
      ,[DocType]
      ,[LineNumber]
      ,[SalesOrderNumber]
      ,[Branch]
      ,[BranchORG]
      ,[GLBU_Class]
      ,[NetSalesAmt]
      ,[ExtendedCostAmt]
      ,[Item]
      ,[Shipto]
      ,[SalesDivision]
      ,[AdjCode]
      ,[AdjNum]
      ,[AdjNote]
      ,[TerritoryCd]
      ,[TerritoryORG]
      ,[InvoiceNumber]
      ,[SalesDate]
      ,[ID]
      ,[OrderSourceCode]
      ,[CustomerPOText1]
      ,[MajorProductClass]
      ,[SalesOrderBillTo]
      ,[ARInvoiceDocType]
      ,[MarketSegment]
      ,[PracticeType]
      ,[LineTypeOrder]
      ,[GLClass]
      ,[AdditionalWarehouse]
      ,[Warehouse]
      ,[GL_BusinessUnit]
      ,[GL_Object_Sales]
      ,[GL_Object_Cost]
      ,[Specialty]
      ,[SpecialtyORG]
      ,[VPA]
      ,[VPAORG]
      ,[StatusCd]
      ,[FreeGoodsEstInd]
      ,[UserAreaTxt]
      ,[ExtChargebackAmt]
      ,[GL_Subsidiary_Sales]
      ,[GL_Subsidiary_Cost]
      ,[GL_Subsidiary_ChargeBack]
      ,[GL_Object_ChargeBack]
      ,[GpsKey]
      ,[gl_account_sales_key]
      ,[gl_account_cost_key]
      ,[gl_account_chargeback_key]
      ,[Excl_Key]
      ,[global_product_class_key]
      ,[GpsKeyORG]
      ,[global_product_class_keyORG]
      ,[ExtChargebackAmtORG]
      ,[d1_prorepair_ind]
  FROM [BRSales].[dbo].[BRS_Transaction] 
  where 
-- actual (good
,tc)
--   [DocType] <> 'AA' and
-- adj
   [DocType] = 'AA' and
   FiscalMonth < 202609 and
  -- [FiscalMonth]>= 202609 and
  -- trx Post Gary W (from Dev)
  iD > 45607666  and
  (1=1)
  order by FiscalMonth asc


--FROM [BRSales].[dbo].[BRS_Transaction] order by ID desc

  -- last trans in prod ID 45849193


  -- backup DEV summary tables

SELECT   *
INTO       BRS_AGG_CDBGAD_Sales_recon_q3
FROM     BRS_AGG_CDBGAD_Sales
  

SELECT   *
INTO       BRS_AGG_CMBGAD_Sales_recon_q3
FROM     BRS_AGG_CMBGAD_Sales

SELECT   *
INTO       BRS_Config_recon_q3
FROM     BRS_Config

-- show July config

SELECT  [id]
      ,[SalesDate]
      ,[FiscalMonth]
      ,[PriorFiscalMonth]
      ,[SalesDateLastWeekly]
      ,[HistorySummaryMonths]
      ,[OffsetDaySeq_Yoy_Fiscal]
      ,[OffsetDaySeq_Yoy_Fiscal_SameDay]
      ,[OffsetDaySeq_Yoy_Fiscal_SameDay_Default]
      ,[PY_SalesDateLastWeekly]
  FROM [dbo].[BRS_Config]

/*
id     SalesDate               FiscalMonth PriorFiscalMonth SalesDateLastWeekly     HistorySummaryMonths OffsetDaySeq_Yoy_Fiscal OffsetDaySeq_Yoy_Fiscal_SameDay OffsetDaySeq_Yoy_Fiscal_SameDay_Default PY_SalesDateLastWeekly
------ ----------------------- ----------- ---------------- ----------------------- -------------------- ----------------------- ------------------------------- --------------------------------------- -----------------------
0      2026-07-31 00:00:00.000 202607      202607           2026-07-31 00:00:00.000 25                   364                     0                               0                                       2025-03-28 00:00:00.000
*/


EXEC dbo.monthend_summary_proc @bDebug = 1



-- 

--
SELECT 
	[FiscalMonth]
	,count(*)
	,sum([NetSalesAmt]) sales_dev
	,sum([ExtendedCostAmt]) extcost_dev
	,sum([ExtChargebackAmt]) extcb_dev
	,'dev' as source
  FROM [DEV_BRSales].[dbo].[BRS_Transaction] 
  where [FiscalMonth] between 202501 and 202607
  GROUP by [FiscalMonth]

SELECT 
	[FiscalMonth]
	,count(*)
	,sum([NetSalesAmt]) sales_prod
	,sum([ExtendedCostAmt]) extcost_prod
	,sum([ExtChargebackAmt]) extcb_prod

	,'prod' as source
  FROM [BRSales].[dbo].[BRS_Transaction] 
  where [FiscalMonth] between 202501 and 202607
  GROUP by [FiscalMonth]


--
-- detail review
SELECT 
--	TOP (100) 

	dev.[FiscalMonth]
	,dev.SalesDate
	,dev.[SalesOrderNumberKEY]
	,dev.[DocType]
	,dev.[LineNumber]
	,dev.[SalesOrderNumber]
	,dev.[Branch]
	,dev.[GLBU_Class]

	,dev.[AdjCode]
	,dev.[FreeGoodsEstInd]

	,dev.[NetSalesAmt]
	,dev.[ExtendedCostAmt]
	,dev.[ExtChargebackAmt]

	--> fix this
	,prod.[AdjCode]				AdjCode_prod
	,prod.[FreeGoodsEstInd]		FreeGoodsEstInd_prod
	,prod.[NetSalesAmt]			NetSalesAmt_prod
	,prod.[ExtendedCostAmt]		ExtendedCostAmt_prod
	,prod.[ExtChargebackAmt]	ExtChargebackAmt_prod
	--< fix this

	,dev.[Item]
	,dev.[Shipto]
	,dev.[SalesDivision]
	,dev.[AdjNum]
	,dev.[AdjNote]
	,dev.[ID]
  FROM 
	[DEV_BRSales].[dbo].[BRS_Transaction] dev

	INNER JOIN 	[BRSales].[dbo].[BRS_Transaction] prod
	ON prod.id = dev.id

  where 

-- testing one-offs (ignore)
-- 	(dev.[SalesOrderNumberKEY] <> prod.[SalesOrderNumberKEY]) AND
--	(dev.[AdjCode] <> 'XXXFGE') and
--	ISNULL(prod.[ExtChargebackAmt],0) <> 0 and
--	(dev.[AdjCode] = 'XXXFGE') and
--	(dev.[AdjCode] <> 'XXXFGE') and


-- final adj test 1. Jan 2025 to Aug 2026
,good
--	(dev.[FiscalMonth] between 202501 and 202608) AND

--	(dev.[FreeGoodsEstInd] <> prod.[FreeGoodsEstInd]) and
--	(dev.[AdjCode] <> prod.[AdjCode]) and
--	(dev.[NetSalesAmt]	 <> prod.[NetSalesAmt]) and
--	(dev.[ExtendedCostAmt] <> prod.[ExtendedCostAmt]) and
--	ISNULL(dev.[ExtChargebackAmt],0) <> ISNULL(prod.[ExtChargebackAmt],0) and

-- final adj test 2. sep 15 MTD (partial)
	(dev.[FiscalMonth] between 202609 and 202609) AND

-- good
--	(dev.[NetSalesAmt]	 <> prod.[NetSalesAmt]) and
--	(dev.[ExtendedCostAmt] <> prod.[ExtendedCostAmt]) and
--	ISNULL(dev.[ExtChargebackAmt],0) <> ISNULL(prod.[ExtChargebackAmt],0) and

-- bad
	(dev.[AdjCode] <> prod.[AdjCode]) and
	-- diff rows 3 451

--	(dev.[FreeGoodsEstInd] = prod.[FreeGoodsEstInd]) and
	-- diff rows 
	-- bad rows 140 704

	(1=1)
  order by ISNULL(dev.[ExtChargebackAmt],0)

--  order by dev.[FiscalMonth]
,dev.SalesDate
GO
--

-- detail review (oops
,XXXFGE broken as well
SELECT 
--	TOP (100) 
	[FiscalMonth]
	,SalesDate
	,[SalesOrderNumberKEY]
	,[DocType]
	,[LineNumber]
	,[SalesOrderNumber]
	,[Branch]
	,[GLBU_Class]
	,[FreeGoodsEstInd]

	,[NetSalesAmt]
	,[ExtendedCostAmt]
	,[ExtChargebackAmt]

	,[Item]
	,[Shipto]
	,[SalesDivision]
	,[AdjCode]
	,[AdjNum]
	,[AdjNote]
	,[ID]
  FROM 
	[dbo].[BRS_Transaction] 

  where 
	([FiscalMonth] between 202501 and 202610) AND


--	([AdjCode] <> 'XXXFGE') and
--	([FreeGoodsEstInd] = 1) and

--	([AdjCode] = 'XXXFGE') and
--	([FreeGoodsEstInd] <> 1) and

	([AdjCode] = 'XXXFGE') and
	ISNULL([ExtChargebackAmt],0) <> 0 and

	(1=1)
  order by SalesDate asc


--
-- fix prod cb from dev
SELECT 

	prod.[ExtChargebackAmt]

  FROM 
	[DEV_BRSales].[dbo].[BRS_Transaction] dev

	INNER JOIN 	[BRSales].[dbo].[BRS_Transaction] prod
	ON prod.id = dev.id

  where 
	-- slow
	(dev.[FiscalMonth] between 202501 and 202608) AND
	ISNULL(dev.[ExtChargebackAmt],0) <> ISNULL(prod.[ExtChargebackAmt],0) and
	(1=1)

-- fix cb
UPDATE  
	BRS_Transaction
SET
	ExtChargebackAmt = ISNULL(dev.ExtChargebackAmt
,0)
FROM
	DEV_BRSales.dbo.BRS_Transaction AS dev 
	
	INNER JOIN BRS_Transaction 
	ON BRS_Transaction.ID = dev.ID AND 
	ISNULL(dev.ExtChargebackAmt
,0) <> ISNULL(BRS_Transaction.ExtChargebackAmt
,0)
WHERE   (dev.FiscalMonth BETWEEN 202501 AND 202608)


-- fix adjnote
UPDATE  
	BRS_Transaction
SET
	[AdjCode] = dev.[AdjCode]
FROM
	DEV_BRSales.dbo.BRS_Transaction AS dev 
	
	INNER JOIN BRS_Transaction 
	ON BRS_Transaction.ID = dev.ID AND 
	(dev.[AdjCode] <> BRS_Transaction.[AdjCode]) 

WHERE   
(dev.FiscalMonth BETWEEN 202501 AND 202608) and
--(dev.FiscalMonth BETWEEN 202601 AND 202606)
(1=1)

--should be 140161

-- fix est

UPDATE  
	BRS_Transaction
SET
	[FreeGoodsEstInd] = dev.[FreeGoodsEstInd]
FROM
	DEV_BRSales.dbo.BRS_Transaction AS dev 
	
	INNER JOIN BRS_Transaction 
	ON BRS_Transaction.ID = dev.ID AND 
	(dev.[FreeGoodsEstInd] <> BRS_Transaction.[FreeGoodsEstInd]) 

WHERE   
(dev.FiscalMonth BETWEEN 202501 AND 202608) and
--(dev.FiscalMonth BETWEEN 202601 AND 202606)
(1=1)


-- fix 202610
-- review  FG / CB for Oct 2026
,things good?

SELECT w.SalesOrderNumber
,w.DocType
,w.LineNumber
,w.Item
,w.FreeGoodsInvoicedInd
,w.FreeGoodsEstInd
,'DS fields to follow->'
, t.[FiscalMonth]
,t.FreeGoodsEstInd
,t.ExtendedCostAmt
,t.[ExtChargebackAmt]
,t.AdjCode
,t.AdjNote
,i.Excl_Code
,i.Supplier
,i.MajorProductClass
FROM        
	-- DW has best FG Est flag
	BRS_TransactionDW AS w 
	-- DS needs to be synced
	INNER JOIN BRS_Transaction t

	-- this joins DW to DS
	ON w.SalesOrderNumber = t.SalesOrderNumberKEY AND 
		w.DocType = t.DocType AND
		w.LineNumber = t.LineNumber AND 

		-- test key fields to ensure join is 100%
,keep for safety
		w.Date = t.SalesDate AND 
		w.Shipto = t.Shipto AND
		w.Item = t.Item AND 
		w.LineTypeOrder = t.LineTypeOrder

	INNER JOIN BRS_Item i
	ON w.Item = i.Item

WHERE     
	(t.FreeGoodsEstInd <> w.FreeGoodsEstInd)  AND

	t.[FiscalMonth] between 202610 and 202610 and
	(1 = 1)
order by  t.[FiscalMonth]

-- test DS vs DW  14 Sept+

-- DS vs DW test 
SELECT 
	TOP (100) 

	-- DW
	dw.Date
	,dw.[SalesOrderNumber]
	,dw.[DocType]
	,dw.[LineNumber]
	,dw.[SalesOrderNumber]
	,dw.*

	-- DS
	,ds.[FiscalMonth]
	,ds.SalesDate
	,ds.[SalesOrderNumberKEY]
	,ds.[DocType]
	,ds.[LineNumber]
	,ds.[SalesOrderNumber]
	,ds.[Branch]
	,ds.[GLBU_Class]

	,ds.[AdjCode]
	,ds.[FreeGoodsEstInd]

	,ds.[NetSalesAmt]
	,ds.[ExtendedCostAmt]
	,ds.[ExtChargebackAmt]

	--> fix this
	,ds.Item					ItemDS
	,dw.item					ItemDW

	,dw.[FreeGoodsEstInd]		FreeGoodsEstInd_prod
	,dw.[NetSalesAmt]			NetSalesAmt_prod
--	,dw.[ExtendedCostAmt]		ExtendedCostAmt_prod
	,dw.[ExtChargebackAmt]	ExtChargebackAmt_prod
	--< fix this

	,ds.[Item]
	,ds.[Shipto]
	,ds.[SalesDivision]
	,ds.[AdjNum]
	,ds.[AdjNote]
	,ds.[ID]
  FROM 
	[dbo].[BRS_Transaction] ds

	RIGHT JOIN [dbo].[BRS_TransactionDW] dw ON
		(ds.[SalesOrderNumberKEY]  = dw.[SalesOrderNumber]) and
		(ds.[DocType] = dw.[DocType])	and
		(ds.[LineNumber] = dw.[LineNumber]) and
		(ds.[SalesOrderNumberKEY] = 19458688) and
		(1=1)

  where 
	(dw.CalMonth >= 202510) and
	(dw.Date >= '2026-10-01') and
	(ds.[SalesOrderNumberKEY] is null) and 
	(1=1)
order by  dw.Date

--  order by ISNULL(dev.[ExtChargebackAmt],0)

--  order by dev.[FiscalMonth]
,dev.SalesDate
GO
--

--

SELECT 
	w.SalesOrderNumber
	,w.DocType
	,w.LineNumber
	,w.Item
	,w.MajorProductClass
	,w.FreeGoodsInvoicedInd
	,w.FreeGoodsEstInd
	, 'ds ->' as note
	,t.FreeGoodsEstInd
	,t.FiscalMonth
	,t.ExtendedCostAmt
	,t.[ExtChargebackAmt]
	,t.AdjCode
	,t.AdjNote
FROM         
	BRS_TransactionDW AS w 

	INNER JOIN BRS_Transaction t
	ON w.SalesOrderNumber = t.SalesOrderNumberKEY AND 
		w.DocType = t.DocType AND
		w.LineNumber = t.LineNumber AND 

		-- needed?
		w.Date = t.SalesDate AND 
		w.Shipto = t.Shipto AND
		w.Item = t.Item AND 
		w.LineTypeOrder = t.LineTypeOrder
WHERE     
	(t.FreeGoodsEstInd <> w.FreeGoodsEstInd)  AND

	[CalMonth] = 202610 AND
	(1 = 1)
ORDER BY ExtendedCostAmt desc
GO


SELECT   CalMonth, date, SUM(ShippedQty) AS SumOfShippedQty, SUM(NetSalesAmt) AS SumOfNetSalesAmt, SUM(GPAmt) AS SumOfGPAmt, SUM(ExtChargebackAmt) AS SumOfExtChargebackAmt
FROM     BRS_TransactionDW
WHERE   (FreeGoodsEstInd = 1) AND (CalMonth >= 202601)
GROUP BY CalMonth, Date
order by date

-- FG fix 18 Oct 25

-- delete from Aug DW in DEV to allow reload 

-- remove RI to allow brute delete
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240
	DROP CONSTRAINT FK_transaction_F5554240_BRS_TransactionDW
GO
ALTER TABLE fg.transaction_F5554240
	DROP CONSTRAINT FK_transaction_F5554240_BRS_TransactionDW1
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- note:  (fisc = cal for Aug)
delete from [dbo].[BRS_TransactionDW] where [CalMonth] >= 202608
-- xx min


