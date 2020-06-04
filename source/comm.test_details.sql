
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: [comm].[test_detail] 
**	Desc: 
**
**              
**
**	Auth: tmc
**	Date: 9 Aug 06
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
*******************************************************************************/

ALTER VIEW [comm].[test_detail]
AS
-- Legacy
SELECT
	-- PK
	t.record_id AS ID_legacy
	,- 1 AS ID
	,CAST(t.doc_id AS int) as doc_id
	,t.line_id

	,t.fiscal_yearmo_num
	,'PROD' AS src
	,LEFT(t.source_cd,3) AS source_cd

	,f.branch_cd
	,t.comm_plan_id AS fsc_comm_plan_id
	,t.salesperson_key_id AS fsc_salesperson_key_id

	,t.ess_salesperson_key_id
	,t.ess_comm_plan_id

	,t.order_source_cd
	,t.salesperson_cd AS fsc_code
	,t.ess_salesperson_cd AS ess_code
	,t.transaction_dt
	,t.item_id
	,-1 as doc_key_id

	,isnull(fsc_map.disp_comm_group_cd,'na_p') AS disp_fsc_comm_group_cd
	,t.item_comm_group_cd AS fsc_comm_group_cd
	,t.item_comm_rt AS fsc_comm_rt
	,ISNULL(ess_map.disp_comm_group_cd,'na_p') AS disp_ess_comm_group_cd
	,t.ess_comm_group_cd
	,t.ess_comm_rt
	,t.comm_amt AS fsc_comm_amt
	,t.ess_comm_amt

	,t.shipped_qty
	,t.transaction_amt
	,t.gp_ext_amt
	,t.transaction_txt
	,t.hsi_shipto_id
	,t.hsi_billto_id
	,t.hsi_shipto_div_cd
	,t.customer_nm
	,t.manufact_cd
	,t.IMCLMJ
	,t.pmts_salesperson_cd AS cps_code

	,-1 AS fsc_calc_key
	,-1 AS ess_calc_key

FROM
	[CommBE].[dbo].comm_transaction AS t 

	INNER JOIN [CommBE].[dbo].comm_salesperson_code_map AS f 
	ON t.salesperson_cd = f.salesperson_cd 

	LEFT JOIN [CommBE].[dbo].comm_plan_group_rate as fsc_map
	ON t.comm_plan_id = fsc_map.comm_plan_id AND
	t.item_comm_group_cd = fsc_map.comm_group_cd

	LEFT JOIN [CommBE].[dbo].comm_plan_group_rate as ess_map
	ON t.ess_comm_plan_id = ess_map.comm_plan_id AND
	t.ess_comm_group_cd = ess_map.comm_group_cd

WHERE
	(t.fiscal_yearmo_num >= '201901') AND
	(t.fiscal_yearmo_num <= (SELECT [current_fiscal_yearmo_num] From [CommBE].[dbo].[comm_configure])) AND
--	(t.ess_salesperson_key_id <> '') AND 
--	(t.doc_id = 13147628) AND
--	(t.line_id = 1000) AND
	(1=1)

UNION ALL

-- New
SELECT
	t.ID_legacy 
	,t.ID AS ID
	,t.WSDOC__document_number
	,t.WSLNID_line_number

	,t.FiscalMonth
	,'TEST' AS src
	,t.source_cd

	,f.Branch
	,t.fsc_comm_plan_id
	,t.fsc_salesperson_key_id

	,t.ess_salesperson_key_id
	,t.ess_comm_plan_id

	,t.WS$OSC_order_source_code
	,t.fsc_code
	,t.ess_code
	,t.WSDGL__gl_date
	,t.WSLITM_item_number
	,t.WSDOCO_salesorder_number

	,ISNULL(p_fsc.disp_comm_group_cd, 'na_t') AS disp_fsc_comm_group_cd
	,t.fsc_comm_group_cd
	,t.fsc_comm_rt
	,ISNULL(p_ess.disp_comm_group_cd, 'na_t') AS disp_ess_comm_group_cd
	,t.ess_comm_group_cd
	,t.ess_comm_rt

	,-t.fsc_comm_amt AS fsc_comm_amt_test
	,-t.ess_comm_amt AS ess_comm_amt_test
	,-t.WSSOQS_quantity_shipped AS quantity_shipped_test
	,-t.transaction_amt AS transaction_amt_test
	,-t.gp_ext_amt AS gp_ext_amt_test

	,t.WSDSC1_description
	,t.WSSHAN_shipto
	,t.WSAN8__billto
	,t.WSAC10_division_code
	,'NA' AS customer_name
	,t.WSSRP6_manufacturer
	,t.WSSRP1_major_product_class
	,t.cps_code

	,t.fsc_calc_key
	,t.ess_calc_key

FROM
	comm.transaction_F555115 AS t 

	LEFT OUTER JOIN BRS_FSC_Rollup AS f 
	ON t.fsc_code = f.TerritoryCd 

	LEFT OUTER JOIN comm.plan_group_rate AS p_fsc
	ON t.fsc_calc_key = p_fsc.calc_key

	LEFT OUTER JOIN comm.plan_group_rate AS p_ess
	ON t.ess_calc_key = p_ess.calc_key

WHERE
	(t.FiscalMonth >= 201901) AND
	(t.FiscalMonth <=(SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) AND
--	(t.ess_salesperson_key_id <> '') AND
--	(t.WSDOCO_salesorder_number = 13147628) AND
--	(t.WSLNID_line_number = 1000) AND
	(1=1)



GO



-- SELECT  * FROM [comm].[test_detail] where ID_legacy = 59153980 
