
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[BRS_ItemBaseHistoryDay]
AS

/******************************************************************************
**	File: 
**	Name: BRS_ItemBaseHistoryDay
**	Desc: unpack BRS_ItemBaseHistoryDayLNK.  No RI on CURR History due to design
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
**    
*******************************************************************************/


SELECT     
	sd.FiscalMonth
	,l.SalesDate
	,i.Item
	,d.Supplier
	,d.Currency
	,d.SupplierCost
	,d.SupplierCost * (fxcad.FX_per_USD_pnl_rt / fx.FX_per_USD_pnl_rt) AS SupplierCostCAD
	,d.CorporatePrice
	,d.SellPrcBrk2
	,d.SellPrcBrk3
	,d.SellQtyBrk2
	,d.SellQtyBrk3

	,(fxcad.FX_per_USD_pnl_rt / fx.FX_per_USD_pnl_rt) AS [FX_per_CAD_pnl_rt]
	,fx.FX_per_CAD_mrk_rt

	,l.ItemKey	
	,l.FamilySetLeaderKey
	,l.PriceKey

FROM         
	BRS_ItemBaseHistoryDayLNK AS l 

	INNER JOIN BRS_ItemBaseHistoryDAT AS d 
	ON l.PriceKey = d.PriceID 

	INNER JOIN BRS_Item AS i 
	ON l.ItemKey = i.ItemKey 

	INNER JOIN [BRS_SalesDay] as sd
	ON l.[SalesDate] = sd.SalesDate

	INNER JOIN BRS_CurrencyHistory AS fx 
	ON d.Currency = fx.Currency AND 
		sd.FiscalMonth = fx.FiscalMonth 

	INNER JOIN BRS_CurrencyHistory AS fxcad 
	ON sd.FiscalMonth = fxcad.FiscalMonth AND 
		fxcad.Currency = 'CAD'


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM BRS_ItemBaseHistoryDay order by salesdate DESC







