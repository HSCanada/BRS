
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_ess_statement_export
**	Desc: commission summary recordset used by Access report front-end
**
**              
**
**	Auth: tmc
**	Date: 02 Mar 08
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-------	-------		-------------------------------------------
**	27 Jan 10	tmc		Updated for Comm 2010
**	26 Mar 10	tmc		Added 5 generic bonus fields
**	02 Dec 10	tmc		Trim SalespersonID and BranchNM
**  01 Mar 11	tmc		Added Free Goods and BIO Biolase Focus
**	01 Feb 13	tmc		Set Free Goods to Current month instead of arrears
**  01 Apr 13	tmc		Add ESS commission plan (to filter out retired plans
**	25 Apr 14	tmc		Replace ITMCNX with ITMMID 
--  29 Jan 16	tmc		Update for new comm codes
--	02 Feb 16	tmc		Added Zone, Branch fields back, ensure key codes trimmed
--	02 Aug 16	tmc		Added GP YTD LYTD
-- 05 Nov 17	tmc		Breakout DIGCCC+DIGCIM -> DIGCCC for Cerec

**    
*******************************************************************************/
ALTER VIEW [dbo].[comm_ess_statement_export]
AS
SELECT     

	m.employee_num,
	RTRIM(m.salesperson_key_id) AS ESS_key_id,
	m.salesperson_nm AS ESS_nm,

	RTRIM(b.branch_nm) AS branch_nm,
	RTRIM(b.zone_cd) AS zone_nm,

	m.master_salesperson_cd AS ESS_code,
	m.territory_start_dt AS start_dt,

	s.ITMFO1_SALES_CM_AMT,
	s.ITMFO1_SALES_LYM_AMT,
	s.ITMFO1_GP_CM_AMT,
	s.ITMFO1_SALES_YTD_AMT,
	s.ITMFO1_GP_YTD_AMT,
	s.ITMFO1_SALES_LYTD_AMT,
	m.ITMFO1_GOAL_YTD_AMT,

	s.ITMFO2_SALES_CM_AMT,
	s.ITMFO2_SALES_LYM_AMT,
	s.ITMFO2_GP_CM_AMT,
	s.ITMFO2_SALES_YTD_AMT,
	s.ITMFO2_GP_YTD_AMT,
	s.ITMFO2_SALES_LYTD_AMT,
	m.ITMFO2_GOAL_YTD_AMT,

	s.ITMFO3_SALES_CM_AMT,
	s.ITMFO3_SALES_LYM_AMT,
	s.ITMFO3_GP_CM_AMT,
	s.ITMFO3_SALES_YTD_AMT,
	s.ITMFO3_GP_YTD_AMT,
	s.ITMFO3_SALES_LYTD_AMT,
	m.ITMFO3_GOAL_YTD_AMT,

	s.ITMFRT_SALES_CM_AMT,
	s.ITMFRT_SALES_LYM_AMT,
	s.ITMFRT_GP_CM_AMT,
	s.ITMFRT_SALES_YTD_AMT,
	s.ITMFRT_GP_YTD_AMT,
	s.ITMFRT_SALES_LYTD_AMT,
	m.ITMFRT_GOAL_YTD_AMT,

	s.DIGIMP_SALES_CM_AMT,
	s.DIGIMP_SALES_LYM_AMT,
	s.DIGIMP_GP_CM_AMT,
	s.DIGIMP_SALES_YTD_AMT,
	s.DIGIMP_GP_YTD_AMT,
	s.DIGIMP_SALES_LYTD_AMT,
	0 AS DIGIMP_GOAL_YTD_AMT,

	s.DIGMAT_SALES_CM_AMT,
	s.DIGMAT_SALES_LYM_AMT,
	s.DIGMAT_GP_CM_AMT,
	s.DIGMAT_SALES_YTD_AMT,
	s.DIGMAT_GP_YTD_AMT,
	s.DIGMAT_SALES_LYTD_AMT,
	0 AS DIGMAT_GOAL_YTD_AMT,

	s.ITMISC_SALES_CM_AMT,
	s.ITMISC_SALES_LYM_AMT,
	s.ITMISC_GP_CM_AMT,
	s.ITMISC_SALES_YTD_AMT,
	s.ITMISC_GP_YTD_AMT,
	s.ITMISC_SALES_LYTD_AMT,
	m.ITMISC_GOAL_YTD_AMT,

	s.DIGCCS_SALES_CM_AMT,
	s.DIGCCS_SALES_LYM_AMT,
	s.DIGCCS_GP_CM_AMT,
	s.DIGCCS_SALES_YTD_AMT,
	s.DIGCCS_GP_YTD_AMT,
	s.DIGCCS_SALES_LYTD_AMT,
	0 AS DIGCCS_GOAL_YTD_AMT,

	s.ITMCPU_SALES_CM_AMT,
	s.ITMCPU_SALES_LYM_AMT,
	s.ITMCPU_GP_CM_AMT,
	s.ITMCPU_SALES_YTD_AMT,
	s.ITMCPU_GP_YTD_AMT,
	s.ITMCPU_SALES_LYTD_AMT,
	m.ITMCPU_GOAL_YTD_AMT,

	s.ITMSOF_SALES_CM_AMT,
	s.ITMSOF_SALES_LYM_AMT,
	s.ITMSOF_GP_CM_AMT,
	s.ITMSOF_COMM_CM_AMT,
	s.ITMSOF_SALES_YTD_AMT,
	s.ITMSOF_GP_YTD_AMT,
	s.ITMSOF_SALES_LYTD_AMT,
	0 AS ITMSOF_GOAL_YTD_AMT,

	s.SFFFIN_SALES_CM_AMT,
	s.SFFFIN_SALES_LYM_AMT,
	s.SFFFIN_GP_CM_AMT,
	s.SFFFIN_SALES_YTD_AMT,
	s.SFFFIN_GP_YTD_AMT,
	s.SFFFIN_SALES_LYTD_AMT,
	0 AS SFFFIN_GOAL_YTD_AMT,

	s.FRESEQ_GP_CM_AMT,
	s.FRESEQ_COMM_CM_AMT,
	s.FRESEQ_GP_YTD_AMT,

	m.comm_plan_id as ESS_comm_plan_id,
	RTRIM(m.branch_cd) AS branch_cd,

--	02 Aug 16	tmc		Added GP YTD LYTD
    ITMFO1_GP_LYM_AMT, 
    ITMFO1_GP_LYTD_AMT, 

    ITMFO2_GP_LYM_AMT, 
    ITMFO2_GP_LYTD_AMT, 

    ITMFO3_GP_LYM_AMT, 
    ITMFO3_GP_LYTD_AMT, 

    ITMFRT_GP_LYM_AMT, 
    ITMFRT_GP_LYTD_AMT, 

    DIGIMP_GP_LYM_AMT, 
    DIGIMP_GP_LYTD_AMT, 

    ITMISC_GP_LYM_AMT, 
    ITMISC_GP_LYTD_AMT, 

    DIGCCS_GP_LYM_AMT, 
    DIGCCS_GP_LYTD_AMT, 

    DIGMAT_GP_LYM_AMT, 
    DIGMAT_GP_LYTD_AMT, 

    ITMCPU_GP_LYM_AMT, 
    ITMCPU_GP_LYTD_AMT, 

    ITMSOF_GP_LYM_AMT, 
    ITMSOF_GP_LYTD_AMT, 

    SFFFIN_GP_LYM_AMT, 
    SFFFIN_GP_LYTD_AMT, 

    FRESEQ_GP_LYM_AMT, 
    FRESEQ_GP_LYTD_AMT,
--
    DIGCCC_SALES_CM_AMT, 
    DIGCCC_SALES_LYM_AMT, 
    DIGCCC_GP_CM_AMT, 
    DIGCCC_COMM_CM_AMT, 
    DIGCCC_SALES_YTD_AMT, 
    DIGCCC_GP_YTD_AMT, 
    DIGCCC_SALES_LYTD_AMT,
    DIGCCC_GP_LYM_AMT, 
    DIGCCC_GP_LYTD_AMT


FROM 
(

  SELECT     

    salesperson_key_id, 

    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMFO1_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMFO1_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMFO1_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMFO1_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO1_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMFO1_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMFO1_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMFO1_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMFO1_GP_LYTD_AMT, 


    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_curr_amt ELSE 0 END) AS ITMFO2_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ref_amt ELSE 0 END) AS ITMFO2_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_curr_amt ELSE 0 END) AS ITMFO2_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.comm_curr_amt ELSE 0 END) AS ITMFO2_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO2_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMFO2_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMFO2_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMFO2_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMFO2_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_curr_amt ELSE 0 END) AS ITMFO3_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ref_amt ELSE 0 END) AS ITMFO3_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_curr_amt ELSE 0 END) AS ITMFO3_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.comm_curr_amt ELSE 0 END) AS ITMFO3_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO3_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMFO3_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMFO3_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMFO3_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMFO3_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_curr_amt ELSE 0 END) AS ITMFRT_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ref_amt ELSE 0 END) AS ITMFRT_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_curr_amt ELSE 0 END) AS ITMFRT_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.comm_curr_amt ELSE 0 END) AS ITMFRT_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFRT_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMFRT_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMFRT_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMFRT_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMFRT_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.sales_curr_amt ELSE 0 END) AS					DIGIMP_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.sales_ref_amt ELSE 0 END) AS						DIGIMP_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.gp_curr_amt ELSE 0 END) AS						DIGIMP_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.comm_curr_amt ELSE 0 END) AS						DIGIMP_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS DIGIMP_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		DIGIMP_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	DIGIMP_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.gp_ref_amt ELSE 0 END) AS						DIGIMP_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGIMP' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			DIGIMP_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_curr_amt ELSE 0 END) AS ITMISC_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ref_amt ELSE 0 END) AS ITMISC_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_curr_amt ELSE 0 END) AS ITMISC_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.comm_curr_amt ELSE 0 END) AS ITMISC_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMISC_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMISC_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMISC_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMISC_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMISC_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.sales_curr_amt ELSE 0 END) AS DIGCCS_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.sales_ref_amt ELSE 0 END) AS DIGCCS_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.gp_curr_amt ELSE 0 END) AS DIGCCS_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.comm_curr_amt ELSE 0 END) AS DIGCCS_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS DIGCCS_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS DIGCCS_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS DIGCCS_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.gp_ref_amt ELSE 0 END) AS						DIGCCS_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGCCS' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			DIGCCS_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.sales_curr_amt ELSE 0 END) AS					DIGMAT_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.sales_ref_amt ELSE 0 END) AS						DIGMAT_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.gp_curr_amt ELSE 0 END) AS						DIGMAT_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.comm_curr_amt ELSE 0 END) AS						DIGMAT_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS DIGMAT_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		DIGMAT_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	DIGMAT_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.gp_ref_amt ELSE 0 END) AS						DIGMAT_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			DIGMAT_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_curr_amt ELSE 0 END) AS ITMCPU_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ref_amt ELSE 0 END) AS ITMCPU_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_curr_amt ELSE 0 END) AS ITMCPU_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.comm_curr_amt ELSE 0 END) AS ITMCPU_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMCPU_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMCPU_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMCPU_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMCPU_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMCPU_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_curr_amt ELSE 0 END) AS ITMSOF_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ref_amt ELSE 0 END) AS ITMSOF_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_curr_amt ELSE 0 END) AS ITMSOF_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.comm_curr_amt ELSE 0 END) AS ITMSOF_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMSOF_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS ITMSOF_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS ITMSOF_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMSOF_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMSOF_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_curr_amt ELSE 0 END) AS SFFFIN_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ref_amt ELSE 0 END) AS SFFFIN_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_curr_amt ELSE 0 END) AS SFFFIN_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.comm_curr_amt ELSE 0 END) AS SFFFIN_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS SFFFIN_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS SFFFIN_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS SFFFIN_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_ref_amt ELSE 0 END) AS						SFFFIN_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			SFFFIN_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_curr_amt ELSE 0 END) AS						FRESEQ_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.comm_curr_amt ELSE 0 END) AS						FRESEQ_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		FRESEQ_GP_YTD_AMT,

    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_ref_amt ELSE 0 END) AS						FRESEQ_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			FRESEQ_GP_LYTD_AMT,

	---
	--	(comm_group_cd IN ('DIGCCC', 'DIGCIM')) AND
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.sales_curr_amt ELSE 0 END)						AS DIGCCC_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.sales_ref_amt ELSE 0 END)						AS DIGCCC_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.gp_curr_amt ELSE 0 END)							AS DIGCCC_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.comm_curr_amt ELSE 0 END)						AS DIGCCC_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END)	AS DIGCCC_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END)			AS DIGCCC_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END)		AS DIGCCC_SALES_LYTD_AMT,
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.gp_ref_amt ELSE 0 END)							AS DIGCCC_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGCCC', 'DIGCIM') THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END)			AS DIGCCC_GP_LYTD_AMT

  FROM          

    dbo.comm_summary AS ss
  WHERE      
    (comm_group_cd <> '') AND 
    (salesperson_key_id <> '') AND
-- Testing
--	(comm_group_cd IN ('DIGCCC', 'DIGCIM')) AND
	(1=1)

  GROUP BY 
    salesperson_key_id

) AS s 

  INNER JOIN dbo.comm_salesperson_master AS m 
  ON s.salesperson_key_id = m.salesperson_key_id 

--	02 Feb 16	tmc		Added Zone, Branch fields back, ensure key codes trimmed
  INNER JOIN dbo.comm_branch AS b
  ON m.branch_cd = b.branch_cd 


WHERE     
	((m.comm_plan_id LIKE 'ESS%') OR (m.comm_plan_id LIKE 'CCS%')) AND
	(1=1)


GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- SELECT top 10 * FROM [comm_ess_statement_export] order by 1