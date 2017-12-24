
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_ess_statement_detail
**	Desc: commission detail recordset used by Access report front-end
**
**              
**
**	Auth: tmc
**	Date: 4 Mar 08
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	26 mar 08	tmc		fixed field so ess_comm is showing, not FSC comm
**	09 Sep 09	tmc		Added additional GP / ESS fields 
**	02 Feb 10	tmc		Make consistent with comm_statement_detail for 2010 Comm Statement
**	01 Mar 10	tmc		Add cost audit information to details
**  14 Jan 11	tmc		Bug fix where post adjustments are not being included in details
**	23 Sep 13	tmc		Remove CUSINS,ITMARS,ITMTEE from Details 
--  30 Jan 16	tmc		Update for new comm codes
-- 03 Feb 16	tmc		Add Plan-specific group hiding
-- 10 Feb 16	tmc	Removed legacy customer_comm_group_cd
--	7 Dec 17	tmc	Convert to new backend
*******************************************************************************/

ALTER VIEW [comm].[backend_detail_ess]
AS
SELECT   
	t.ID							AS record_id,

	t.ess_salesperson_key_id		AS salesperson_key_id, 
	t.source_cd						AS source_cd,

	m.salesperson_nm				AS salesperson_nm, 
	t.WS$ESS_equipment_specialist_code	AS salesperson_cd, 
	t.ess_comm_plan_id				AS comm_plan_id,
	p.comm_plan_nm, 

	t.fsc_code						AS fsc_salesperson_cd,
	t.fsc_salesperson_key_id		AS fsc_salesperson_key_id,

	t.FiscalMonth					AS fiscal_yearmo_num, 
	c.BeginDt						AS fiscal_begin_dt, 
	c.EndDt							AS fiscal_end_dt, 

	t.WSDOCO_salesorder_number		AS doc_key_id, 
	t.[WSLNID_line_number]			AS line_id, 
	t.WSDOCO_salesorder_number		AS doc_id, 
	0								AS order_id, 

	t.[WSDGL__gl_date]				AS transaction_dt, 

	t.[WSSHAN_shipto]				AS hsi_shipto_id, 
	cust.PracticeName				AS customer_nm, 
	t.[ess_comm_group_cd]			AS item_comm_group_cd,

	g.comm_group_desc,

	t.[WSLITM_item_number]			AS item_id, 
	t.[WSDSC1_description]			AS transaction_txt, 
	t.[ess_comm_rt]					AS item_comm_rt, 
	t.[ess_comm_amt]				AS comm_amt, 

	t.[transaction_amt]				AS transaction_amt, 
	t.[gp_ext_amt]					AS gp_ext_amt,
	t.[WSSOQS_quantity_shipped]		AS shipped_qty,

	t.[WSSRP6_manufacturer]			AS manufact_cd,
	t.[WS$OSC_order_source_code]	AS order_source_cd,
	t.[WSCYCL_cycle_count_category]	AS item_label_cd,
	t.[WSSRP1_major_product_class]	AS IMCLMJ,

	t.[WSVR01_reference]			AS customer_po_num,
	cust.comm_status_cd				AS SPM_StatusCd

FROM         
	[comm].[transaction_F555115] t

	INNER JOIN [comm].[salesperson_master] m
	ON t.ess_salesperson_key_id = m.salesperson_key_id

	INNER JOIN [comm].[plan] p
	ON m.comm_plan_id = p.comm_plan_id

	INNER JOIN [dbo].[BRS_FiscalMonth]  c
	ON t.[FiscalMonth] = c.[FiscalMonth]

	INNER JOIN [comm].[group] g
	ON t.ess_comm_group_cd = g.comm_group_cd

	INNER JOIN [dbo].[BRS_Customer] cust
	ON t.[WSSHAN_shipto] = cust.ShipTo

WHERE     
	t.FiscalMonth = (Select [PriorFiscalMonth] from [dbo].[BRS_Config]) AND
	t.source_cd in ('JDE', 'IMP') AND
	t.ess_salesperson_key_id <> '' And
	g.show_ind = 1 AND
	1=1
GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM [comm].[backend_detail_ess] 
