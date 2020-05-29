
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
-- ESS Legacy
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

	,t.item_comm_group_cd AS fsc_comm_group_cd
	,t.item_comm_rt AS fsc_comm_rt
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

	,i.comm_group_cd
	,i.note_txt

	,-1 AS fsc_calc_key
	,-1 AS ess_calc_key


FROM
	[CommBE].[dbo].comm_transaction AS t 
	INNER JOIN [CommBE].[dbo].comm_salesperson_code_map AS f 
	ON t.salesperson_cd = f.salesperson_cd 

	LEFT OUTER JOIN [CommBE].[dbo].[comm_item_master] AS i 
	ON t.item_id = i.[item_id]

WHERE
	(t.fiscal_yearmo_num = (SELECT [current_fiscal_yearmo_num] From [CommBE].[dbo].[comm_configure])) AND
--	(t.ess_salesperson_key_id <> '') AND 
--	(t.doc_id = 13147628) AND
--	(t.line_id = 1000) AND
	(1=1)

UNION ALL

-- ESS DEV
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

	,t.fsc_comm_group_cd
	,t.fsc_comm_rt
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

	,i.[comm_group_cd]
	,i.[comm_note_txt] 

	,t.fsc_calc_key
	,t.ess_calc_key

FROM
	comm.transaction_F555115 AS t 

	LEFT OUTER JOIN BRS_FSC_Rollup AS f 
	ON t.fsc_code = f.TerritoryCd 

	LEFT OUTER JOIN comm.plan_group_rate AS p 
	ON t.ess_calc_key = p.calc_key

	LEFT JOIN [dbo].[BRS_Item] i
	ON t.WSLITM_item_number = i.item

WHERE
	(t.FiscalMonth =(SELECT [PriorFiscalMonth] FROM [dbo].[BRS_Config])) AND
--	(t.ess_salesperson_key_id <> '') AND
--	(t.WSDOCO_salesorder_number = 13147628) AND
--	(t.WSLNID_line_number = 1000) AND
	(1=1)



GO



-- SELECT top 10 * FROM [comm].[test_detail] 
