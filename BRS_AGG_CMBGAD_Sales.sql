
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_AGG_CMBGAD_Sales]
AS

/******************************************************************************
**	File: 
**	Name: BRS_AGG_CMBGAD_Sales
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
**	Date: 11 Jan 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/


SELECT     
    FiscalMonth, 
    Branch, 
    GLBU_Class, 
    AdjCode, 
    SalesDivision, 
    Shipto, 
    FreeGoodsEstInd, 
    OrderSourceCode, 
    SUM(SalesAmt) AS SalesAmt, 
    SUM(GPAmt) AS GPAmt, 
    SUM(FactCount) AS FactCount, 

    MIN(HIST_Specialty) AS HIST_Specialty, 
    MIN(HIST_MarketClass) AS HIST_MarketClass, 
    MIN(HIST_TerritoryCd) AS HIST_TerritoryCd, 
    MIN(HIST_VPA) AS HIST_VPA, 
    MIN(ID_MAX) AS ID_MAX, 
    MIN(HIST_SegCd) AS HIST_SegCd

FROM         

    BRS_AGG_CDBGAD_Sales
GROUP BY 
    FiscalMonth, 
    Branch, 
    GLBU_Class, 
    AdjCode, 
    SalesDivision, 
    Shipto, 
    FreeGoodsEstInd, 
    OrderSourceCode

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_AGG_CMBGAD_Sales
