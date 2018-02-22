
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[BRS_ItemBaseHistory]
AS

/******************************************************************************
**	File: 
**	Name: BRS_ItemBaseHistory
**	Desc: unpack BRS_ItemBaseHistoryLNK.  No RI on CURR History due to design
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
**	Date: 05 Oct 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	28 Mar 17	tmc		Added Marketing FX and broke out Financail FX
--  07 Apr 17	tmc		Added Internal IDs to allow manual maintenance
--	10 Jul 17	tmc		Fixed Item.ID to .ItemKey rename
--	27 Jul 17	tmc		swap out month with daily table
**    
*******************************************************************************/


SELECT     
	m.CalMonth
	,l.Item
	,l.Supplier
	,l.Currency
	,l.SupplierCost
	,l.SupplierCostCAD
	,l.CorporatePrice
	,l.SellPrcBrk2
	,l.SellPrcBrk3
	,l.SellQtyBrk2
	,l.SellQtyBrk3

	,l.[FX_per_CAD_pnl_rt]
	,l.FX_per_CAD_mrk_rt

	,l.ItemKey	
	,l.FamilySetLeaderKey
	,l.PriceKey

FROM         
	[dbo].[BRS_ItemBaseHistoryDay] AS l 

	INNER JOIN [dbo].[BRS_CalMonth] as m
	ON l.FiscalMonth = m.CalMonth AND
		l.SalesDate = m.BCI_BenchmarkDay


-- latest update maps to 0 month

UNION ALL 


SELECT     
	0 AS CalMonth
	,l.Item
	,l.Supplier
	,l.Currency
	,l.SupplierCost
	,l.SupplierCostCAD
	,l.CorporatePrice
	,l.SellPrcBrk2
	,l.SellPrcBrk3
	,l.SellQtyBrk2
	,l.SellQtyBrk3

	,l.[FX_per_CAD_pnl_rt]
	,l.FX_per_CAD_mrk_rt

	,l.ItemKey	
	,l.FamilySetLeaderKey
	,l.PriceKey

FROM         
	[dbo].[BRS_ItemBaseHistoryDay] AS l 

WHERE 
	l.SalesDate = (SELECT MAX(salesdate) FROM [dbo].[BRS_ItemBaseHistoryDayLNK])


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM BRS_ItemBaseHistory order by CalMonth ASC

-- SELECT top 10 * FROM BRS_ItemBaseHistory where calmonth = 201712


