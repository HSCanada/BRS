
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[PriceMethod]
AS

/******************************************************************************
**	File: 
**	Name: PriceMethod
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
--	02 Aug 17	tmc		Added Rollup
**    
*******************************************************************************/

SELECT
	pm.PriceMethodKey
	,pm.PriceMethodDescr	AS PriceMethod
	,pr.PriceMethodDescr	AS PriceMethodRollup
FROM
	BRS_PriceMethod pm

	JOIN BRS_PriceMethod pr
	ON pm.PriceMethodRollup = pr.PriceMethod
WHERE
	pm.StatusCd=1

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.PriceMethod order by 1
