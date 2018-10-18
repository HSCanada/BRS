
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Salesorder_brs]
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
**	Date: 30 Sep 18
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
	f.SalesOrderNumber
	,os.AdvancedPricingInd 
	,os.OrderSourceCode + ' | ' 
	+ RTRIM(os.OrderSourceCodeDescr)			AS OrderSource
	 
	,RTRIM(os2.OrderSourceCodeDescr)			AS OrderSourceRollup
	,pr.PromotionType
	,RTRIM(pr.PromotionDescription) + ' | ' + pr.PromotionCode	AS Promotion
	,ISNULL(p2.PromotionDescription,'Other')	AS PromotionConvention

	,f.DocType + ' | ' + dt.DocTypeDescr		AS DocType

	,f.EnteredBy
	,f.OrderTakenBy

FROM
	Fact.Sale_brs AS f 

	INNER JOIN BRS_DocType AS dt 
	ON f.DocType = dt.DocType 

	INNER JOIN BRS_Promotion AS pr 
	ON f.OrderPromotionCode = pr.PromotionCode 

	INNER JOIN BRS_OrderSource AS os 
	ON f.OrderSourceCode = os.OrderSourceCode

	INNER JOIN BRS_OrderSource AS os2 
	ON os.OrderSourceRollup = os2.OrderSourceCode

	LEFT JOIN BRS_Promotion p2 
	ON pr.PromotionTrackingCode = p2.PromotionCode AND
		pr.PromotionTrackingCode <>''


WHERE        
	(f.FactKey = f.FactKeyFirst) AND
--	f.FactKey = 0 AND
	1=1

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Salesorder_brs 
