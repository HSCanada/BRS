
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Salesorder]
AS

/******************************************************************************
**	File: 
**	Name: DocType
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
**	14 Sep 17	tmc		Simplified model
**	13 Jan 18	tmc		added AdvancedPricing flag for improved analysis
**    
*******************************************************************************/

SELECT
	f.SalesOrderNumber
	,os.AdvancedPricingInd 
	,os.OrderSourceCode + ' | ' 
	+ os.OrderSourceCodeDescr					AS OrderSource
	,pr.PromotionType
	,RTRIM(pr.PromotionDescription) + ' | ' + pr.PromotionCode	AS Promotion
	,ISNULL(p2.PromotionDescription,'Other')	AS PromotionConvention

	,f.DocType + ' | ' + dt.DocTypeDescr		AS DocType

	,f.EnteredBy
	,f.OrderTakenBy

FROM
	Fact.Sale AS f 

	INNER JOIN BRS_DocType AS dt 
	ON f.DocType = dt.DocType 

	INNER JOIN BRS_Promotion AS pr 
	ON f.OrderPromotionCode = pr.PromotionCode 

	INNER JOIN BRS_OrderSource AS os 
	ON f.OrderSourceCode = os.OrderSourceCode

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


-- SELECT top 10 * FROM Dimension.Salesorder 
