-- Add the below logic to a post ETL load proc
-- 17 Dec 17, tmc
-- AFTER data flow doc

--- update F0901 from ETL - run package to update F0901, F0909

-- update BU
INSERT INTO [dbo].[BRS_BusinessUnit]
(BusinessUnit)
SELECT        Distinct GMMCU__business_unit 
FROM            Integration.F0901_account_master AS s
WHERE NOT EXISTS 
(
	SELECT * FROM [dbo].[BRS_BusinessUnit] b
	WHERE s.GMMCU__business_unit = b.BusinessUnit
)

-- update Obj
INSERT INTO [dbo].[BRS_Object]
([GLAcctNumberObj])
SELECT        Distinct GMOBJ__object_account 
FROM            Integration.F0901_account_master AS s
WHERE NOT EXISTS 
(
	SELECT * FROM [dbo].[BRS_Object] o
	WHERE s.GMOBJ__object_account = o.[GLAcctNumberObj]
)

-- update details

INSERT INTO hfm.account_master_F0901
                         (GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, 
                         GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, 
                         GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated)
SELECT        GMCO___company, GMAID__account_id, GMMCU__business_unit, GMOBJ__object_account, GMSUB__subsidiary, GMANS__free_form_3rd_acct_no, 
                         GMDL01_description, GMLDA__account_level_of_detail, GMBPC__budget_pattern_code, GMPEC__posting_edit, GMUSER_user_id, GMPID__program_id, 
                         GMJOBN_work_station_id, GMUPMJ_date_updated_JDT, GMUPMT_time_last_updated
FROM            Integration.F0901_account_master AS s
WHERE NOT EXISTS 
(
	SELECT * FROM hfm.account_master_F0901 d
	WHERE 
		s.[GMMCU__business_unit]=d.[GMMCU__business_unit] AND 
		s.[GMOBJ__object_account] = d.[GMOBJ__object_account] AND
		s.[GMSUB__subsidiary] = d.[GMSUB__subsidiary]
)

-- update bu map
UPDATE       
	hfm.account_master_F0901
SET                
	HFM_CostCenter = b.CostCenter, 
	[LastUpdated]  = getdate()
FROM            
	[dbo].[BRS_BusinessUnit] b 
	INNER JOIN hfm.account_master_F0901 m
ON 
	m.[GMMCU__business_unit] = b.BusinessUnit 
WHERE 
	b.CostCenter <>'' AND
	ISNULL(HFM_CostCenter,'') <> b.CostCenter



-- update Obj map
UPDATE       hfm.account_master_F0901
SET                HFM_Account = [HFM_Account_TargetKey]
FROM            hfm.account_master_F0901 INNER JOIN
                         hfm.object_to_account_map_rule AS m ON 
                         hfm.account_master_F0901.GMMCU__business_unit + hfm.account_master_F0901.GMOBJ__object_account + hfm.account_master_F0901.GMSUB__subsidiary LIKE
                          REPLACE(REPLACE(m.Rule_WhereClauseLike, '?', '_'), '*', '%')
WHERE        (m.ActiveInd = 1) AND ISNULL(HFM_Account, '') <> [HFM_Account_TargetKey]

-- TODO Exclusive history, ...

--- Test RI -- sales, cost, cb all should be zero rows

-- sales
SELECT        
	-- TOP (10) 
	FiscalMonth, [SalesOrderNumberKEY], DocType, [LineNumber], [AdjNote], [GLBU_Class], GL_BusinessUnit, GL_Object_Sales, [GL_Subsidiary_Sales], [NetSalesAmt], [ExtendedCostAmt], [ExtChargebackAmt]
FROM            
	BRS_Transaction as t
where 
	[NetSalesAmt] <>0 AND 
	not exists 
	(
		select * from [hfm].[account_master_F0901] a
		where 
			[GMMCU__business_unit]=t.GL_BusinessUnit AND
			[GMOBJ__object_account] = t.GL_Object_Sales AND
			[GMSUB__subsidiary] = t.[GL_Subsidiary_Sales] 
	) 


-- cost
SELECT        
	-- TOP (10) 
	FiscalMonth, [SalesOrderNumberKEY], DocType, [LineNumber], [AdjNote], [GLBU_Class], GL_BusinessUnit, GL_Object_Cost, [GL_Subsidiary_Cost], [NetSalesAmt], [ExtendedCostAmt], [ExtChargebackAmt]
FROM            
	BRS_Transaction as t
where 
	[ExtendedCostAmt] <>0 AND 
	not exists 
	(
		select * from [hfm].[account_master_F0901] a
			where 
			[GMMCU__business_unit]=t.GL_BusinessUnit AND
			[GMOBJ__object_account] = t.GL_Object_Cost AND
			[GMSUB__subsidiary] = t.[GL_Subsidiary_Cost]
	) 

-- cost cb
SELECT        
	-- TOP (10) 
	FiscalMonth, [SalesOrderNumberKEY], DocType, [LineNumber], [AdjNote], [GLBU_Class], GL_BusinessUnit, GL_Object_ChargeBack, [GL_Subsidiary_ChargeBack], [NetSalesAmt], [ExtendedCostAmt], [ExtChargebackAmt]
FROM            
	BRS_Transaction as t
where 
	[ExtChargebackAmt] <>0 AND 
	not exists 
	(
		select * from [hfm].[account_master_F0901] a
			where 
			[GMMCU__business_unit]=t.GL_BusinessUnit AND
			[GMOBJ__object_account] = t.GL_Object_ChargeBack AND
			[GMSUB__subsidiary] = t.[GL_Subsidiary_ChargeBack]
	) 

-- test 
SELECT TOP 10
      [GMMCU__business_unit]
      ,[GMOBJ__object_account]
      ,[GMSUB__subsidiary]
      ,[HFM_CostCenter]
      ,[HFM_Account]
      ,[LastUpdated]
  FROM [BRSales].[hfm].[account_master_F0901] 
  
  where 
--  [GMMCU__business_unit] = '020099000000' AND
  [GMOBJ__object_account] in ('4130', '4300', '4515', '4579', '4730')
  order by 1



