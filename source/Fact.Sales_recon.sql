
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Fact].[Sale_recon]
AS

/******************************************************************************
**	File: 
**	Name: Sale_recon
**	Desc:  used to reconcile commission facts to financial tranactions
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
**	Date: 9 Jul 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/
SELECT        
	t.ID						AS FactKey
	,t.FiscalMonth				AS FiscalMonth
	,t.SalesOrderNumberKEY		AS SalesOrderNumber
	,doct.DocTypeKey			AS DocTypeKey

	,bu.GLBU_ClassKey
	,adj.AdjCodeKey

	,t.ShipTo					AS ShipTo
	,i.ItemKey					AS ItemKey
	,mpc.MajorProductClassKey	
	
	,t.[NetSalesAmt]			AS SalesAmt

FROM            

	[dbo].[BRS_Transaction] AS t

	INNER JOIN [dbo].[BRS_Item] AS i 
--	INNER JOIN Dimension.Item AS i 
	ON t.Item = i.[Item]

	INNER JOIN BRS_BusinessUnitClass AS bu 
	ON t.GLBU_Class = bu.GLBU_Class 

	INNER JOIN BRS_AdjCode AS adj 
	ON t.AdjCode = adj.AdjCode 

	INNER JOIN [dbo].[BRS_DocType] doct
	ON t.DocType = doct.DocType

	INNER JOIN [dbo].[BRS_ItemMPC] mpc
	ON t.MajorProductClass = mpc.MajorProductClass
WHERE        
	(EXISTS (SELECT * FROM [Dimension].[Period] dd WHERE t.FiscalMonth = dd.FiscalMonth)) AND
	(1 = 1)

GO


-- SELECT TOP 10 * FROM [Fact].[Sale_recon]

-- SELECT count(*) FROM [Fact].[Sale_recon]
