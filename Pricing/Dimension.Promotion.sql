
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Promotion]
AS

/******************************************************************************
**	File: 
**	Name: Promotion
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
**    
*******************************************************************************/

SELECT
	p.PromotionId								AS PromotionKey
	,p.PromotionDescription						AS Promotion
	,p.PromotionType
	,ISNULL(p2.PromotionDescription,'Other')	AS Convention
	,p.PromotionCode
FROM
	BRS_Promotion p
	
	LEFT JOIN BRS_Promotion p2 
	ON p.PromotionTrackingCode = p2.PromotionCode AND
		p.PromotionTrackingCode <>''

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.Promotion order by 1
