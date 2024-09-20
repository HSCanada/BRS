-- DS BI BE update, tmc, 25 Jun 24


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
