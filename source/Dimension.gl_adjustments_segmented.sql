
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[gl_adjustments_segmented]
AS

/******************************************************************************
**	File: 
**	Name: [Dimension].[gl_adjustments_segmented]
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
	f.ID_DS
	,f.AdjBatchNum
	,f.[AdjNum]
	,f.[AdjCode]
	,f.[AdjNote]
	,f.[AdjRemark]
	,f.[AdjSource]
	,f.[AdjOwner]
	,f.AdjGLDocType
	,f.AdjCodeKey
	,f.AdjType
	,f.AdjCodeDesc
	,f.AdjLevel
	,f.AdjClass

FROM
	Fact.SaleVendor f

WHERE    
	-- AA are adjustments 
	f.DocType = 'AA' AND
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.[gl_adjustments_segmented]
-- where SalesOrderNumber = 0
