
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW fg.redeem_actual_commission
AS

/******************************************************************************
**	File: 
**	Name: fg.redeem_actual
**	Desc: show vendor redeemed free goods (for testing)
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
**	Date: 11 Nov 21
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

--
SELECT
	[SalesOrderNumber]
	,[DocType]
	,0 AS [LineNumber]
	,conf.PriorFiscalMonth AS CalMonthRedeem
	,t.[FiscalMonth] AS [CalMonth]
	,'' AS fg_exempt_cd
	,t.SourceCode as src
	,0 AS fg_offer_id
	,'' AS fg_offer_note
	,t.[Shipto]
	,c.PracticeName
	,fsc.Branch
	,t.[Item]
	,i.ItemDescription
	,0 AS [ShippedQty]
	,[ExtFileCostCadAmt] AS WKECST_extended_cost
	, [ExtFileCostCadAmt]
	,0 AS WKUNCS_unit_cost
	,'CAD' AS WKCRCD_currency_code
	,'.' AS [PromotionCode] 
	,'.' AS PromotionDescription
	,'.' AS [OrderPromotionCode]
	,NULL AS [OrderFirstShipDate]
	,ch.HIST_VPA AS VPA
	,ch.HIST_Specialty 
	,'.' AS [LineTypeOrder]
	,ch.HIST_SalesDivision AS [SalesDivision]
	,i.MajorProductClass AS MajorProductClass
	,mpc.MajorProductClassDesc
	,ih.Label
	,ih.Supplier 
	,'.' AS [InvoiceNumber]
	,0 AS [OriginalSalesOrderNumber]
	,'.' AS [OriginalOrderDocumentType]
	,0 AS [OriginalOrderLineNumber]
	,c.BillTo
	,'.' AS billto_name
	,t.ID
	,t.[ID] AS ID_source_ref
	,'.' AS status_code_high
	,'.' AS [ChargebackContractNumber] 
	,'.' AS [PricingAdjustmentLine]
	,'.' AS [EnteredBy] 
	,'' AS order_file_name
FROM
	[comm].[freegoods] t


	INNER JOIN [dbo].[BRS_Item] i
	ON t.Item = i.item

	INNER JOIN [dbo].[BRS_ItemMPC] mpc
	ON i.MajorProductClass = mpc.MajorProductClass

	INNER JOIN [dbo].[BRS_Customer] c
	ON t.Shipto = c.ShipTo

	INNER JOIN [dbo].[BRS_CustomerFSC_History] ch
	ON t.shipto = ch.[Shipto] AND
	t.FiscalMonth = ch.FiscalMonth

	INNER JOIN [dbo].[BRS_FSC_Rollup] fsc
	ON ch.HIST_TerritoryCd = fsc.TerritoryCd

	INNER JOIN [dbo].[BRS_ItemHistory]ih
	ON t.Item = ih.Item AND
	t.FiscalMonth = ih.FiscalMonth

/*
	INNER JOIN [dbo].[BRS_Promotion] pr
	ON t.PromotionCode = pr.PromotionCode
*/

	CROSS JOIN [dbo].[BRS_Config] conf

WHERE
	(t.SourceCode = 'ACT') AND
	(t.FiscalMonth = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) AND
	-- test
	--(t.SalesOrderNumber = 14459975) AND
	(1=1)

GO




--SELECT TOP 100 * FROM fg.redeem_working
SELECT * FROM fg.redeem_actual_commission WHERE SalesOrderNumber = 14459975
