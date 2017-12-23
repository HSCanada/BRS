
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_SM_Customer]
AS

/******************************************************************************
**	File: 
**	Name: BRS_SM_Customer
**	Desc:  
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
**	Date: 19 Mar 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	22 Mar 16	tmc		Set unassigned CustomerGroup to Other
**    
*******************************************************************************/

SELECT     
	c.ShipTo, 
	c.BillTo, 
	c.DSO_ParentShipTo, 
	c.PracticeName, 
	c.AccountType, 
	c.SalesDivision, 
	c.VPA, 
	CASE WHEN c.CustGrpWrk = '' THEN 'Other' ELSE c.CustGrpWrk END CustomerGroup, 
	c.MarketClass, 
	c.SegCd, 
	c.Specialty, 
	c.DateAccountOpened, 
	f.TerritoryCd, 
	f.FSCName, 
	f.Branch
FROM         

	BRS_Customer AS c 

	INNER JOIN BRS_CustomerGroup AS cg 
	ON c.CustGrpWrk = cg.CustGrp 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd

WHERE     
	(cg.ReportInd = 1) OR
	(c.ShipTo = 0)	

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_SM_Customer WHERE shipto = 0
