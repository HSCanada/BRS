
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[SalesPlan]
AS

/******************************************************************************
**	File: 
**	Name: SalesPlan
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
	VpaKey	AS SalesPlanKey,
	VPADesc	AS SalesPlan,
	VPATypeCd	AS SalesPlanType,
	VPA		AS SalesPlanCode
FROM
	BRS_CustomerVPA

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT top 10 * FROM Dimension.SalesPlan order by 1
