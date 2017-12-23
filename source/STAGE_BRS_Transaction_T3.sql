
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[STAGE_BRS_Transaction_T3]
AS

/******************************************************************************
**	File: 
**	Name: STAGE_BRS_Transaction_T3
**	Desc: STAGE_BRS_Transaction - Transform 3
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

SELECT     

	t.FiscalMonth, 
	t.SalesOrderNumberKEY, 
	t.DocType, 
	t.LineNumber, 
	t.GLOBJ_Type, 
	t.SalesOrderNumber, 
	t.Branch, 
	t.BranchORG, 
	t.GLBU_Class, 
	ISNULL(e.GLBU_ClassNEW, N'') AS GLBU_ClassNEW, 
	t.SUM_GLAA, 
	t.Item, 
	t.Shipto, 
	t.SalesDivision, 
	t.TerritoryCd, 
	t.TerritoryORG, 
	t.InvoiceNumber, 
	t.SalesDate, 
	t.OrderSourceCode, 
	t.CustomerPOText1, 
	t.MajorProductClass, 
	t.GLANI, 
	t.SalesOrderBillTo, 
	t.ARInvoiceDocType, 
	t.MarketSegment, 
	t.PracticeType, 
	t.LineTypeOrder, 
	t.GLClass, 
	t.AdditionalWarehouse, 
	t.Warehouse, 
	t.BusinessUnit, 
	t.GLAcctNumberObj, 
	t.MIN_ID

FROM         

	dbo.STAGE_BRS_Transaction_T2 AS t 

	LEFT OUTER JOIN dbo.BRS_BusinessUnitClassExcept AS e 
	ON t.BusinessUnit LIKE e.BusinessUnit AND 
		t.GLAcctNumberObj LIKE e.GLAcctNumberObj AND 
		t.MajorProductClass LIKE e.MajorProductClass AND 
		t.MajorProductClass NOT LIKE e.MajorProductClassNOT

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM STAGE_BRS_Transaction_T3
