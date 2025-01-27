-- DS BI BE update, tmc, 25 Jun 24
-- updated 24 Oct 24


-- GLBU net sales calc

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnitClass
	DROP CONSTRAINT DF_BRS_BusinessUnitClass_planning_ro_amt
GO
ALTER TABLE dbo.BRS_BusinessUnitClass
	DROP COLUMN planning_ro_amt, planning_ro_text
GO
ALTER TABLE dbo.BRS_BusinessUnitClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnitClass ADD
	planning_ro_sales_amt money NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_planning_ro_sales_amt DEFAULT 0,
	planning_ro_gp_amt money NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_planning_ro_gp_amt DEFAULT 0,

	planning_ro_text varchar(50) NULL
GO
ALTER TABLE dbo.BRS_BusinessUnitClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- PPE built table

SELECT distinct [CategoryRollupPPE]
  FROM [BRS_AGG_CDBGAD_Sales]
GO

-- drop table dbo.BRS_DS_PPE

SELECT DISTINCT CategoryRollupPPE
INTO       dbo.BRS_DS_PPE
FROM     BRS_AGG_CDBGAD_Sales
GO

-- xx
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_DS_PPE ADD
	ppe_descr varchar(30) NULL
GO
ALTER TABLE dbo.BRS_DS_PPE ADD CONSTRAINT
	BRS_DS_PPE_c_pk PRIMARY KEY CLUSTERED 
	(
	CategoryRollupPPE
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE dbo.BRS_DS_PPE SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_DS_PPE ADD
	ppe_key int  NOT NULL Identity(1,1)
GO
ALTER TABLE dbo.BRS_DS_PPE SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

select * from BRS_DS_PPE


-- add RI

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales ADD CONSTRAINT
	FK_BRS_AGG_CDBGAD_Sales_BRS_DS_PPE FOREIGN KEY
	(
	CategoryRollupPPE
	) REFERENCES dbo.BRS_DS_PPE
	(
	CategoryRollupPPE
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemCategory ADD CONSTRAINT
	FK_BRS_ItemCategory_BRS_DS_PPE FOREIGN KEY
	(
	CategoryRollupPPE
	) REFERENCES dbo.BRS_DS_PPE
	(
	CategoryRollupPPE
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_ItemCategory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_DS_PPE ADD
	disp_ppe_group_cd char(10) NOT NULL CONSTRAINT DF_BRS_DS_PPE_disp_ppe_group_cd DEFAULT ''
GO
ALTER TABLE dbo.BRS_DS_PPE ADD CONSTRAINT
	FK_BRS_DS_PPE_BRS_DS_PPE FOREIGN KEY
	(
	disp_ppe_group_cd
	) REFERENCES dbo.BRS_DS_PPE
	(
	CategoryRollupPPE
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_DS_PPE SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


update BRS_DS_PPE
set ppe_descr = 'Gloves', [disp_ppe_group_cd] = 'PPE-GLOV'
where CategoryRollupPPE = 'PPE-GLOV'

update BRS_DS_PPE
set ppe_descr = 'other PPE/IC', [disp_ppe_group_cd] = 'PPE-INFCON'
where CategoryRollupPPE like 'PPE%' and CategoryRollupPPE <> 'PPE-GLOV'


update BRS_DS_PPE
set ppe_descr = 'zNonPPE'
where ppe_descr is null


-- pop RO for Jun
SELECT   GLBU_Class, ReportingClass, planning_ro_sales_amt, planning_ro_gp_amt, planning_ro_text
FROM     BRS_BusinessUnitClass 
order by 2, 1
-- where ReportingClass = 'NSA' and planning_ro_text is null


UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 27635000, planning_ro_gp_amt = 10629928, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'MERCH')
GO
	

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 8487220, planning_ro_gp_amt = 2826244, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'EQUIP')
GO

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 2512780, planning_ro_gp_amt = 809115, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'HITEC')
GO
	
UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 2291422, planning_ro_gp_amt= 2180758 , planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'LABOU')
GO
	
UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 2268025, planning_ro_gp_amt= 1028467 ,planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'PARTS')
GO
	
UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 1300000, planning_ro_gp_amt= 479700, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'TEETH')
GO
	

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 514999, planning_ro_gp_amt= 417580, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'DTXSP')
GO

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 371658, planning_ro_gp_amt= 146954, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'MEDIC')
GO
	
UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 231899, planning_ro_gp_amt= 100181, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'DTXHW')
GO
	
UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 80069, planning_ro_gp_amt= 80069, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'LEASE')
GO
	

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 71531 , planning_ro_gp_amt=71531, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'FRTEQ')
GO

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 63776, planning_ro_gp_amt=63776, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'FREIG')
GO
		

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 4962, planning_ro_gp_amt=4962, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'ALLOM')
GO
	

	
UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 3505, planning_ro_gp_amt=3505, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'BSOLN')
GO
	

	
UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = -691689, planning_ro_gp_amt= -691689, planning_ro_text = 'RO202406'
WHERE   (GLBU_Class = 'REBAT')
GO

-- Gary math

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = -41555, planning_ro_gp_amt=-41555 , planning_ro_text = 'RO202406gw'
WHERE   (GLBU_Class = 'PROMM')
GO

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = -27159, planning_ro_gp_amt= -27159, planning_ro_text = 'RO202406gw'
WHERE   (GLBU_Class = 'PROME')
GO
	

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = -37722 , planning_ro_gp_amt= -37722, planning_ro_text = 'RO202406gw'
WHERE   (GLBU_Class = 'THRVM')
GO

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = -24654, planning_ro_gp_amt=  -24654, planning_ro_text = 'RO202406gw'
WHERE   (GLBU_Class = 'THRVE')
GO

UPDATE  BRS_BusinessUnitClass
SET        planning_ro_sales_amt = 0, planning_ro_gp_amt=  0, planning_ro_text = 'RO202406gw'
WHERE   (GLBU_Class in ('ALLOE'
,'ALLOT'
,'PROMC'
,'PROML'
,'PROMX'
,'CAMLG'
,'EXNSW'
,'ZZZZZ'

))
GO

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX BRS_DS_PPE_u_idx ON dbo.BRS_DS_PPE
	(
	ppe_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_DS_PPE SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--> broken?
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales ADD CONSTRAINT
	FK_BRS_AGG_CDBGAD_Sales_BRS_ppe2 FOREIGN KEY
	(
	ppe_key
	) REFERENCES dbo.BRS_DS_PPE
	(
	ppe_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_AGG_CDBGAD_Sales SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

UPDATE  BRS_AGG_CDBGAD_Sales
SET        ppe_key = BRS_DS_PPE.ppe_key
FROM     BRS_AGG_CDBGAD_Sales INNER JOIN
             BRS_DS_PPE ON BRS_AGG_CDBGAD_Sales.CategoryRollupPPE = BRS_DS_PPE.CategoryRollupPPE
--< broken?



-- create DS GL reporing rollup
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnitClass ADD
	GLBU_ClassDS_L1_desc varchar(50) NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_ClassDS_L1_desc DEFAULT '',
	GLBU_ClassDS_L2_desc varchar(50) NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_ClassDS_L2_desc DEFAULT '',
	GLBU_ClassDS_L3_desc varchar(50) NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_ClassDS_L3_desc DEFAULT '',
	GLBU_ClassDS_Reporting_desc varchar(50) NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_ClassDS_Reporting_desc DEFAULT '',
	GLBU_ClassDS_L1_sort smallint NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_ClassDS_L1_sort DEFAULT 0,
	GLBU_ClassDS_L2_sort smallint NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_ClassDS_L2_sort DEFAULT 0,
	GLBU_ClassDS_L3_sort smallint NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_ClassDS_L3_sort1 DEFAULT 0,
	GLBU_ClassDS_Reporting_sort smallint NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_GLBU_ClassDS_Reporting_sort DEFAULT 0
GO
ALTER TABLE dbo.BRS_BusinessUnitClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- update GL hiearchy based on below

SELECT   GLBU_Class, GLBU_ClassNm, ReportingClass, GLBU_ClassDS_L1_desc, GLBU_ClassDS_L1_sort, GLBU_ClassDS_L2_desc, GLBU_ClassDS_L2_sort, GLBU_ClassDS_L3_desc, GLBU_ClassDS_L3_sort, GLBU_ClassDS_Reporting_desc, GLBU_ClassDS_Reporting_sort
FROM     BRS_BusinessUnitClass




-- rollup data for BRS_BusinessUnitClass

SELECT  [GLBU_Class]
      ,[planning_ro_sales_amt]
      ,[planning_ro_gp_amt]
      ,[planning_ro_text]
	  ,(REPLACE(REPLACE(REPLACE(GLBU_ClassDS_L1_desc, CHAR(13), ''), CHAR(10), ''), ' ', '')) AS GLBU_ClassDS_L1_desc
	  ,(REPLACE(REPLACE(REPLACE(GLBU_ClassDS_L2_desc, CHAR(13), ''), CHAR(10), ''), ' ', '')) AS GLBU_ClassDS_L2_desc
	  ,(REPLACE(REPLACE(REPLACE(GLBU_ClassDS_L3_desc, CHAR(13), ''), CHAR(10), ''), ' ', '')) AS GLBU_ClassDS_L3_desc

      ,[GLBU_ClassDS_Reporting_desc]
      ,[GLBU_ClassDS_L1_sort]
      ,[GLBU_ClassDS_L2_sort]
      ,[GLBU_ClassDS_L3_sort]
      ,[GLBU_ClassDS_Reporting_sort]
  FROM [DEV_BRSales].[dbo].[BRS_BusinessUnitClass]


/*

select top 10 * from [BRS_BusinessUnitClass]

-- setting the rolllups, manually
-- tbd
GLBU_Class|planning_ro_sales_amt|planning_ro_gp_amt|planning_ro_text|GLBU_ClassDS_L1_desc|GLBU_ClassDS_L2_desc|GLBU_ClassDS_L3_desc|GLBU_ClassDS_Reporting_desc|GLBU_ClassDS_L1_sort|GLBU_ClassDS_L2_sort|GLBU_ClassDS_L3_sort|GLBU_ClassDS_Reporting_sort
     |0.00|0.00|NULL|.||||0|0|0|0
ALLOE|0.00|0.00|RO202406gw|AllowanceEquip|AllowanceforReturns|TotalEquipment|Net Sales|584|580|200|200
ALLOM|4962.00|4962.00|RO202406|AllowanceMerch|AllowanceforReturns|TotalMerch&SmallEquipment|Net Sales|580|580|100|200
ALLOT|0.00|0.00|RO202406gw|AllowanceTeeth|AllowanceforReturns|Teeth,beforerebates|Net Sales|582|580|580|200
BSOLN|3505.00|3505.00|RO202406|BusinessSolutions|BusinessSolutions|BusinessSolutions|Gross Sales|150|150|150|100
CAMLG|0.00|0.00|RO202406gw|.|zExcluded|zExcluded|Gross Sales|145|999|999|100
DTXHW|231899.00|100181.00|RO202406|ComputerEquipment|ComputerEquipment|TotalEquipment|Gross Sales|430|430|200|100
DTXSP|514999.00|417580.00|RO202406|HSOneSupport|HSOneSoftware&Support|HSOneSoftware&Support|Gross Sales|400|400|400|100
DTXSW|0.00|0.00|NULL|HSOneSoftware|HSOneSoftware&Support|HSOneSoftware&Support|Gross Sales|410|400|400|100
EQDIG|0.00|0.00|NULL|HiTechDigitalEquip|HiTechDigital/OtherEquip|TotalEquipment|Gross Sales|200|200|200|100
EQUIP|8487220.00|2826244.00|RO202406|LargeEquipment|LargeEquipment|TotalEquipment|Gross Sales|230|230|200|100
EXNSW|0.00|0.00|RO202406gw|Exan|Exan|HSOneSoftware&Support|Gross Sales|420|420|400|100
FREIG|63776.00|63776.00|RO202406|DeliveryRecovery(Merch/Teeth)|DeliveryRecovery(Merch/Teeth)|TotalMerch&SmallEquipment|Gross Sales|500|500|100|100
FRTEQ|71531.00|71531.00|RO202406|DeliveryRecovery(Equip)|DeliveryRecovery(Equip)|TotalEquipment|Gross Sales|510|510|200|100
HICAD|0.00|0.00|NULL|HiTechCadCam|HiTechDigital/OtherEquip|TotalEquipment|Gross Sales|210|200|200|100
HITEC|2512780.00|809115.00|RO202406|HiTechEquipment|HiTechEquipment|TotalEquipment|Gross Sales|220|220|200|100
LABOU|2291422.00|2180758.00|RO202406|Labour|Parts&Service|Parts&Service|Gross Sales|310|300|300|100
LEASE|80069.00|80069.00|RO202406|HSFSLeasing|HSFSLeasing|TotalEquipment|Gross Sales|440|440|200|100
MECAD|0.00|0.00|NULL|Merchandise-HiTec|Merchandise,beforerebates|TotalMerch&SmallEquipment|Gross Sales|110|100|100|100
MECAZ|0.00|0.00|NULL|Merchandise-HiTecZahn|Merchandise,beforerebates|TotalMerch&SmallEquipment|Gross Sales|120|100|100|100
MEDIC|371658.00|146954.00|RO202406|MedicalCustomers(Merchandise)|MedicalCustomers(Merchandise)|MedicalCustomers(Merchandise)|Gross Sales|160|160|160|100
MERCH|27635000.00|10629928.00|RO202406|Merchandise|Merchandise,beforerebates|TotalMerch&SmallEquipment|Gross Sales|100|100|100|100
PARTS|2268025.00|1028467.00|RO202406|Parts|Parts&Service|Parts&Service|Gross Sales|300|300|300|100
PROMC|0.00|0.00|RO202406gw|.|zExcluded|zExcluded|Net Sales|0|999|999|200
PROME|-27159.00|-27159.00|RO202406gw|PromoEquip|SalesPromotions|TotalEquipment|Net Sales|530|550|200|200
PROML|0.00|0.00|RO202406gw|PromoLease|SalesPromotions|TotalEquipment|Net Sales|540|550|200|200
PROMM|-41555.00|-41555.00|RO202406gw|PromoMerch|SalesPromotions|TotalMerch&SmallEquipment|Net Sales|550|550|100|200
PROMX|0.00|0.00|RO202406gw|.|zExcluded|zExcluded|Net Sales|0|999|999|200
REBAT|-691689.00|-691689.00|RO202406|RebateProvision|RebateProvision|TotalMerch&SmallEquipment|Net Sales|520|520|100|200
SMEQU|0.00|0.00|NULL|SmallEquipment(SE)|SmallEquipment(SE)|TotalMerch&SmallEquipment|Gross Sales|130|130|100|100
TEETH|1300000.00|479700.00|RO202406|Teeth,beforerebates|Teeth,beforerebates|Teeth,beforerebates|Gross Sales|140|140|580|100
THRVE|-24654.00|-24654.00|RO202406gw|ThriveEquip|ThriveRewards|TotalEquipment|Net Sales|570|560|200|200
THRVM|-37722.00|-37722.00|RO202406gw|ThriveMerch|ThriveRewards|TotalMerch&SmallEquipment|Net Sales|560|560|100|200
VETER|0.00|0.00|NULL|MedicalVet|MedicalCustomers(Merchandise)|MedicalCustomers(Merchandise)|Gross Sales|165|160|160|100
ZZZZZ|0.00|0.00|RO202406gw|zExcluded|zExcluded|zExcluded|Gross Sales|999|999|999|100
*/

-- Phase2 begins!

---- updated 24 Oct 24

-- Test1: [dbo].[BRS_TransactionDW] vs [dbo].[BRS_TransactionDW_Ext] RI

select count(*) from [dbo].[BRS_TransactionDW] t where not exists (SELECT * from [dbo].[BRS_TransactionDW_Ext] ext where t.SalesOrderNumber = ext.SalesOrderNumber and t.DocType = ext.DocType)
-- ORG 11 405 599
-- Missing = 0

-- test2: [dbo].[BRS_Transaction] vs [dbo].[BRS_TransactionDW_Ext] RI
select count(*) from [dbo].[BRS_Transaction] t where not exists (SELECT * from [dbo].[BRS_TransactionDW_Ext] ext where t.SalesOrderNumber = ext.SalesOrderNumber and t.DocType = ext.DocType)
-- ORG 11 572 531
-- Missing = 0

-- test3: [dbo].[BRS_TransactionDW] vs [dbo].[BRS_Transaction]

select count(*), min(t.date), max(t.date) from [dbo].[BRS_TransactionDW] t where t.date >= '2024-01-01' and t.date <= '2024-01-30' and not exists (SELECT * from [dbo].[BRS_Transaction] ext where t.SalesOrderNumber = ext.SalesOrderNumber and t.DocType = ext.DocType and t.LineNumber = ext.LineNumber)

select t.*  from [dbo].[BRS_TransactionDW] t where t.date >= '2021-01-01' and t.date <= '2024-09-18' and t.item > '0' and t.GLBusinessUnit not in( '020099990000') and linetypeorder<>'M2' and not exists (SELECT * from [dbo].[BRS_Transaction] ext where t.SalesOrderNumber = ext.SalesOrderNumber and t.DocType = ext.DocType and t.LineNumber = ext.LineNumber) order by 9 desc


-- test4: [dbo].[BRS_Transaction] vs [dbo].[BRS_TransactionDW], less DS adj
--select count(*), min(t.salesdate), max(t.salesdate) from [dbo].[BRS_Transaction] t where t.doctype <> 'AA' AND t.SalesDate >= '2021-01-01' and t.SalesDate <= '2021-08-30' and exists (SELECT * from [dbo].[BRS_TransactionDW] ext where t.SalesOrderNumber = ext.SalesOrderNumber and t.DocType = ext.DocType  and t.LineNumber = ext.LineNumber)

select top 1000 t.* from [dbo].[BRS_Transaction] t where t.SalesDate >= '2022-01-01' and t.SalesDate <= '2021-08-30' and t.doctype <> 'AA' and t.GLBU_Class not in ('FREIG') AND exists (SELECT * from [dbo].[BRS_TransactionDW] ext where t.SalesOrderNumber = ext.SalesOrderNumber and t.DocType = ext.DocType and t.LineNumber = ext.LineNumber)


-- BI Planning, tmc,  6 Dec 24 adds

-- cust hist key
-- 1min
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	cust_hist_key int NOT NULL Identity(1,1)
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	BRS_CustomerFSC_History_u_idx3 UNIQUE NONCLUSTERED 
	(
	cust_hist_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- item hist
BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.BRS_ItemHistory.ID', N'Tmp_item_hist_key', 'COLUMN' 
GO
EXECUTE sp_rename N'dbo.BRS_ItemHistory.Tmp_item_hist_key', N'item_hist_key', 'COLUMN' 
GO
ALTER TABLE dbo.BRS_ItemHistory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--34s
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemHistory ADD CONSTRAINT
	BRS_ItemHistory_u_idx_3 UNIQUE NONCLUSTERED 
	(
	item_hist_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE dbo.BRS_ItemHistory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- support for salesorder DIM

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD
	ID_DS_xref int NULL
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_Transaction FOREIGN KEY
	(
	ID_DS_xref
	) REFERENCES dbo.BRS_Transaction
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX BRS_TransactionDW_Ext_idx_03 ON dbo.BRS_TransactionDW_Ext
	(
	ID_DS_xref
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- pre-populdate data, move code to DS ME commission

truncate table zzzshipto

insert into [dbo].[zzzShipto] ([ST], note)

select 
--top 10 
SalesOrderNumber
--, LineNumber
, DocType
--, ID 
--, count (*)
from BRS_Transaction t
inner join zzzShipto
ON t.SalesOrderNumber = st

where
--	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE t.FiscalMonth = dd.FiscalMonth)) AND
	t.SalesOrderNumber <>0 and
	t.SalesOrdernumber = 15145412 and
--	t.DocType = 'AA' AND
	(1=1)
group by 
SalesOrderNumber
--, LineNumber
, DocType

--having doctype = 'aa'

-- update


select 
-- top 10
SalesOrderNumber
, DocType
, MIN(ID) first_line
from BRS_Transaction t
where
--	t.fiscalmonth = 202401 and
	t.SalesOrderNumber <>0 and
	t.SalesOrdernumber = 14146847 AND
	 t.DocType <> 'AA' AND
	(1=1)
group by 
SalesOrderNumber
, DocType


SELECT   TOP (10) SalesOrderNumber, DocType, ID_DS_xref
FROM     BRS_TransactionDW_Ext ext
inner join 
(
	select 
	-- top 10
	SalesOrderNumber
	, DocType
	, MIN(ID) first_line
	from BRS_Transaction t
	where
	--	t.fiscalmonth = 202401 and
		t.SalesOrderNumber <>0 and
		 t.DocType <> 'AA' AND
		(1=1)
	group by 
	SalesOrderNumber
	, DocType
) upd
on ext.SalesOrderNumber = upd.SalesOrderNumber and ext.DocType = upd.DocType


UPDATE  BRS_TransactionDW_Ext
SET        ID_DS_xref = NULL
where ID_DS_xref is not NULL

-- map salesorder to the FIRST line of the order from the Daily Sales Transactions - 1
UPDATE  BRS_TransactionDW_Ext
SET        ID_DS_xref = upd.first_line
FROM     BRS_TransactionDW_Ext INNER JOIN
        (SELECT   SalesOrderNumber, DocType, MIN(ID) AS first_line
        FROM     BRS_Transaction AS t
        WHERE   (SalesOrderNumber <> 0) AND (DocType <> 'AA') AND (1 = 1)
        GROUP BY SalesOrderNumber, DocType) AS upd ON BRS_TransactionDW_Ext.SalesOrderNumber = upd.SalesOrderNumber AND BRS_TransactionDW_Ext.DocType = upd.DocType
WHERE ID_DS_xref is NULL

-- map salesorder to the FIRST line of the order from the Daily Sales Transactions - 2
UPDATE  BRS_TransactionDW_Ext
SET        ID_DS_xref = upd.first_line
FROM     BRS_TransactionDW_Ext INNER JOIN
        (SELECT   SalesOrderNumber, DocType, MIN(ID) AS first_line
        FROM     BRS_Transaction AS t
        WHERE   (SalesOrderNumber <> 0) AND (DocType <> 'AA') AND (1 = 1)
        GROUP BY SalesOrderNumber, DocType) AS upd ON BRS_TransactionDW_Ext.SalesOrderNumber = upd.SalesOrderNumber 
WHERE 
BRS_TransactionDW_Ext.[DocType] = 'AA' AND
ID_DS_xref is NULL


select * from BRS_TransactionDW_Ext where SalesOrderNumber = 14146847

SELECT [Shipto]
	--,[wheel_active_ind]
	,wheel_thresh1_sales_ind
	,wheel_thresh2_recent_order_ind

	,[wheel_seg1_merchandise_ind]
	,[wheel_seg2_hs_branded_ind]
	,[wheel_seg3_equip_hitech_ind]
	,[wheel_seg4_digital_restoration_ind]
	,[wheel_seg5_henry_schein_one_ind]
	,[wheel_seg6_equipment_services_ind]
	,[wheel_seg7_business_solutions_ind]
FROM [dbo].[BRS_CustomerFSC_History]
WHERE FiscalMonth = 202410


select PriorFiscalMonth, ROUND(PriorFiscalMonth - 100, -2)+12 from BRS_Config



SELECT   item_hist_key, ItemCode, FiscalMonth, SupplierCode, Supplier, MinorProductClass, Major, SubMajor, Minor, label, LabelDesc, Excl_key, Excl_Code, Excl_Name, BrandEquityCategory, ProductCategory, EffectivePeriod, ExpiredPeriod, Excl_Code_Public
FROM     Dimension.ItemHistory


-- add CB backup for DS FG  work-around

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	ExtChargebackAmtORG money NULL
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
