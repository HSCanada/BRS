
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_DS_Market_Rollup]
AS

/******************************************************************************
**	File: 
**	Name: BRS_DS_Market_Rollup
**	Desc:  
**
**              
**	Return values:  @@Error
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 16 Feb 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	28 Feb 17	tmc		Added extrac roll-up for planning 
**    
*******************************************************************************/

SELECT     
	MarketClass, 
	MarketClassDesc, 
	MarketRollup_L1, 
	MarketRollup_L2
	MarketRollup_L3

FROM         
	dbo.BRS_CustomerMarketClass
WHERE     
	(StatusCd = 1)
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_DS_Market_Rollup
