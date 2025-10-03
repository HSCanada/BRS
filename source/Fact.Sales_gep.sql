SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Fact].Sales_gep
	@bDebug as smallint = 1
AS

/******************************************************************************
**	File: 
**	Name: [Fact].Sales_gep
**	Desc: Telesales Sales pull  
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@bDebug
**
**	Auth: tmc
**	Date: 11 Oct 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	07 Nov 16	tmc		Added additional metrics
--  08 Nov 16	tmc		Clarified Tag coding Y/N -> TS_TAG / NO
--	29 Dec 16	tmc		Add MTD Logic
--	05 Feb 17	tmc		Changed from goods logic from Est to Billed at zero
--	22 Feb 18	tmc		update to daily for consolidator
--	19 Sep 25	tmc		update model to support GEP KPI
--	02 Oct	25	tmc		add show tracking:  line, header, show promo
**    
*******************************************************************************/

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET NOCOUNT ON

	if (@bDebug <> 0)
		SET NOCOUNT OFF;

	if (@bDebug <> 0)
		Print 'BRS_TS_Cube_proc - DEBUG MODE.'

	--Get Params
	 
	--Pull Cube based on Params

	SELECT     
		--> test case
--		top 1000 
		--< test case

		t.ID							AS FactKey
		,CAST(d.SalesDate as date)		AS SalesDate
--		,d.FiscalMonth
		,t.Shipto
		,i.ItemKey						AS ItemKey

		,t.[SalesOrderNumber]			AS SalesOrderNumber
		,t.[LineNumber]					AS LineNumber
		,ISNULL(isr_emp.[EmployeeKey], 1) AS IsrEmployeeKey
		,src.OrderSourceCodeKey
		,dtype.DocTypeKey

		,CASE 
			WHEN (t2.TsTerritoryCd) = '' 
			THEN 0 
			ELSE 1
		END								AS TsTagInd

		,CASE 
			WHEN 
				t.Item = hdr.Item And 
				t.Shipto = hdr.Shipto AND
				t.Date = hdr.LastSalesDate
			THEN 1
			ELSE 0
		END								AS LastOrderInd

		,t.[ShippedQty]					AS Quantity
		,t.NetSalesAmt					AS SalesAmt
		,t.GPAtCommCostAmt				AS GPcommAmt

-->	17 Sep 25	tmc		update model to support GEP KPI
		,t.GEP_Order_Flag_ind
		
		-- from quote tracker fact
		,(t.GPAmt + ISNULL(t.ExtChargebackAmt,0))		AS GPfinAmt
		,(t.ExtListPrice  + t.ExtPrice -  t.NetSalesAmt)  AS ExtBaseAmt
		,(t.ExtListPrice  + t.ExtPrice -2*t.NetSalesAmt)  AS DiscountAmt
		,(t.ExtListPrice  + 0          -  t.NetSalesAmt)  AS DiscountLineAmt
		,(0               + t.ExtPrice -  t.NetSalesAmt)  AS DiscountOrderAmt
		,d.FiscalWeek

		-- magic cohort flag (time period in correct period AND customer cohort active
		, CASE 
			WHEN dd.GEP_TimePeriod_cd = 'AF' AND d.SalesDate >= gep_cohort.GEP_StartDate THEN 1
			WHEN dd.GEP_TimePeriod_cd = 'PY' AND d.SalesDate >= gep_cohort.GEP_StartDate_LY THEN 1
			WHEN dd.GEP_TimePeriod_cd = 'BF' AND c.GEP_Cohort_Code <> 'ZZ' THEN 1
			ELSE 0
		END AS GEP_Period_Flag_ind

/*
		,c.GEP_Cohort_Code GEP_Cohort_Code_test
		,d.SalesDate SalesDate_test
		,gep_cohort.GEP_StartDate GEP_StartDate_test
		,gep_cohort.GEP_StartDate_LY GEP_StartDate_LY_test
		,dd.GEP_TimePeriod_cd GEP_TimePeriod_cd_test

		, CASE 
			WHEN dd.GEP_TimePeriod_cd = 'AF' AND d.SalesDate >= gep_cohort.GEP_StartDate THEN 'AF good'
			WHEN dd.GEP_TimePeriod_cd = 'PY' AND d.SalesDate >= gep_cohort.GEP_StartDate_LY THEN 'PY good'
			WHEN dd.GEP_TimePeriod_cd = 'BF' AND c.GEP_Cohort_Code <> 'ZZ' THEN 'BF good'
			ELSE 'zOther'
		END AS GEP_Period_Flag_ind_test
*/


--<	17 Sep 25	tmc		update model to support GEP KPI

	,ISNULL(plin.promotion_key,1)	AS promo_line_key
	,ISNULL(phdr.promotion_key,1)	AS promo_header_key
	,ISNULL(pshw.promotion_key,1)	AS promo_show_key




	FROM         
		dbo.BRS_TransactionDW AS t 

		INNER JOIN [dbo].[BRS_Item] AS i
		on t.item = i.item	

		INNER JOIN [dbo].[BRS_Customer] as c
		on t.Shipto = c.ShipTo

-->	19 Sep 25	tmc		update model to support GEP KPI
		LEFT JOIN [pbi].[gep_cohort] as gep_cohort
		on c.GEP_Cohort_Code = gep_cohort.GEP_Cohort_Code

		INNER JOIN [Dimension].[Day] dd 
		ON t.Date = dd.SalesDate

--<	19 Sep 25	tmc		update model to support GEP KPI


		INNER JOIN [dbo].[BRS_FSC_Rollup] isr
		ON c.TsTerritoryCd = isr.TerritoryCd
		
		LEFT JOIN [dbo].[BRS_Employee] isr_emp
		ON isr.FSCRollup = isr_emp.IsrRollupCd 

		INNER JOIN BRS_SalesDay AS d 
		ON d.SalesDate = t.Date 

	    INNER JOIN BRS_TransactionDW_Ext AS t2 
		ON t.SalesOrderNumber = t2.SalesOrderNumber AND 
			t.DocType = t2.DocType 

-->	02 Oct	25	tmc		add show tracking:  line, header, show promo
	    LEFT JOIN [dbo].[BRS_Promotion] AS plin
		ON t.PromotionCode = plin.PromotionCode

	    LEFT JOIN [dbo].[BRS_Promotion] AS phdr
		ON t.OrderPromotionCode = phdr.PromotionCode

	    LEFT JOIN [dbo].[BRS_Promotion] AS pshw
		ON t2.PromotionTrackingCode = pshw.PromotionCode


--<	02 Oct	25	tmc		add show tracking:  line, header, show promo


		INNER JOIN [dbo].[BRS_DocType] AS dtype
		ON t.DocType = dtype.DocType

		INNER JOIN [dbo].[BRS_OrderSource] as src
		ON t.OrderSourceCode = src.OrderSourceCode

		-- identify last customer / item order
		LEFT JOIN 
		(
			SELECT
				tlast.shipto,
				tlast.item,
				Max(tlast.Date) AS LastSalesDate
			FROM
				dbo.BRS_TransactionDW AS tlast 
			WHERE     
				-- ensure sub-range and full match
				(tlast.FreeGoodsInvoicedInd = 0) AND
				(EXISTS 
					(SELECT * FROM [Dimension].[Day] dd2 
					WHERE tlast.Date = dd2.SalesDate)
				) AND
				(1=1)
			GROUP BY 
				tlast.[Shipto],
				tlast.Item
		) AS hdr
		ON t.Shipto = hdr.Shipto AND
			t.Item= hdr.Item

	WHERE     
		(t.FreeGoodsInvoicedInd = 0) AND
		(i.SalesCategory in ('MERCH', 'SMEQU')) AND
		(EXISTS (SELECT * FROM [Dimension].[Day] dd WHERE t.Date = dd.SalesDate)) AND

		--> test case
--		t.CalMonth = 202506 AND
--		t.CalMonth = 202406 AND
--		t.CalMonth = 202505 AND
--		t.CalMonth = 202412 AND


--		c.GEP_Cohort_Code = 'C01' AND
--		c.GEP_Cohort_Code = 'C03' AND
--		GEP_Order_Flag_ind = 1 AND
--		dd.GEP_TimePeriod_cd <>'ZZ' AND

--		t.SalesOrderNumber in( 9952412, 10174200, 10205806, 10657109, 11950720, 11950757) AND
--		(d.FiscalMonth = 201802 ) AND 

		--< test case

		(1=1)

END

GO

--	Select FiscalMonth, PriorFiscalMonth, FirstFiscalMonth_LY, SalesDateLastWeekly FROM BRS_TS_Config g


-- Prod
-- [Fact].Sales_isr 0

-- Debug
--  [Fact].Sales_gep

-- 182 861 @ 28m, 1 mo
-- 5 761 092, 3m46s