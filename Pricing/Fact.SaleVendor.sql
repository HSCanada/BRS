
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[SaleVendor]
AS

/******************************************************************************
**	File: 
**	Name: Sale
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 14 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/
SELECT        
	t.FiscalMonth,
	b.BranchKey,
	bu.GLBU_ClassKey,
	adj.AdjCodeKey,
	c.ShipTo,
	i.ItemKey,
	mc.MarketClassKey				AS HIST_MarketClassKey,
	--s.SupplierKey					AS HIST_SupplierKey,
	--ic.CategoryRollupKey,
	t.SalesAmt						AS TotalSalesAmt,
	t.GPAmt							AS TotalGPAmt,
	t.GP_Org_Amt					AS TotalGPExclCBAmt,
	ISNULL(t.ExtChargebackAmt, 0)	AS ExtChargebackAmt

FROM            

	BRS_AGG_ICMBGAD_Sales AS t 

	INNER JOIN BRS_ItemHistory AS h 
	ON t.Item = h.Item AND t.FiscalMonth = h.FiscalMonth 

	--INNER JOIN Dimension.Supplier AS s 
	--ON h.Supplier = s.SupplierCode 

	INNER JOIN Dimension.Item AS i 
	ON t.Item = i.ItemCode 

	--INNER JOIN Dimension.ItemCategory AS ic 
	--ON i.CategoryRollup = ic.CategoryRollupCode 

	INNER JOIN BRS_Branch AS b 
	ON t.Branch = b.Branch  

	INNER JOIN BRS_BusinessUnitClass AS bu 
	ON t.GLBU_Class = bu.GLBU_Class 

	INNER JOIN BRS_AdjCode AS adj 
	ON t.AdjCode = adj.AdjCode 

	INNER JOIN Dimension.Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_CustomerMarketClass AS mc 
	ON c.MarketClass = mc.MarketClass

WHERE        
	(t.FiscalMonth BETWEEN 201401 AND 201707) AND 
	(t.FreeGoodsEstInd = 0) AND 
	(1 = 1)

/*
	SELECT     
		t.FiscalMonth
		,t.Branch
		,t.GLBU_Class
		,t.AdjCode
		,t.SalesDivision
		,t.HIST_MarketClass					AS MarketClass
		,t.HIST_SegCd						AS CustSeg

		,i.label

		,CASE 
			WHEN isupf.ReportInd = 1		
			THEN isupf.SupplierFamily	
			ELSE 'ZOTHER'				
		END									AS SupplierFamily
		,CASE 
			WHEN icat.CategoryRollup = ''	
			THEN 'ADJUST'				
			ELSE icat.CategoryRollup	
		END									AS CategoryRollup

		,MIN(icr.CategoryClass_Rollup)		as CategoryClass_Rollup
		,t.GLBU_Class						as CategoryClass_GLBU

		,SUM(t.SalesAmt)					AS TotalSalesAmt
		,SUM(t.GPAmt)						AS TotalGPAmt

		-- 13 Mar 17	tmc		Add Chargeback and original GP for greater transparency
		,SUM(t.GP_Org_Amt)					AS TotalGPExclCBAmt
		,SUM(ISNULL(ExtChargebackAmt,0))	AS ExtChargebackAmt
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
		(t.FiscalMonth between  201701 and 201701 ) AND 
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
*/

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*

SELECT 
 top 10 
-- count 
* 
FROM Fact.SaleVendor
*/

/*
SELECT        
count (*)

FROM            

	BRS_AGG_ICMBGAD_Sales AS t 

WHERE        
	(t.FiscalMonth BETWEEN 201401 AND 201707) AND 
	(t.FreeGoodsEstInd = 0) AND 
	(1 = 1)
*/