
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
**  19 Dec 22	tmc		relaxed historical lookups to allow mid-month run
**	15 Apr 23	tmc		add backorder to feed
**	10 Oct 24	tmc		add invoice date (for testing)
*******************************************************************************/

-- Buy section
SELECT
	[SalesOrderNumber]
	,[DocType]
	,[LineNumber]
	,conf.PriorFiscalMonth AS CalMonthRedeem
	,t.[CalMonth]
	,'.' AS fg_exempt_cd
	, 'BUY' as src
	,0 as fg_redeem_ind
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
	,i.Label
	--,ih.Label
	,i.Supplier
	--,ih.Supplier 
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
	,t.CreditMinorReasonCode
	,t.CreditTypeCode
	,1 AS show_ind
	,t.Date as invoice_date

FROM
	[dbo].[BRS_TransactionDW] t

	INNER JOIN [dbo].[BRS_ItemMPC] mpc
	ON t.MajorProductClass = mpc.MajorProductClass

	INNER JOIN [dbo].[BRS_Item] i
	ON t.Item = i.item

	INNER JOIN [dbo].[BRS_Customer] c
	ON t.Shipto = c.ShipTo

	LEFT JOIN [dbo].[BRS_CustomerFSC_History] ch
--	INNER JOIN [dbo].[BRS_CustomerFSC_History] ch
	ON t.shipto = ch.[Shipto] AND
	t.CalMonth = ch.FiscalMonth

	LEFT JOIN [dbo].[BRS_FSC_Rollup] fsc
--	INNER JOIN [dbo].[BRS_FSC_Rollup] fsc
	ON ch.HIST_TerritoryCd = fsc.TerritoryCd

	LEFT JOIN [dbo].[BRS_ItemHistory]ih
--	INNER JOIN [dbo].[BRS_ItemHistory]ih
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
			-- remove price adj
			(s.[WKDCTO_order_type] not in ('CO')) AND
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
	-- manual removes slow
	--(t.Item > '0') AND
	-- remove restocking
	-- (t.SalesOrderNumber = 14651893) AND
	(1=1)


UNION ALL

-- GET Section
SELECT
	WKDOCO_salesorder_number
	,WKDCTO_order_type
	,WKLNNO_line_number
	,CalMonthRedeem
	,CalMonthOrder
	,t.fg_exempt_cd
	, 'GET' as src
	,ISNULL(fg_redeem_ind,'') as fg_redeem_ind
	,fg_offer_id
	,fg_offer_note
	,WKSHAN_shipto
	,WKNAME_shipto_name
	,ISNULL(fsc.Branch, '.') Branch
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
	,tt.CreditMinorReasonCode
	,tt.CreditTypeCode
	,ex.show_ind
	,tt.Date as invoice_date

FROM
	fg.transaction_F5554240 t

	INNER JOIN 
	[dbo].[BRS_TransactionDW] tt
	ON t.ID_source_ref = tt.ID

	INNER JOIN 
	[dbo].[BRS_ItemMPC] mpc
	ON t.MajorProductClass = mpc.MajorProductClass

	LEFT JOIN 
--	INNER JOIN 
	[dbo].[BRS_CustomerFSC_History] ch
	ON t.WKSHAN_shipto = ch.[Shipto] AND
	t.CalMonthRedeem = ch.FiscalMonth

	LEFT JOIN 
--	INNER JOIN 
	[dbo].[BRS_FSC_Rollup] fsc
	ON ch.HIST_TerritoryCd = fsc.TerritoryCd

	INNER JOIN 
	[dbo].[BRS_Item] i
	ON t.WKLITM_item_number = i.Item

--	LEFT JOIN 
	INNER JOIN 
	[fg].[exempt_code] ex
	ON t.fg_exempt_cd = ex.fg_exempt_cd

WHERE
	(CalMonthRedeem = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) AND
--	(ex.show_ind = 1) AND
	-- test
	--(t.WKDOCO_salesorder_number = 14652012) AND
	(1=1)

UNION ALL

-- backorder section
SELECT
	[SDDOCO_salesorder_number]				AS JDE_ORDER
	,'.'									AS [DocType]
	,0										AS [LineNumber]
	,CONVERT(nvarchar(6), SalesDay, 112)	AS CalMonthRedeem
	,CONVERT(nvarchar(6), SalesDay, 112)	AS [CalMonth]
	,'.'									AS fg_exempt_cd
	, 'BUY'									as src
	,0										as fg_redeem_ind
	,0										AS fg_offer_id
	,'bo'									AS fg_offer_note
	,[SDSHAN_shipto] 						AS SHIP_TO_ACCOUNT
	,RTRIM(c.PracticeName)					AS PracticeName
	,'.'									AS Branch
	,RTRIM(t.[SDLITM_item_number])			AS ITEM
	,RTRIM(i.[ItemDescription])				AS ItemDescription
	,[SDSOBK_quantity_backordered]
	,0										AS WKECST_extended_cost
	,0										AS [ExtFileCostCadAmt]
	,0										AS WKUNCS_unit_cost
	,'CAD'									AS WKCRCD_currency_code
	,'.'									AS [PromotionCode] 
	,'.'									AS PromotionDescription
	,'.'									AS [OrderPromotionCode]
	,[QCTRDJ_order_date]					AS ORDER_DATE
	,'.'									AS [VPA]
	,'.'									AS HIST_Specialty 
	,'.'									AS [LineTypeOrder]
	,'.'									AS [SalesDivision]
	,'.'									AS MajorProductClass
	,'.'									AS MajorProductClassDesc
	,'.'									AS Label
	,[QN$SPC_supplier_code]					AS SUPPLIER_CODE
	,0										AS [InvoiceNumber]
	,[SDDOCO_salesorder_number]				AS [OriginalSalesOrderNumber]
	,'.'									AS [OriginalOrderDocumentType]
	,0										AS [OriginalOrderLineNumber]
	,0										AS BillTo
	,'.'									AS billto_name
	,0										AS ID
	,0										AS ID_source_ref
	,'.'									AS status_code_high
	,0										AS [ChargebackContractNumber] 
	,'.'									AS [PricingAdjustmentLine]
	,'.'									AS [EnteredBy] 
	,'backorder'							AS order_file_name
	,i.[FamilySetLeader]					AS FAMILY_SET
	,'.'									AS ManufPartNumber
	,'.'									AS SalesCategory
	,'.'									AS CreditMinorReasonCode
	,'.'									AS CreditTypeCode
	,1										AS show_ind
	,t.SalesDay as invoice_date

FROM
	[fg].[backorder_FBACKRPT1_history] t

	INNER JOIN [dbo].[BRS_Item] i
	ON t.[SDLITM_item_number] = i.item

	INNER JOIN [dbo].[BRS_Customer] c
	ON t.[SDSHAN_shipto] = c.ShipTo

WHERE
	t.SalesDay =
	(
		SELECT MAX(SalesDay) 
		FROM  [fg].[backorder_FBACKRPT1_history] 
		WHERE CONVERT(nvarchar(6), SalesDay, 112) = 
		(
			SELECT [PriorFiscalMonth] 
			FROM [dbo].[BRS_Config]
		)
	) AND

	-- include full order
	EXISTS 
	(
		SELECT * 
		FROM [BRSales].[fg].[transaction_F5554240] s
		WHERE 
			(CalMonthRedeem = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])  ) AND
			-- test
--			(fg_exempt_cd NOT LIKE 'XXX%') AND
			(t.[SDDOCO_salesorder_number] = s.WKDOCO_salesorder_number ) AND
			-- remove price adj
			(s.[WKDCTO_order_type] not in ('CO')) AND
			(1=1)
	) AND
	-- manual removes slow
	--(t.Item > '0') AND
	-- remove restocking
	-- (t.SalesOrderNumber = 14651893) AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- SELECT TOP 100 * FROM fg.redeem_working where src = 'GET' and DocType = 'SE' order by 1
-- SELECT * FROM fg.redeem_working
-- 20 sec

-- SELECT count (*) FROM fg.redeem_working

-- ORG 122 703
-- NEW 122 703

--SELECT * FROM fg.redeem_working WHERE SalesOrderNumber = 17278123

--SELECT * FROM fg.redeem_working WHERE order_file_name = 'backorder'

