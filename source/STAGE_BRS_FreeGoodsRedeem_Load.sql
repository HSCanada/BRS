
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[STAGE_BRS_FreeGoodsRedeem_Load]
AS

/******************************************************************************
**	File: 
**	Name: STAGE_BRS_FreeGoodsRedeem_Load
**	Desc: Helper view to normalize Free goods for loading to production
**
**              
**	Return values:  
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 12 Dec 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/


SELECT     
	Item, 
	SalesOrderNumber, 
	FiscalMonth, 
	SUM(ExtFileCostAmt)	AS ExtFileCostAmt, 
	MIN(ShipTo)			AS ShipTo, 
	MIN(Supplier)		AS Supplier
FROM         
	STAGE_BRS_FreeGoodsRedeem
GROUP BY 
	FiscalMonth, 
	SalesOrderNumber, 
	Item

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- TRUNCATE TABLE STAGE_BRS_FreeGoodsRedeem


-- Select * from STAGE_BRS_FreeGoodsRedeem_Load







