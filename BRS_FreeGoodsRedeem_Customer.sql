
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_FreeGoodsRedeem_Customer]
AS

/******************************************************************************
**	File: 
**	Name: BRS_FreeGoodsRedeem_Customer
**	Desc: Helper view to summarized Free goods for P&L True-up adjustment
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
**	Date: 13 Dec 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	14 Dec 16	tmc		Add Historical FSC associated Branch 
**    
*******************************************************************************/


SELECT     
	f.ShipTo, 
	c.SalesCategory_FreeGoodsRedeem_Rollup AS SalesCategory_Rollup, 
	f.FiscalMonth, 

--	14 Dec 16	tmc		Add Historical FSC associated Branch 
	MIN(h.HIST_TerritoryCd) as HIST_TerritoryCd,

	SUM(f.ExtFileCostAmt) AS FreeGoodsRedeem_ExtFileCostAmt

FROM         

	BRS_FreeGoodsRedeem AS f 
	INNER JOIN BRS_Item AS i 
	ON f.Item = i.Item 

	INNER JOIN BRS_ItemSalesCategory AS c 
	ON i.SalesCategory = c.SalesCategory

	LEFT JOIN BRS_CustomerFSC_History AS h 
	ON f.Shipto = h.Shipto AND
		f.FiscalMonth = h.FiscalMonth

WHERE     
	(f.FiscalMonth =
          (SELECT     PriorFiscalMonth
            FROM          BRS_Config)
	)
GROUP BY 
	f.FiscalMonth, 
	f.ShipTo, 
	c.SalesCategory_FreeGoodsRedeem_Rollup

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- Select * from BRS_FreeGoodsRedeem_Customer







