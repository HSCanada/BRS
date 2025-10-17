	-- Sales 1 of 3
	SELECT   
--		top 10  

		--cc.[Entity]	
		'' AS Entity

		,t.GLBU_Class

		,t.FiscalMonth						AS PERIOD
		,RTRIM(excl.BrandEquityCategory)		AS BRAND_EQUITY
		,RTRIM(excl.Excl_Code_Public)			AS BRAND_LINE
		,RTRIM(ch.HIST_MarketClass)				AS CUSTOMER

		,CASE WHEN ch.HIST_MarketClass = 'ELITE' THEN cust.CustGrpWrk ELSE '' END	AS CUSTOMER_GROUP
		,RTRIM(ih.Supplier)						AS SUPPLIER
		,RTRIM(sup.CountryGroup)				AS SUPPLIER_GLOBAL
		,MIN(sup.MELP_code)						AS MELP

		,RTRIM(t.AdjCode)						AS AdjCode

		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS REPORTING_SOURCE
		,SUM(t.[NetSalesAmt])				AS sales_amt

		-- make GP (fix)

		,CASE 
			WHEN (glru.ReportingClass) = 'NSA' 
			THEN 0 
			ELSE SUM(NetSalesAmt - (ExtendedCostAmt - ISNULL(ExtChargebackAmt,0))) 
		END									AS gp_amt


		,COUNT(*)							AS lines_qty
		,glru.ReportingClass
		,SUM(t.ExtendedCostAmt) ext_cost_amt
		,SUM(ISNULL(t.ExtChargebackAmt,0)) ext_cb_amt
--		,MIN(t.ID) minid
--		,MAX(t.ID) maxiid

-- test
--		,t.GL_BusinessUnit					AS TEST_BusinessUnit
--		,t.GL_Object_Sales					AS TEST_Object
--		,t.SalesDivision					AS TEST_SalesDivision
--		,t.GLBU_Class						AS TEST_GLBU_Class

	FROM         
		[dbo].[BRS_Transaction] AS t 

--		LEFT JOIN BRS_DS_GLBU_Rollup AS glru
		INNER JOIN BRS_DS_GLBU_Rollup AS glru
		ON	t.GLBU_Class = glru.GLBU_Class


--		LEFT JOIN [dbo].[BRS_CustomerFSC_History] as ch
		INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
		ON t.Shipto = ch.[Shipto] AND
			t.[FiscalMonth] = ch.[FiscalMonth]


--		LEFT JOIN [dbo].[BRS_Customer] cust
		INNER JOIN [dbo].[BRS_Customer] cust
		on t.Shipto = cust.ShipTo


--		LEFT JOIN [dbo].[BRS_FSC_Rollup] fsc
		INNER JOIN [dbo].[BRS_FSC_Rollup] fsc
		ON ch.HIST_TerritoryCd = fsc.TerritoryCd

/*
--		LEFT JOIN [dbo].[BRS_Branch] br
		INNER JOIN [dbo].[BRS_Branch] br
		ON fsc.Branch = br.Branch
*/


--		LEFT JOIN [dbo].[BRS_ItemHistory] as ih
		INNER JOIN [dbo].[BRS_ItemHistory] as ih
		ON t.Item = ih.[Item] AND
			t.[FiscalMonth] = ih.[FiscalMonth]


--		LEFT JOIN [dbo].[BRS_ItemSupplier] as sup
		INNER JOIN [dbo].[BRS_ItemSupplier] as sup
		ON ih.Supplier = sup.Supplier


-- added
/*
		INNER JOIN [hfm].[account_master_F0901] as hfm	
		ON t.[GL_BusinessUnit] = hfm.[GMMCU__business_unit] AND	
			t.[GL_Object_Sales] = hfm.[GMOBJ__object_account] AND	
			t.[GL_Subsidiary_Sales] = hfm.[GMSUB__subsidiary] 	
		INNER JOIN [hfm].[cost_center] as cc	
		ON hfm.HFM_CostCenter = cc.CostCenter	
*/

--

--		LEFT JOIN [hfm].[exclusive_product] as excl
		INNER JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key


--		LEFT JOIN [dbo].[BRS_DocType] as doct
		INNER JOIN [dbo].[BRS_DocType] as doct
		ON t.DocType = doct.DocType


	WHERE
		(t.FiscalMonth between 202507 AND 202509)  AND

		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 

		-- exclude Free goods estimates (they are always ignored.  GL correction applied to removed state
		t.AdjCode <> 'XXXFGE' AND

		-- test
--		t.DocType = 'AA' AND
--		t.ID in (38460042,38460156) AND

		-- note FG est included XXXFG

		--(doct.SourceCd <> 'JDE') AND
		--

		(1=1)


	GROUP BY 
		t.FiscalMonth
		,t.GLBU_Class
		,t.AdjCode
--		,cc.[Entity]	
		,ih.Supplier
		,sup.CountryGroup
		,excl.BrandEquityCategory
		,excl.Excl_Code_Public

		,ch.HIST_MarketClass

		,CASE WHEN ch.HIST_MarketClass = 'ELITE' THEN cust.CustGrpWrk ELSE '' END
		,doct.SourceCd
		,glru.ReportingClass

-- 1. set date
-- 2. set to tab text
-- 3. run script


