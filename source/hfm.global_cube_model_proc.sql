﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [hfm].global_cube_model_proc 
AS

/******************************************************************************
**	File: 
**	Name: [hfm].global_cube_model_proc 
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
*******************************************************************************/

BEGIN
	Declare @StartMonth int

	SET NOCOUNT ON;

	Set @StartMonth = (Select MIN([FiscalMonth]) FROM [Dimension].[Day])

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
		
		,CAST(t.SalesDate as date)					AS sales_day
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

		,(t.[NetSalesAmt])							AS sales_amt
		,(t.[ExtendedCostAmt]) 
		-ISNULL(t.[ExtChargebackAmt],0)				AS gp_amt
-- test

	FROM         
		[dbo].[BRS_Transaction] AS t 

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

		LEFT JOIN [hfm].[gps_code] as g
		ON t.GpsKey = g.GpsKey


	WHERE
		(t.FiscalMonth >= @StartMonth)  AND
		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 
--		(EXISTS (SELECT * FROM [Dimension].[Day] dd WHERE CAST(t.SalesDate as date) = dd.SalesDate)) AND

		-- test
--		t.SalesOrderNumber = 1109883 AND
		--
		(1=1)

END


GO


-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01

-- Exec [hfm].global_cube_model_proc 
-- 8 163 932 in 2m50s