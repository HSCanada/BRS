
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
**    
*******************************************************************************/


SELECT     
	l.CalMonth
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
FROM         
	BRS_ItemBaseHistoryLNK AS l 

	INNER JOIN BRS_ItemBaseHistoryDAT AS d 
	ON l.PriceID = d.PriceID 

	INNER JOIN BRS_Item AS i 
	ON l.ItemID = i.ID 

	INNER JOIN BRS_CurrencyHistory AS fx 
	ON d.Currency = fx.Currency AND 
		l.CalMonth = fx.FiscalMonth 

	INNER JOIN BRS_CurrencyHistory AS fxcad 
	ON l.CalMonth = fxcad.FiscalMonth AND 
		fxcad.Currency = 'CAD'


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM BRS_ItemBaseHistory order by CalMonth DESC







