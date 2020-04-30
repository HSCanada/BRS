
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
**	15 Dec 19	tmc		add returns logic
**	14 Feb 20	tmc		added factkey for linking
**	12 Mar 20	tmc		added price method rollup code for filter
**	14 Apr 20	tmc		fixed negative Return logic and improved buckets
**	30 Apr 20	tmc		remove (move) price method line-level dimension
**						(price method at line level, not order)
*******************************************************************************/

SELECT
	f.SalesOrderNumber
	,f.sales_order_key

	,f.ReturnValidInd
	-- ugly case to correct for bad data where return date is earlier than original invoice.
	,CASE WHEN ReturnOriginalDateKey > DateKey THEN 0 ELSE datediff(MONTH,ReturnOriginalDateKey,DateKey) END ReturnMonths
	,CASE CASE WHEN ReturnOriginalDateKey > DateKey THEN 0 ELSE datediff(MONTH,ReturnOriginalDateKey,DateKey) END
 	WHEN 0 Then ' 0-1mo'
	WHEN 1 Then ' 0-1mo'
	WHEN 2 Then ' 1-3mo'
	WHEN 3 Then ' 1-3mo'
	WHEN 4 Then ' 3-6mo'
	WHEN 5 Then ' 3-6mo'
	WHEN 6 Then ' 3-6mo'
	WHEN 7 Then ' 6-12mo'
	WHEN 8 Then ' 6-12mo'
	WHEN 9 Then ' 6-12mo'
	WHEN 10 Then ' 6-12mo'
	WHEN 11 Then ' 6-12mo'
	WHEN 12 Then ' 6-12mo'
	else '12+mo'
	END
	 as ReturnRange
	,OriginalSalesOrderNumber

/*
	,pm.[PriceMethodDescr]						AS PriceMethod
	,pm2.[PriceMethodDescr]						AS PriceMethodRollup
	,pm.PriceMethod								AS PriceMethodCode
	,pm2.PriceMethod							AS PriceMethodRollupCode
*/

	,os.OrderSourceCode + ' | ' 
	+ os.OrderSourceCodeDescr					AS OrderSource
	,pr.PromotionType							
	,RTRIM(pr.PromotionDescription) + ' | ' + pr.PromotionCode	AS Promotion
	,ISNULL(p2.PromotionDescription,'Other')	AS PromotionConvention

	,f.DocType + ' | ' + dt.DocTypeDescr		AS DocType

	,f.EnteredBy
	,f.OrderTakenBy
	,f.FactKeyFirst
FROM
	Fact.Sale_qt AS f 

	INNER JOIN BRS_DocType AS dt 
	ON f.DocType = dt.DocType 

	INNER JOIN BRS_Promotion AS pr 
	ON f.OrderPromotionCode = pr.PromotionCode 

	INNER JOIN BRS_OrderSource AS os 
	ON f.OrderSourceCode = os.OrderSourceCode
/*
	INNER JOIN [BRS_PriceMethod] AS pm
	ON f.[PriceMethod] = pm.[PriceMethod]

	INNER JOIN [BRS_PriceMethod] AS pm2
	ON pm.[PriceMethodRollup] = pm2.[PriceMethod]
*/

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

-- SELECT top 10 * FROM Dimension.Salesorder_qt where SalesOrderNumber = 11016807 
-- SELECT top 10 * FROM Dimension.Salesorder_qt where ReturnMonths = 8



--ReturnMonths < 0 and DocType like 'CM%'
