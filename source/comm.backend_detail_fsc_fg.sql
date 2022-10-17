
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: [comm].[backend_detail_fsc_fg] 
**	Desc: commission free goods detail recordset used by Access report front-end
**			(based on [comm].[backend_detail_fsc_fg])
**
**              
**
**	Auth: tmc
**	Date: 30 Sep 22
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
*******************************************************************************/

ALTER VIEW [comm].[backend_detail_fsc_fg]
AS
SELECT   
	t.FiscalMonth
	,t.fsc_salesperson_key_id		AS salesperson_key_id
	,t.[ShipTo]
	,t.salesorder_num
	,t.item_id
	,t.[fsc_comm_group_cd]

	,MIN(m.salesperson_nm)			AS salesperson_nm
	,MIN(t.fsc_code)				AS salesperson_cd
	,MIN(m.comm_plan_id)			AS comm_plan_id
	,MIN(p.comm_plan_nm)			AS comm_plan_nm
	,MIN(m2.[master_salesperson_cd])	AS ess_salesperson_cd
--	t.ess_salesperson_key_id		AS ess_salesperson_key_id,
	,MIN(c.BeginDt)					AS fiscal_begin_dt
	,MIN(c.EndDt)					AS fiscal_end_dt
	,MIN(t.order_type)				AS doc_type
	,MIN(t.transaction_date)		AS transaction_dt
	,MIN(t.customer_name)			AS customer_nm
	,MIN(g.comm_group_desc)			AS comm_group_desc
	,MIN(t.details)					AS transaction_txt
	,MIN(t.item_label_cd)			AS item_label_cd
	,MIN(t.[Supplier])				AS [Supplier]
	,'IMP' 							AS source_cd
--	NULL							AS IMCLMJ,

	-- EST is OUT, ACT is IN 
	,SUM(CASE WHEN t.adj_type_code = 'ACT' THEN 0 ELSE t.[gp_ext_amt] END)	AS gp_ext_amt_out
	,SUM(CASE WHEN t.adj_type_code = 'ACT' THEN t.[gp_ext_amt] ELSE 0 END)	AS gp_ext_amt_in
	,SUM(CASE WHEN t.adj_type_code = 'ACT' THEN 0 ELSE t.[fg_quantity] END)	AS shipped_qty_out
	,SUM(CASE WHEN t.adj_type_code = 'ACT' THEN t.[fg_quantity] ELSE 0 END)	AS shipped_qty_in


FROM         
	[comm].[freegoods_export] t

	INNER JOIN [comm].[salesperson_master] m
	ON t.fsc_salesperson_key_id = m.salesperson_key_id

	INNER JOIN [comm].[salesperson_master] m2
	ON t.ess_salesperson_key_id = m2.salesperson_key_id

	INNER JOIN [comm].[plan] p
	ON m.comm_plan_id = p.comm_plan_id

	INNER JOIN [dbo].[BRS_FiscalMonth]  c
	ON t.[FiscalMonth] = c.[FiscalMonth]


	INNER JOIN [comm].[group] g
	ON g.comm_group_cd = t.[fsc_comm_group_cd]

/*

	INNER JOIN [comm].[plan_group_rate] AS pr 
	ON (t.fsc_calc_key = pr.calc_key)

	LEFT JOIN [dbo].[BRS_Customer] cust
	ON t.WSSHAN_shipto = cust.ShipTo
*/

WHERE     
	t.FiscalMonth = (Select [PriorFiscalMonth] from [dbo].[BRS_Config]) AND
--	t.source_cd in ('JDE', 'IMP') AND
	-- the free goods exception is to allow two reports from the same source
--	((pr.show_ind = 1) OR pr.disp_comm_group_cd in('FRESEQ', 'FRESND', 'SPMFGE', 'SPMFGS')) AND
	-- test
	-- t.ID = 8211296 AND
	1=1
GROUP BY
t.FiscalMonth
,t.fsc_salesperson_key_id
,t.[ShipTo]
,t.salesorder_num
,t.item_id
,t.[fsc_comm_group_cd]

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM [comm].[backend_detail_fsc_fg]

-- SELECT  * FROM [comm].[backend_detail_fsc_fg]

--SELECT * FROM [comm].[backend_detail_fsc] where ess_salesperson_cd <>  ess_salesperson_cd_new

--SELECT top 10 * FROM [comm].[backend_detail_fsc] where salesperson_key_id = 'ESS32'
--SELECT top 10 * FROM [comm].[backend_detail_fsc] where ess_salesperson_cd = 'ESS47'

-- ORG 3868

--SELECT * FROM [comm].[backend_detail_fsc] where salesperson_key_id = 'JACK.FREEBORN'

