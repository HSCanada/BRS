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

*******************************************************************************/

-- it would be a_CAN_Jan-18 

Declare @sVersion	varchar(10)		= 'Working'
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
		cc.[Entity]							AS ENTITY 
		,[HFM_Account]						AS ACCOUNT
		,RTRIM(LEFT(ih.MinorProductClass,9))	AS PRODUCT
		,RTRIM(excl.BrandEquityCategory)	AS BRAND_EQUITY
		,RTRIM(excl.Excl_Code)				AS BRAND_LINE
		,RTRIM(ch.HIST_MarketClass)			AS CUSTOMER
		,@sCurrency							AS CURRENCY
		,RTRIM(ISNULL(g.GpsCode, @sAnalysis))	AS ANALYSIS
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS REPORTING_SOURCE
		,t.FiscalMonth						AS PERIOD
		,@sVersion							AS VERSION
		,SUM(t.[NetSalesAmt])				AS AMOUNT

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
		(t.FiscalMonth between @StartMonth AND @EndMonth) 

	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,excl.Excl_Code
		,g.GpsCode
		,ch.HIST_MarketClass
		,doct.SourceCd
	HAVING
		(SUM(t.[NetSalesAmt]) <>0)


	UNION ALL

	-- Cost 2 of 3
	SELECT     
		cc.[Entity]							AS Entity
		,[HFM_Account]						AS Account
		,RTRIM(LEFT(ih.MinorProductClass,9))	AS Product
		,RTRIM(excl.BrandEquityCategory)	AS BrandEquity
		,RTRIM(excl.Excl_Code)				AS BrandLine
		,RTRIM(ch.HIST_MarketClass)			AS CustomerCategory
		,@sCurrency							AS Currency
		,RTRIM(ISNULL(g.GpsCode, @sAnalysis))	AS ANALYSIS
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,@sVersion								AS Version
		,SUM(t.[ExtendedCostAmt])			AS ValueAmt
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

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth)

	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,excl.Excl_Code
		,g.GpsCode
		,ch.HIST_MarketClass
		,doct.SourceCd
	HAVING 
		SUM(t.[ExtendedCostAmt])<>0

	UNION ALL

	-- Chargeback 3 of 3
	SELECT     
		cc.[Entity]							AS Entity
		,[HFM_Account]						AS Account
		,RTRIM(LEFT(ih.MinorProductClass,9))	AS Product
		,RTRIM(excl.BrandEquityCategory)	AS BrandEquity
		,RTRIM(excl.Excl_Code)				AS BrandLine
		,RTRIM(ch.HIST_MarketClass)			AS CustomerCategory
		,@sCurrency							AS Currency
		,RTRIM(ISNULL(g.GpsCode, @sAnalysis))	AS ANALYSIS
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,@sVersion							AS Version
		,SUM(t.[ExtChargebackAmt])			AS ValueAmt
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

	WHERE
		(t.ExtChargebackAmt is NOT NULL) AND
		(t.FiscalMonth between @StartMonth AND @EndMonth)

	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,excl.Excl_Code
		,g.GpsCode
		,ch.HIST_MarketClass
		,doct.SourceCd

	HAVING
		(SUM(t.[ExtChargebackAmt])<> 0)

END


GO


-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01


-- [hfm].global_cube_proc  201704, 201704

/*
	SELECT     
		cc.[Entity]							AS ENTITY 
		,t.[GL_BusinessUnit]
		,[HFM_Account]						AS ACCOUNT
		,RTRIM(LEFT(ih.MinorProductClass,9))	AS PRODUCT
		,RTRIM(excl.BrandEquityCategory)	AS BRAND_EQUITY
		,RTRIM(excl.Excl_Code)				AS BRAND_LINE
		,RTRIM(ch.HIST_MarketClass)			AS CUSTOMER
		,'curr'							AS CURRENCY
		,RTRIM(ISNULL(g.GpsCode, 'analysis'))	AS ANALYSIS
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS REPORTING_SOURCE
		,t.FiscalMonth						AS PERIOD
		,'ver'							AS VERSION
		,SUM(t.[NetSalesAmt])				AS AMOUNT

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
		(t.FiscalMonth = 201802)  AND
		([HFM_Account] in ('CgsMtrxEquip', 'MtrxCredEquip', 'MtrxEquip')) AND
		( cc.[Entity]	is  NULL)

	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,t.[GL_BusinessUnit]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,excl.Excl_Code
		,g.GpsCode
		,ch.HIST_MarketClass
		,doct.SourceCd
	HAVING
		(SUM(t.[NetSalesAmt]) <>0)


*/