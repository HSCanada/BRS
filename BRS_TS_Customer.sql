
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_TS_Customer]
AS

/******************************************************************************
**	File: 
**	Name: BRS_TS_Customer
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
**	Date: 11 Oct 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT     
	c.ShipTo, 
	c.BillTo, 
	c.DSO_ParentShipTo, 
	c.PracticeName, 
	CASE WHEN c.AccountType = 'D' THEN 'D' ELSE 'A' END AccountType, 
	c.SalesDivision, 
	c.VPA, 
	CASE WHEN c.CustGrpWrk = '' THEN 'Other' ELSE c.CustGrpWrk END CustomerGroup, 
	c.MarketClass, 
	c.SegCd, 
	c.Specialty, 
	CONVERT(INT, LEFT(CONVERT(varchar, (c.DateAccountOpened), 112), 6)) AS DateAccountOpenedFiscalMonth, 

	f.Branch,

	f.TerritoryCd AS FscTerritoryCd, 
	f.FSCName AS FscName, 
	f.FSCStatusCode AS FscStatusCode,

	TS_CategoryCd AS FscShareType,

	t.TsTerritoryCd , 
	t.TsName , 
	t.StatusCode AS TsStatusCode,

-----------------------------------------
--			|	TS		|	No
-----------------------------------------
--	FSC		|	Shared	|	Field
-----------------------------------------
--	House	|	Tele	|	Unassasigned
-----------------------------------------

	CASE WHEN f.FSCStatusCode LIKE 'F%' 
		THEN 
			CASE WHEN t.StatusCode LIKE 'T%' 
				THEN 'S'  
				ELSE 'F' 
			END 
		ELSE 
			CASE WHEN t.StatusCode LIKE 'T%' 
				THEN 'T'  
				ELSE 'U' 
			END 
	END AS SalesChannel,

	c.FocusCd


FROM         

	BRS_Customer AS c 

	INNER JOIN BRS_FSC_Rollup AS f 
	ON c.TerritoryCd = f.TerritoryCd

	INNER JOIN BRS_TS_Rollup AS t
	ON c.TsTerritoryCd = t.TsTerritoryCd

WHERE     
	(1=1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM BRS_TS_Customer WHERE VPA = 'DENCORP'