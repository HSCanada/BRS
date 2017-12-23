
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
--	25 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
--	26 May 16	tmc		Fixed bug where FG EST and ACT are double-counted (see 25 May 16)
--  20 Oct 16	tmc		Set active month filter 
-- 22 Jan 17    tmc     Referenced BRS_Rollup_Support01 for conistent logic
**    
*******************************************************************************/

SELECT     

	s.GLBU_Class, 
	s.FiscalMonth, 
	s.FreeGoodsEstInd, 
	s.OrderSourceCode, 
	s.ShipTo, 
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

	BRS_AGG_CMBGAD_Sales AS s 

	INNER JOIN dbo.BRS_Customer AS c 
	ON s.Shipto = c.ShipTo 

	INNER JOIN dbo.BRS_Customer AS p 
	ON p.ShipTo = c.DSO_ParentShipTo 

	INNER JOIN dbo.BRS_FSC_Rollup AS r 
	ON p.TerritoryCd = r.TerritoryCd 

	INNER JOIN dbo.BRS_BusinessUnitClass AS bu 
	ON s.GLBU_Class = bu.GLBU_Class

	INNER JOIN BRS_FiscalMonth as fm
	ON fm.FiscalMonth = s.FiscalMonth


WHERE     
	(c.CustGrpWrk = 'Dental Corp') AND

--	25 May 16	tmc		Add Free Good Estimate vs Actual logic:  History NO, Prior=Conditional, Current=YES
	(s.FreeGoodsEstInd = CASE WHEN fm.ME_FreeGoodsAct_LoadedInd = 0 THEN 0 ELSE s.FreeGoodsEstInd END ) AND
--  20 Oct 16	tmc		Set active month filter 
	(s.FiscalMonth Between (Select YearFirstFiscalMonth_LY FROM BRS_Rollup_Support01) AND (Select PriorFiscalMonth FROM BRS_Rollup_Support01) ) AND


	(1=1)

GROUP BY 

	s.FiscalMonth, 
	s.GLBU_Class, 
	s.AdjCode,
	s.ShipTo, 

	s.FreeGoodsEstInd, 
	s.OrderSourceCode, 

	c.DSO_TrackingCd, 
	c.DSO_ParentShipTo

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT * FROM BRS_SM_DCC_Cube
