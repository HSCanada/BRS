
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_transaction_ts
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
--	12 Apr 17	tmc		Added ess_comm group for DSS role, removed fiscal filter
-- 
*******************************************************************************/

ALTER VIEW [dbo].[comm_transaction_ts]
AS
SELECT     
	record_id 

	,fiscal_yearmo_num
	,CAST (fiscal_yearmo_num AS int) as FiscalMonth

	,salesperson_key_id
	,ess_salesperson_cd
	,ess_salesperson_key_id
	,order_source_cd
	,reference_order_txt
	,doc_id
	,CASE WHEN ISNUMERIC(doc_id)=1 THEN CAST(doc_id AS int) ELSE 0 END as SalesOrderNumber
	,item_id
	,transaction_txt

	,item_comm_group_cd
	,ess_comm_group_cd
	,shipped_qty
	,transaction_amt
	,gp_ext_amt

	,transaction_dt

	,source_cd 
	,doc_key_id
	,line_id

	,salesperson_cd
	,customer_nm
	,comm_plan_id

	,doc_type_cd
	,hsi_shipto_id
	,hsi_shipto_div_cd
	,manufact_cd
	,sales_category_cd
	,customer_po_num
	,IMCLMJ

FROM         
	comm_transaction AS t

WHERE     
	t.source_cd IN('JDE', 'IMPORT') AND
--	t.source_cd = 'JDE' AND

--	t.fiscal_yearmo_num = (SELECT current_fiscal_yearmo_num FROM comm_configure) AND
--	t.salesperson_key_id = 'ptario' And
	fiscal_yearmo_num >= 201701 AND
	1=1
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 100 * FROM [comm_transaction_ts]
