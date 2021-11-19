
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW fg.redeem_working
AS

/******************************************************************************
**	File: 
**	Name: fg.redeem_working
**	Desc: show buy and get in a single source
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
**	Date: 29 Oct 21
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
	,[LineNumber]
	,conf.PriorFiscalMonth AS CalMonthRedeem
	,t.[CalMonth]
	,'.' AS fg_exempt_cd
	, 'BUY' as src
	,0 AS fg_offer_id
	,'.' AS fg_offer_note
	,t.[Shipto]
	,c.PracticeName
	,fsc.Branch
	,t.[Item]
	,i.ItemDescription
	,[ShippedQty]
	,([NetSalesAmt]-[GPAtFileCostAmt]) AS WKECST_extended_cost
	,([NetSalesAmt]-[GPAtFileCostAmt]) AS [ExtFileCostCadAmt]
	,0 AS WKUNCS_unit_cost
	,'CAD' AS WKCRCD_currency_code
	,t.[PromotionCode] 
	,pr.PromotionDescription
	,[OrderPromotionCode]
	,[OrderFirstShipDate]
	,t.[VPA]
	,ch.HIST_Specialty 
	,[LineTypeOrder]
	,t.[SalesDivision]
	,t.MajorProductClass
	,mpc.MajorProductClassDesc
	,ih.Label
	,ih.Supplier 
	,[InvoiceNumber]
	,[OriginalSalesOrderNumber]
	,[OriginalOrderDocumentType]
	,[OriginalOrderLineNumber]
	,c.BillTo
	,'.' AS billto_name
	,t.ID
	,t.[ID] AS ID_source_ref
	,'.' AS status_code_high
	,[ChargebackContractNumber] 
	,[PricingAdjustmentLine]
	,[EnteredBy] 
	,'.' AS order_file_name
	,i.FamilySetLeader
	,i.ManufPartNumber
	,i.SalesCategory
FROM
	[dbo].[BRS_TransactionDW] t

	INNER JOIN [dbo].[BRS_ItemMPC] mpc
	ON t.MajorProductClass = mpc.MajorProductClass

	INNER JOIN [dbo].[BRS_Item] i
	ON t.Item = i.item

	INNER JOIN [dbo].[BRS_Customer] c
	ON t.Shipto = c.ShipTo

	INNER JOIN [dbo].[BRS_CustomerFSC_History] ch
	ON t.shipto = ch.[Shipto] AND
	t.CalMonth = ch.FiscalMonth

	INNER JOIN [dbo].[BRS_FSC_Rollup] fsc
	ON ch.HIST_TerritoryCd = fsc.TerritoryCd

	INNER JOIN [dbo].[BRS_ItemHistory]ih
	ON t.Item = ih.Item AND
	t.CalMonth = ih.FiscalMonth

	INNER JOIN [dbo].[BRS_Promotion] pr
	ON t.PromotionCode = pr.PromotionCode

	CROSS JOIN [dbo].[BRS_Config] conf

WHERE
	-- include full order
	EXISTS 
	(
		SELECT * 
		FROM fg.transaction_F5554240 s
		WHERE 
			(CalMonthRedeem = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) AND
			-- test
--			(fg_exempt_cd NOT LIKE 'XXX%') AND
			(t.[SalesOrderNumber] = s.WKDOCO_salesorder_number ) AND
			(1=1)
	) AND
	-- exclude get line (added below)
	NOT EXISTS 
	(
		SELECT * 
		FROM fg.transaction_F5554240 s2
		WHERE 
			(t.ID = s2.ID_source_ref ) AND
			(1=1)
	) AND
	-- remove restocking
	-- (t.Item > '0') AND
	-- test
	--(t.SalesOrderNumber = 14459975) AND
	(1=1)


UNION ALL

--
SELECT
	WKDOCO_salesorder_number
	,WKDCTO_order_type
	,WKLNNO_line_number
	,CalMonthRedeem
	,CalMonthOrder
	,fg_exempt_cd
	, 'GET' as src
	,fg_offer_id
	,fg_offer_note
	,WKSHAN_shipto
	,WKNAME_shipto_name
	,fsc.Branch
	,WKLITM_item_number
	,WKDSC1_description
	,WKUORG_quantity
	,WKECST_extended_cost
	,([NetSalesAmt]-[GPAtFileCostAmt]) AS [ExtFileCostCadAmt]
	,WKUNCS_unit_cost
	,WKCRCD_currency_code
	,WKPMID_promo_code
	,WKDL01_promo_description
	,WKFRGD_from_grade AS [OrderPromotionCode]
	,WKDATE_order_date
	,t.VPA
	,Specialty
	,WKLNTY_line_type
	,WKAC10_division_code
	,t.MajorProductClass
	,mpc.MajorProductClassDesc
	,t.Label
	,WK$SPC_supplier_code
	,WKPSN__invoice_number
	,t.OriginalSalesOrderNumber
	,t.[OriginalOrderDocumentType]
	,t.[OriginalOrderLineNumber]
	,WKAN8__billto
	,WKALPH_billto_name
	,t.ID
	,t.ID_source_ref
	,WK$HGS_status_code_high
	,t.WK$ODN_free_goods_contract_number
	,WKDSC2_pricing_adjustment_line
	,t.[EnteredBy] 
	,order_file_name
	,i.FamilySetLeader AS FamilySetLeader
	,t.[WKCITM_customersupplier_item_number] ManufPartNumber
	,i.SalesCategory

FROM
	fg.transaction_F5554240 t

	INNER JOIN 
	[dbo].[BRS_TransactionDW] tt
	ON t.ID_source_ref = tt.ID

	INNER JOIN [dbo].[BRS_ItemMPC] mpc
	ON t.MajorProductClass = mpc.MajorProductClass

	INNER JOIN [dbo].[BRS_CustomerFSC_History] ch
	ON t.WKSHAN_shipto = ch.[Shipto] AND
	t.CalMonthRedeem = ch.FiscalMonth

	INNER JOIN [dbo].[BRS_FSC_Rollup] fsc
	ON ch.HIST_TerritoryCd = fsc.TerritoryCd

	INNER JOIN [dbo].[BRS_Item] i
	ON t.WKLITM_item_number = i.Item

WHERE
	(CalMonthRedeem = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) AND
	-- test
	--(t.WKDOCO_salesorder_number = 14459975) AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT TOP 100 * FROM fg.redeem_working
--SELECT * FROM fg.redeem_working WHERE SalesOrderNumber = 14459975
