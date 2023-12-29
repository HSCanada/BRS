
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW nes.gp_exception_R5557ALL
AS

/******************************************************************************
**	File: 
**	Name: nes.gp_exception_R5557ALL
**	Desc:  revese engineer R5557ALL GP exception report
**              
**	Return values:  
**
**	Called by:   excel
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**  BRS_Config!PriorFiscalMonth
**
**	Auth: tmc
**	Date: 15 Nov 22
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--  27 Jan 23	tmc		update param to for MTD vs PY MTD (full)
**    
*******************************************************************************/

SELECT
	d.FiscalMonth
	,t.SalesDivision
	,i.SalesCategory
	,RTRIM(mpc.MajorProductClass) + ' | ' + RTRIM(mpc.MajorProductClassDesc)	AS MajorProductClass
	,RTRIM(i.Item) + ' | ' + RTRIM(i.ItemDescription)	AS Item
	,RTRIM(CAST(c.Shipto as char)) + ' | ' + c.PracticeName  	AS Customer

	,t.SalesOrderNumber
	,t.DocType
	,t.LineNumber
	,t.InvoiceNumber
	,t.OrderSourceCode
	,t.PriceMethod
	,t.NetSalesAmt
	,t.GPAtCommCostAmt
	,t.GPAtFileCostAmt
	,t.GPAmt
	,t.ExtChargebackAmt
	,t.ShippedQty
	,t.ExtListPrice
	,t.ExtPrice
	,t.ExtDiscAmt
	,t.VPA
	,t.OrderTakenBy
	,t.EnteredBy
	,t.ID
	,t.Item AS ItemCode
	,t.Shipto AS ShiptoCode
	,t.MajorProductClass AS MajorProductClassCode
	,t.Date
	,d.FiscWeekName
	,t.PromotionCode
	,t.OrderPromotionCode
	,t.GLBusinessUnit
	,t.FreeGoodsInvoicedInd
	,t.OriginalSalesOrderNumber
	,t.CreditTypeCode
	,t.CreditMinorReasonCode
	,i.CurrentFileCost
	,i.CurrentCorporatePrice
	,i.CurrentCorporatePrice - i.CurrentFileCost AS CurrentFileCostGP
	,fsc.Branch
	,d.CalWeek
	,LEFT(d.FiscalMonth,4) AS year_

FROM
	BRS_TransactionDW AS t 

	INNER JOIN BRS_SalesDay AS d 
	ON t.Date = d.SalesDate 

	INNER JOIN BRS_Item AS i 
	ON t.Item = i.Item 

	INNER JOIN BRS_Customer AS c 
	ON t.Shipto = c.ShipTo 

	INNER JOIN BRS_FSC_Rollup as fsc
	ON c.TerritoryCd = fsc.TerritoryCd

	INNER JOIN BRS_ItemMPC AS mpc 
	ON i.MajorProductClass = mpc.MajorProductClass



	-- uncomment for audit view
 /*
	INNER JOIN zzzShipto as so
	ON t.SalesOrderNumber = so.ST
*/
	/*
	-- salesorder that with questionable GP
	INNER JOIN (
		SELECT SalesOrderNumber
		FROM
			BRS_TransactionDW AS t2 

			INNER JOIN BRS_SalesDay AS d2
			ON t2.Date = d2.SalesDate 
		WHERE
			d2.FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])
		GROUP BY 
			t2.SalesOrderNumber
		HAVING 
			NOT SUM(t2.[GPAmt]) / NULLIF(SUM(t2.[NetSalesAmt]), 0) between 0.2 and 0.5 
	) so_filter
	ON t.SalesOrderNumber = so_filter.SalesOrderNumber
 */


WHERE
	d.FiscalMonth = ((SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) OR d.FiscalMonth = ((SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])-100) 

	-- uncomment for audit view
--	d.FiscalMonth between 202301 and 202306


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT  top 1000 * from nes.gp_exception_R5557ALL order by 2 desc
-- SELECT   * from nes.gp_exception_R5557ALL

-- SELECT  count(*) from nes.gp_exception_R5557ALL
-- ORG 216 493

-- ORG 199
-- NEW 543323

-- select count(*) from zzzShipto