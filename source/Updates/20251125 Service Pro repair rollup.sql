-- Service Pro repair rollup, tmc, 25 Nov 25

SELECT TOp 10
*
FROM [Offline].[dbo].[OL_ServiceData]
where [TCPDT] >= 202510

select distinct [TCPDT] from [Offline].[dbo].[OL_ServiceData]

-- truncate table zzzshipto2

-- find and review dups - sample
insert into zzzshipto2 
(ST, Note, Note2)

SELECT 
	top 10 *
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
--	[workorder #]='WY04240364' AND
	[Invoice #]= '21913515' AND
--	[TCPDT] between 202401 and 202512 AND
--	[JDE order number] = 0 AND
--	[Record Type] = 'C' AND
--	[JDE order number]   in (1402079, 1402342, 1403528, 1403653, 1496836) AND
	(1=1)
order by [JDE order number], [Call type]
GO

-- find and review dups - all
SELECT 
	[Invoice #]
--	[workorder #]
    ,MIN([Call type])
	,MAX([Call type])
	,SUM([Ext Sell Price])
--      ,[TCPDT]
  FROM [Offline].[dbo].[OL_ServiceData] 
  where 
	[TCPDT] between 202401 and 202512 AND
--	[JDE order number] <> 0 AND
--	[Call type] = 'TRAN' AND
	[Call type] like 'PR%' AND
--	[Call type] is null AND
--	[Record Type] = 'C' AND
--	[JDE order number]   in (1402079, 1402342, 1403528, 1403653, 1496836) AND
	(1=1)
--GROUP by [workorder #]
GROUP by [Invoice #]
having MIN([Call type]) = MAX([Call type])
--having MIN([Call type]) <> MAX([Call type])
order by 4 desc
GO

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

-- truncate table zzzshipto2
-- load
insert into zzzshipto2 
(ST, Note)
SELECT 
	[Invoice #]
    ,MIN([Call type])
  FROM [Offline].[dbo].[OL_ServiceData] 
  where 
	[TCPDT] between 202501 and 202510 AND
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

-- test missing orders (found to be internal)
select ST, Note FROM zzzShipto2 where not exists (Select * from BRS_Transaction t where t.InvoiceNumber = ST) order by 2

-- test dollars1 salesorder - failed

SELECT   RTRIM(zzzShipto2.Note) AS call_type, s.FiscalMonth, s.DocType, SalesDivision, SUM(s.NetSalesAmt) AS sales_amt
FROM     zzzShipto2 INNER JOIN
             BRS_Transaction s ON zzzShipto2.ST = s.SalesOrderNumber
GROUP BY zzzShipto2.Note, s.FiscalMonth, s.DocType, s.SalesDivision

-- test dollars2, invoice -

SELECT   RTRIM(zzzShipto2.Note) AS call_type, s.FiscalMonth, s.DocType, s.SalesOrderNumber, s.InvoiceNumber, SalesDivision, SUM(s.NetSalesAmt) AS sales_amt
FROM     zzzShipto2 INNER JOIN
             BRS_Transaction s ON zzzShipto2.ST = s.InvoiceNumber
GROUP BY zzzShipto2.Note, s.FiscalMonth, s.DocType, s.SalesOrderNumber, s.InvoiceNumber, s.SalesDivision


-- add pro-repair flag
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	d1_prorepair_ind bit NULL
GO
COMMIT


-- set flag

UPDATE  BRS_Transaction
SET        d1_prorepair_ind = 1
FROM     zzzShipto2 INNER JOIN
             BRS_Transaction ON zzzShipto2.ST = BRS_Transaction.InvoiceNumber

SELECT   s.FiscalMonth, s.ACCOUNT_sales, s.ENTITY_sales, s.PRODUCT, SUM(s.NetSalesAmt) AS sales_amt
FROM      [hfm].global_cube s
WHERE d1_prorepair_ind=1
GROUP BY s.FiscalMonth, s.ACCOUNT_sales, s.ENTITY_sales, s.PRODUCT



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