	-- Sales 1 of 3
	SELECT   
--		top 10  

		cc.[Entity]								AS ENTITY 
		,[HFM_Account]							AS ACCOUNT
		,t.[GLBU_Class]			
		,RTRIM(icat.[CategoryRollup])			AS CategoryRollup
--		,RTRIM(LEFT(ih.MinorProductClass,9))	AS PRODUCT
		,RTRIM(excl.BrandEquityCategory)		AS BRAND_EQUITY
		,RTRIM(excl.Excl_Code_Public)			AS BRAND_LINE
		,RTRIM(ch.HIST_MarketClass)				AS MarketClass
		,RTRIM(ch.[HIST_SalesDivision])			AS SalesDivision
		,RTRIM(ISNULL(g.GpsCode, 'NoAnalysis'))	AS ANALYSIS

		-- new
--		,RTRIM(ih.Supplier)						AS SUPPLIER

		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS REPORTING_SOURCE
		,LEFT(t.FiscalMonth,4)						AS [PERIOD]
		,SUM(t.[NetSalesAmt])				AS net_sales
		,SUM(t.[ExtendedCostAmt])			AS ext_cost
		,-SUM(ISNULL(t.[ExtChargebackAmt],0))			AS ext_charge_back

-- test

--		,t.GL_BusinessUnit					AS TEST_BusinessUnit
--		,t.GL_Object_Sales					AS TEST_Object
--		,t.SalesDivision					AS TEST_SalesDivision
--		,t.GLBU_Class						AS TEST_GLBU_Class
--		,t.AdjCode							AS TEST_AdjCode



	FROM         
		[dbo].[BRS_Transaction] AS t 

		INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
		ON t.Shipto = ch.[Shipto] AND
			t.[FiscalMonth] = ch.[FiscalMonth]

		INNER JOIN [dbo].[BRS_ItemHistory] as ih
		ON t.Item = ih.[Item] AND
			t.[FiscalMonth] = ih.[FiscalMonth]

		INNER JOIN [hfm].[account_master_F0901] as hfm
		ON t.[GL_BusinessUnit] = hfm.[GMMCU__business_unit] AND
			t.[GL_Object_Sales] = hfm.[GMOBJ__object_account] AND
			t.[GL_Subsidiary_Sales] = hfm.[GMSUB__subsidiary] 

		INNER JOIN [hfm].[cost_center] as cc
		ON hfm.HFM_CostCenter = cc.CostCenter

		INNER JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key

		INNER JOIN [dbo].[BRS_DocType] as doct
		ON t.DocType = doct.DocType

		LEFT JOIN [hfm].[gps_code] as g
		ON t.GpsKey = g.GpsKey

		INNER JOIN BRS_DS_GLBU_Rollup AS glru
		ON	t.GLBU_Class = glru.GLBU_Class

		INNER JOIN [dbo].[BRS_Item] AS i
		ON	t.Item = i.[Item]

		INNER JOIN  [dbo].[BRS_ItemCategory] icat
		ON i.[MinorProductClass] = icat.[MinorProductClass]

	WHERE
		(t.FiscalMonth between 201910 AND 201910)  AND
		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 
		(glru.ReportingClass <> 'NSA') AND

--		test
--		t.SalesOrderNumber = 1109883 AND
		(1=1)


	GROUP BY 
		LEFT(t.FiscalMonth,4)
		,t.[GLBU_Class]
		,cc.[Entity]
		,hfm.[HFM_Account]
		,icat.[CategoryRollup]
--		,ih.MinorProductClass
		-- new
--		,ih.Supplier
		,excl.BrandEquityCategory
		,excl.Excl_Code_Public
		,g.GpsCode
		-- new
		,ch.HIST_MarketClass
		,ch.[HIST_SalesDivision]
		,doct.SourceCd
-- test

--		,t.GL_BusinessUnit
--		,t.GL_Object_Sales
--		,t.SalesDivision
--		,t.GLBU_Class
--		,t.AdjCode


--	HAVING
--		(SUM(t.[NetSalesAmt]) <>0)


-- set format to Tab delim, text 


