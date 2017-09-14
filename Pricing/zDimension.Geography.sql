
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Geography]
AS

/******************************************************************************
**	File: 
**	Name: Geography
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
**	Date: 15 Jun 17
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	10 Jul 17	tmc		updated ABC group
**    
*******************************************************************************/

SELECT
	FsaKey
	,FSA
	,City
	,Region
	,Province
	,Country
	,Geo_Category	AS Abc_GeoCustomer
FROM
	BRS_Customer_FSA

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM Dimension.Geography order by 1
