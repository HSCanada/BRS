-- backorder 
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

/*
	Select max(SalesDay) from  [fg].[backorder_FBACKRPT1_history] where CONVERT(nvarchar(6), SalesDay, 112) = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])

	select month('2022-10-31')

	SELECT CONVERT(nvarchar(6), GETDATE(), 112)
*/

-- select top 1 * from fg.redeem_working