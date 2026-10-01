-- Service Pro repair rollup, tmc, 25 Nov 25

SELECT TOp 10
*
FROM [Offline].[dbo].[OL_ServiceData]
where [TCPDT] >= 202510

select distinct [Call type]  from [Offline].[dbo].[OL_ServiceData] where [TCPDT] between 202301 and 202512 

-- truncate table zzzshipto2

-- find and review dups - sample
insert into zzzshipto2 
(ST, Note, Note2)

SELECT 
--	top 10
	*
--	distinct  
	-- [JDE order number]

--	,ID
	-- ,[Record Type]
--	,[Invoice #]
--     ,[workorder #]

--	,[JDE order line #]

     -- ,[Call type]
--      ,[TCPDT]
  FROM [Offline].[dbo].[OL_ServiceData] 
  where 
	[workorder #] in('WY01230424'

) AND
--	[Invoice #]= '21913515' AND
--	[TCPDT] between 202401 and 202512 AND
--	[JDE order number] = 0 AND
--	[Record Type] = 'C' AND
--	[JDE order number]   in (1402079, 1402342, 1403528, 1403653, 1496836) AND
	(1=1)
order by [JDE order number], [Call type]
GO


-- find and review dups - all
SELECT 
--	[Invoice #]
	[workorder #]
    ,MIN([Call type])
	,MAX([Call type])
	,SUM([Ext Sell Price])
--      ,[TCPDT]
  FROM [Offline].[dbo].[OL_ServiceData] 
  where 
	[TCPDT] between 202301 and 202512 AND
--	[JDE order number] <> 0 AND
	[Call type] = 'WARR' AND
--	[Call type] like 'PR%' AND
--	[Call type] is null AND
--	[Record Type] = 'C' AND
--	[JDE order number]   in (1402079, 1402342, 1403528, 1403653, 1496836) AND
	(1=1)
GROUP by [workorder #]
--GROUP by [Invoice #]
--having MIN([Call type]) = MAX([Call type])
having MIN([Call type]) <> MAX([Call type])
order by 4 desc
GO
*/

--= load warrenty orders 
-- truncate table zzzshipto2

-- SV vs LE

-- load
insert into zzzshipto2 
	(ST, Note, [Note2])
SELECT 
	[Invoice #]
--	,MIN([workorder #]) minwo
	,MAX([workorder #]) maxwo

--    ,MIN([Call type]) minc
	,MAX([Call type]) maxc
/*
	,[Ext Sell Price]
	,[Item Code]
	,[Item Description]
	,*
*/
--      ,[TCPDT]
  FROM [Offline].[dbo].[OL_ServiceData] d 

--  Inner join [Offline].[dbo].[zzzItem] wo
--  ON d.[workorder #] = wo.[zzzItem]

  where 
	[TCPDT] between 202301 and 202512 AND
--	[workorder #] = 'WY02080439' and
--	[JDE order number] <> 0 AND
--	[Call type] <> 'WARR' AND
--	[Call type] like 'PR%' AND

	[Call type] in ('WARR','PROW','PRIW','HTW','WARM','DSPW','DSCW','PMAW','XWAR','WART','PWAR') and
--	[Warranty Y/N] = 'n' and

--	[Call type] is null AND
--	[Record Type] = 'C' AND
--	[JDE order number]   in (1402079, 1402342, 1403528, 1403653, 1496836) AND
	(1=1)
GROUP by [Invoice #]
--having MIN([Call type]) <> MAX([Call type])
--having MIN([workorder #]) <> MAX([workorder #])
order by 1,2,3 desc
GO

-- warrently service pull
SELECT        
t.ID
,t.[Record Type]
,t.[Invoice #]
,t.[workorder #]
,t.[invoice date]
,t.[Ets order #]
,t.[JDE customer ship to account]
,t.[Warranty Y/N]
,t.[Invoice type Sv/le]
,t.[Call type]

,t.[Primary Technician]
,t.[Item Code]
,t.[Ship Quanity]
,t.[Ext Sell Price]
,t.[Ext File Cost]
,t.TCPDT
,inv.ST invoice
,inv.Note workorder
,inv.Note2 calltype
FROM            OL_ServiceData AS t INNER JOIN
                         zzzShipto2 AS inv ON t.[Invoice #] = inv.ST

/*
-- truncate table [zzzItem]

insert into [zzzItem]
(Item,Note1)
SELECT 
    [Call type]
	,count(*)
  FROM [Offline].[dbo].[OL_ServiceData] 
  where 
	[TCPDT] between 202401 and 202512 AND
	[JDE order number] <> 0 AND
--	[Call type] = 'TRAN' AND
	[Call type] is not null AND
--	[Record Type] = 'C' AND
--	[JDE order number]   in (1402079, 1402342, 1403528, 1403653, 1496836) AND
	(1=1)
GROUP by [Call type]
order by 2 desc
--having MIN([Call type]) = MAX([Call type])
--having MIN([Call type]) <> MAX([Call type])
GO


select Item,Note1 from [zzzItem] where not exists (select * from [nes].[call_type] ct where ct.call_type_code = Item)

-- add missing calltype

insert into [nes].[call_type]
(call_type_code, call_type_descr)
select Item, '.' from [zzzItem] where not exists (select * from [nes].[call_type] ct where ct.call_type_code = Item)

*/

-- truncate table zzzshipto2
-- load
insert into zzzshipto2 
(ST, Note)
SELECT 
	[Invoice #]
    ,MIN([Call type])
  FROM [Offline].[dbo].[OL_ServiceData] 
  where 
	[TCPDT] between 202609 and 202609 AND
--	[JDE order number] <> 0 AND
	[Call type] like 'PR%'  AND
--	[Call type] = 'TRAN' AND
--	[Record Type] = 'C' AND
--	[JDE order number]   in (1402079, 1402342, 1403528, 1403653, 1496836) AND
	(1=1)
GROUP by [Invoice #]
--having MIN([Call type]) = MAX([Call type])
--having MIN([Call type]) <> MAX([Call type])
GO

-- test missing orders from DS (found to be internal)
select ST, Note FROM zzzShipto2 where not exists (Select * from BRS_Transaction t where t.InvoiceNumber = ST) order by 2 desc

Select * from BRS_Transaction t where t.InvoiceNumber = 24291940

-- test missing orders from Comm (why? )

select ST, Note FROM zzzShipto2 where not exists (Select * from [comm].[transaction_F555115] t where t. = ST) order by 2 desc

Select * from [comm].[transaction_F555115] t where t.WSDOCO_salesorder_number = 24291940


/*
-- test dollars1 salesorder - failed
SELECT   RTRIM(zzzShipto2.Note) AS call_type, s.FiscalMonth, s.DocType, SalesDivision, SUM(s.NetSalesAmt) AS sales_amt
FROM     zzzShipto2 INNER JOIN
             BRS_Transaction s ON zzzShipto2.ST = s.SalesOrderNumber
GROUP BY zzzShipto2.Note, s.FiscalMonth, s.DocType, s.SalesDivision
*/

-- test dollars2, invoice -

SELECT   RTRIM(zzzShipto2.Note) AS call_type, s.FiscalMonth, s.DocType, s.SalesOrderNumber, s.InvoiceNumber, SalesDivision, SUM(s.NetSalesAmt) AS sales_amt
FROM     zzzShipto2 INNER JOIN
             BRS_Transaction s ON zzzShipto2.ST = s.InvoiceNumber
where d1_prorepair_ind is null
GROUP BY zzzShipto2.Note, s.FiscalMonth, s.DocType, s.SalesOrderNumber, s.InvoiceNumber, s.SalesDivision

/*
print ('add pro-repair flag')
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	d1_prorepair_ind bit NULL
GO
COMMIT

*/

print ('set pre-repair flag')
UPDATE  BRS_Transaction
SET        d1_prorepair_ind = 1
FROM     zzzShipto2 INNER JOIN
             BRS_Transaction ON zzzShipto2.ST = BRS_Transaction.InvoiceNumber
where d1_prorepair_ind is null

GO

SELECT   s.FiscalMonth, s.ACCOUNT_sales, s.ENTITY_sales, s.BRAND_LINE, s.PRODUCT, s.supplier, SUM(s.NetSalesAmt) AS sales_amt
FROM      [hfm].global_cube s
WHERE d1_prorepair_ind=1 and FiscalMonth between 202608 and 202608
GROUP BY s.FiscalMonth, s.ACCOUNT_sales, s.ENTITY_sales, s.PRODUCT, s.BRAND_LINE, s.SUPPLIER
Order by 1
GO

-- prelim
SELECT   'sales' as src, s.FiscalMonth, SUM(s.NetSalesAmt) AS value_amt
--SELECT   'sales' as src, s.FiscalMonth, s.DocType, s.SalesOrderNumber, s.InvoiceNumber, SalesDivision, SUM(s.NetSalesAmt) AS value_amt
FROM     BRS_Transaction s 
WHERE d1_prorepair_ind=1 and FiscalMonth >= 202601
GROUP BY s.FiscalMonth
--GROUP BY s.FiscalMonth, s.DocType, s.SalesOrderNumber, s.InvoiceNumber, s.SalesDivision

UNION ALL

SELECT   'gp' as src, s.FiscalMonth, SUM(s.NetSalesAmt - s.ExtendedCostAmt) AS value_amt
FROM     BRS_Transaction s 
WHERE d1_prorepair_ind=1 and FiscalMonth >= 202601
GROUP BY s.FiscalMonth
order by 2,1







--WO = WY12130099
--INV = 22383310

/*
-- add workorder and calltype to trans
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	nes_work_order_num char(10) NULL,
	nes_call_type_code char(5) NULL
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_order FOREIGN KEY
	(
	nes_work_order_num
	) REFERENCES nes.[order]
	(
	work_order_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_call_type FOREIGN KEY
	(
	nes_call_type_code
	) REFERENCES nes.call_type
	(
	call_type_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--

BEGIN TRANSACTION
GO
ALTER TABLE nes.call_type ADD
	pro_repair_ind bit NOT NULL CONSTRAINT DF_call_type_pro_repair_ind DEFAULT 0
GO
ALTER TABLE nes.call_type SET (LOCK_ESCALATION = TABLE)
COMMIT
*/

/*

select * from nes.call_type
where call_type_code
in('PRCR'
 ,'PRIW' 
 ,'PRNC' 
 ,'PROC' 
 ,'PROO' 
 ,'PROW' 
 ,'PRPM' 
 ,'PRSH')

UPDATE  nes.call_type
SET        pro_repair_ind = 1
WHERE   (call_type_code IN ('PRCR', 'PRIW', 'PRNC', 'PROC', 'PROO', 'PROW', 'PRPM', 'PRSH'))

select * from nes.call_type
where call_type_code like 'PR%'

*/


select ST, Note FROM zzzShipto2 where not exists (Select * from BRS_Transaction t where t.InvoiceNumber = ST) order by 2 desc
select * from BRS_ItemCategory where LEFT(MinorProductClass,3) in( '810', '820', '830', '840', '850', '860', '880')


-- EQ WarrExt - item

SELECT        i.Item, i.ItemDescription, i.size, i.strength, i.ManufPartNumber, i.Supplier, i.CurrentCorporatePrice, i.CurrentFileCost, i.SalesCategory, i.SubMinorProductCodec, i.comm_group_cd, i.global_product_class, cat.CategoryRollup, cat.global_product_class
FROM            BRS_ItemCategory AS cat INNER JOIN
                         BRS_Item AS i ON cat.MinorProductClass = i.MinorProductClass
WHERE       
 i.SalesCategory in ('EQUIPM', 'HITECH') AND
 (LEFT(cat.global_product_class, 3) IN ('810', '820', '830', '840', '850', '860', '880')) AND
(1=1)

-- EQ WarrExt Sales

SELECT        t.FiscalMonth, t.WSDOCO_salesorder_number, t.WSDCTO_order_type, t.WSLNTY_line_type, t.WSLNID_line_number, t.WS$OSC_order_source_code, t.WSSHAN_shipto, t.WSDGL__gl_date, t.WSLITM_item_number, 
                         t.WSSOQS_quantity_shipped, t.WSPSN__pick_slip_number, t.WSORD__equipment_order, t.WSORDT_order_type, t.WSAC10_division_code, t.WS$O01_number_equipment_serial_01, t.ID, t.source_cd, t.transaction_amt, 
                         t.gp_ext_amt, i.SalesCategory
FROM            comm.transaction_F555115 AS t INNER JOIN
                         BRS_Item AS i ON t.WSLITM_item_number = i.Item
WHERE        (t.FiscalMonth BETWEEN 202301 AND 202512) AND (t.WSDCTO_order_type <> 'AA') AND (i.SalesCategory  in ('EQUIPM', 'HITECH'))
GO
