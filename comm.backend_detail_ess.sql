
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
**    
*******************************************************************************/
ALTER VIEW [dbo].[comm_ess_statement_detail]
AS
SELECT     

  t.record_id, 

	t.ess_salesperson_key_id AS salesperson_key_id, 
	t.source_cd,

	m.salesperson_nm, 
	t.ess_salesperson_cd AS salesperson_cd, 
	t.ess_comm_plan_id AS comm_plan_id, 
	p.comm_plan_nm, 

	t.salesperson_key_id AS fsc_salesperson_key_id, 

	t.fiscal_yearmo_num, 
	c.fiscal_begin_dt, 
	c.fiscal_end_dt, 

	t.doc_key_id, 
	t.line_id, 
	t.doc_id, 
	t.order_id, 

	t.transaction_dt, 

	t.hsi_shipto_id, 
	t.customer_nm, 
-- 10 Feb 16	tmc	Removed legacy customer_comm_group_cd
--	t.customer_comm_group_cd,
	t.ess_comm_group_cd AS item_comm_group_cd, 

	g.comm_group_desc,

	t.item_id, 
	t.transaction_txt, 
	t.ess_comm_rt AS comm_rt, 
	t.ess_comm_amt AS comm_amt, 

	t.transaction_amt, 
	t.gp_ext_amt,
	t.shipped_qty,

	t.manufact_cd,
	t.order_source_cd,
	t.item_label_cd,
	t.IMCLMJ

FROM         

  dbo.comm_transaction AS t 

  INNER JOIN dbo.comm_salesperson_master AS m 
  ON t.ess_salesperson_key_id = m.salesperson_key_id 

  INNER JOIN dbo.comm_configure AS f 
  ON t.fiscal_yearmo_num = f.current_fiscal_yearmo_num 

  INNER JOIN dbo.comm_plan AS p 
  ON m.comm_plan_id = p.comm_plan_id 

  INNER JOIN dbo.comm_batch_control AS c 
  ON t.fiscal_yearmo_num = c.fiscal_yearmo_num 

  INNER JOIN dbo.comm_group AS g 
  ON t.ess_comm_group_cd = g.comm_group_cd 

-- 03 Feb 16	tmc		Add Plan-specific group hiding
  INNER JOIN dbo.comm_plan_group_rate AS pr 
  ON (t.ess_comm_plan_id = pr.comm_plan_id) AND 
	(t.ess_comm_group_cd = pr.comm_group_cd)

WHERE     

  (t.source_cd IN ('JDE', 'IMPORT')) AND 

-- 03 Feb 16	tmc		Add Plan-specific group hiding
--	(pr.show_ind = 1) AND

  (1 = 1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT * FROM comm_ess_statement_detail WHERE doc_id = '10290539'
