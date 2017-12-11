
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: [comm].[backend_detail_isr]
**	Desc: map commission fields to better join to newer DS tables
**
**              
**
**	Auth: tmc
**	Date: 29 Nov 16
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
--	7 Dec 17	tmc	Convert to new backend
*******************************************************************************/

ALTER VIEW [comm].[backend_detail_isr]
AS
SELECT   
	t.ID							AS record_id,
	t.FiscalMonth					AS fiscal_yearmo_num, 

	t.fsc_salesperson_key_id		AS fsc_salesperson_key_id, 
	t.fsc_code						AS fsc_salesperson_cd, 
	t.ess_salesperson_key_id		AS ess_salesperson_key_id,
	t.WS$ESS_equipment_specialist_code	AS ess_salesperson_cd,
	t.[fsc_comm_group_cd]			AS fsc_item_comm_group_cd,
	t.[ess_comm_group_cd]			AS ess_item_comm_group_cd,

	t.source_cd						AS source_cd,

	t.fsc_comm_plan_id				AS comm_plan_id,


	t.WSDOCO_salesorder_number		AS doc_key_id, 
	t.[WSDCTO_order_type]			AS doc_type_cd,
	t.[WSLNID_line_number]			AS line_id, 
	t.WSDOCO_salesorder_number		AS doc_id, 
	0								AS order_id, 

	t.[WSDGL__gl_date]				AS transaction_dt, 

	t.[WSSHAN_shipto]				AS hsi_shipto_id, 
	cust.PracticeName				AS customer_nm, 
	t.[WSAC10_division_code]		AS hsi_shipto_div_cd,	


	t.[WSLITM_item_number]			AS item_id, 
	t.[WSDSC1_description]			AS transaction_txt, 
	i.[SalesCategory]				AS sales_category_cd,

	t.[transaction_amt]				AS transaction_amt, 
	t.[gp_ext_amt]					AS gp_ext_amt,
	t.[WSSOQS_quantity_shipped]		AS shipped_qty,

	t.[WSSRP6_manufacturer]			AS manufact_cd,
	t.[WS$OSC_order_source_code]	AS order_source_cd,
	t.[WSCYCL_cycle_count_category]	AS item_label_cd,
	t.[WSSRP1_major_product_class]	AS IMCLMJ,

	t.[WSVR01_reference]			AS customer_po_num

FROM         
	[comm].[transaction_F555115] t

	INNER JOIN [dbo].[BRS_Customer] cust
	ON t.[WSSHAN_shipto] = cust.ShipTo

	INNER JOIN [dbo].[BRS_Item] i
	ON t.[WSLITM_item_number] = i.Item

WHERE     
	t.FiscalMonth = (Select [PriorFiscalMonth] from [dbo].[BRS_Config]) AND
	t.source_cd in ('JDE', 'IMP') AND

--	t.salesperson_key_id = 'ptario' And
	1=1
GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 100 * FROM [comm].[backend_detail_isr]
