
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
--	20 Sep 17	tmc		fixed ambiguous market class join 
**    
*******************************************************************************/
SELECT        
	t.FiscalMonth

	,b.BranchKey
	,bu.GLBU_ClassKey
	,adj.AdjCodeKey
	,c.ShipTo
	,i.ItemKey
	,mc.MarketClassKey				AS HIST_MarketClassKey
	
	,t.SalesAmt						AS TotalSalesAmt
	,t.GPAmt							AS TotalGPAmt
	,t.GP_Org_Amt					AS TotalGPExclCBAmt
	,ISNULL(t.ExtChargebackAmt, 0)	AS ExtChargebackAmt

FROM            

	BRS_AGG_ICMBGAD_Sales AS t 


	INNER JOIN BRS_ItemHistory AS h 
	ON t.Item = h.Item AND t.FiscalMonth = h.FiscalMonth 
	
	INNER JOIN Dimension.Item AS i 
	ON t.Item = i.ItemCode 

	INNER JOIN BRS_Branch AS b 
	ON t.Branch = b.Branch  

	INNER JOIN BRS_BusinessUnitClass AS bu 
	ON t.GLBU_Class = bu.GLBU_Class 


	INNER JOIN BRS_AdjCode AS adj 
	ON t.AdjCode = adj.AdjCode 

	INNER JOIN Dimension.Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_CustomerMarketClass AS mc 
	ON c.MarketClassCode = mc.MarketClass


WHERE        
	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE t.FiscalMonth = dd.FiscalMonth)) AND

	(t.FreeGoodsEstInd = 0) AND 
	(1 = 1)


GO


/*

-- Testing

-- adhoc look at the data
select top 10 * from [Fact].[SaleVendor] where HIST_MarketClassKey not in (8,20)

SELECT 
 top 10 
-- count 
* 
FROM Fact.SaleVendor


-- row count testing2 -- success

SELECT        COUNT(*) AS line_count
FROM            BRS_AGG_ICMBGAD_Sales AS t
WHERE        (FiscalMonth BETWEEN 201701 AND 201708) AND (FreeGoodsEstInd = 0) AND (1 = 1)
GROUP BY HIST_MarketClass

-- ORG 1682277
-- NEW 1682277


-- find missing data - failed

SELECT        COUNT(*) AS line_count
FROM            [Fact].[SaleVendor] AS t
WHERE        
--	(FiscalMonth BETWEEN 201401 AND 201707) AND 
--	(FreeGoodsEstInd = 0) AND 
	(1 = 1)

GROUP BY FiscalMonth

-- ORG 1682277 
-- NEW1 292271 - fail
-- NEW2 1682277 - partial success (not full join)
-- NEW3 1682277 - success!


*/