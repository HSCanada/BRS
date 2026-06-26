SELECT TOP (1000) [JDEORNO]
      ,[ORDOTYCD]
      ,[LNNO]
      ,[CMID]
      ,[PDID]
      ,[PDDT]
      ,[CUID]
      ,[ADNOID]
      ,[ITID]
      ,[ITLONO]
      ,[ENBYNA]
      ,[ORTKBYID]
      ,[ORSCCD]
      ,[RF1TT]
      ,[PRMDCD]
      ,[SPCDID]
      ,[LNTY]
      ,[HSDCDID]
      ,[MJPRCLID]
      ,[CBCONTRNO]
      ,[GLBUNO]
      ,[ORFISHDT]
      ,[IVNO]
      ,[PMID]
      ,[OPMID]
      ,[OORNO]
      ,[OORTY]
      ,[OORLINO]
      ,[PCADLINO]
      ,[BTADNO]
      ,[ESSCD]
      ,[CCSCD]
      ,[ESTCD]
      ,[TSSCD]
      ,[CAGREPCD]
      ,[EQORDNO]
      ,[EQORDTYCD]
      ,[GEP_Order_Flag]
      ,[Order_Level_Promo_Code_GEP]
      ,[Line_Promo_Coupon_GEP]
      ,[WJXBFS1]
      ,[WJXBFS2]
      ,[WJXBFS3]
      ,[WJXBFS4]
      ,[WJXBFS5]
      ,[WJXBFS6]
      ,[WJXBFS7]
      ,[WJXBFS8]
  FROM [BRSales].[dbo].[STAGE_BRS_TransactionDW] where [ENBYNA] is null or [RF1TT] like 'WEB%' and [CUID] = 136117


  SELECT  [JDEORNO]
      ,[ORDOTYCD]
      ,[LNNO]
      ,[CMID]
      ,[PDID]
      ,[PDDT]
      ,[CUID]
      ,[ADNOID]
      ,[ITID]
      ,[ITLONO]
      ,[ENBYNA]
      ,[ORTKBYID]
  FROM [BRSales].[dbo].[STAGE_BRS_TransactionDW] where [ENBYNA] is null 


UPDATE [dbo].[STAGE_BRS_TransactionDW] 
SET [ENBYNA] = 'MMCCLE'
where [ENBYNA] is null 

Exec BRS_BE_Transaction_DW_load_proc @bClearStage=0, @bDebug=1;

SELECT SalesDateLastWeekly FROM BRS_Config


Exec BRS_BE_Transaction_DW_load_proc @bClearStage=0, @bDebug=0;



  
