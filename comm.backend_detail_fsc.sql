
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: [comm].[backend_detail_fsc] 
**	Desc: commission detail recordset used by Access report front-end
**			(renamed from comm_statement_detail)
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
**	7 May 07	tmc	Added JDE source to details
** 22 Jan 08	tmc Added JDE shipto and JDE item to details
** 23 Jan 08    tmc	Fixed bug intruduced from 22 Jan 08 where imports were excluded
**					(due to inner join on item table instead of left join)
** 09 Sep 09	tmc	Added additional GP / ESS fields 
** 10 Feb 10	tmc Mapped commission Group to Item Commission Group for completeness
** 01 Mar 10	tmc	Add cost audit information to details
** 04 Jun 13	tmc	Optimized to use fiscal inner join rather than fiscal filter; 3m+ -> 1 sec.
--  30 Jan 16	tmc	Update for new comm codes
-- 03 Feb 16	tmc	Fixed wrong comm rate field 
-- 10 Feb 16	tmc	Removed legacy customer_comm_group_cd
-- 29 Sep 16	tmc	Add PO number to help ID conventions
--	7 Dec 17	tmc	Convert to new backend
*******************************************************************************/

ALTER VIEW [comm].[backend_detail_fsc]
AS
SELECT   
	t.record_id,

	t.salesperson_key_id, 
	t.source_cd,

	m.salesperson_nm, 
	t.salesperson_cd, 
	t.comm_plan_id,
	p.comm_plan_nm, 

	t.ess_salesperson_cd,
	t.ess_salesperson_key_id,

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
	t.item_comm_group_cd,

	g.comm_group_desc,

	t.item_id, 
	t.transaction_txt, 
-- 03 Feb 16	tmc	Fixed wrong comm rate field 
	t.item_comm_rt, 
--	t.comm_rt, 
	t.comm_amt, 

	t.transaction_amt, 
	t.gp_ext_amt,
	t.shipped_qty,

	t.manufact_cd,
	t.order_source_cd,
	t.item_label_cd,
	t.IMCLMJ,

-- 29 Sep 16	tmc	Add PO number to help ID conventions
	customer_po_num

FROM         
	[comm].[transaction_F555115] t

	INNER JOIN [comm].[salesperson_master] m
	ON t.salesperson_key_id = m.salesperson_key_id

	INNER JOIN [comm].[config] f
	ON t.fiscal_yearmo_num = f.current_fiscal_yearmo_num

	INNER JOIN [comm].[plan] p
	ON m.comm_plan_id = p.comm_plan_id

	-- TODO create comm view!
	INNER JOIN comm_batch_control c
	ON t.fiscal_yearmo_num = c.fiscal_yearmo_num

	INNER JOIN comm_group g
	ON t.item_comm_group_cd = g.comm_group_cd



WHERE     
	-- removed in place of joing optimize code 4 Jun 13, tmc

	t.source_cd in ('JDE', 'IMPORT') And
	g.show_ind = 1 AND

--	t.salesperson_key_id = 'ptario' And
	1=1
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM [comm_statement_detail] where item_comm_group_cd IN ('DIGCIM', 'DIGCCC')