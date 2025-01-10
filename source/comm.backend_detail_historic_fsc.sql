
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: [comm].[backend_detail_historic] 
**	Desc: commission detail history, based on [comm].[backend_detail_fsc
**		fields mirror the excel details
**
**		*** To Do ***                
**		add ESS, ISR, etc...
**
**	Auth: tmc
**	Date: 10 Jan 25
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
*******************************************************************************/

ALTER VIEW [comm].[backend_detail_historic]
AS
SELECT   
	t.ID							AS record_id,

	t.fsc_salesperson_key_id		AS salesperson_key_id, 
	t.source_cd						AS source_cd,

	m.salesperson_nm				AS salesperson_nm, 
	t.fsc_code						AS salesperson_cd, 
	t.fsc_comm_plan_id				AS comm_plan_id,
	p.comm_plan_nm, 

	m2.[master_salesperson_cd]		AS ess_salesperson_cd,
--	t.ess_code						AS ess_salesperson_cd,

	t.ess_salesperson_key_id		AS ess_salesperson_key_id,

	t.FiscalMonth					AS fiscal_yearmo_num, 
	c.BeginDt						AS fiscal_begin_dt, 
	c.EndDt							AS fiscal_end_dt, 

	t.WSDOCO_salesorder_number		AS doc_key_id, 
	t.WSDCTO_order_type				AS doc_type,
	t.[WSLNID_line_number]			AS line_id, 
	t.WSDOCO_salesorder_number		AS doc_id, 
	t.[WSDOC__document_number]		AS order_id, 

	t.[WSDGL__gl_date]				AS transaction_dt, 

	t.[WSSHAN_shipto]				AS hsi_shipto_id, 
	LEFT(ISNULL(cust.PracticeName, t.[WSVR02_reference_2]),25)	AS customer_nm, 
	pr.disp_comm_group_cd			AS item_comm_group_cd,

	g.comm_group_desc,

	t.[WSLITM_item_number]			AS item_id, 
	t.[WSDSC1_description]			AS transaction_txt, 
	t.[fsc_comm_rt]					AS item_comm_rt, 
	t.[fsc_comm_amt]				AS comm_amt, 

	t.[transaction_amt]				AS transaction_amt, 
	t.[gp_ext_amt]					AS gp_ext_amt,
	t.[WSSOQS_quantity_shipped]		AS shipped_qty,

	t.[WSSRP6_manufacturer]			AS manufact_cd,
	t.[WS$OSC_order_source_code]	AS order_source_cd,
	t.[WSCYCL_cycle_count_category]	AS item_label_cd,
	t.[WSSRP1_major_product_class]	AS IMCLMJ,

	t.[WSVR01_reference]			AS customer_po_num,
	t.[cust_comm_group_cd]			AS SPM_StatusCd,
	t.ID_legacy
	,pr.show_ind					AS show_ind

	,gp_ext_amt / nullif(transaction_amt,0) gm_rt
	,pr.[comm_gm_threshold_ind]
	,pr.[disp_comm_group_cd]
	,pr.[comm_gm_threshold_cd]
	,ISNULL(pr.[comm_gm_threshold_descr],'') as comm_gm_threshold_descr
	,t.fsc_calc_key


FROM         
	[comm].[transaction_F555115] t

	INNER JOIN [comm].[salesperson_master] m
	ON t.fsc_salesperson_key_id = m.salesperson_key_id

	INNER JOIN [comm].[salesperson_master] m2
	ON t.ess_salesperson_key_id = m2.salesperson_key_id

	INNER JOIN [comm].[plan] p
	ON m.comm_plan_id = p.comm_plan_id

	INNER JOIN [dbo].[BRS_FiscalMonth]  c
	ON t.[FiscalMonth] = c.[FiscalMonth]

	INNER JOIN [comm].[plan_group_rate] AS pr 
	ON (t.fsc_calc_key = pr.calc_key)

	INNER JOIN [comm].[group] g
	ON g.comm_group_cd = pr.disp_comm_group_cd

	LEFT JOIN [dbo].[BRS_Customer] cust
	ON t.WSSHAN_shipto = cust.ShipTo

WHERE     
--	t.FiscalMonth = (Select [PriorFiscalMonth] from [dbo].[BRS_Config]) AND
--	t.FiscalMonth >= 20301 and
	t.source_cd in ('JDE', 'IMP') AND
--	-- the free goods exception is to allow two reports from the same source
--	((pr.show_ind = 1) OR pr.disp_comm_group_cd in('FRESEQ', 'FRESND', 'SPMFGE', 'SPMFGS')) AND
	(pr.show_ind = 1)  AND
	-- test
	-- t.ID = 8211296 AND
	1=1
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM [comm].[backend_detail_historic] where fiscal_yearmo_num = 202312
-- SELECT count(*) FROM [comm].[backend_detail_historic]

