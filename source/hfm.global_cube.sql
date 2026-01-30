
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
**	29 Jun 22	tmc		add temp 
**	14 Oct 24	tmc		add PPE to model for planning
**	28 Nov 24	tmc		refactor to serve as planning backend, base on VendorCat
**	29 Nov 24	tmc		add facts for Planning
**  06 Dec 24	tmc		org dimensions for Planning 
**	10 Dec 24	tmc		add salesorder xref for SO dimension
**	07 Oct 25	tmc		add GEP flag for eComm reporting
**	14 Jan 26	tmc		add pro-repair flag
**	29 Jan 26	tmc		add ProRepair to BrandLine
**    
*******************************************************************************/

	SELECT   

	--> Metrics
	--
	--top 10
	--

	-- ID
		t.ID										
		,dw.ID										AS ID_DW

	-- Orders and flags ->
		,t.SalesOrderNumber
		,t.LineNumber
		,t.DocType

		-- ds source
		,doct.SourceCd
		-- comm source
		,doc_source.source_key
		,gl_bu.ReportingClass 
		,doc_source.source_global_desc				AS REPORTING_SOURCE
		,t.FreeGoodsEstInd
		,dw.OrderPromotionCode
		,dw.PromotionCode
		,t.OrderSourceCode
		,dw.EnteredBy
		,dw.OrderTakenBy

		,dw.[CustomerPOText1]
		,dw.EquipmentOrderType
		,dw.EquipmentOrderNumber

		-- reminder that FG invoiced is from the DW (qty) and if left joined to the DS
		,ISNULL(dw.FreeGoodsInvoicedInd, 0) AS FreeGoodsInvoicedInd
		,ext.[ID_DS_xref]
		,'LOC'										AS CURRENCY
		,'WRKNG'									AS VERSION

		-- metrics core
		,(t.[NetSalesAmt])																												AS NetSalesAmt
		,CASE WHEN gl_bu.ReportingClass = 'NSA' THEN 0 ELSE t.NetSalesAmt - (t.ExtendedCostAmt - ISNULL(t.[ExtChargebackAmt],0)) END	AS GPAmt
		,CASE WHEN gl_bu.ReportingClass = 'NSA' THEN 0 ELSE t.NetSalesAmt - (t.ExtendedCostAmt) END										AS GPExclCBAmt
		,ISNULL(dw.ShippedQty,0)																										AS ShippedQty
		-- dup sales for legacy support
		,(t.[NetSalesAmt])																												AS sales
		,(t.[ExtendedCostAmt])						AS ext_cost
		-- invert the sign intentional:  CBs lower costs, 31 Mar 18
		,-(ISNULL(t.[ExtChargebackAmt],0))			AS ext_chargeback
		,ISNULL(dw.ShippedQty * size_unit_rate,0) AS QuantityUnit
	--< Metrics

	--> Time
		,t.FiscalMonth								
		,t.FiscalMonth								AS PERIOD
		,sales_day.day_key
--		,t.FiscalMonth / 100	AS fiscal_year
	--< Time

	--> Customer Historic 
		,t.Shipto
		,c.BillTo

		,ch.cust_hist_key

			,cmarket.MarketClassKey						AS HIST_MarketClassKey
			,ch.HIST_MarketClass
			,RTRIM(ch.HIST_MarketClass)					AS CUSTOMER
			,cspec.specialty_key
			,RTRIM(ch.HIST_Specialty)					AS CUSTOMER_SPECIALTY

			,sdiv.SalesDivision_key
			,t.SalesDivision

			,br.BranchKey								AS HIST_BranchKey
			,t.Branch

	--< Customer Historic

	--> Item Historic

		-- item
		,i.ItemKey
		,ih.item_hist_key

		,t.Item
		--,dw.Item  item_dw

		-- supplier
		,isup.SupplierKey							AS HIST_SupplierKey

		-- break out wand supplier
		,CASE 
			WHEN excl.Excl_Code_Public = 'COMPUDENT' 
			THEN 'COMP'
			ELSE RTRIM(ISNULL(ih.Supplier,''))
		END											AS SUPPLIER

		-- minor
		,icat.MinorProductClassKey
		,ih.MinorProductClass
		,t.MajorProductClass
		,icat.CategoryRollup
		,icat.CategoryRollupPPE

		-- global
		,iglob.global_product_class_key
		-- break out Dentrix from other software using special codes
		,CASE
			WHEN t.GLBU_Class ='DTXSP'
			THEN 
				CASE 
					WHEN ih.[global_product_class] = '870-20-20'	THEN 'ProductSW'
					ELSE											'Other_Technology'
--					WHEN ih.[global_product_class] = ''				THEN 'Other_Technology'
--					ELSE RTRIM(LEFT(ih.[global_product_class],9))
				END
			ELSE 
				CASE 
					-- override prorepair mapping with custom US code
					WHEN t.d1_prorepair_ind=1	THEN '920-99'
					ELSE						RTRIM(LEFT(ISNULL(iglob.[global_product_class],''),9))
				END
		END											AS PRODUCT

		-- label hist (dim item hist)
		,ih.Label  AS hist_label	
		-- set adjustment drive owned product
		,CASE 
			WHEN t.GLBU_Class in ('BSOLN', 'DTXSP', 'LEASE') 
			THEN 'Owned' 
			ELSE RTRIM(excl.BrandEquityCategory)
		END											AS BRAND_EQUITY

		,CASE 
			WHEN t.GLBU_Class in ('BSOLN', 'DTXSP', 'LEASE') 
			THEN '' 
			ELSE 
				CASE 
					-- override prorepair mapping with custom US code
					WHEN t.d1_prorepair_ind=1	THEN 'ProRepair'
					ELSE						RTRIM(ISNULL(excl.Excl_Code_Public,''))
				END

			
		END											AS BRAND_LINE

		,excl.Excl_Key

		-- glove units (dim item curr)
		,i.size_unit_rate

	--< Item Historic


	--> GPS new dim to to GLBU rules
		,gps.GpsKey
		,RTRIM(ISNULL(gps.GpsCode, 'NoAnalysis'))	AS ANALYSIS

	--< GPS new dim to to GLBU rules

	-- fin adj segmented (DS)->
		,t.[SalesOrderNumberKEY]	AS  AdjBatchNum
		,t.[AdjNum]
		,t.[AdjCode]
		,t.[AdjNote]
		,t.[Warehouse]				AS AdjRemark
		,t.[CustomerPOText1]		AS AdjSource
		,t.[AdditionalWarehouse]	AS AdjOwner
		,t.[ARInvoiceDocType]		AS AdjGLDocType
		,adj.AdjCodeKey
		,adj.AdjType
		,adj.AdjCodeDesc
		,adj.AdjLevel
		,adj.AdjClass

		-- fin adj segmented (DS) <-

		-- promo
		,promo_line.promotion_key	AS promoline_promotion_key

		-- GL ->
		,gl_bu.GLBU_ClassKey

		-- phase2
		,cc_sales.[Entity]							AS ENTITY_sales
		,cc_cost.[Entity]							AS ENTITY_cost
		,cc_cb.[Entity]								AS ENTITY_cb

		,hfm_sales.[HFM_Account]					AS ACCOUNT_sales
		,hfm_cost.[HFM_Account]						AS ACCOUNT_cost
		,hfm_cb.[HFM_Account]						AS ACCOUNT_cb

		-- remove NSA for costs
		,cc_sales.[CostCenterKey]					AS ENTITY_sales_key
		,cc_cost.[CostCenterKey]					AS ENTITY_cost_key
		,cc_cb.[CostCenterKey]						AS ENTITY_cb_key

		,hfm_account_sales.[HFM_Account_key]		AS ACCOUNT_sales_key
		,hfm_account_cost.[HFM_Account_key]			AS ACCOUNT_cost_key
		,hfm_account_cb.[HFM_Account_key]			AS ACCOUNT_cb_key

		,t.[GL_BusinessUnit]
		,t.[GL_Object_Sales]
		,t.[GL_Subsidiary_Sales]
		,t.[GL_Object_Cost] 
		,t.[GL_Subsidiary_Cost]
		,t.[GL_Object_ChargeBack]
		,t.[GL_Subsidiary_ChargeBack]

		,t.GLBU_Class			AS GLBU_Class_trans
		,iglob_bu.GLBU_Class	AS GLBU_Class_global
		,gps.GLBU_Class_map		AS GLBU_Class_gps

		,gl_bu.[GLBU_Class_map]	AS GLBU_Class_trans_map
		,iglob_bu.GLBU_Class_map	AS GLBU_Class_global_map
		,gps_bu.GLBU_Class_map	AS GLBU_Class_gps_map
		
		,hfm_sales.gl_account_key   hfm_gl_account_sales_key
		,hfm_cost.gl_account_key	hfm_gl_account_cost_key
		,hfm_cb.gl_account_key		hfm_gl_account_cb_key

		-- GL <-
		,dw.GEP_Order_Flag_ind

		,t.d1_prorepair_ind



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

		INNER JOIN [dbo].[BRS_Customer] c
		ON t.Shipto = c.ShipTo

		-- branch
		INNER JOIN [dbo].[BRS_Branch] br
		ON t.Branch = br.Branch

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

		-- adjuments
		INNER JOIN [dbo].[BRS_AdjCode] adj
		on t.AdjCode = adj.AdjCode

		-- exclusive	
		LEFT JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key

		-- ppe
		LEFT JOIN [dbo].[BRS_ItemCategory] as icat
		ON ih.MinorProductClass = icat.MinorProductClass

		-- GPS
		LEFT JOIN [hfm].[gps_code] as gps
		ON t.GpsKey = gps.GpsKey

		LEFT JOIN [dbo].[BRS_BusinessUnitClass] as gps_bu
		ON gps_bu.[GLBU_Class] = gps.[GLBU_Class_map]

		-- qty

		LEFT JOIN [dbo].[BRS_Item] i
		ON t.Item = i.Item

		LEFT JOIN [dbo].[BRS_TransactionDW] dw
		ON t.SalesOrderNumberKEY = dw.SalesOrderNumber AND
			t.DocType = dw.DocType AND
			t.LineNumber = dw.LineNumber AND
			doct.SourceCd = 'JDE' AND
			-- test
			(1=1)

		-- salesorder
		LEFT JOIN [dbo].[BRS_TransactionDW_Ext] ext
		ON t.[SalesOrderNumber] = ext.[SalesOrderNumber] AND
		t.DocType = ext.doctype

		-- day
		INNER JOIN [dbo].[BRS_SalesDay] sales_day
		ON t.[SalesDate] = sales_day.SalesDate

		-- salesdiv history
		INNER JOIN [dbo].[BRS_SalesDivision] sdiv
		ON t.SalesDivision = sdiv.SalesDivision

		-- promo line
		LEFT JOIN [dbo].[BRS_Promotion] promo_line
		ON dw.PromotionCode = promo_line.PromotionCode


	WHERE
		(t.FiscalMonth between 201901 and (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config]))  AND

--		(t.FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config]))  AND
--		(t.FiscalMonth between 202108 and 202108)  AND

		-- exclude non-sales
		(t.SalesDivision < 'AZA') AND 
		(gl_bu.[GLBU_ClassUS_L1] < 'ZZZZZ') AND
		-- temp fix, active Feb 2022 going forward
		(t.AdjCode <> 'XXXFGE') AND

		--(AdjCode = 'XXXFGE') AND
		--
--		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 
		--
--		test
--		i.size_unit_rate > 0 and 
--		t.Item <> dw.Item AND
--		t.Shipto <> dw.Shipto AND
--		(t.DocType <> 'AA') AND
--		(t.GLBU_Class like 'PRO%') AND
--		(t.GpsKey is not null) AND
--		(gl_bu.[GLBU_Class_map]	<> gps_bu.GLBU_Class_map) AND
--		(gl_bu.[GLBU_Class_map]	<> iglob_bu.[GLBU_Class_map]) AND
--		(iglob_bu.[GLBU_Class_map] <> '') AND
		
--		t.SalesOrderNumber = 1109883 AND
		(1=1)



GO

 

 -- BI test
-- SELECT top 10 * FROM [hfm].global_cube where PERIOD = 202510
 -- SELECT * FROM [hfm].global_cube where PERIOD = (SELECT PriorFiscalMonth from BRS_Config)

 -- SELECT PriorFiscalMonth from BRS_Config
 
 -- ORG 222 284 @ 11s
 -- NEW 222 284 @ 26s

 -- PROD 313 988 @ 43
 /*

print ('T01: missing ENTITY_sales')
SELECT * FROM [hfm].global_cube where ENTITY_sales is null and sales <> 0.0 and PERIOD = 202512
-- ok

print ('T02: missing ACCOUNT_sales')
SELECT * FROM [hfm].global_cube where ACCOUNT_sales is null and sales <> 0.0 and PERIOD = 202512
-- ok

print ('T03: missing ENTITY_cost')
SELECT * FROM [hfm].global_cube where ENTITY_cost is null and ext_cost <> 0.0 and PERIOD = 202512
-- ok

print ('T04: missing ACCOUNT_cost')
SELECT * FROM [hfm].global_cube where ACCOUNT_cost is null and ext_cost <> 0.0 and PERIOD = 202512
-- ok

-- xxx
print ('T05: missing ENTITY_cb') 
SELECT * FROM [hfm].global_cube where ENTITY_cb is null and ext_chargeback <> 0.0 and PERIOD = 202512
-- ok

print ('T06: missing ACCOUNT_cb')
SELECT * FROM [hfm].global_cube where ACCOUNT_cb is null and ext_chargeback <> 0.0 and PERIOD = 202512
-- ok

print ('T07: missing PRODUCT')
SELECT distinct Item, MinorProductClass FROM [hfm].global_cube where PRODUCT = '' and MinorProductClass <> '' and PERIOD = 202512
-- check global mapping by product / defaults

print ('T08: missing SUPPLIER')
SELECT * FROM [hfm].global_cube where SUPPLIER = '' and Item not in ('', '+ Delivery','FREIGHT','105ZZZZ') and PERIOD = 202512
-- ok

print ('T09: missing BRAND_EQUITY')
SELECT * FROM [hfm].global_cube where BRAND_EQUITY = '' and PERIOD = 202512
-- ok

print ('T10: missing BRAND_LINE')
SELECT * FROM [hfm].global_cube where BRAND_LINE = ''and PERIOD = 202512
-- ok

print ('T11: missing CUSTOMER')
SELECT * FROM [hfm].global_cube where CUSTOMER = '' and PERIOD = 202512
-- ok

print ('T12: missing CUSTOMER_SPECIALTY')
SELECT * FROM [hfm].global_cube where CUSTOMER_SPECIALTY = '' and PERIOD = 202512
-- ok

print ('T13: missing ANALYSIS')
SELECT distinct ANALYSIS FROM [hfm].global_cube where PERIOD = 202512
-- compare list with excel final GPS

print ('T14: missing SourceCd')
SELECT * FROM [hfm].global_cube WHERE SourceCd is null and PERIOD = 202512
-- add next text to source 	'GL_Input', 'Manual_Entry' 


*/

-- TO DO GL conflict / 

--SELECT top 100 * from [hfm].global_cube order by PERIOD desc
--SELECT sum(ext_cost) from [hfm].global_cube where period = 202201 and AdjCode <> 'XXXFGE' 
--SELECT sum(ext_cost) from [hfm].global_cube where period = 202201 and AdjCode = 'XXXFGE' 
--SELECT sum(ext_cost) from [hfm].global_cube where period = 202201 and AdjCode = 'FREEGD' 
--SELECT * from [hfm].global_cube where period = 202201 and AdjCode in( 'FREEGD' ,'XXXFGE')
--SELECT distinct AdjCode from [hfm].global_cube where period = 202108 and AdjCode <> 'XXXFGE' 

/*
FG = 745660.66
FG Not = 23119915.8911
total = 23865576.5511
*/

--SELECT  * from [hfm].global_cube order by PERIOD

--SELECT  count(*) from [hfm].global_cube 

-- SELECT * FROM [hfm].global_cube where PERIOD = 202408 and PRODUCT = '850-30-10'  order by sales desc

 /*

 -- patch chargeback due to cyber fun, tmc, 21 Nov 23

UPDATE 
	BRS_Transaction 
SET 
	BRS_Transaction.GL_Object_ChargeBack = '4730'
WHERE 
	(BRS_Transaction.FiscalMonth=202401) AND 
	(BRS_Transaction.ExtChargebackAmt<>0) AND 
	(BRS_Transaction.GL_Object_ChargeBack='')
GO

UPDATE
	BRS_Transaction
SET
	[gl_account_chargeback_key] = a.[gl_account_key]
FROM
	hfm.account_master_F0901 AS a 
	INNER JOIN BRS_Transaction 
	ON a.GMMCU__business_unit = BRS_Transaction.GL_BusinessUnit AND 
		a.GMOBJ__object_account = BRS_Transaction.GL_Object_ChargeBack AND 
		a.GMSUB__subsidiary = BRS_Transaction.GL_Subsidiary_ChargeBack
WHERE
	ISNULL([gl_account_chargeback_key],0) <> a.[gl_account_key] AND
	(BRS_Transaction.FiscalMonth = 202401)
GO


--  Thrive fix

select * from [hfm].[account_master_F0901] where [GMOBJ__object_account] in ('4332', '4320') or [GMDL01_description] like '%priv%' order by GMOBJ__object_account -- [GMDL01_description]

select * from [hfm].[account_master_F0901] where [GMOBJ__object_account] in ('4730')  order by GMOBJ__object_account -- [GMDL01_description]


*/



-- BI test - NEW
-- note: set to text output
/*
SELECT
	MIN(t.FiscalMonth) as FiscalMonth
	,COUNT (*)  AS line_count
	,SUM(NetSalesAmt) TotalSalesAmt
	,SUM(GPAmt) TotalGPAmt
	,SUM(GPExclCBAmt) TotalGPExclCBAmt
	,-SUM(ext_chargeback)  ExtChargebackAmt

FROM            [hfm].global_cube AS t
WHERE        
	PERIOD =  202410
*/
 

SELECT * FROM [hfm].global_cube AS t WHERE PERIOD =  202401 and d1_prorepair_ind=1

-- SELECT * FROM [hfm].global_cube AS t WHERE PERIOD =  202509 and SUPPLIER like 'BAINT%' and PRODUCT like '880%'

-- SELECT count (*) FROM [hfm].global_cube AS t WHERE PERIOD =  202410 
-- ORG 313 988

