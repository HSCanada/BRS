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
-- actual (good,tc)
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

id     SalesDate               FiscalMonth PriorFiscalMonth SalesDateLastWeekly     HistorySummaryMonths OffsetDaySeq_Yoy_Fiscal OffsetDaySeq_Yoy_Fiscal_SameDay OffsetDaySeq_Yoy_Fiscal_SameDay_Default PY_SalesDateLastWeekly
------ ----------------------- ----------- ---------------- ----------------------- -------------------- ----------------------- ------------------------------- --------------------------------------- -----------------------
0      2026-09-25 00:00:00.000 202609      202609           2026-09-25 00:00:00.000 25                   364                     0                               0                                       2025-03-28 00:00:00.000

*/


EXEC dbo.monthend_summary_proc @bDebug = 1
-- eta 9m

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

-- add RI
ALTER TABLE [fg].[transaction_F5554240]  WITH CHECK ADD  CONSTRAINT [FK_transaction_F5554240_BRS_TransactionDW] FOREIGN KEY([WKDOCO_salesorder_number], [WKDCTO_order_type], [WKLNNO_line_number])
REFERENCES [dbo].[BRS_TransactionDW] ([SalesOrderNumber], [DocType], [LineNumber])
GO

ALTER TABLE [fg].[transaction_F5554240] CHECK CONSTRAINT [FK_transaction_F5554240_BRS_TransactionDW]
GO



--

-- note:  (fisc = cal for Aug)
delete from [dbo].[BRS_TransactionDW] where [CalMonth] >= 202608

-- 617 369 rows deleted
-- 4 min

-- 617 369 added
-- 4 min

/*
-- dev load 1 - load init
---------------------------------------------------------
Proc: BRS_BE_Transaction_DW_load_proc
Desc: Update DW Table with new transaction details
Mode: DEBUG
---------------------------------------------------------
(0 rows affected)
17. Map Promo tagged TS to Order-level TS Code...

(2474 rows affected)
18. Append Credit lookup table

(0 rows affected)
19a. Update BRS_TransactionDW GEP Promo (retro)

(0 rows affected)
19b. LOAD BRS_TransactionDW

(617369 rows affected)
------------------------------------------------------------------------------------------------------------
20. Free goods estimate model, updated to match Datawarehouse, 12 May 26 
------------------------------------------------------------------------------------------------------------
 

(14205 rows affected)
21. Update SalesDateLastWeekly

(1 row affected)
--------------------------------------------------------------------------------
22. add chargeback side-effect here, copy CB amt from DW to DS, tmc, 17 Dec 17 
--------------------------------------------------------------------------------
 

(3757 rows affected)
--------------------------------------------------------------------------------
23. add FG side-effect here, copy FG flag from DW to DS, tmc, 14 May 26
--------------------------------------------------------------------------------
 

(6137 rows affected)
24. Update Credit Info

(4081 rows affected)
25. Clear STAGE_BRS_TransactionDW

(617369 rows affected)

*/

-- test GEP promo retro
update [dbo].[BRS_TransactionDW]
set [GEP_Order_Flag_ind] = 0,
[GEP_PromotionCode_key] = null,
[GEP_OrderPromotionCode_key] = null
where [CalMonth] = 202608
-- ORG 226878 row
/*
19a. Update BRS_TransactionDW GEP Promo (retro)
(95489 rows affected)
19b. LOAD BRS_TransactionDW
(0 rows affected)
*/

-- test FG retro
update [dbo].[BRS_TransactionDW]
set [FreeGoodsEstInd]= 0
where [CalMonth] = 202609
/*
------------------------------------------------------------------------------------------------------------
No transactions to load.  Skipping to end. 
------------------------------------------------------------------------------------------------------------
 
--------------------------------------------------------------------------------
22. add chargeback side-effect here, copy CB amt from DW to DS, tmc, 17 Dec 17 
--------------------------------------------------------------------------------
 

(0 rows affected)
--------------------------------------------------------------------------------
23. add FG side-effect here, copy FG flag from DW to DS, tmc, 14 May 26
--------------------------------------------------------------------------------
 

(0 rows affected)
*/

-- test Sep reload
delete from [dbo].[BRS_TransactionDW] where [CalMonth] >= 202609
/*19b. LOAD BRS_TransactionDW
(390491 rows affected)
------------------------------------------------------------------------------------------------------------
20. Free goods estimate model, updated to match Datawarehouse, 12 May 26 
------------------------------------------------------------------------------------------------------------
(9413 rows affected)
*/

-- test DW FG est Aug - Oct - good est?  compare with prod, BI


SELECT   
--	TOP (100) 
	dev.SalesOrderNumber, dev.DocType, dev.LineNumber, dev.OrderSourceCode, dev.CalMonth, dev.Date, i.item, i.[MajorProductClass], i.Supplier, i.Label, i.Excl_Code
	, dev.[ChargebackContractNumber], dev.ShippedQty, dev.NetSalesAmt, dev.GPAmt, dev.ExtChargebackAmt, dev.ID, dev.FreeGoodsInvoicedInd, dev.[FreeGoodsEstInd]
	, prod.[ChargebackContractNumber], prod.ShippedQty, prod.NetSalesAmt, prod.GPAmt, prod.ExtChargebackAmt, prod.ID, prod.FreeGoodsInvoicedInd, prod.[FreeGoodsEstInd]
FROM
	BRS_TransactionDW dev

	-- vs prod
	INNER JOIN BRSales..BRS_TransactionDW prod 
	ON  dev.SalesOrderNumber = prod.SalesOrderNumber AND
		dev.DocType = prod.DocType and
		dev.LineNumber = prod.LineNumber

	INNER JOIN BRS_Item i
	ON dev.Item = i.item_usd
WHERE
	dev.CalMonth = 202301 and

	-- out for 20207 - 08 by 5153, mainly handpieces
	-- dev.[FreeGoodsEstInd] <> prod.[FreeGoodsEstInd] and 

	-- good
	-- dev.FreeGoodsInvoicedInd <> prod.FreeGoodsInvoicedInd and

	dev.[FreeGoodsEstInd]  = 1 and
--	dev.ExtChargebackAmt > 0 and
	(1=1)
ORDER BY 
dev.GPAmt asc
-- dev.Date
GO

--  DW fg flag is review: BAD
SELECT
    BRS_TransactionDW.CalMonth,
    Sum(BRS_TransactionDW.ShippedQty) AS SumOfShippedQty,
    Sum(BRS_TransactionDW.NetSalesAmt) AS SumOfNetSalesAmt,
    Sum(BRS_TransactionDW.GPAmt) AS SumOfGPAmt,
    Sum(BRS_TransactionDW.ExtChargebackAmt) AS SumOfExtChargebackAmt,
	count(*) lines
FROM
    BRS_TransactionDW
WHERE
    (((BRS_TransactionDW.CalMonth) >= 202501)) and
    (((BRS_TransactionDW.FreeGoodsEstInd) <> 0))
	(1=1)
GROUP BY
    BRS_TransactionDW.CalMonth
GO

--> prod
-- fix FG est
UPDATE    
	BRS_TransactionDW
SET              
FreeGoodsEstInd = 0
-- SELECT *
FROM         
BRS_TransactionDW s
		
WHERE     
-- optimize for re-run
s.FreeGoodsEstInd =1 and
[CalMonth] >= 202401 AND
(1=1)
-- 15 161 rows


UPDATE    
BRS_TransactionDW
SET              
FreeGoodsEstInd = 1
-- SELECT *
FROM         
BRS_TransactionDW s
		
INNER JOIN BRS_Item AS i 
ON s.Item = i.Item

WHERE     
-- optimize for re-run
s.FreeGoodsInvoicedInd = 1 AND

-- est
s.FreeGoodsEstInd <> 1 AND

-- include
s.NetSalesAmt = 0 AND
s.ShippedQty <> 0 AND
i.[MajorProductClass] in (	'001','002','003','004','005','006','007','008','010','011','012','013','017','019','020','021','022','023','025', '074', '369',
							'054','057','058','124','125','300','316','320','340','364','370','083','082','076','084','355','024','073','071','372', '315') AND

-- exclude
s.DocType <> 'SN' AND
i.Supplier NOT in( 'SIRONC','BAINTE','ROSSCH','IMPEXW','SABLEI','HENGLB','GLHEAL','PROCGA','USENDO','HENSCH','ORTHOT','SOUDEN','FKGDCH') AND
i.Label <> 'P' AND 
i.Item NOT in ('9394930','1381736','9395540') AND
	
-- remove below 3 comments to retro-fix DW FG flags 
/*
EXISTS
(
	Select 
		* 
	From 
		STAGE_BRS_TransactionDW s
	Where 
		SalesOrderNumber = s.JDEORNO And
		DocType = s.ORDOTYCD And
		LineNumber = ROUND(s.LNNO * 1000,0) 
) AND
*/
[CalMonth] >= 202401 AND
(1 = 1)
-- 219639 rows


--  DS fg flag is review: BAD
SELECT
    t.[FiscalMonth],
--    Sum(t.ShippedQty) AS SumOfShippedQty,
    Sum(t.NetSalesAmt) AS SumOfNetSalesAmt,
    Sum(t.[ExtendedCostAmt]) AS SumOfExtendedCostAmt,
    Sum(t.ExtChargebackAmt) AS SumOfExtChargebackAmt,
	count(*) lines
FROM
    BRS_Transaction t
WHERE
    (t.[FiscalMonth] >= 202501) and
    (
--		(t.FreeGoodsEstInd = 1) and
--		([AdjCode] <> 'XXXFGE')

--		(t.FreeGoodsEstInd = 0) and
		([AdjCode] = 'XXXFGE')
	)
GROUP BY
    t.[FiscalMonth]
GO

-- test FG vs ADJ

SELECT   FiscalMonth, FreeGoodsEstInd, AdjCode, SUM(NetSalesAmt) AS sales, SUM(ExtendedCostAmt) AS cost, SUM(ExtChargebackAmt) AS cb
FROM     BRS_Transaction AS t
where 
FiscalMonth between 202607 and 202609 and
AdjCode in ('XXXFGE','FREEGD')
GROUP BY FiscalMonth, AdjCode, FreeGoodsEstInd


-- Sept MTD FG adj
SELECT   FiscalMonth, doctype, SalesOrderNumber, FreeGoodsEstInd, AdjCode, AdjNum, AdjNote, NetSalesAmt,ExtendedCostAmt, ExtChargebackAmt, ID,  SalesOrderNumberKEY, LineNumber, Branch, TerritoryCd, Shipto, GLBU_Class,   GL_BusinessUnit
FROM     BRS_Transaction AS t
where 
FiscalMonth between 202609 and 202609 and
AdjCode in ('FREEGD')
order by  LineNumber



SELECT   FiscalMonth, doctype, FreeGoodsEstInd, AdjCode, NetSalesAmt,ExtendedCostAmt, ExtChargebackAmt
FROM     BRS_Transaction AS t
where 
FiscalMonth between 202607 and 202609 and
AdjCode in ('XXXFGE')
and ExtChargebackAmt <> 0
order by  1

-- fix cb 
UPDATE  BRS_Transaction
SET        ExtChargebackAmt = 0
WHERE   (FiscalMonth BETWEEN 202607 AND 202609) AND (AdjCode IN ('XXXFGE')) AND (ExtChargebackAmt <> 0)

SELECT   FiscalMonth, [SalesOrderNumberKEY], doctype, shipto, item, [GLBU_Class], FreeGoodsEstInd, AdjCode, AdjNote, AdjNum, NetSalesAmt,ExtendedCostAmt, ExtChargebackAmt
FROM     BRS_Transaction AS t
where 
FiscalMonth between 202609 and 202609 and
AdjCode in ('FREEGD')
order by  1

-- match FG to DUT

SELECT   t.FiscalMonth, t.doctype, t.FreeGoodsEstInd, t.AdjCode, t.NetSalesAmt,t.ExtendedCostAmt, t.ExtChargebackAmt,
		dut.FiscalMonth, dut.doctype, dut.FreeGoodsEstInd, dut.AdjCode, dut.NetSalesAmt,dut.ExtendedCostAmt, dut.ExtChargebackAmt
FROM     
	BRS_Transaction AS t

	INNER JOIN DUT_BRSales..BRS_Transaction AS dut
	ON t.id = dut.id
where 
t.FiscalMonth between 202608 and 202608 and
--t.AdjCode in ('XXXFGE')
t.AdjCode <> dut.AdjCode
order by  1

-- fix Aug to org
UPDATE  BRS_Transaction
SET        FreeGoodsEstInd =dut.FreeGoodsEstInd, AdjCode =dut.AdjCode,  ExtChargebackAmt =dut.ExtChargebackAmt
FROM     BRS_Transaction INNER JOIN
             DUT_BRSales.dbo.BRS_Transaction AS dut ON BRS_Transaction.ID = dut.ID AND BRS_Transaction.AdjCode <> dut.AdjCode
WHERE   (BRS_Transaction.FiscalMonth BETWEEN 202608 AND 202608)
--rows = 425


-- remove 

-- Sept MTD FG adj - review
SELECT   FiscalMonth, doctype, SalesOrderNumber, FreeGoodsEstInd,  AdjCode, AdjNum, AdjNote, NetSalesAmt,ExtendedCostAmt, ExtChargebackAmt, ID,  SalesOrderNumberKEY, LineNumber, Branch, TerritoryCd, Shipto, GLBU_Class,   GL_BusinessUnit, GL_Object_Sales, GL_Object_Cost, GL_Object_ChargeBack
FROM     BRS_Transaction AS t
where 
FiscalMonth between 202609 and 202609 and
--AdjNum = 'AA-099' and
AdjNum = 'AA-005' and
--AdjCode in ('FREEGD' ) and
--GL_Object_Cost = 4579       and
(1=1)
order by  LineNumber

-- Sept MTD FG adj - stash
SELECT   FiscalMonth, DocType, SalesOrderNumber, FreeGoodsEstInd, AdjCode, AdjNum, AdjNote, NetSalesAmt, ExtendedCostAmt, ExtChargebackAmt, ID, SalesOrderNumberKEY, LineNumber, Branch, TerritoryCd, Shipto, GLBU_Class, GL_BusinessUnit
INTO       BRS_Transaction_fg_202609_bad_tc
FROM     BRS_Transaction AS t
WHERE   (FiscalMonth BETWEEN 202609 AND 202609) AND (AdjNum = 'AA-005') AND (1 = 1)
-- (72 rows affected)

-- Sept MTD FG adj - remove
DELETE FROM BRS_Transaction
--WHERE   (FiscalMonth BETWEEN 202609 AND 202609) AND (AdjNum = 'AA-099') AND (1 = 1)
WHERE   (FiscalMonth BETWEEN 202609 AND 202609) AND (AdjNum = 'AA-005') AND (1 = 1)