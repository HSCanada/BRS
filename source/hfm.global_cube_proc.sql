﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [hfm].global_cube_proc 
	@StartMonth int = 201701, 
	@EndMonth int = 201701
AS

/******************************************************************************
**	File: 
**	Name: BRS_global_cube_proc
**	Desc: Pull Global Vendor Cube data
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
**	Date: 23 Oct 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	30 Nov 17	tmc		update Product to use sub-minor & use global rollup 4CC
**	02 Feb 18	tmc		Update layout, based on 1 Feb meeting
--	01 Mar 18	tmc		Update specs for load
--	02 Mar 18	tmc		Update Analysis for GSP
--	07 Mar 18	tmc		Add GSP dimension to Analysis
--	19 Mar 18	tmc		add test logic fields (remove after sign-off)
--	21 Mar 18	tmc		add net gp logic - caught during testing
--	22 Mar 18	tmc		add GLBU & Adj codes to cube for testing, remove zzzEXC tbd
--	06 May 18	tmc		added new Marketclass for restate logic
--	08 May 18	tmc		removed test fields
--	20 Jun 18	tmc		Point to Marketclass from new, as we are not in prod
--  29 Nov 18	tmc		add new Exclusive public field for rename flexabiltity
--	09 Jan 19	tmc		add temp test scafolding to find missing Sales order
--  29 Mar 19	tmc		add specialty & Supplier to feed
--	26 Sep 19	tmc		add global product xref
*******************************************************************************/

-- it would be a_CAN_Jan-18 

Declare @sVersion	varchar(10)		= 'WRKNG'
Declare @sCurrency	varchar(3)		= 'LOC'
Declare @sAnalysis	varchar(10)		= 'NoAnalysis'


BEGIN
	SET NOCOUNT ON;

	IF (@StartMonth = 0)
	BEGIN	
		SELECT     
			@StartMonth = YearFirstFiscalMonth_LY, 
			@EndMonth = PriorFiscalMonth
		FROM         
			BRS_Rollup_Support01
	END


	-- Sales 1 of 3
	SELECT   
--		top 10  

		cc.[Entity]								AS ENTITY 
		,[HFM_Account]							AS ACCOUNT
		,RTRIM(LEFT(ih.[global_product_class],9))	AS PRODUCT
--		,RTRIM(LEFT(ih.MinorProductClass,9))	AS PRODUCT
		,RTRIM(excl.BrandEquityCategory)		AS BRAND_EQUITY
		,RTRIM(excl.Excl_Code_Public)			AS BRAND_LINE
		,RTRIM(ch.HIST_MarketClass)				AS CUSTOMER
		,@sCurrency								AS CURRENCY
		,RTRIM(ISNULL(g.GpsCode, @sAnalysis))	AS ANALYSIS

		-- new
		,RTRIM(ih.Supplier)						AS SUPPLIER
		,RTRIM(ch.HIST_Specialty)				AS CUSTOMER_SPECIALTY

		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS REPORTING_SOURCE
		,t.FiscalMonth						AS PERIOD
		,@sVersion							AS VERSION
		,SUM(t.[NetSalesAmt])				AS AMOUNT

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

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth)  AND
		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 
--		test
--		t.SalesOrderNumber = 1109883 AND
		(1=1)


	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,hfm.[HFM_Account]
		,ih.[global_product_class]
--		,ih.MinorProductClass
		-- new
		,ih.Supplier
		,excl.BrandEquityCategory
		,excl.Excl_Code_Public
		,g.GpsCode
		-- new
		,ch.HIST_Specialty
		,ch.HIST_MarketClass
		,doct.SourceCd
-- test

--		,t.GL_BusinessUnit
--		,t.GL_Object_Sales
--		,t.SalesDivision
--		,t.GLBU_Class
--		,t.AdjCode


	HAVING
		(SUM(t.[NetSalesAmt]) <>0)


	UNION ALL


	-- Cost 2 of 3
	SELECT     
--		top 10

		cc.[Entity]								AS Entity
		,[HFM_Account]							AS Account
		,RTRIM(LEFT(ih.[global_product_class],9))	AS PRODUCT
--		,RTRIM(LEFT(ih.MinorProductClass,9))	AS PRODUCT
		,RTRIM(excl.BrandEquityCategory)		AS BrandEquity
		,RTRIM(excl.Excl_Code_Public)			AS BrandLine
		,RTRIM(ch.HIST_MarketClass)				AS CustomerCategory
		,@sCurrency								AS Currency
		,RTRIM(ISNULL(g.GpsCode, @sAnalysis))	AS ANALYSIS

		-- new
		,RTRIM(ih.Supplier)						AS SUPPLIER
		,RTRIM(ch.HIST_Specialty)				AS CUSTOMER_SPECIALTY

		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,@sVersion							AS Version
		,SUM(t.[ExtendedCostAmt])			AS ValueAmt
/*
-- test
		,t.GL_BusinessUnit
		,t.GL_Object_Cost
		,t.SalesDivision
		,t.GLBU_Class						AS TEST_GLBU_Class
		,t.AdjCode							AS TEST_AdjCode
		,t.AdjNum
		,min(t.id) id_min
		,max(t.id) id_max
*/
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
			t.[GL_Object_Cost] = hfm.[GMOBJ__object_account] AND
			t.[GL_Subsidiary_Cost] = hfm.[GMSUB__subsidiary] 

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

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth) AND
		(glru.ReportingClass <> 'NSA') AND
		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 

--		test
--		([HFM_Account]='CgsAdjBaseSchdA') AND
--		(cc.[Entity] is null) AND	
--		t.SalesOrderNumber = 1109883 AND

		(1=1)

	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,hfm.[HFM_Account]
		,ih.[global_product_class]
--		,ih.MinorProductClass
		-- new
		,ih.Supplier
		,excl.BrandEquityCategory
		,excl.Excl_Code_Public
		,g.GpsCode
		-- new
		,ch.HIST_Specialty
		,ch.HIST_MarketClass
		,doct.SourceCd
/*
-- test
		,t.GL_BusinessUnit
		,t.GL_Object_Cost
		,t.SalesDivision
		,t.GLBU_Class
		,t.AdjCode
		,t.AdjNum
*/

	HAVING 
		SUM(t.[ExtendedCostAmt])<>0

	UNION ALL


	-- Chargeback 3 of 3
	SELECT     
--		top 10 

		cc.[Entity]								AS Entity
		,[HFM_Account]							AS Account
		,RTRIM(LEFT(ih.[global_product_class],9))	AS PRODUCT
--		,RTRIM(LEFT(ih.MinorProductClass,9))	AS PRODUCT
		,RTRIM(excl.BrandEquityCategory)		AS BrandEquity
		,RTRIM(excl.Excl_Code_Public)			AS BrandLine
		,RTRIM(ch.HIST_MarketClass)				AS CustomerCategory
		,@sCurrency								AS Currency
		,RTRIM(ISNULL(g.GpsCode, @sAnalysis))	AS ANALYSIS

		-- new
		,RTRIM(ih.Supplier)						AS SUPPLIER
		,RTRIM(ch.HIST_Specialty)				AS CUSTOMER_SPECIALTY

		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,@sVersion							AS Version
		-- invert the sign intentional:  CBs lower costs, 31 Mar 18
		,-SUM(t.[ExtChargebackAmt])			AS ValueAmt

-- test

--		,t.GL_BusinessUnit
--		,t.GL_Object_ChargeBack
--		,t.SalesDivision
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
			t.[GL_Object_ChargeBack] = hfm.[GMOBJ__object_account] AND
			t.[GL_Subsidiary_ChargeBack] = hfm.[GMSUB__subsidiary] 

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

	WHERE
		(t.ExtChargebackAmt is NOT NULL) AND
		(t.FiscalMonth between @StartMonth AND @EndMonth) AND
		(glru.ReportingClass <> 'NSA') AND
		(t.SalesDivision NOT IN('AZA', 'AZE')) AND 

--		test
--		t.SalesOrderNumber = 1109883 AND

		(1=1)

	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,hfm.[HFM_Account]
		,ih.[global_product_class]
--		,ih.MinorProductClass
		-- new
		,ih.Supplier
		,excl.BrandEquityCategory
		,excl.Excl_Code_Public
		,g.GpsCode
		-- new
		,ch.HIST_Specialty
		,ch.HIST_MarketClass
		,doct.SourceCd
-- test

--		,t.GL_BusinessUnit
--		,t.GL_Object_ChargeBack
--		,t.SalesDivision
--		,t.GLBU_Class
--		,t.AdjCode


	HAVING
		(SUM(t.[ExtChargebackAmt])<> 0)


END


GO


-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01

-- see ETL for current update script docs - S:\BR\zDev\BRS\source\Updates\etl_working 20171217 global vendor - ETL details.sql

--a_CAN_Dec-19_RA.csv
-- [hfm].global_cube_proc  202108, 202108
-- 46 452 rows @ 6s
-- 



