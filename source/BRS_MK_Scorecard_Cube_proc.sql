set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: BRS_MK_Scorecard_Cube_proc
**	Desc: Marketing Scorecard Data
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 1 May 15
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	08 Jan 16	tmc		fix rollup
--	26 Feb 16	tmc		Updated test params
-- 22 Jan 17    tmc     Reverenced BRS_Rollup_Support01 for conistent logic

**    
*******************************************************************************/


ALTER PROCEDURE [dbo].[BRS_MK_Scorecard_Cube_proc] 
	-- Add the parameters for the stored procedure here
	@StartMonth int = 201501, 
	@EndMonth int = 201501
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
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
		s.SalesDivision, 
		c.MarketClass, 
		cspec.SegCd CustSeg, 
		CASE WHEN isupf.ReportInd = 1 THEN isupf.SupplierFamily ELSE 'ZOTHER' END as SupplierFamily,
		CASE WHEN icat.CategoryRollup = '' THEN 'ADJUST' ELSE icat.CategoryRollup END AS CategoryRollup, 
		CategoryClass_Rollup,

-- Updated 08 Jan 16, tmc,	fix rollup
		s.GLBU_Class as CategoryClass_GLBU,

		Label,
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
	--	(AdjCode <> '') AND
	--	(icat.CategoryRollup <> '') AND
		1=1

	GROUP BY 
		s.FiscalMonth, 
		s.Branch, 
		s.GLBU_Class,
		s.SalesDivision, 
		c.MarketClass, 
		cspec.SegCd, 
		CASE WHEN isupf.ReportInd = 1 THEN isupf.SupplierFamily ELSE 'ZOTHER' END,
		CASE WHEN icat.CategoryRollup = '' THEN 'ADJUST' ELSE icat.CategoryRollup END,
		CategoryClass_Rollup,

-- Updated 08 Jan 16, tmc,	fix rollup
		s.GLBU_Class,

		Label

	END

--	26 Feb 16	tmc		Updated test params

-- Use config lookup params
--[BRS_MK_Scorecard_Cube_proc] 0


