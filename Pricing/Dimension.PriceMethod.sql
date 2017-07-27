
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
**    
*******************************************************************************/

SELECT
	PriceMethodKey
	,PriceMethodDescr	AS PriceMethod
FROM
	BRS_PriceMethod
WHERE
	StatusCd=1

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.PriceMethod order by 1
