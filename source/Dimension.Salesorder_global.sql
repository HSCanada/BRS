
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Salesorder_global]
AS

/******************************************************************************
**	File: 
**	Name: Sales Order - Global
**	Desc:  base on Sales Order - Quote Tracker
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
**	Date: 15 Mar 22
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
*******************************************************************************/

SELECT
	f.ID_Header
	,f.SalesOrderNumber
	,f.OriginalSalesOrderNumber

	,os.OrderSourceCode + ' | ' 
	+ os.OrderSourceCodeDescr					AS OrderSource

	-- 

	,RTRIM(pr.[PromoNameTracking]) + ' | ' 
	+ pr.PromotionCode							AS Promotion

	--
	,RTRIM(prt.[PromoNameTracking]) 
	+ ' | ' + prt.[PromotionTrackingCode]		AS PromotionTracking

	,prt.[PromotionTypeTracking]					AS PromotionTrackingType							

	,f.DocType + ' | ' + dt.DocTypeDescr		AS DocType

	,f.EnteredBy
	,f.OrderTakenBy
FROM
	fact.global_cube AS f 


	INNER JOIN BRS_DocType AS dt 
	ON f.DocType = dt.DocType 

	INNER JOIN BRS_Promotion AS pr
	ON f.[OrderPromotionCode] = pr.PromotionCode 

	INNER JOIN BRS_Promotion AS prt
	ON f.promotion_key = prt.[promotion_key]

	INNER JOIN BRS_OrderSource AS os 
	ON f.OrderSourceCode = os.OrderSourceCode

WHERE        
	(f.ID = f.ID_Header) AND
	-- test
	-- (f.SalesOrderNumber = 13086442) AND
	--
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM Dimension.Salesorder_global where SalesOrderNumber =13164170

