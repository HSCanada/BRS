
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW fg.item_cost_extract
AS

/******************************************************************************
**	File: 
**	Name: fg.item_cost_extract
**	Desc: JDE cost standard used to fix Free goods extract, 
**			base on BRS_ItemBaseHistoryDayLNK.
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
**	Date: 18 Nov 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/


SELECT     
	i.Item
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
	,sd.FiscalMonth
	,sd.CalMonth
	,l.SalesDate


FROM         
	BRS_ItemBaseHistoryDayLNK AS l 

	INNER JOIN BRS_ItemBaseHistoryDAT AS d 
	ON l.PriceKey = d.PriceID 

	INNER JOIN BRS_Item AS i 
	ON l.ItemKey = i.ItemKey 

	INNER JOIN [BRS_SalesDay] as sd
	ON l.[SalesDate] = sd.SalesDate

--	INNER JOIN [dbo].[BRS_FiscalMonth] as fm
--	ON sd.FiscalMonth = fm.[FiscalMonth]

	INNER JOIN BRS_CurrencyHistory AS fx 
	ON d.Currency = fx.Currency AND 
		sd.FiscalMonth = fx.FiscalMonth 

	INNER JOIN BRS_CurrencyHistory AS fxcad 
	ON sd.FiscalMonth = fxcad.FiscalMonth AND 
		fxcad.Currency = 'CAD'
WHERE
--	l.SalesDate = '2021-10-22'
	l.SalesDate = 
	(
		SELECT CAST(m.fg_cost_date as Date)
		FROM BRS_Config AS c 
			INNER JOIN BRS_FiscalMonth AS m 
			ON c.[PriorFiscalMonth] = m.FiscalMonth AND c.PriorFiscalMonth = m.FiscalMonth
	)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
SELECT top 10 * FROM fg.item_cost_extract
SELECT * FROM fg.item_cost_extract

SELECT        m.fg_cost_date
FROM            BRS_Config AS c INNER JOIN
                         BRS_FiscalMonth AS m ON c.[PriorFiscalMonth] = m.FiscalMonth AND c.PriorFiscalMonth = m.FiscalMonth

*/




