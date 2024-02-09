-- DS Vet resate, tmc, 8 Feb 24

-- vet resate

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


  -- update map MEDIC
UPDATE       BRS_BusinessUnit
SET                
	GLBU_Class = 'MEDIC', 
	Note = N'moved Vet to Med as per Glen, 8 Feb 24'
WHERE        (BusinessUnit = '020040000000')
GO

-- update history (avoid freight, which is object driven)
UPDATE       BRS_Transaction
SET                GLBU_Class = 'MEDIC'
WHERE        
(GL_BusinessUnit = '020040000000') AND 
(NOT (GLBU_Class IN ('FREIG','MEDIC'))) AND 
-- ([FiscalMonth] >= 202301) and
(1 = 1)

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


--- Thrive, NOT posted yet
/*
knowns.

* 28 BU
* Planning isnot yet mapped
* Points vs End Bal, vs ...
*/

EXECUTE pricing.order_note_post_proc @bDebug=1
EXECUTE pricing.order_note_post_proc @bDebug=0

SELECT *
  FROM [hfm].[account_master_F0901] 
  where 
--	[HFM_CostCenter]='CC020040000000' and  
--	GMDL01_description like '%priv%'
	GMOBJ__object_account = '4332' 
  order by GMOBJ__object_account

  -- 28 Thrive lines




