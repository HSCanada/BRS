-- backorder mock-up

SELECT
	[QN$SPC_supplier_code]						AS SUPPLIER_CODE

	,CAST([SDSHAN_shipto] AS varchar(30)) + ' | ' 
	+ RTRIM(c.PracticeName)						AS SHIP_TO_ACCOUNT
	, [SDDOCO_salesorder_number]				AS JDE_ORDER
	,[QCTRDJ_order_date]						AS ORDER_DATE
	,[SDDOCO_salesorder_number]					AS DEAL_ORDER
	,i.[FamilySetLeader]						AS FAMILY_SET
	,RTRIM(t.[SDLITM_item_number]) + ' | ' 
	+ i.[ItemDescription]						AS ITEM
	, 'BUY' as BUY_GET
	,[SDSOBK_quantity_backordered]
	,'.'										AS CLAIM
	,'.'										AS DEAL
	,'.'										AS fg_exempt_cd
	,'bo'										AS fg_offer_note



FROM
	[fg].[backorder_FBACKRPT1_history] t

	INNER JOIN [dbo].[BRS_Item] i
	ON t.[SDLITM_item_number] = i.item

	INNER JOIN [dbo].[BRS_Customer] c
	ON t.[SDSHAN_shipto] = c.ShipTo

WHERE
	(t.SalesDay ='2022-12-30') AND

	-- include full order
	EXISTS 
	(
		SELECT * 
		FROM [BRSales].[fg].[transaction_F5554240] s
		WHERE 
			(CalMonthRedeem = 202212 ) AND
--			(CalMonthRedeem = (SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) AND
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

