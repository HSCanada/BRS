	-- Sales 1 of 3
	SELECT   
--		top 10  

		cc.[Entity]	
--		,hfm.[HFM_Account]
		,t.GLBU_Class

		,t.FiscalMonth						AS PERIOD
--		,RTRIM(LEFT(ih.[global_product_class],9))	AS PRODUCT
--		,RTRIM(LEFT(ih.MinorProductClass,9))	AS PRODUCT
		,RTRIM(excl.BrandEquityCategory)		AS BRAND_EQUITY
		,RTRIM(excl.Excl_Code_Public)			AS BRAND_LINE
		,RTRIM(MIN(ch.HIST_MarketClass))				AS CUSTOMER
		,CASE WHEN ch.HIST_MarketClass = 'ELITE' THEN cust.CustGrpWrk ELSE '' END	AS CUSTOMER_GROUP
		,CASE WHEN sup.MELP_code = '' THEN '' ELSE ih.Supplier END AS SUPPLIER
		,CASE WHEN sup.MELP_code = '' THEN '' ELSE sup.CountryGroup END AS SUPPLIER_GLOBAL
		,MIN(sup.MELP_code)						AS MELP
--		,RTRIM(ih.Supplier)						AS SUPPLIER

--		,RTRIM(br.Branch)						AS BRANCH
		,t.AdjCode

		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS REPORTING_SOURCE
		,SUM(t.[NetSalesAmt])				AS sales_amt

		-- make GP
		,CASE 
			WHEN MIN(glru.ReportingClass) = 'NSA' 
			THEN 0 
			ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) 
		END									AS gp_amt
		,COUNT(*)							AS lines_qty

-- test
--		,t.GL_BusinessUnit					AS TEST_BusinessUnit
--		,t.GL_Object_Sales					AS TEST_Object
--		,t.SalesDivision					AS TEST_SalesDivision
--		,t.GLBU_Class						AS TEST_GLBU_Class

	FROM         
		[dbo].[BRS_Transaction] AS t 

		INNER JOIN BRS_DS_GLBU_Rollup AS glru
		ON	t.GLBU_Class = glru.GLBU_Class

		INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
		ON t.Shipto = ch.[Shipto] AND
			t.[FiscalMonth] = ch.[FiscalMonth]

		INNER JOIN [dbo].[BRS_Customer] cust
		on t.Shipto = cust.ShipTo

		INNER JOIN [dbo].[BRS_FSC_Rollup] fsc
		ON ch.HIST_TerritoryCd = fsc.TerritoryCd

		INNER JOIN [dbo].[BRS_Branch] br
		ON fsc.Branch = br.Branch

		INNER JOIN [dbo].[BRS_ItemHistory] as ih
		ON t.Item = ih.[Item] AND
			t.[FiscalMonth] = ih.[FiscalMonth]

		INNER JOIN [dbo].[BRS_ItemSupplier] as sup
		ON ih.Supplier = sup.Supplier
--
		INNER JOIN [hfm].[account_master_F0901] as hfm	
		ON t.[GL_BusinessUnit] = hfm.[GMMCU__business_unit] AND	
			t.[GL_Object_Sales] = hfm.[GMOBJ__object_account] AND	
			t.[GL_Subsidiary_Sales] = hfm.[GMSUB__subsidiary] 	
		INNER JOIN [hfm].[cost_center] as cc	
		ON hfm.HFM_CostCenter = cc.CostCenter	
--
		INNER JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key

		INNER JOIN [dbo].[BRS_DocType] as doct
		ON t.DocType = doct.DocType

	WHERE
		(t.FiscalMonth between 202310 AND 202311)  AND
		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 
		(
			(ch.HIST_MarketClass = 'ELITE') OR
			(sup.MELP_code <> '')
		) AND
--		test
--		glru.ReportingClass = 'NSA' AND
--		t.SalesOrderNumber = 1109883 AND
--		(t.AdjCode = 'XXXFGE') AND
		(1=1)


	GROUP BY 
		t.FiscalMonth
		,t.AdjCode
		,t.GLBU_Class
		,cc.[Entity]	
--		,hfm.[HFM_Account]
		,CASE WHEN sup.MELP_code = '' THEN '' ELSE ih.Supplier END
		,CASE WHEN sup.MELP_code = '' THEN '' ELSE sup.CountryGroup END
		,excl.BrandEquityCategory
		,excl.Excl_Code_Public
--		,ch.HIST_MarketClass
		,CASE WHEN ch.HIST_MarketClass = 'ELITE' THEN cust.CustGrpWrk ELSE '' END
--		,br.Branch
		,doct.SourceCd

-- 1. set date
-- 2. set to tab text
-- 3. run script


