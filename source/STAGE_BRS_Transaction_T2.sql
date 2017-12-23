
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[STAGE_BRS_Transaction_T2]
AS

/******************************************************************************
**	File: 
**	Name: STAGE_BRS_Transaction_T2
**	Desc: STAGE_BRS_Transaction - Transform 2
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

	g.FiscalMonth, 
	ts.SHDOCO AS SalesOrderNumberKEY, 
	ts.SHDCTO AS DocType, 
	ROUND(ts.SDLNID * 1000, 0) AS LineNumber, 
	ts.GLOBJ_Type, 
	ts.SHDOCO AS SalesOrderNumber, 
	b.Branch, 
	b.Branch AS BranchORG, 
	bu.GLBU_Class, 
	ts.SUM_GLAA, 
	ISNULL(t.SDLITM, N'') AS Item, 
	t.SDSHAN AS Shipto, 
	t.QCAC10 AS SalesDivision, 
	c.TerritoryCd, 
	c.TerritoryCd AS TerritoryORG, 
	t.SDDOC AS InvoiceNumber, 
	g.SalesDate, 
	t.QC$OSC AS OrderSourceCode, 
	'' AS CustomerPOText1, 
	ISNULL(t.SDSRP1, N'') AS MajorProductClass, 
	t.GLANI, 
	t.SDAN8 AS SalesOrderBillTo, 
	t.SDDCT AS ARInvoiceDocType, 
	t.QCAC08 AS MarketSegment, 
	t.QCAC04 AS PracticeType, 
	t.SDLNTY AS LineTypeOrder, 
	t.SDGLC AS GLClass, 
	t.SDMCU AS AdditionalWarehouse, 
	t.SDMCU01 AS Warehouse, 
	bu.BusinessUnit, 
	ts.GLAcctNumberObj, 
	ts.MIN_ID

FROM         

	dbo.STAGE_BRS_Transaction AS t 

	INNER JOIN dbo.STAGE_BRS_Transaction_T1 AS ts 
	ON ts.MIN_ID = t.ID 

	INNER JOIN dbo.BRS_BusinessUnit AS bu 
	ON LEFT(t.GLANI, 12) = bu.BusinessUnit 

	INNER JOIN dbo.BRS_Customer AS c 
	ON c.ShipTo = t.SDSHAN 

		INNER JOIN dbo.BRS_FSC_Rollup AS b 
		ON c.TerritoryCd = b.TerritoryCd 

	CROSS JOIN
		dbo.BRS_Config AS g

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM STAGE_BRS_Transaction_T2
