
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
**	8 Nov 19	tmc		Add VPA foucs code for MBO tracking
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

	,RTRIM(ISNULL(padj.[SNAST__adjustment_name],''))			AS Adjustment
	,RTRIM(ISNULL(padj.[PJEFTJ_effective_date],'1980-01-01'))	AS AdjEffectiveDate
	,RTRIM(ISNULL(padj.[PJEXDJ_expired_date],'1980-01-01'))		AS AdjExpiredDate
	,RTRIM(ISNULL(padj.[PJUSER_user_id],''))					AS AdjUserId
	,RTRIM(ISNULL(padj.[EnrollSource],''))						AS AdjEnrollSource
	,RTRIM(ISNULL(padj.[PriceMethod],''))						AS AdjPriceMethod
	,V.FocusCd													as SalesplanFocusCode



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

	-- de-dup enroll (due to contract + special price enroll)
	LEFT JOIN 
	(
		SELECT 
			*
		FROM            
			[Pricing].[price_adjustment_enroll] AS s
		WHERE EXISTS 
		(
			SELECT MIN(s2.ID) AS id_unique 
			FROM [Pricing].[price_adjustment_enroll] s2
			GROUP BY s2.BillTo
			HAVING s.[ID] = MIN(s2.ID)
		)
	)  padj
	ON bt.BillTo = padj.BillTo


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
SELECT        BillTo, COUNT(*) AS Expr1, MIN(
FROM            Pricing.price_adjustment_enroll
GROUP BY BillTo
HAVING        (COUNT(*) > 1)
*/


