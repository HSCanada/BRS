
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [Dimension].[Customer_qt]
AS

/******************************************************************************
**	File: 
**	Name: Customer Billto
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
**	Date: 22 Jan 19
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT
	bt.Billto
	,bt.ShipToPrimary

	,c.PracticeName + ' | ' + RTRIM(CAST(bt.Billto as char))	AS Customer

	,RTRIM(v.VPA) + ' | ' + RTRIM(VPADesc)  			AS SalesPlan

	,RTRIM(terr.FSCName)								AS FieldSales
	,RTRIM(b.BranchName)								AS Branch
	,RTRIM(c.City)										AS City


	,CAST(c.DateAccountOpened AS date)					AS DateAccountOpened

	,RTRIM(c.SalesDivision)								AS SalesDivisionCode
	,RTRIM(mclass.MarketClassDesc)						AS MarketClass



FROM
	[BRS_CustomerBT] as bt

	INNER JOIN BRS_Customer AS c 
	ON bt.ShipToPrimary = c.ShipTo


	INNER JOIN BRS_CustomerMarketClass AS mclass 
	ON c.MarketClass = mclass.MarketClass 

	
	INNER JOIN BRS_CustomerVPA as v
	ON c.[VPA] = v.[VPA]

	INNER JOIN BRS_FSC_Rollup AS terr
	ON c.TerritoryCd = terr.[TerritoryCd]

	INNER JOIN BRS_Branch AS b 
	ON terr.Branch = b.Branch

WHERE 
--	test
--	c.Billto = 1527764 AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT top 10 * FROM Dimension.Customer_qt 
-- where  billto = 2613256 order by 1

-- integrity check
-- SELECT * from BRS_Customer where not exists (SELECT * FROM Dimension.Customer where  ShipTo = BRS_Customer.[ShipTo])

-- dup check
/*
SELECT        BillTo, COUNT(*) AS Expr1
FROM            Pricing.price_adjustment_enroll
GROUP BY BillTo
HAVING        (COUNT(*) > 1)
*/

-- Select count(*) from [Dimension].[Customer] where IsrLoginId <>''

-- Select top 10 * from [Dimension].[Customer] where IsrTerritoryCd = 'DTSNT'

-- Select top 10 * from [Dimension].[Customer] where ReviewTrackingInd = 1

