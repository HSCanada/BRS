﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE BRS_global_cube_proc 
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

*******************************************************************************/

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

	-- Sales
	SELECT     
		t.GL_BusinessUnit					AS Test_GL_BusinessUnit
		,t.GL_Object_Sales					AS Test_GL_Object_Sales
--		,t.Shipto
--		,t.Item
		,'Test.SALES.ACT'					AS Test_Source
		,hfm.[HFM_CostCenter]				AS Entity
		,[HFM_Account]						AS Account
		,LEFT(ih.MinorProductClass,3)		AS Product
		,excl.BrandEquityCategory			AS BrandEquity
		,ch.HIST_MarketClass				AS CustomerCategory
		,'CAD'								AS Currency
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,'Actual'							AS Senario
		,SUM(t.[NetSalesAmt])				AS ValueAmt
--		,CASE	WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 
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

		INNER JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key

		INNER JOIN [dbo].[BRS_DocType] as doct
		ON t.DocType = doct.DocType

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth) 
--		(t.FiscalMonth between 201701 AND 201701) 

	GROUP BY 
		t.FiscalMonth
--		,t.Shipto
--		,t.Item
		,t.GL_BusinessUnit
		,t.GL_Object_Sales
		,hfm.[HFM_CostCenter]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,ch.HIST_MarketClass
		,doct.SourceCd

	UNION ALL

	-- Cost
	SELECT     
		t.GL_BusinessUnit					AS Test_GL_BusinessUnit
		,t.GL_Object_Sales					AS Test_GL_Object_Sales
--		,t.Shipto
--		,t.Item
		,'Test.COST.ACT'					AS Test_Source
		,hfm.[HFM_CostCenter]				AS Entity
		,[HFM_Account]						AS Account
		,LEFT(ih.MinorProductClass,3)		AS Product
		,excl.BrandEquityCategory			AS BrandEquity
		,ch.HIST_MarketClass				AS CustomerCategory
		,'CAD'								AS Currency
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,'Actual'							AS Senario
		,SUM(t.[ExtendedCostAmt])			AS ValueAmt
--		,CASE	WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 
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

		INNER JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key

		INNER JOIN [dbo].[BRS_DocType] as doct
		ON t.DocType = doct.DocType

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth) 
--		(t.FiscalMonth between 201701 AND 201701) 

	GROUP BY 
		t.FiscalMonth
--		,t.Shipto
--		,t.Item
		,t.GL_BusinessUnit
		,t.GL_Object_Sales
		,hfm.[HFM_CostCenter]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,ch.HIST_MarketClass
		,doct.SourceCd

	UNION ALL

	-- Chargeback
	SELECT     
		t.GL_BusinessUnit					AS Test_GL_BusinessUnit
		,t.GL_Object_Sales					AS Test_GL_Object_Sales
--		,t.Shipto
--		,t.Item
		,'Test.CHARGEBACK.EST'					AS Test_Source
		,hfm.[HFM_CostCenter]				AS Entity
		,[HFM_Account]						AS Account
		,LEFT(ih.MinorProductClass,3)		AS Product
		,excl.BrandEquityCategory			AS BrandEquity
		,ch.HIST_MarketClass				AS CustomerCategory
		,'CAD'								AS Currency
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,'Actual'							AS Senario
		,SUM(t.[ExtChargebackAmt])			AS ValueAmt
--		,CASE	WHEN MIN(glru.ReportingClass) = 'NSA' THEN 0 
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

		INNER JOIN [hfm].[exclusive_product] as excl
		ON ih.Excl_key = excl.Excl_Key

		INNER JOIN [dbo].[BRS_DocType] as doct
		ON t.DocType = doct.DocType

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth) AND
--		(t.FiscalMonth between 201701 AND 201701) AND
		(t.ExtChargebackAmt is NOT NULL) AND
		(1=1)

	GROUP BY 
		t.FiscalMonth
--		,t.Shipto
--		,t.Item
		,t.GL_BusinessUnit
		,t.GL_Object_Sales
		,hfm.[HFM_CostCenter]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,ch.HIST_MarketClass
		,doct.SourceCd

END

GO


-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01

-- Run with PrioBRS_global_cube_procr Fiscal Month ref (results to text)
-- BRS_global_cube_proc 201701, 201709

-- ORG = 29323 rows, 11 sec



