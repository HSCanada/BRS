
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Salesorder]
AS

/******************************************************************************
**	File: 
**	Name: [Dimension].[Salesorder]
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   Finacial Model
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 10 Dec 24
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/
/*
-- create 0 entry for missing
SELECT
	0		AS SalesOrderNumber
	,''		AS DocType
	,''		AS OrderSource
	,''		AS PromotionType
	,''		AS PromotionLine
	,''		AS PromotionConvention
	,''		AS EnteredBy
	,''		AS OrderTakenBy
	,''		AS EquipmentOrderType
	,''		AS EquipmentOrderNumber
	,''		AS [CustomerPOText1]
	,0		AS ID_DS_xref
	,0		AS ID

UNION ALL
*/
SELECT
	f.SalesOrderNumber
	,doct.DocType + ' | ' + doct.DocTypeDescr		AS DocType

	,os.OrderSourceCode + ' | ' 
	+ os.OrderSourceCodeDescr					AS OrderSource

	,pr_line.PromotionType
	,RTRIM(pr_line.PromotionDescription) + ' | ' + pr_line.PromotionCode	AS PromotionLine

	,ISNULL(pr_track.PromotionDescription,'Other')	AS PromotionConvention


	,f.EnteredBy
	,f.OrderTakenBy
	,f.EquipmentOrderType
	,f.EquipmentOrderNumber
	,f.[CustomerPOText1]

	,f.ID_DS_xref
	,ext.ID


FROM
	[dbo].[BRS_TransactionDW_Ext] ext

	INNER JOIN Fact.SaleVendor f
	ON ext.ID_DS_xref = f.ID_DS

	INNER JOIN [dbo].[BRS_DocType] as doct
	ON ext.DocType = doct.DocType

	INNER JOIN BRS_Promotion AS pr_line
	ON f.PromotionCode = pr_line.PromotionCode 

	INNER JOIN BRS_Promotion AS pr_track
	ON ext.PromotionTrackingCode = pr_track.PromotionCode 

	INNER JOIN BRS_OrderSource AS os 
	ON f.OrderSourceCode = os.OrderSourceCode

WHERE    
	-- remove duplicate entries so that Salesorder is primarykey for Analysis modelling
	ext.DocType <> 'AA' AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.Salesorder 
-- where SalesOrderNumber = 0
