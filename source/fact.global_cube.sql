SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER view fact.global_cube
AS

/******************************************************************************
**	File: 
**	Name: [hfm].global_cube_model
**	Desc: more granular version of [hfm].global_cube_proc.  used for modelling
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@StartMonth -- if 0, use defaults  
**	@EndMonth 
**	
**
**	Auth: tmc
**	Date: 29 Oct 20
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	14 Mar 22	tmc		Added GM line and group key for analysis
*******************************************************************************/

	SELECT   
--		top 1000

--		cc.[Entity]									AS ENTITY 
		ent.EntityKey

--		,hfm_map.[HFM_Account]						AS ACCOUNT
		,hfm.HFM_Account_key

--		,RTRIM(LEFT(ih.[global_product_class],9))	AS PRODUCT
		,gprod.global_product_class_key	

--		,RTRIM(excl.BrandEquityCategory)			AS BRAND_EQUITY
--		,RTRIM(excl.Excl_Code_Public)				AS BRAND_LINE
		,excl.Excl_Key

--		,RTRIM(ch.HIST_MarketClass)					AS MarketClass
		,mc.MarketClassKey

--		,RTRIM(ISNULL(g.GpsCode, ''))				AS GPS
		,ISNULL(g.GpsKey, 1)						AS gps_key

--		,RTRIM(ih.Supplier)							AS SUPPLIER
		,sup.SupplierKey

--		,doct.SourceCd								AS REPORTING_SOURCE
		,doct.DocTypeKey

		,t.FiscalMonth						
		,(t.ID)
--		,t.GLBU_Class						
		,buc.GLBU_ClassKey

--		,t.SalesDivision		
		,sdiv.SalesDivision_key
		
		,t.SalesDate								AS SalesDate_ORG
		,d.day_key

		,t.Shipto

--		,t.Item
		,itm.ItemKey

--		,t.TerritoryCd
		,br.BranchKey

--		,t.AdjCode	
		,adj.[AdjCodeKey]

		,t.SalesOrderNumber	
		,t.LineNumber

		,t.[FreeGoodsEstInd]
		,ISNULL(dw.FreeGoodsInvoicedInd,0)			AS FreeGoodsInvoicedInd

		,ISNULL(dw.ShippedQty,0)					AS ShippedQty

		,t.[NetSalesAmt]							AS sales_amt

		,(t.[NetSalesAmt]) - (t.[ExtendedCostAmt] -ISNULL(t.[ExtChargebackAmt],0))						AS gp_amt

		-- ugly, due to 0 trapping
		,ISNULL(1-(t.[ExtendedCostAmt] -ISNULL(t.[ExtChargebackAmt],0))/NULLIF(t.[NetSalesAmt],0),0)	AS gm_line
		,q.SpendKey	AS gm_line_key

		,ISNULL(pm.PriceMethodKey, 1)			AS PriceMethodKey
	
		-- Lookup fields for Salesorder dimension
		,ISNULL(hdr.ID_Header, 0)				AS ID_Header

		,ISNULL(dw.OriginalSalesOrderNumber,0)	AS OriginalSalesOrderNumber
		,ISNULL(t.[DocType], '')				AS [DocType]
		,ISNULL(dw.[OrderPromotionCode], '')	AS [OrderPromotionCode]
		,ISNULL(t.[OrderSourceCode], '')		AS [OrderSourceCode]
		,ISNULL(dw.[EnteredBy], '')				AS [EnteredBy]
		,ISNULL(dw.[OrderTakenBy], '')			AS [OrderTakenBy]
		-- promo tracking key
		,ISNULL(promo.promotion_key, 1)			AS promotion_key


	FROM         
		[dbo].[BRS_Transaction] AS t 

		LEFT JOIN [dbo].[BRS_TransactionDW] AS dw
		ON t.ID_source_ref = dw.ID

		INNER JOIN [dbo].[BRS_CustomerFSC_History] as ch
		ON t.Shipto = ch.[Shipto] AND
			t.[FiscalMonth] = ch.[FiscalMonth]

		INNER JOIN [dbo].[BRS_FSC_Rollup] fsc
		ON ch.HIST_TerritoryCd = fsc.TerritoryCd

		INNER JOIN [dbo].[BRS_Branch] br
		ON fsc.Branch = br.Branch

		INNER JOIN [dbo].[BRS_CustomerMarketClass] mc
		ON ch.HIST_MarketClass = mc.MarketClass

		INNER JOIN [dbo].[BRS_ItemHistory] as ih
		ON t.Item = ih.[Item] AND
			t.[FiscalMonth] = ih.[FiscalMonth]

		INNER JOIN [dbo].[BRS_ItemSupplier] sup
		ON ih.Supplier = sup.Supplier

		INNER JOIN [hfm].[global_product] gprod
		ON ih.global_product_class = gprod.global_product_class

		INNER JOIN [hfm].[account_master_F0901] as hfm_map
		ON t.[GL_BusinessUnit] = hfm_map.[GMMCU__business_unit] AND
			t.[GL_Object_Sales] = hfm_map.[GMOBJ__object_account] AND
			t.[GL_Subsidiary_Sales] = hfm_map.[GMSUB__subsidiary] 

		INNER JOIN [hfm].[account] as hfm
		ON hfm_map.HFM_Account = hfm.HFM_Account

		INNER JOIN [hfm].[cost_center] as cc
		ON hfm_map.HFM_CostCenter = cc.CostCenter

		INNER JOIN [hfm].[entity] as ent
		on cc.Entity = ent.Entity

		INNER JOIN [dbo].[BRS_BusinessUnitClass] buc
		ON t.GLBU_Class  = buc.GLBU_Class	

		INNER JOIN [dbo].[BRS_SalesDivision] sdiv
		ON t.SalesDivision = sdiv.SalesDivision

		INNER JOIN [dbo].[BRS_Item] itm
		ON t.Item = itm.Item

		INNER JOIN [dbo].[BRS_AdjCode] adj
		ON t.AdjCode = adj.[AdjCode]

		INNER JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key

		INNER JOIN [dbo].[BRS_DocType] as doct
		ON t.DocType = doct.DocType

		INNER JOIN [dbo].[BRS_TransactionDW_Ext] ext
		ON t.[SalesOrderNumber] = ext.[SalesOrderNumber] AND
		t.[DocType] = ext.[DocType]

		INNER JOIN [dbo].[BRS_Promotion] promo
		ON ext.PromotionTrackingCode =promo.[PromotionCode]

		INNER JOIN [dbo].[BRS_SalesDay] d
		ON t.SalesDate = d.[SalesDate]

		LEFT JOIN [hfm].[gps_code] as g
		ON t.GpsKey = g.GpsKey

		-- map gp_line to map bucket
		LEFT JOIN 
		(
			SELECT
				Spend_From, Spend_To, Spend_Display, Spend_Rank, SpendKey
			FROM
				BRS_Customer_Spend_Category
			WHERE
				(Spend_Category = N'L')
		) as q ON 
		(ISNULL(1-(t.[ExtendedCostAmt] -ISNULL(t.[ExtChargebackAmt],0))/NULLIF(t.[NetSalesAmt],0),0) >= q.Spend_From ) AND
		(ISNULL(1-(t.[ExtendedCostAmt] -ISNULL(t.[ExtChargebackAmt],0))/NULLIF(t.[NetSalesAmt],0),0) < q.Spend_to) AND
		-- between is inclusive and picking up overlaps
		-- (ISNULL(1-(t.[ExtendedCostAmt] -ISNULL(t.[ExtChargebackAmt],0))/NULLIF(t.[NetSalesAmt],0),0) between q.Spend_From and q.Spend_to)
		(1=1)

		-- identify first sales order (for sales order dimension)
		LEFT JOIN 
		(
			SELECT
				SalesOrderNumber
				,MIN(ID) AS ID_Header
			FROM
				BRS_Transaction
			WHERE 
				(FiscalMonth >= (Select MIN([FiscalMonth]) FROM [Dimension].[Day]))  AND
				-- (FiscalMonth = 202203)  AND
				(SalesDivision NOT IN('AZA', 'AZE')) AND 
				(1=1)
			GROUP BY SalesOrderNumber
		) AS hdr
		ON t.SalesOrderNumber = hdr.SalesOrderNumber

		LEFT JOIN [dbo].[BRS_PriceMethod] pm
		ON dw.PriceMethod = pm.PriceMethod



	WHERE
		(t.FiscalMonth >= (Select MIN([FiscalMonth]) FROM [Dimension].[Day]))  AND
		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 

		-- test
		-- t.id = 26278116 AND
--		t.SalesOrderNumber = 1109883 AND
--		ext.PromotionTrackingCode is null AND
--		(t.FiscalMonth = 202009)  AND
--		d.SalesDate is null AND
		--
		(1=1)

GO

-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01

 -- select * from fact.global_cube where SalesOrderNumber = 13164170
 -- ORG 6 445 502 @ 2m50s

