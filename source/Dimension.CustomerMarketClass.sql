
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
**	28 May 18	tmc		fixed bug where status = 1 or -1 for true
**    
*******************************************************************************/

SELECT        
	MarketClassKey, 
	MarketClass		AS MarketClassCode, 
	MarketClassDesc	AS MarketClassName
FROM            
	BRS_CustomerMarketClass 
WHERE
	[StatusCd] <> 0

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM Dimension.CustomerMarketClass
