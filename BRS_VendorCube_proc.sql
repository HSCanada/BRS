set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BRS_VendorCube_proc] 
	@StartMonth int = 201701, 
	@EndMonth int = 201701
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Cube_proc
**	Desc: Provide sales information for Vendor reporting.
**          Added Chargeback **TBD*** 22 Jan 17
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
**	Date: 24 Apr 15
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
-- 05 Jan 16	tmc		Fixed category rollup to use item level, not GLBU
-- 12 Feb 16	tmc		Cleanup metadata (confirmed dynamice Segment)
-- 15 Sep 16	tmc		Added Label to cube for private label cuts
-- 22 Jan 17    tmc     Referenced BRS_Rollup_Support01 for conistent logic
-- 20 Feb 17	tmc		Made SM static for new 2017 SM P&L
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

	SELECT     
		t.FiscalMonth
		,t.Branch
		,t.GLBU_Class
		,t.AdjCode
		,t.SalesDivision
		,t.HIST_MarketClass AS MarketClass
		,t.HIST_SegCd		AS CustSeg

		,i.label

		,CASE WHEN isupf.ReportInd = 1		THEN isupf.SupplierFamily	ELSE 'ZOTHER'				END AS SupplierFamily
		,CASE WHEN icat.CategoryRollup = ''	THEN 'ADJUST'				ELSE icat.CategoryRollup	END AS CategoryRollup

		,MIN(icr.CategoryClass_Rollup) as CategoryClass_Rollup
		,t.GLBU_Class as CategoryClass_GLBU

		,SUM(t.SalesAmt) AS TotalSalesAmt
		,SUM(t.GPAmt) AS TotalGPAmt
	FROM         
		BRS_AGG_ICMBGAD_Sales AS t 

		INNER JOIN BRS_ItemHistory AS h 
		ON t.Item = h.Item AND 
			t.FiscalMonth = h.FiscalMonth 

		INNER JOIN BRS_Item AS i 
		ON t.Item = i.Item 

		INNER JOIN BRS_ItemCategory AS icat 
		ON i.MinorProductClass = icat.MinorProductClass 

		INNER JOIN BRS_ItemCategoryRollup AS icr
		ON icr.CategoryRollup = icat.CategoryRollup

		INNER JOIN BRS_ItemSupplier AS isup 
		ON h.Supplier = isup.Supplier 

		INNER JOIN BRS_ItemSupplierFamily AS isupf 
		ON isupf.SupplierFamily = isup.SupplierFamily

	WHERE     
		(t.FiscalMonth between  @StartMonth and @EndMonth ) AND 
		--  need to use Estimate as it operates at the item level
		(t.FreeGoodsEstInd = 0) AND
		1=1

	GROUP BY 
		t.FiscalMonth
		,t.Branch
		,t.GLBU_Class
		,t.AdjCode
		,t.SalesDivision
		,t.HIST_MarketClass
		,t.HIST_SegCd
		,i.label
		,CASE WHEN isupf.ReportInd = 1		THEN isupf.SupplierFamily	ELSE 'ZOTHER'				END
		,CASE WHEN icat.CategoryRollup = ''	THEN 'ADJUST'				ELSE icat.CategoryRollup	END

END



-- Select YearFirstFiscalMonth_LY, PriorFiscalMonth  FROM BRS_Rollup_Support01

-- exec [BRS_VendorCube_proc] 0 

