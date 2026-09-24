-- MED 5, Zoran
-- CIP process, Zoran built, Alexander, who does not have access to MED1, MED5

-- 1. access MED5 (easy)
-- 2. use MED1 as proxy


--USE [ExpressCoreBuyingList]
GO


DECLARE @NEWID UNIQUEIDENTIFIER
SET @NEWID = NEWID()


SELECT @NEWID AS [CIP Reference#]



INSERT INTO [USNYMEMED5].[ExpressCoreBuyingList].[dbo].[DataInputDetail]
  ([CIPGuid]
  ,[CustomerNumber] 
  ,[ItemNumber]
  ,CIPDate
  ,[Quantity])
SELECT TOP 10
  @NEWID as CIPGuid
  ,CAST(a.[SHIP_TO] AS INT) AS [CustomerNumber]
  ,CAST(a.[ITEM_NUMB] AS INT) AS [ItemNumber]
  ,CONVERT(VARCHAR(8), GETDATE(), 112) as CIPDate
  ,1 AS [Quantity]  
FROM [USNYMEMED5].[Canada_CIP].[dbo].[tstCanada_ST-ItemCombos] AS a



-- IF YOU WANT TO SCHEDULE A CIP in a future: ExecuteAfterDate



INSERT INTO [USNYMEMED5].[ExpressCoreBuyingList].[dbo].[DataInput]
  ([CIPGuid]
  ,[CIPDate]
  ,[CIPStatus]
  ,[ReportName]
  ,[EmailRecipient]
  ,[FinalTableName_DB_Schema_Table]
  ,[AS400SettingId]
  ,[FetchDataType] 
  ,IsProcessed
  ,[IsActive]
  ,ExecuteAfterDate)
SELECT 
  @NEWID as CIPGuid
  ,getdate() as CIPDate 
  ,'' as CIPStatus 
  ,'Trevor_CIP_Canada' as ReportName 
  ,'trevor.crowley@henryschein.ca' as EmailRecipient 
  ,'[Canada_CIP].[dbo].[Trevor_CIP_Results_Canada_20261026_2]' as FinalTableName_DB_Schema_Table 
--  ,'[USNYMEDNT1].[Canada_Shared].[dbo].[Trevor_CIP_Results_Canada_20261026_2]' as FinalTableName_DB_Schema_Table 

  ,3 AS AS400SettingId  -- Don't change
  ,2 AS FetchDataType  -- Don't change
  ,0 AS IsProcessed-- Don't change
  ,1 AS IsActive -- Don't change
  ,null AS ExecuteAfterDate;



SELECT * FROM [USNYMEMED5].[ExpressCoreBuyingList].[dbo].[DataInputDetail] WHERE CIPGuid = @NEWID
SELECT * FROM [USNYMEMED5].[ExpressCoreBuyingList].[dbo].[DataInput] WHERE CIPGuid = @NEWID


-- review results
/*
SELECT [Id]
      ,[BLRequestId]
      ,[BLRequestDetailsId]
      ,[CustNumber]
      ,[ItemNumber]
      ,[Date]
      ,[Quantity]
      ,[BillToNumber]
      ,[CurrentSalePlan]
      ,[SupplierCode]
      ,[ManfPart#]
      ,[ItemDescription]
      ,[UOMCase]
      ,[ChargebackSubmitCONTnumber]
      ,[FileCost]
      ,[FreightFactor]
      ,[CustomerDivision]
      ,[DivMktAdj%]
      ,[CorpMktAdj %]
      ,[LandedCost]
      ,[CommCost]
      ,[FinalPrice]
      ,[CommCostGP%]
      ,[CatalogCorpListPrice]
      ,[Contract#1InternalContract#]
      ,[Contract#1ExternalContract#]
      ,[Contract#1ContractDescription]
      ,[Contract#1ContractCost]
      ,[Adj(1)Name(HighestSeq#)]
      ,[Adj(1)Price]
      ,[Reference#]
      ,[UserID]
      ,[ProgramID]
      ,[WorkStnID]
      ,[Date Updated]
      ,[TimeofDay]
      ,[InsertDate]
  FROM [USNYMEMED5].[Canada_CIP].[dbo].[Trevor_CIP_Results_Canada_20261026_1]
GO

*/
