SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [ds].backorder_current
AS

/******************************************************************************
**	File: 
**	Name: [Fact].Sales_gep
**	Desc: Telesales Sales pull  
**
**              
**	Return values:  
**
**	Called by:   
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**	@bDebug
**
**	Auth: tmc
**	Date: 11 Oct 25
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT 

	-- test
--	top 10
	--

	[SalesDay] as capture_day

	,[SDDOCO_salesorder_number]
	,[SDDCTO_order_type]
	,[SDLNID_line_number]


	,[SDDOC__document_number]
	,[SDSHAN_shipto]
	,[SDLITM_item_number]
	,[QN$SPC_supplier_code]
	,[QCTRDJ_order_date]
	,[SDUPRC_unit_price]
	,[SDSOBK_quantity_backordered]

	-- test
	,ISNULL(dw.ShippedQty, 0) AS ShippedQty
	,CASE WHEN [SDSOBK_quantity_backordered] = dw.ShippedQty THEN 1 ELSE 0 END as backorder_shipped_ind 
	--


	, [SDUPRC_unit_price] * [SDSOBK_quantity_backordered] AS ext_backorder_amt 
	,[SDUORG_quantity]
	,[IMBUYR_buyer_number]
	,[SDDSC1_description]
	,[QV$PRI_pricing_info]
	,[QV$AVC_availability_code]
	,[QV$CLC_classification_code]
	,[SDSHAN01_mailing_name]
	,[GIADDZ_postal_code]
	,[GICTY1_city]
	,[GIADDS_state]
	,[GICTR__country]
	,[QCAC10_division_code]
	,[SDLNTY_line_type]
	,[IMLNTY_line_type]
	,[SDMCU__business_unit]
	,[SDVR01_reference]
	,[SDVR02_reference_2]
	,[QCENTB_entered_by]
	,[SDRSDJ_promised_delivery]
	,[SDNXTR_status_code_next]
	,s.[ID] AS ID_bo_ref
	,dw.ID  AS ID_dw_ref
FROM 
	[fg].[backorder_FBACKRPT1_history] s

	LEFT JOIN [dbo].[BRS_TransactionDW] dw
	ON dw.SalesOrderNumber = s.SDDOCO_salesorder_number AND
	dw.DocType = s.SDDCTO_order_type AND
	dw.LineNumber = s.SDLNID_line_number AND
	-- add item, customer test for guardrails (should not be needed)
	dw.Item = s.SDLITM_item_number AND
	dw.[Shipto] = s.[SDSHAN_shipto]

where 
	-- last loaded
	([SalesDay] = (SELECT max([SalesDay]) from [fg].[backorder_FBACKRPT1_history])) AND
	-- remove credits
	([SDSOBK_quantity_backordered] >0) and 
	-- remove internal sales
	(QCAC10_division_code not in ('AZA', 'AZE')) AND
	-- remove free goods
	([SDUPRC_unit_price] <> 0) AND

	--test
	-- (dw.ShippedQty is null) AND
	--	[SDSOBK_quantity_backordered] <> dw.ShippedQty AND
	--
	(1=1)

 

GO

--	Select FiscalMonth, PriorFiscalMonth, FirstFiscalMonth_LY, SalesDateLastWeekly FROM BRS_TS_Config g

/*
SELECT top 10 * from [ds].backorder_current
SELECT count (*) from [ds].backorder_current
-- ORG 10 024

SELECT * from [ds].backorder_current where [SDLITM_item_number] = '9405063'

*/

