﻿
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Salesorder_qt]
AS

/******************************************************************************
**	File: 
**	Name: Sales Order - Quote Tracker
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
**	Date: 22 Jan 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
	f.SalesOrderNumber
	,pm.[PriceMethodDescr]						AS PriceMethod
	,pm2.[PriceMethodDescr]						AS PriceMethodRollup
	,os.OrderSourceCode + ' | ' 
	+ os.OrderSourceCodeDescr					AS OrderSource
	,pr.PromotionType							
	,RTRIM(pr.PromotionDescription) + ' | ' + pr.PromotionCode	AS Promotion
	,ISNULL(p2.PromotionDescription,'Other')	AS PromotionConvention

	,f.DocType + ' | ' + dt.DocTypeDescr		AS DocType

	,f.EnteredBy
	,f.OrderTakenBy

FROM
	Fact.Sale_qt AS f 

	INNER JOIN BRS_DocType AS dt 
	ON f.DocType = dt.DocType 

	INNER JOIN BRS_Promotion AS pr 
	ON f.OrderPromotionCode = pr.PromotionCode 

	INNER JOIN BRS_OrderSource AS os 
	ON f.OrderSourceCode = os.OrderSourceCode

	INNER JOIN [BRS_PriceMethod] AS pm
	ON f.[PriceMethod] = pm.[PriceMethod]

	INNER JOIN [BRS_PriceMethod] AS pm2
	ON pm.[PriceMethodRollup] = pm2.[PriceMethod]

	LEFT JOIN BRS_Promotion p2 
	ON pr.PromotionTrackingCode = p2.PromotionCode AND
		pr.PromotionTrackingCode <>''


WHERE        
	(f.FactKey = f.FactKeyFirst)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Salesorder_qt