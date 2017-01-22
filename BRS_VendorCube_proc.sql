set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BRS_VendorCube_proc] 
	-- Add the parameters for the stored procedure here
	@StartMonth int = 201501, 
	@EndMonth int = 201501
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
-- 22 Jan 17    tmc     Reverenced BRS_Rollup_Support01 for conistent logic
*******************************************************************************/

BEGIN
	SET NOCOUNT ON;

	if (@StartMonth = 0)
	begin	
		SELECT     
			@StartMonth = YearFirstFiscalMonth_LY, 
			@EndMonth = PriorFiscalMonth
		FROM         
			BRS_Rollup_Support01
	end

    -- Insert statements for procedure here
	SELECT     

		s.FiscalMonth, 
		s.Branch, 
		s.GLBU_Class,
		s.AdjCode,
		s.SalesDivision, 

		c.MarketClass, 
		cspec.SegCd CustSeg, 

		i.label,

		CASE WHEN isupf.ReportInd = 1 THEN isupf.SupplierFamily ELSE 'ZOTHER' END as SupplierFamily,
		CASE WHEN icat.CategoryRollup = '' THEN 'ADJUST' ELSE icat.CategoryRollup END AS CategoryRollup, 

-- UPDATED 5 Jan 16, tmc, Fixed category rollup to use item level, not GLBU
		MAX(icr.CategoryClass_Rollup) as CategoryClass_Rollup,
		s.GLBU_Class as CategoryClass_GLBU,

		SUM(s.SalesAmt) AS TotalSalesAmt, 
		SUM(s.GPAmt) AS TotalGPAmt

	FROM         

		BRS_AGG_ICMBGAD_Sales AS s 

		INNER JOIN BRS_ItemHistory AS h 
		ON s.Item = h.Item AND 
			s.FiscalMonth = h.FiscalMonth 

		INNER JOIN BRS_Customer AS c 
		ON s.Shipto = c.ShipTo 

		INNER JOIN BRS_Item AS i 
		ON s.Item = i.Item 

		INNER JOIN BRS_ItemCategory AS icat 
		ON i.MinorProductClass = icat.MinorProductClass 


		INNER JOIN BRS_ItemCategoryRollup AS icr
		ON icr.CategoryRollup = icat.CategoryRollup


		INNER JOIN BRS_CustomerSpecialty AS cspec 
		ON c.Specialty = cspec.Specialty 

		INNER JOIN BRS_ItemSupplier AS isup 
		ON h.Supplier = isup.Supplier 

		INNER JOIN BRS_ItemSupplierFamily AS isupf 
		ON isupf.SupplierFamily = isup.SupplierFamily

		INNER JOIN BRS_BusinessUnitClass AS buc
		ON buc.GLBU_Class = s.GLBU_Class

	WHERE     
		(s.FiscalMonth between  @StartMonth and @EndMonth ) AND 
		(s.FreeGoodsEstInd = 0) AND

		1=1

	GROUP BY 
		s.FiscalMonth, 
		s.Branch, 
		s.GLBU_Class,
		s.AdjCode,
		s.SalesDivision, 
		c.MarketClass, 
		cspec.SegCd, 
		i.label,
		CASE WHEN isupf.ReportInd = 1 THEN isupf.SupplierFamily ELSE 'ZOTHER' END,
		CASE WHEN icat.CategoryRollup = '' THEN 'ADJUST' ELSE icat.CategoryRollup END

-- UPDATED 5 Jan 16, tmc, Fixed category rollup to use item level, not GLBU
--		icr.CategoryClass_Rollup,
--		GLBU_ClassVN_L1,
--		GLBU_ClassDS_L1
END


-- takes 1.5min on SQL1, 5 Jan 16

-- exec [BRS_VendorCube_proc] 0 

select * from dbo.BRS_Rollup_Support01