
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
	t.[SalesOrderNumber]
	,tt.WKDCTO_order_type [DocType]
	,tt.WKLNNO_line_number AS [LineNumber]
	,conf.PriorFiscalMonth AS CalMonthRedeem
	,t.[FiscalMonth] AS [CalMonth]
	,tt.fg_exempt_cd AS fg_exempt_cd
	,t.SourceCode as src
	,tt.fg_offer_id
	,tt.fg_offer_note
	,tt.WKSHAN_shipto AS [Shipto]
	,tt. WKNAME_shipto_name AS PracticeName
	,fsc.Branch
	,t.[Item]
	,tt.WKDSC1_description ItemDescription
	,tt.[WKUORG_quantity] AS [ShippedQty]
	,tt.WKECST_extended_cost
	,t.[ExtFileCostCadAmt]
	,tt.WKUNCS_unit_cost
	,tt.WKCRCD_currency_code
	,tt.[WKPMID_promo_code] AS [PromotionCode] 
	,tt.[WKDL01_promo_description] AS PromotionDescription
	,tt.WKFRGD_from_grade AS [OrderPromotionCode]
	,tt.[WKDATE_order_date] AS [OrderFirstShipDate]
	,tt.VPA
	,ch.HIST_Specialty 
	,tt.[WKLNTY_line_type] AS [LineTypeOrder]
	,tt.WKAC10_division_code AS [SalesDivision]
	,tt.MajorProductClass
	,mpc.MajorProductClassDesc
	,ih.Label
	,tt.WK$SPC_supplier_code Supplier 
	,tt.WKPSN__invoice_number AS [InvoiceNumber]
	,tt.[OriginalSalesOrderNumber]
	,tt.[OriginalOrderDocumentType]
	,tt.[OriginalOrderLineNumber]
	,tt.WKAN8__billto AS BillTo
	,tt.WKALPH_billto_name AS billto_name
	,t.ID
	,t.ID_source_ref 
	,tt.[WK$HGS_status_code_high] AS status_code_high
	,tt.[WK$ODN_free_goods_contract_number] [ChargebackContractNumber] 
	,tt.[WKDSC2_pricing_adjustment_line] AS [PricingAdjustmentLine]
	,tt.[EnteredBy] 
	,tt.order_file_name
FROM
	[comm].[freegoods] t

	LEFT JOIN
	[fg].[transaction_F5554240] tt
	ON t.ID_source_ref = tt.ID_source_ref

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
-- SELECT * FROM fg.redeem_actual_commission WHERE SalesOrderNumber = 14459975

SELECT * FROM fg.redeem_actual_commission WHERE ID_source_ref is null

