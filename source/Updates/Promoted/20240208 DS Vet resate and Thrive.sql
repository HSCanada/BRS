-- DS Vet resate, tmc, 8 Feb 24

-- vet restate, do AFTER ME

-- 1. ID Vet from HFM
SELECT *
  FROM [hfm].[account_master_F0901] 
  where 
--	[HFM_CostCenter]='CC020040000000' and  
	[GMMCU__business_unit] = '020040000000'
  order by GMOBJ__object_account
-- ORG 82 lines

-- 2. ID Vet from DS

SELECT [BusinessUnit]
      ,[BusinessUnitName]
      ,[GLBU_Class]
      ,[StatusCd]
      ,[CostCenter]
      ,[Note]
      ,[Branch]
      ,[SalesDivision]
      ,[hs_branded_baseline_ind]
  FROM [dbo].[BRS_BusinessUnit]
  where  
  --[BusinessUnit] = '020040000000'
  note like '%vet%' OR GLBU_Class like 'V%' or GLBU_Class like 'MED%'
GO

-- 3. ID Vet history

SELECT top 10 [FiscalMonth]
      ,[SalesOrderNumberKEY]
      ,[DocType]
      ,[LineNumber]
      ,[GLBU_Class]
      ,[NetSalesAmt]
      ,[ExtendedCostAmt]
      ,[GLClass]
	  ,SalesDivision
      ,[GL_BusinessUnit]

      ,[GL_Object_Sales]
      ,[GL_Object_Cost]
      ,[GL_Subsidiary_Sales]
      ,[GL_Subsidiary_Cost]
      ,[GL_Subsidiary_ChargeBack]
      ,[GL_Object_ChargeBack]
  FROM 
  [dbo].[BRS_Transaction] 
  where 
  [GL_BusinessUnit] = '020040000000' and 
  -- GL_Object_Sales = '4200' and       
   not GLBU_Class in ('FREIG') and 
  (1=1)

-- promote to prod as per Gary, 14 Feb 24 START

  -- update map MEDIC
UPDATE       BRS_BusinessUnit
SET                
	GLBU_Class = 'MEDIC', 
	Note = N'moved Vet to Med as per Glen, 8 Feb 24'
WHERE        (BusinessUnit = '020040000000')
GO

select * from BRS_BusinessUnit
WHERE        (BusinessUnit = '020040000000')
GO

-- update history (avoid freight, which is object driven)
UPDATE       BRS_Transaction
SET                GLBU_Class = 'MEDIC'
WHERE        
(GL_BusinessUnit = '020040000000') AND 
(NOT (GLBU_Class IN ('FREIG','MEDIC'))) AND 
([FiscalMonth] >= 202301) and
(1 = 1)

-- promote to prod as per Gary, 14 Feb 24 STOP

  -- ORG 7 297 


  -- pull stage data from prod 

INSERT INTO STAGE_BRS_Transaction
(SHDOCO, SHDCTO, SDLNID, SDAN8, SDSHAN, SDLITM, SDDOC, SDDCT, QCAC10, QCAC08, QCAC04, QC$OSC, SDLNTY, SDSRP1, SDGLC, SHMCU, SHMCU01, SDMCU, SDMCU01, SDEMCU, SDEMCU01, GLANI, GMDL01, GLAA)
SELECT        SHDOCO, SHDCTO, SDLNID, SDAN8, SDSHAN, SDLITM, SDDOC, SDDCT, QCAC10, QCAC08, QCAC04, QC$OSC, SDLNTY, SDSRP1, SDGLC, SHMCU, SHMCU01, SDMCU, SDMCU01, SDEMCU, SDEMCU01, GLANI, GMDL01, GLAA
FROM            BRSales.dbo.STAGE_BRS_Transaction AS s

GO


  select * from DEV_brsales.dbo.STAGE_BRS_Transaction

  -- and run update script

  -- setnew date for load map test
  --
  update [dbo].[BRS_Config] set [SalesDate] = '2024-01-23'

  -- debug run
-- [BRS_BE_Transaction_load_proc] 
-- 13788 @ 10s

-- prod run
-- [BRS_BE_Transaction_load_proc] 0, 0


  -- confirm changes

SELECT  [FiscalMonth]
      ,[SalesOrderNumberKEY]
	  ,SalesDate
      ,[DocType]
      ,[LineNumber]
      ,[GLBU_Class]
      ,[NetSalesAmt]
      ,[ExtendedCostAmt]
      ,[GLClass]
	  ,SalesDivision
      ,[GL_BusinessUnit]

      ,[GL_Object_Sales]
      ,[GL_Object_Cost]
      ,[GL_Subsidiary_Sales]
      ,[GL_Subsidiary_Cost]
      ,[GL_Subsidiary_ChargeBack]
      ,[GL_Object_ChargeBack]
  FROM 
  [dbo].[BRS_Transaction] 
  where 
  [GL_BusinessUnit] = '020040000000' and 
  -- GL_Object_Sales = '4200' and       
   not GLBU_Class in ('FREIG') and 
   [FiscalMonth] >= 202401  and
   [ID] >= 36955018 and
  (1=1)
order by SalesDate


select top 13788 * from [dbo].[BRS_Transaction] order by ID desc


/*
* 28 BU
* Planning isnot yet mapped
* Points vs End Bal, vs ...
*/

/* 
mapping code in here

Exec BRS_BE_Transaction_load_proc 0,0
exec BRS06_qapp_BRS_TransactionPost
*/

EXECUTE pricing.order_note_post_proc @bDebug=1
EXECUTE pricing.order_note_post_proc @bDebug=0

SELECT *
  FROM [hfm].[account_master_F0901] 
  where 
--	[HFM_CostCenter]='CC020040000000' and  
   GMDL01_description like '%priv%'OR
	GMOBJ__object_account = '4332' 
  order by GMOBJ__object_account

-- Thrive line logic (mirror allowance process)

/*
ALLOE -> THRVE
ALLOM -> THRVM

ALLOWA -> THRIVA
*/
-- copy

-- Promote Thrive to prod -> 14 Feb 24

-- copy
select * from [BRS_BusinessUnitClass] where GLBU_Class in ('ALLOE', 'ALLOM')


SELECT        'THRVE' GLBU_Class, 'Thrive Rewards - Equpipment' GLBU_ClassNm, StatusCd, GLBU_ClassUS_L1, CorpParticipationFactor, 'TC 14 Feb 24' NoteTxt, ReportingClass, FreeGoodsEstInd, 'THRVE' GLBU_ClassDS_L1, GLBU_ClassSM_L1, GLBU_ClassSM_L2, GLBU_ClassSM_L3, 
                         CategoriesServed, GLBU_Class_map, global_product_class_default
FROM            BRS_BusinessUnitClass
WHERE        (GLBU_Class IN ('ALLOE'))

-- Thrive EQ
INSERT INTO BRS_BusinessUnitClass
                         (GLBU_Class, GLBU_ClassNm, StatusCd, GLBU_ClassUS_L1, CorpParticipationFactor, NoteTxt, ReportingClass, FreeGoodsEstInd, GLBU_ClassDS_L1, GLBU_ClassSM_L1, GLBU_ClassSM_L2, GLBU_ClassSM_L3, 
                         CategoriesServed, GLBU_Class_map, global_product_class_default)
SELECT        'THRVE' AS GLBU_Class, 'Thrive Rewards - Equpipment' AS GLBU_ClassNm, StatusCd, GLBU_ClassUS_L1, CorpParticipationFactor, 'TC 14 Feb 24' AS NoteTxt, ReportingClass, FreeGoodsEstInd, 
                         'THRVE' AS GLBU_ClassDS_L1, GLBU_ClassSM_L1, GLBU_ClassSM_L2, GLBU_ClassSM_L3, CategoriesServed, GLBU_Class_map, global_product_class_default
FROM            BRS_BusinessUnitClass AS BRS_BusinessUnitClass_1
WHERE        (GLBU_Class IN ('ALLOE'))

-- Thrive Merch
INSERT INTO BRS_BusinessUnitClass
                         (GLBU_Class, GLBU_ClassNm, StatusCd, GLBU_ClassUS_L1, CorpParticipationFactor, NoteTxt, ReportingClass, FreeGoodsEstInd, GLBU_ClassDS_L1, GLBU_ClassSM_L1, GLBU_ClassSM_L2, GLBU_ClassSM_L3, 
                         CategoriesServed, GLBU_Class_map, global_product_class_default)
SELECT        'THRVM' AS GLBU_Class, 'Thrive Rewards - Merch' AS GLBU_ClassNm, StatusCd, GLBU_ClassUS_L1, CorpParticipationFactor, 'TC 14 Feb 24' AS NoteTxt, ReportingClass, FreeGoodsEstInd, 
                         'THRVM' AS GLBU_ClassDS_L1, GLBU_ClassSM_L1, GLBU_ClassSM_L2, GLBU_ClassSM_L3, CategoriesServed, GLBU_Class_map, global_product_class_default
FROM            BRS_BusinessUnitClass AS BRS_BusinessUnitClass_1
WHERE        (GLBU_Class IN ('ALLOM'))


SELECT        *
FROM            BRS_DS_GLBU_Rollup
WHERE        (GLBU_Class like 'T%')


-- add
select * from [dbo].[BRS_AdjCode] where adjcode = 'ALLOWA'

INSERT INTO BRS_AdjCode
(AdjCode, AdjType, AdjCodeDesc, AdjLevel, AdjClass, StatusCd, NoteTxt, MTDEstInd, MTDEst_rt)
SELECT        'THRIVA' AdjCode, 'THRIVA' AdjType, 'NSA- Thrive Rewards (M&E)' AdjCodeDesc, AdjLevel, AdjClass, 1 as StatusCd, 'Update Thrive 14 Feb 2024 TC' NoteTxt, MTDEstInd, MTDEst_rt
FROM            BRS_AdjCode
WHERE        (AdjCode = 'ALLOWA')


SELECT        *
FROM            BRS_AdjCode
WHERE        (AdjCode like 'T%')

-- update OBJ
select  * from [dbo].[BRS_Object] where adjcode = 'ALLOWA' or GLAcctNumberObj = '4332'


UPDATE       BRS_Object
SET                GLOBJ_Name ='Thrive Rewards OBJ', GLOBJ_Type ='S', Note ='Thrive Rewards Mao to Cost Obj, 14 Feb 24', AdjCode ='THRIVA'
WHERE        (GLAcctNumberObj = '4332')

-- test
select  * from [dbo].[BRS_Object] where GLAcctNumberObj = '4332'


-- Fix Planning lookup, in prod, 16 Feb 24


INSERT INTO hfm.account
                         (HFM_Account, Note, GLOBJ_Type, HFM_Account_descr)
VALUES        (N'PrivPoints', N'TC add 20240216', N'S', N'ThrivePoints')


SELECT        GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, HFM_Account
FROM            hfm.account_master_F0901
WHERE        (GMOBJ__object_account IN ('4332'))

UPDATE       hfm.account_master_F0901
SET                HFM_Account = N'PrivPoints'
WHERE        (GMOBJ__object_account IN ('4332'))
--

-- fix Branch

UPDATE       BRS_Transaction
SET                Branch = 'MEDIC', BranchORG = [Branch]
WHERE        (GL_BusinessUnit = '020040000000') AND (GLBU_Class IN ('MEDIC')) AND (Branch <> 'MEDIC') AND (FiscalMonth >= 202301) AND (1 = 1)


-- test
SELECT  [FiscalMonth]
	  ,[DocType] 
      ,[GLBU_Class]
	  ,[Branch]
	  ,[BranchORG]
      ,[NetSalesAmt]
      ,[ExtendedCostAmt]
      ,[GLClass]
	  ,SalesDivision
      ,[GL_BusinessUnit]

  FROM 
  [dbo].[BRS_Transaction] 
  where 
  [GL_BusinessUnit] = '020040000000' and 
   GLBU_Class in ('MEDIC') and 
   Branch <> 'MEDIC' and
   [FiscalMonth] >= 202301  and
--   [ID] >= 36955018 and
  (1=1)
order by SalesDate
