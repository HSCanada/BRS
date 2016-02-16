
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_SM_DCC_Cube]
AS

/******************************************************************************
**	File: 
**	Name: BRS_SM_DCC_Cube
**	Desc:  Dental Corp Sales Retention Feed.  This requires that the DSO_ParentShiptTo 
**		field be maintained monthly -- See Trevor
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
**    
*******************************************************************************/

SELECT     

	s.GLBU_Class, 
	s.FiscalMonth, 
	s.FreeGoodsEstInd, 
	s.OrderSourceCode, 
	c.ShipTo, 
	c.DSO_TrackingCd, 
	c.DSO_ParentShipTo, 
	s.AdjCode, 
	MIN(bu.GLBU_ClassNm) AS SalesClass, 
	MIN(p.AddressLine3) AS DSO_Name, 
	MIN(c.BillTo) AS BillTo, 
	MIN(r.Branch) AS DSO_Branch, 
	CONVERT(INT, LEFT(CONVERT(varchar, MIN(p.DateAccountOpened), 112), 6)) AS DSO_StartFiscalMonth, 
	SUM(s.SalesAmt) AS Sales, SUM(s.GPAmt) AS GP

FROM         

	dbo.BRS_AGG_CMBGAD_Sales AS s 

	INNER JOIN dbo.BRS_Customer AS c 
	ON s.Shipto = c.ShipTo 

	INNER JOIN dbo.BRS_Customer AS p 
	ON p.ShipTo = c.DSO_ParentShipTo 

	INNER JOIN dbo.BRS_FSC_Rollup AS r 
	ON p.TerritoryCd = r.TerritoryCd 

	INNER JOIN dbo.BRS_BusinessUnitClass AS bu 
	ON s.GLBU_Class = bu.GLBU_Class

WHERE     
	(c.CustGrpWrk = 'Dental Corp')
GROUP BY 

	s.GLBU_Class, 
	s.FiscalMonth, 
	s.FreeGoodsEstInd, 
	s.OrderSourceCode, 
	c.ShipTo, 
	c.DSO_TrackingCd, 
	c.DSO_ParentShipTo, 
	s.AdjCode

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM BRS_SM_DCC_Cube