
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [hfm].global_cube
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc:  based on [hfm].global_cube_proc 
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 5 Oct 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

	SELECT   
		cc_sales.[Entity]							AS ENTITY_sales
		,cc_cost.[Entity]							AS ENTITY_cost
		,cc_cb.[Entity]								AS ENTITY_cb
		,hfm_sales.[HFM_Account]					AS ACCOUNT_sales
		,hfm_cost.[HFM_Account]						AS ACCOUNT_cost
		,hfm_cb.[HFM_Account]						AS ACCOUNT_cb

		,RTRIM(LEFT(ih.[global_product_class],9))	AS PRODUCT
		,RTRIM(excl.BrandEquityCategory)			AS BRAND_EQUITY
		,RTRIM(excl.Excl_Code_Public)				AS BRAND_LINE
		,RTRIM(ch.HIST_MarketClass)					AS CUSTOMER
		,'LOC'										AS CURRENCY
		,RTRIM(ISNULL(gps.GpsCode, 'NoAnalysis'))	AS ANALYSIS

		-- new
		,RTRIM(ih.Supplier)							AS SUPPLIER
		,RTRIM(ch.HIST_Specialty)					AS CUSTOMER_SPECIALTY

		,doc_source.source_global_desc				AS REPORTING_SOURCE

		,t.FiscalMonth								AS PERIOD
		,'WRKNG'									AS VERSION

		,(t.[NetSalesAmt])							AS sales
		,(t.[ExtendedCostAmt])						AS ext_cost
		-- invert the sign intentional:  CBs lower costs, 31 Mar 18
		,-(t.[ExtChargebackAmt])					AS ext_chargeback

		-- extra
		-- remove NSA for costs
		,t.ID
		,cc_sales.[CostCenterKey]					AS ENTITY_sales_key
		,cc_cost.[CostCenterKey]					AS ENTITY_cost_key
		,cc_cb.[CostCenterKey]						AS ENTITY_cb_key
		,hfm_account_sales.[HFM_Account_key]		AS ACCOUNT_sales_key
		,hfm_account_cost.[HFM_Account_key]			AS ACCOUNT_cost_key
		,hfm_account_cb.[HFM_Account_key]			AS ACCOUNT_cb_key

		,iglob.global_product_class_key
		,isup.SupplierKey
		,cmarket.MarketClassKey
		,cspec.specialty_key
		,doc_source.source_key

		,doct.SourceCd
		,t.[GL_BusinessUnit]
		,t.[GL_Object_Sales]
		,t.[GL_Subsidiary_Sales]
		,t.[GL_Object_Cost] 
		,t.[GL_Subsidiary_Cost]
		,t.[GL_Object_ChargeBack]
		,t.[GL_Subsidiary_ChargeBack]

		,gl_bu.ReportingClass 
		,t.SalesDivision

		-- test
		,t.MajorProductClass
		,t.GLBU_Class			AS GLBU_Class_trans
		,iglob_bu.GLBU_Class	AS GLBU_Class_global
		,gps.GLBU_Class_map		AS GLBU_Class_gps

		,gl_bu.[GLBU_Class_map]	AS GLBU_Class_trans_map
		,iglob_bu.GLBU_Class_map	AS GLBU_Class_global_map
		,gps_bu.GLBU_Class_map	AS GLBU_Class_gps_map

		,t.AdjCode
		,t.Item
		,ih.MinorProductClass
		,t.Shipto
		,ch.HIST_MarketClass


	FROM         
		[dbo].[BRS_Transaction] AS t 

		INNER JOIN [dbo].[BRS_DocType] as doct
		ON t.DocType = doct.DocType

		INNER JOIN [comm].[source] as doc_source
		ON doct.SourceCd = doc_source.[source_cd]

		-- customer history
		INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
		ON t.Shipto = ch.[Shipto] AND
			t.[FiscalMonth] = ch.[FiscalMonth]

		INNER JOIN [dbo].[BRS_CustomerMarketClass] cmarket
		ON ch.HIST_MarketClass = cmarket.MarketClass

		INNER JOIN [dbo].[BRS_CustomerSpecialty] cspec
		ON ch.HIST_Specialty = cspec.Specialty

		-- item history
		INNER JOIN [dbo].[BRS_ItemHistory] as ih
		ON t.Item = ih.[Item] AND
			t.[FiscalMonth] = ih.[FiscalMonth]

		INNER JOIN [dbo].[BRS_ItemSupplier] as isup
		ON ih.Supplier = isup.Supplier

		-- sales
		LEFT JOIN [hfm].[account_master_F0901] as hfm_sales
		ON t.gl_account_sales_key = hfm_sales.gl_account_key 

		LEFT JOIN [hfm].[account] as hfm_account_sales
		ON hfm_sales.HFM_Account = hfm_account_sales.HFM_Account

		LEFT JOIN [hfm].[cost_center] as cc_sales
		ON hfm_sales.HFM_CostCenter = cc_sales.CostCenter

		-- ext_cost
		LEFT JOIN [hfm].[account_master_F0901] as hfm_cost
		ON t.gl_account_cost_key = hfm_cost.gl_account_key

		LEFT JOIN [hfm].[account] as hfm_account_cost
		ON hfm_cost.HFM_Account = hfm_account_cost.HFM_Account

		LEFT JOIN [hfm].[cost_center] as cc_cost
		ON hfm_cost.HFM_CostCenter = cc_cost.CostCenter

		-- ext chargeback
		LEFT JOIN [hfm].[account_master_F0901] as hfm_cb
		ON t.gl_account_chargeback_key = hfm_cb.gl_account_key

		LEFT JOIN [hfm].[account] as hfm_account_cb
		ON hfm_cb.HFM_Account = hfm_account_cb.HFM_Account

		LEFT JOIN [hfm].[cost_center] as cc_cb
		ON hfm_cb.HFM_CostCenter = cc_cb.CostCenter
		--

		-- GL Cost centre mapping

		INNER JOIN BRS_BusinessUnitClass  AS gl_bu
		ON	t.GLBU_Class = gl_bu.GLBU_Class

		LEFT JOIN [hfm].[global_product] as iglob
		ON t.[global_product_class_key] = iglob.global_product_class_key

		LEFT JOIN [dbo].[BRS_BusinessUnitClass] as iglob_bu
		ON iglob_bu.[GLBU_Class] = iglob.[GLBU_Class_map]

		-- exclusive	
		LEFT JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key

		-- GPS
		LEFT JOIN [hfm].[gps_code] as gps
		ON t.GpsKey = gps.GpsKey

		LEFT JOIN [dbo].[BRS_BusinessUnitClass] as gps_bu
		ON gps_bu.[GLBU_Class] = gps.[GLBU_Class_map]


	WHERE
--		(t.FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config]))  AND
		(t.FiscalMonth between 202108 and 202108)  AND

		-- exclude non-sales
		(t.SalesDivision < 'AZA') AND 
--		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 
		(gl_bu.[GLBU_ClassUS_L1] < 'ZZZZZ') AND
		--
--		test
--		(t.DocType <> 'AA') AND
--		(t.GLBU_Class like 'PRO%') AND
--		(t.GpsKey is not null) AND
--		(gl_bu.[GLBU_Class_map]	<> gps_bu.GLBU_Class_map) AND
--		(gl_bu.[GLBU_Class_map]	<> iglob_bu.[GLBU_Class_map]) AND
--		(iglob_bu.[GLBU_Class_map] <> '') AND
		
--		t.SalesOrderNumber = 1109883 AND
		(1=1)



GO

/*

print ('T01: missing ENTITY_sales')
SELECT * FROM [hfm].global_cube where ENTITY_sales is null and sales <> 0.0
-- ok

print ('T02: missing ACCOUNT_sales')
SELECT * FROM [hfm].global_cube where ACCOUNT_sales is null and sales <> 0.0
-- ok

print ('T03: missing ENTITY_cost')
SELECT * FROM [hfm].global_cube where ENTITY_cost is null and ext_cost <> 0.0
-- ok

print ('T04: missing ACCOUNT_cost')
SELECT * FROM [hfm].global_cube where ACCOUNT_cost is null and ext_cost <> 0.0
-- ok

print ('T05: missing ENTITY_cb')
SELECT * FROM [hfm].global_cube where ENTITY_cb is null and ext_chargeback <> 0.0
-- ok

print ('T06: missing ACCOUNT_cb')
SELECT * FROM [hfm].global_cube where ACCOUNT_cb is null and ext_chargeback <> 0.0
-- ok

print ('T07: missing PRODUCT')
SELECT * FROM [hfm].global_cube where PRODUCT = '' and MinorProductClass <> ''
-- check global mapping by product / defaults

print ('T08: missing SUPPLIER')
SELECT * FROM [hfm].global_cube where SUPPLIER = '' and Item not in ('', '+ Delivery','FREIGHT','105ZZZZ')
-- ok

print ('T09: missing BRAND_EQUITY')
SELECT * FROM [hfm].global_cube where BRAND_EQUITY = ''
-- ok

print ('T10: missing BRAND_LINE')
SELECT * FROM [hfm].global_cube where BRAND_LINE = ''
-- ok

print ('T11: missing CUSTOMER')
SELECT * FROM [hfm].global_cube where CUSTOMER = ''
-- add marketclass to 201909: 3855064, 3855329

print ('T12: missing CUSTOMER_SPECIALTY')
SELECT * FROM [hfm].global_cube where CUSTOMER_SPECIALTY = '' 
-- add specialty to 201909: 3855064, 3855329

print ('T13: missing ANALYSIS')
SELECT distinct ANALYSIS FROM [hfm].global_cube
-- compare list with excel final GPS


print ('T14: missing SourceCd')
SELECT * FROM [hfm].global_cube WHERE SourceCd is null
-- add next text to source 	'GL_Input', 'Manual_Entry' 


*/

-- TO DO GL conflict / 

-- SELECT top 100 * from [hfm].global_cube order by PERIOD

SELECT  * from [hfm].global_cube order by PERIOD
