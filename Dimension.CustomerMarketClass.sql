
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[CustomerMarketClass]
AS

/******************************************************************************
**	File: 
**	Name: xxx
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
**	Date: 3 Oct 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
	MarketClassKey, 
	MarketClass		AS MarketClassCode, 
	MarketClassDesc	AS MarketClassName
FROM            
	BRS_CustomerMarketClass 
WHERE
	[StatusCd] = 1

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM Dimension.CustomerMarketClass
