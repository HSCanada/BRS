
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[STAGE_BRS_Transaction_Load]
AS

/******************************************************************************
**	File: 
**	Name: STAGE_BRS_Transaction_Load
**	Desc: Flatten Daily Sales Sales and Cost files into 1 table
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
**	Date: 16 Feb 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/


-- Both Costs & Sales parts

SELECT     
	c.FiscalMonth, 
	c.SalesOrderNumberKEY, 
	c.DocType, 
	c.LineNumber, 
	c.SalesOrderNumber, 
	c.Branch, 
	c.BranchORG, 
	CASE WHEN s.GLBU_ClassNEW <> '' THEN s.GLBU_ClassNEW ELSE CASE WHEN c.GLBU_ClassNEW <> '' THEN c.GLBU_ClassNEW ELSE s.GLBU_Class END END AS GLBUClass, 
	s.SUM_GLAA AS NetSalesAmt, 
	c.SUM_GLAA AS ExtendedCostAmt, 
	c.Item, 
	c.Shipto, 
	c.SalesDivision, 
	c.TerritoryCd, 
	c.TerritoryORG, 
	c.InvoiceNumber, 
	c.SalesDate, 
	s.MIN_ID AS S_MIN_ID, 
	c.MIN_ID AS C_MIN_ID, 
	c.OrderSourceCode, 
	c.CustomerPOText1, 
	c.MajorProductClass, 
	s.GLANI AS GLAcctNumberSales, 
	c.GLANI AS GLAcctNumberCost, 
	c.SalesOrderBillTo, 
	c.ARInvoiceDocType, 
	c.MarketSegment, 
	c.PracticeType, 
	c.LineTypeOrder, 
	c.GLClass, 
	c.AdditionalWarehouse, 
	c.Warehouse, 
	s.BusinessUnit AS BusinessUnitSales, 
	c.BusinessUnit AS BusinessUnitCost, 
	s.GLAcctNumberObj AS GLAcctNumberObjSales, 
	c.GLAcctNumberObj AS GLAcctNumberObjCost

FROM         

	dbo.STAGE_BRS_Transaction_T3 AS c 
	INNER JOIN dbo.STAGE_BRS_Transaction_T3 AS s 
	ON c.FiscalMonth = s.FiscalMonth AND 
		c.SalesOrderNumberKEY = s.SalesOrderNumberKEY AND 
		c.DocType = s.DocType AND 
		c.LineNumber = s.LineNumber AND 

		c.GLOBJ_Type = 'C' AND 
		s.GLOBJ_Type = 'S'


UNION ALL

-- Costs & NO Sales parts
SELECT     
	FiscalMonth, 
	SalesOrderNumberKEY, 
	DocType, LineNumber, 
	SalesOrderNumber, 
	Branch, BranchORG, 
	CASE WHEN GLBU_ClassNEW <> '' THEN GLBU_ClassNEW ELSE GLBU_Class END AS GLBUClass, 0 AS NetSalesAmt, 
	SUM_GLAA AS ExtendedCostAmt, 
	Item, 
	Shipto, 
	SalesDivision, 
	TerritoryCd, 
	TerritoryORG, 
	InvoiceNumber, 
	SalesDate, - 1 AS S_MIN_ID, 
	MIN_ID AS C_MIN_ID, 
	OrderSourceCode, 
	CustomerPOText1, 
	MajorProductClass, 
	GLANI AS GLAcctNumberSales, 
	GLANI AS GLAcctNumberCost, 
	SalesOrderBillTo, 
	ARInvoiceDocType, 
	MarketSegment, 
	PracticeType, 
	LineTypeOrder, 
	GLClass, 
	AdditionalWarehouse, 
	Warehouse, 
	BusinessUnit AS BusinessUnitSales, 
	BusinessUnit AS BusinessUnitCost, 
	GLAcctNumberObj AS GLAcctNumberObjSales, 
	GLAcctNumberObj AS GLAcctNumberObjCost

FROM         
	dbo.STAGE_BRS_Transaction_T3 AS t1

WHERE     
(
	GLOBJ_Type = 'C') AND 

	(NOT EXISTS
		(SELECT     
			* 
		FROM          
			dbo.STAGE_BRS_Transaction_T3 AS t2
		                            
		WHERE      
			(t1.FiscalMonth = FiscalMonth) AND 
			(t1.SalesOrderNumberKEY = SalesOrderNumberKEY) AND 
			(t1.DocType = DocType) AND 
			(t1.LineNumber = LineNumber) AND 
			(t1.GLOBJ_Type = 'C') AND 
			(GLOBJ_Type = 'S')
	)
)

UNION ALL

-- Sales & NO Costs parts

SELECT     

	FiscalMonth, 
	SalesOrderNumberKEY, 
	DocType, LineNumber, 
	SalesOrderNumber, 
	Branch, 
	BranchORG, 
	CASE WHEN GLBU_ClassNEW <> '' THEN GLBU_ClassNEW ELSE GLBU_Class END AS GLBUClass, 
	SUM_GLAA AS NetSalesAmt, 
	0 AS ExtendedCostAmt, 
	Item, 
	Shipto, 
	SalesDivision, 
	TerritoryCd, 
	TerritoryORG, 
	InvoiceNumber, 
	SalesDate, 
	MIN_ID AS S_MIN_ID, 
	- 1 AS C_MIN_ID, 
	OrderSourceCode, 
	CustomerPOText1, 
	MajorProductClass, 
	GLANI AS GLAcctNumberSales, 
	GLANI AS GLAcctNumberCost, 
	SalesOrderBillTo, 
	ARInvoiceDocType, 
	MarketSegment, 
	PracticeType, 
	LineTypeOrder, 
	GLClass, 
	AdditionalWarehouse, 
	Warehouse, 
	BusinessUnit AS BusinessUnitSales, 
	BusinessUnit AS BusinessUnitCost, 
	GLAcctNumberObj AS GLAcctNumberObjSales, 
	GLAcctNumberObj AS GLAcctNumberObjCost

FROM         
	dbo.STAGE_BRS_Transaction_T3 AS t1

WHERE     

	(GLOBJ_Type = 'S') AND 

	(NOT EXISTS
		(SELECT     
			*
		                            
		FROM          
			dbo.STAGE_BRS_Transaction_T3 AS t2
		WHERE      
			(t1.FiscalMonth = FiscalMonth) AND 
			(t1.SalesOrderNumberKEY = SalesOrderNumberKEY) AND 
			(t1.DocType = DocType) AND 
			(t1.LineNumber = LineNumber) AND 
			(t1.GLOBJ_Type = 'S') AND 
			(GLOBJ_Type = 'C')
		)
	)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM STAGE_BRS_Transaction_Load
