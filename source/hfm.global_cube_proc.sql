SET ANSI_NULLS ON
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

*******************************************************************************/

Declare @sVer varchar(10) = '2018.02.02'

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

	-- Sales 1 of 2
	SELECT     
		cc.[Entity]							AS Entity
		,[HFM_Account]						AS Account
		,LEFT(ih.MinorProductClass,9)		AS Product
		,excl.BrandEquityCategory			AS BrandEquity
		,excl.Excl_Code						AS BrandLine
		,ch.HIST_MarketClass				AS CustomerCategory
		,'CAD'								AS Currency
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,'Actual'							AS Senario
		,@sVer								AS Version
		,SUM(t.[NetSalesAmt])				AS ValueAmt

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

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth) 

	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,excl.Excl_Code
		,ch.HIST_MarketClass
		,doct.SourceCd

	UNION ALL

	-- Cost 2 of 3
	SELECT     
		cc.[Entity]							AS Entity
		,[HFM_Account]						AS Account
		,LEFT(ih.MinorProductClass,9)		AS Product
		,excl.BrandEquityCategory			AS BrandEquity
		,excl.Excl_Code						AS BrandLine
		,ch.HIST_MarketClass				AS CustomerCategory
		,'CAD'								AS Currency
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,'Actual'							AS Senario
		,@sVer								AS Version
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

	WHERE
		(t.FiscalMonth between @StartMonth AND @EndMonth) 

	GROUP BY 
		t.FiscalMonth
		,cc.[Entity]
		,hfm.[HFM_Account]
		,ih.MinorProductClass
		,excl.BrandEquityCategory
		,excl.Excl_Code
		,ch.HIST_MarketClass
		,doct.SourceCd

	UNION ALL

	-- Chargeback 3 of 3
	SELECT     
		cc.[Entity]							AS Entity
		,[HFM_Account]						AS Account
		,LEFT(ih.MinorProductClass,9)		AS Product
		,excl.BrandEquityCategory			AS BrandEquity
		,excl.Excl_Code						AS BrandLine
		,ch.HIST_MarketClass				AS CustomerCategory
		,'CAD'								AS Currency
		,CASE 
			WHEN doct.SourceCd = 'JDE' 
			THEN 'GL_Input' 
			ELSE 'Manual_Entry' 
		END									AS ReportingSource
		,t.FiscalMonth						AS Period
		,'Actual'							AS Senario
		,@sVer								AS Version
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
		,ch.HIST_MarketClass
		,doct.SourceCd

END


GO


-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01


-- [hfm].global_cube_proc  201712, 201712

