
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[SalesorderCommission] 

AS

/******************************************************************************
**	File: 
**	Name: Salesorder
**	Desc: salesorder based on commission extract
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
**	Date: 08 Dec 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
	f.SalesOrderNumber

	,f.DocType + ' | ' + dt.DocTypeDescr					AS DocType
	,os.OrderSourceCode + ' | ' + os.OrderSourceCodeDescr	AS OrderSource
	,f.EnteredBy											AS EnteredByCode
	,f.OrderTakenBy											AS OrderTakenByCode
	,f.EquipmentOrderNumber
	,f.CustomerPOText1

FROM
	Fact.Commission AS f 

	INNER JOIN BRS_DocType AS dt 
	ON f.DocType = dt.DocType 

	INNER JOIN BRS_OrderSource AS os 
	ON f.OrderSourceCode = os.OrderSourceCode



WHERE        
	(f.FactKey = f.FactKeyFirst)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.[SalesorderCommission] order by 1
