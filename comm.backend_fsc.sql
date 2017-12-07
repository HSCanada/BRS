
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: 
**	Name: comm_statement_export
**	Desc: commission summary recordset used by Access report front-end
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
**	11 Mar 07	tmc		Added LY * LYTD to show growth
**	28 Mar 07	tmc		Added extra fields to export
**  11 Sept 07	tmc		Added FSC Goals to DB backend
**  12 Sept 07  tmc		Added GP
**	19 Feb 08	tmc		Added YTD GP
**  07 Jul 09	tmc		Added Camlog fields to export
**  28 Oct 09	tmc		Added Free Goods to export
**	27 Jan 10	tmc		Updated for Comm 2010
**	02 Feb 10	tmc		Added FRE3RS group
**	11 Mar 10	tmc		Set Sundry and Small EQ free goods to read Curr Month as last month
**	02 Dec 10	tmc		Trim SalespersonID and BranchNM
**	28 Mar 11	tmc		Added Arestin Group to INST rollup
**	01 Feb 13	tmc		Set Free Goods to use Current Month instead of in Arrears
**  25 Apr 14	tmc		replaces CNX with MID comm code in summary
--  29 Jan 16	tmc		Update for new comm codes
--	02 Feb 16	tmc		Added Zone, Branch fields back, ensure key codes trimmed
-- 04 Feb 16	tmc		Fixed DIGMAT field map bug
-- 03 May 16	tmc		Added new Special Market Free Goods fields and GP YTD LYTD
-- 05 Nov 17	tmc		Merge DIGCCC -> DIGCCS, DIGCIM -> DIGIMP for Cerec
**    
*******************************************************************************/
ALTER VIEW [dbo].[comm_statement_export]
AS
SELECT 

  m.employee_num,
  RTRIM(m.salesperson_key_id) AS salesperson_key_id,
  m.salesperson_nm,
  RTRIM(m.branch_cd) as branch_cd,
  RTRIM(b.branch_nm) AS branch_nm,
  RTRIM(b.zone_cd) AS zone_nm,
  RTRIM(m.comm_plan_id) AS comm_plan_id,
  RTRIM(m.master_salesperson_cd) as hsi_salesperson_cd,
  m.territory_start_dt,

  s.ITMSND_SALES_CM_AMT,
  s.ITMSND_SALES_LYM_AMT,
  s.ITMSND_GP_CM_AMT,
  s.ITMSND_COMM_CM_AMT,
  s.ITMSND_SALES_YTD_AMT,
  s.ITMSND_GP_YTD_AMT,
  s.ITMSND_SALES_LYTD_AMT,
  m.ITMSND_GOAL_YTD_AMT,

  s.REBSND_SALES_CM_AMT,
  s.REBSND_SALES_LYM_AMT,
  s.REBSND_GP_CM_AMT,
  s.REBSND_COMM_CM_AMT,
  s.REBSND_SALES_YTD_AMT,
  s.REBSND_GP_YTD_AMT,
  s.REBSND_SALES_LYTD_AMT,

  s.SPMSND_SALES_CM_AMT,
  s.SPMSND_SALES_LYM_AMT,
  s.SPMSND_GP_CM_AMT,
  s.SPMSND_COMM_CM_AMT,
  s.SPMSND_SALES_YTD_AMT,
  s.SPMSND_GP_YTD_AMT,
  s.SPMSND_SALES_LYTD_AMT,

  s.ITMTEE_SALES_CM_AMT,
  s.ITMTEE_SALES_LYM_AMT,
  s.ITMTEE_GP_CM_AMT,
  s.ITMTEE_COMM_CM_AMT,
  s.ITMTEE_SALES_YTD_AMT,
  s.ITMTEE_GP_YTD_AMT,
  s.ITMTEE_SALES_LYTD_AMT,
  m.ITMTEE_GOAL_YTD_AMT,
 
  s.REBTEE_SALES_CM_AMT,
  s.REBTEE_SALES_LYM_AMT,
  s.REBTEE_GP_CM_AMT,
  s.REBTEE_COMM_CM_AMT,
  s.REBTEE_SALES_YTD_AMT,
  s.REBTEE_GP_YTD_AMT,
  s.REBTEE_SALES_LYTD_AMT,

  s.ITMFO1_SALES_CM_AMT,
  s.ITMFO1_SALES_LYM_AMT,
  s.ITMFO1_GP_CM_AMT,
  s.ITMFO1_COMM_CM_AMT,
  s.ITMFO1_SALES_YTD_AMT,
  s.ITMFO1_GP_YTD_AMT,
  s.ITMFO1_SALES_LYTD_AMT,
  m.ITMFO1_GOAL_YTD_AMT,

  s.ITMFO2_SALES_CM_AMT,
  s.ITMFO2_SALES_LYM_AMT,
  s.ITMFO2_GP_CM_AMT,
  s.ITMFO2_COMM_CM_AMT,
  s.ITMFO2_SALES_YTD_AMT,
  s.ITMFO2_GP_YTD_AMT,
  s.ITMFO2_SALES_LYTD_AMT,
  m.ITMFO2_GOAL_YTD_AMT,

  s.ITMFO3_SALES_CM_AMT,
  s.ITMFO3_SALES_LYM_AMT,
  s.ITMFO3_GP_CM_AMT,
  s.ITMFO3_COMM_CM_AMT,
  s.ITMFO3_SALES_YTD_AMT,
  s.ITMFO3_GP_YTD_AMT,
  s.ITMFO3_SALES_LYTD_AMT,
  m.ITMFO3_GOAL_YTD_AMT,

  s.ITMFRT_SALES_CM_AMT,
  s.ITMFRT_SALES_LYM_AMT,
  s.ITMFRT_GP_CM_AMT,
  s.ITMFRT_COMM_CM_AMT,
  s.ITMFRT_SALES_YTD_AMT,
  s.ITMFRT_GP_YTD_AMT,
  s.ITMFRT_SALES_LYTD_AMT,
  m.ITMFRT_GOAL_YTD_AMT,
 
  s.SPMFO1_SALES_CM_AMT,
  s.SPMFO1_SALES_LYM_AMT,
  s.SPMFO1_GP_CM_AMT,
  s.SPMFO1_COMM_CM_AMT,
  s.SPMFO1_SALES_YTD_AMT,
  s.SPMFO1_GP_YTD_AMT,
  s.SPMFO1_SALES_LYTD_AMT,

  s.SPMFO2_SALES_CM_AMT,
  s.SPMFO2_SALES_LYM_AMT,
  s.SPMFO2_GP_CM_AMT,
  s.SPMFO2_COMM_CM_AMT,
  s.SPMFO2_SALES_YTD_AMT,
  s.SPMFO2_GP_YTD_AMT,
  s.SPMFO2_SALES_LYTD_AMT,

  s.SPMFO3_SALES_CM_AMT,
  s.SPMFO3_SALES_LYM_AMT,
  s.SPMFO3_GP_CM_AMT,
  s.SPMFO3_COMM_CM_AMT,
  s.SPMFO3_SALES_YTD_AMT,
  s.SPMFO3_GP_YTD_AMT,
  s.SPMFO3_SALES_LYTD_AMT,

  s.ITMISC_SALES_CM_AMT,
  s.ITMISC_SALES_LYM_AMT,
  s.ITMISC_GP_CM_AMT,
  s.ITMISC_COMM_CM_AMT,
  s.ITMISC_SALES_YTD_AMT,
  s.ITMISC_GP_YTD_AMT,
  s.ITMISC_SALES_LYTD_AMT,
  m.ITMISC_GOAL_YTD_AMT,

  s.DIGCCS_SALES_CM_AMT,
  s.DIGCCS_SALES_LYM_AMT,
  s.DIGCCS_GP_CM_AMT,
  s.DIGCCS_COMM_CM_AMT,
  s.DIGCCS_SALES_YTD_AMT,
  s.DIGCCS_GP_YTD_AMT,
  s.DIGCCS_SALES_LYTD_AMT,

  s.ITMCPU_SALES_CM_AMT,
  s.ITMCPU_SALES_LYM_AMT,
  s.ITMCPU_GP_CM_AMT,
  s.ITMCPU_COMM_CM_AMT,
  s.ITMCPU_SALES_YTD_AMT,
  s.ITMCPU_GP_YTD_AMT,
  s.ITMCPU_SALES_LYTD_AMT,
  m.ITMCPU_GOAL_YTD_AMT,

  s.SFFFIN_SALES_CM_AMT,
  s.SFFFIN_SALES_LYM_AMT,
  s.SFFFIN_GP_CM_AMT,
  s.SFFFIN_COMM_CM_AMT,
  s.SFFFIN_SALES_YTD_AMT,
  s.SFFFIN_GP_YTD_AMT,
  s.SFFFIN_SALES_LYTD_AMT,

  s.DIGIMP_SALES_CM_AMT,
  s.DIGIMP_SALES_LYM_AMT,
  s.DIGIMP_GP_CM_AMT,
  s.DIGIMP_COMM_CM_AMT,
  s.DIGIMP_SALES_YTD_AMT,
  s.DIGIMP_GP_YTD_AMT,
  s.DIGIMP_SALES_LYTD_AMT,

  s.ITMPAR_SALES_CM_AMT,
  s.ITMPAR_SALES_LYM_AMT,
  s.ITMPAR_GP_CM_AMT,
  s.ITMPAR_COMM_CM_AMT,
  s.ITMPAR_SALES_YTD_AMT,
  s.ITMPAR_GP_YTD_AMT,
  s.ITMPAR_SALES_LYTD_AMT,
  m.ITMPAR_GOAL_YTD_AMT,

  s.ITMSER_SALES_CM_AMT,
  s.ITMSER_SALES_LYM_AMT,
  s.ITMSER_GP_CM_AMT,
  s.ITMSER_COMM_CM_AMT,
  s.ITMSER_SALES_YTD_AMT,
  s.ITMSER_GP_YTD_AMT,
  s.ITMSER_SALES_LYTD_AMT,
  m.ITMSER_GOAL_YTD_AMT,

  s.ITMEQ0_SALES_CM_AMT,
  s.ITMEQ0_SALES_LYM_AMT,
  s.ITMEQ0_GP_CM_AMT,
  s.ITMEQ0_COMM_CM_AMT,
  s.ITMEQ0_SALES_YTD_AMT,
  s.ITMEQ0_GP_YTD_AMT,
  s.ITMEQ0_SALES_LYTD_AMT,
  m.ITMEQ0_GOAL_YTD_AMT,

  s.DIGMAT_SALES_CM_AMT,
  s.DIGMAT_SALES_LYM_AMT,
  s.DIGMAT_GP_CM_AMT,
  s.DIGMAT_COMM_CM_AMT,
  s.DIGMAT_SALES_YTD_AMT,
  s.SALD30_COMM_CM_AMT,
  s.STMPBA_COMM_CM_AMT,

  s.DIGMAT_GP_YTD_AMT,
  s.DIGMAT_SALES_LYTD_AMT,

  s.ITMCAM_SALES_CM_AMT,
  s.ITMCAM_SALES_LYM_AMT,
  s.ITMCAM_GP_CM_AMT,
  s.ITMCAM_COMM_CM_AMT,
  s.ITMCAM_SALES_YTD_AMT,
  s.ITMCAM_GP_YTD_AMT,
  s.ITMCAM_SALES_LYTD_AMT,
  m.ITMCAM_GOAL_YTD_AMT,

  s.ITMSOF_SALES_CM_AMT,
  s.ITMSOF_SALES_LYM_AMT,
  s.ITMSOF_GP_CM_AMT,
  s.ITMSOF_COMM_CM_AMT,
  s.ITMSOF_SALES_YTD_AMT,
  s.ITMSOF_GP_YTD_AMT,
  s.ITMSOF_SALES_LYTD_AMT,
  m.ITMSOF_GOAL_YTD_AMT,

  s.FRESND_GP_CM_AMT,
  s.FRESND_COMM_CM_AMT,
  s.FRESND_GP_YTD_AMT,
  s.FRESEQ_GP_CM_AMT,
  s.FRESEQ_COMM_CM_AMT,
  s.FRESEQ_GP_YTD_AMT,

-- 03 May 16	tmc		Added new Special Market Free Goods fields
	SPMFGS_GP_CM_AMT, 
	SPMFGS_COMM_CM_AMT, 
	SPMFGS_GP_YTD_AMT, 
	SPMFGS_GP_LYM_AMT, 
	SPMFGS_GP_LYTD_AMT, 

	SPMFGE_GP_CM_AMT, 
	SPMFGE_COMM_CM_AMT, 
	SPMFGE_GP_YTD_AMT, 
	SPMFGE_GP_LYM_AMT, 
	SPMFGE_GP_LYTD_AMT,

	ITMSND_GP_LYM_AMT, 
	ITMSND_GP_LYTD_AMT, 
	REBSND_GP_LYM_AMT, 
	REBSND_GP_LYTD_AMT, 
	SPMSND_GP_LYM_AMT, 
	SPMSND_GP_LYTD_AMT, 
	ITMTEE_GP_LYM_AMT, 
	ITMTEE_GP_LYTD_AMT, 
	REBTEE_GP_LYM_AMT, 
	REBTEE_GP_LYTD_AMT, 
	ITMFO1_GP_LYM_AMT, 
	ITMFO1_GP_LYTD_AMT, 
	ITMFO2_GP_LYM_AMT, 
	ITMFO2_GP_LYTD_AMT, 
	ITMFO3_GP_LYM_AMT, 
	ITMFO3_GP_LYTD_AMT, 
	ITMFRT_GP_LYM_AMT, 
	ITMFRT_GP_LYTD_AMT, 
	SPMFO1_GP_LYM_AMT, 
	SPMFO1_GP_LYTD_AMT, 
	SPMFO2_GP_LYM_AMT, 
	SPMFO2_GP_LYTD_AMT, 
	SPMFO3_GP_LYM_AMT, 
	SPMFO3_GP_LYTD_AMT, 
	ITMISC_GP_LYM_AMT, 
	ITMISC_GP_LYTD_AMT, 
	DIGCCS_GP_LYM_AMT, 
	DIGCCS_GP_LYTD_AMT, 
	ITMCPU_GP_LYM_AMT, 
	ITMCPU_GP_LYTD_AMT, 
	SFFFIN_GP_LYM_AMT, 
	SFFFIN_GP_LYTD_AMT, 
	DIGIMP_GP_LYM_AMT, 
	DIGIMP_GP_LYTD_AMT, 
	ITMPAR_GP_LYM_AMT, 
	ITMPAR_GP_LYTD_AMT, 
	ITMSER_GP_LYM_AMT, 
	ITMSER_GP_LYTD_AMT, 
	ITMEQ0_GP_LYM_AMT, 
	ITMEQ0_GP_LYTD_AMT, 
	ITMCAM_GP_LYM_AMT, 
	ITMCAM_GP_LYTD_AMT, 
	ITMSOF_GP_LYM_AMT, 
	ITMSOF_GP_LYTD_AMT, 
	FRESND_GP_LYM_AMT, 
	FRESND_GP_LYTD_AMT, 
	FRESEQ_GP_LYM_AMT, 
	FRESEQ_GP_LYTD_AMT, 
	DIGMAT_GP_LYM_AMT, 
	DIGMAT_GP_LYTD_AMT 


FROM         
(
  SELECT     
    salesperson_key_id, 

    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMSND_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMSND_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMSND_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMSND_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMSND_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMSND_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMSND_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMSND_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSND' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMSND_GP_LYTD_AMT, 



    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.sales_curr_amt ELSE 0 END) AS					REBSND_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.sales_ref_amt ELSE 0 END) AS						REBSND_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.gp_curr_amt ELSE 0 END) AS						REBSND_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.comm_curr_amt ELSE 0 END) AS						REBSND_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS REBSND_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		REBSND_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	REBSND_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.gp_ref_amt ELSE 0 END) AS						REBSND_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBSND' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			REBSND_GP_LYTD_AMT, 


    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.sales_curr_amt ELSE 0 END) AS					SPMSND_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.sales_ref_amt ELSE 0 END) AS						SPMSND_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.gp_curr_amt ELSE 0 END) AS						SPMSND_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.comm_curr_amt ELSE 0 END) AS						SPMSND_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS SPMSND_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		SPMSND_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	SPMSND_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.gp_ref_amt ELSE 0 END) AS						SPMSND_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMSND' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			SPMSND_GP_LYTD_AMT, 


    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMTEE_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMTEE_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMTEE_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMTEE_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMTEE_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMTEE_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMTEE_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMTEE_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMTEE' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMTEE_GP_LYTD_AMT, 


    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.sales_curr_amt ELSE 0 END) AS					REBTEE_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.sales_ref_amt ELSE 0 END) AS						REBTEE_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.gp_curr_amt ELSE 0 END) AS						REBTEE_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.comm_curr_amt ELSE 0 END) AS						REBTEE_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS REBTEE_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		REBTEE_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	REBTEE_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.gp_ref_amt ELSE 0 END) AS						REBTEE_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'REBTEE' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			REBTEE_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMFO1_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMFO1_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMFO1_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMFO1_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO1_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMFO1_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMFO1_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMFO1_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO1' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMFO1_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMFO2_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMFO2_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMFO2_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMFO2_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO2_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMFO2_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMFO2_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMFO2_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO2' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMFO2_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMFO3_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMFO3_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMFO3_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMFO3_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFO3_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMFO3_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMFO3_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMFO3_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFO3' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMFO3_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMFRT_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMFRT_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMFRT_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMFRT_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMFRT_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMFRT_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMFRT_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMFRT_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMFRT' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMFRT_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.sales_curr_amt ELSE 0 END) AS					SPMFO1_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.sales_ref_amt ELSE 0 END) AS						SPMFO1_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.gp_curr_amt ELSE 0 END) AS						SPMFO1_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.comm_curr_amt ELSE 0 END) AS						SPMFO1_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS SPMFO1_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		SPMFO1_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	SPMFO1_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.gp_ref_amt ELSE 0 END) AS						SPMFO1_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO1' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			SPMFO1_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.sales_curr_amt ELSE 0 END) AS					SPMFO2_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.sales_ref_amt ELSE 0 END) AS						SPMFO2_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.gp_curr_amt ELSE 0 END) AS						SPMFO2_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.comm_curr_amt ELSE 0 END) AS						SPMFO2_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS SPMFO2_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		SPMFO2_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	SPMFO2_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.gp_ref_amt ELSE 0 END) AS						SPMFO2_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO2' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			SPMFO2_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.sales_curr_amt ELSE 0 END) AS					SPMFO3_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.sales_ref_amt ELSE 0 END) AS						SPMFO3_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.gp_curr_amt ELSE 0 END) AS						SPMFO3_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.comm_curr_amt ELSE 0 END) AS						SPMFO3_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS SPMFO3_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		SPMFO3_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	SPMFO3_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.gp_ref_amt ELSE 0 END) AS						SPMFO3_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFO3' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			SPMFO3_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMISC_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMISC_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMISC_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMISC_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMISC_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMISC_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMISC_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMISC_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMISC' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMISC_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.sales_curr_amt ELSE 0 END) AS					DIGCCS_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.sales_ref_amt ELSE 0 END) AS						DIGCCS_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.gp_curr_amt ELSE 0 END) AS						DIGCCS_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.comm_curr_amt ELSE 0 END) AS						DIGCCS_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS DIGCCS_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		DIGCCS_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	DIGCCS_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.gp_ref_amt ELSE 0 END) AS						DIGCCS_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd in('DIGCCS', 'DIGCCC') THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			DIGCCS_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMCPU_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMCPU_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMCPU_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMCPU_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMCPU_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMCPU_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMCPU_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMCPU_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCPU' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMCPU_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_curr_amt ELSE 0 END) AS					SFFFIN_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ref_amt ELSE 0 END) AS						SFFFIN_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_curr_amt ELSE 0 END) AS						SFFFIN_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.comm_curr_amt ELSE 0 END) AS						SFFFIN_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS SFFFIN_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		SFFFIN_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	SFFFIN_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_ref_amt ELSE 0 END) AS						SFFFIN_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SFFFIN' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			SFFFIN_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.sales_curr_amt ELSE 0 END) AS					DIGIMP_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.sales_ref_amt ELSE 0 END) AS					DIGIMP_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.gp_curr_amt ELSE 0 END) AS						DIGIMP_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.comm_curr_amt ELSE 0 END) AS					DIGIMP_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS DIGIMP_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		DIGIMP_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	DIGIMP_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.gp_ref_amt ELSE 0 END) AS						DIGIMP_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd IN ('DIGIMP', 'DIGCIM') THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS		DIGIMP_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMPAR_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMPAR_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMPAR_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMPAR_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMPAR_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMPAR_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMPAR_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMPAR_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMPAR' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMPAR_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMSER_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMSER_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMSER_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMSER_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMSER_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMSER_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMSER_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMSER_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSER' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMSER_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMEQ0_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMEQ0_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMEQ0_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMEQ0_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMEQ0_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMEQ0_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMEQ0_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMEQ0_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMEQ0' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMEQ0_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMCAM_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMCAM_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMCAM_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMCAM_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMCAM_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMCAM_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMCAM_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMCAM_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMCAM' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMCAM_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_curr_amt ELSE 0 END) AS					ITMSOF_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ref_amt ELSE 0 END) AS						ITMSOF_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_curr_amt ELSE 0 END) AS						ITMSOF_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.comm_curr_amt ELSE 0 END) AS						ITMSOF_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS ITMSOF_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		ITMSOF_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	ITMSOF_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_ref_amt ELSE 0 END) AS						ITMSOF_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'ITMSOF' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			ITMSOF_GP_LYTD_AMT, 

    
    SUM(CASE WHEN comm_group_cd = 'FRESND' THEN ss.gp_curr_amt ELSE 0 END) AS						FRESND_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESND' THEN ss.comm_curr_amt ELSE 0 END) AS						FRESND_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESND' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		FRESND_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_curr_amt ELSE 0 END) AS						FRESEQ_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.comm_curr_amt ELSE 0 END) AS						FRESEQ_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		FRESEQ_GP_YTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'FRESND' THEN ss.gp_ref_amt ELSE 0 END) AS						FRESND_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESND' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			FRESND_GP_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_ref_amt ELSE 0 END) AS						FRESEQ_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'FRESEQ' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			FRESEQ_GP_LYTD_AMT, 


-- 04 Feb 16	tmc		Fixed DIGMAT field map bug
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.sales_curr_amt ELSE 0 END) AS					DIGMAT_SALES_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.sales_ref_amt ELSE 0 END) AS						DIGMAT_SALES_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.gp_curr_amt ELSE 0 END) AS						DIGMAT_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.comm_curr_amt ELSE 0 END) AS						DIGMAT_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.sales_ytd_amt + ss.sales_curr_amt ELSE 0 END) AS DIGMAT_SALES_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		DIGMAT_GP_YTD_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.sales_ly_amt + ss.sales_ref_amt ELSE 0 END) AS	DIGMAT_SALES_LYTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.gp_ref_amt ELSE 0 END) AS						DIGMAT_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'DIGMAT' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			DIGMAT_GP_LYTD_AMT, 


    SUM(CASE WHEN comm_group_cd = 'SALD30' THEN ss.comm_curr_amt ELSE 0 END) AS						SALD30_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'STMPBA' THEN ss.comm_curr_amt ELSE 0 END) AS						STMPBA_COMM_CM_AMT,

-- 03 May 16	tmc		Added new Special Market Free Goods fields
    SUM(CASE WHEN comm_group_cd = 'SPMFGS' THEN ss.gp_curr_amt ELSE 0 END) AS						SPMFGS_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFGS' THEN ss.comm_curr_amt ELSE 0 END) AS						SPMFGS_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFGS' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		SPMFGS_GP_YTD_AMT, 

    SUM(CASE WHEN comm_group_cd = 'SPMFGS' THEN ss.gp_ref_amt ELSE 0 END) AS						SPMFGS_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFGS' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			SPMFGS_GP_LYTD_AMT, 


    SUM(CASE WHEN comm_group_cd = 'SPMFGE' THEN ss.gp_curr_amt ELSE 0 END) AS						SPMFGE_GP_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFGE' THEN ss.comm_curr_amt ELSE 0 END) AS						SPMFGE_COMM_CM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFGE' THEN ss.gp_ytd_amt + ss.gp_curr_amt ELSE 0 END) AS		SPMFGE_GP_YTD_AMT,
    
    SUM(CASE WHEN comm_group_cd = 'SPMFGE' THEN ss.gp_ref_amt ELSE 0 END) AS						SPMFGE_GP_LYM_AMT, 
    SUM(CASE WHEN comm_group_cd = 'SPMFGE' THEN ss.gp_ly_amt + ss.gp_ref_amt ELSE 0 END) AS			SPMFGE_GP_LYTD_AMT
                      
  FROM 
           
    dbo.comm_summary AS ss

  WHERE      
    (comm_group_cd <> '') AND 
    (salesperson_key_id <> '') AND
--	testing
--	(comm_group_cd IN ('DIGCCC', 'DIGCIM')) AND

	(1=1)

  GROUP BY 
    salesperson_key_id
) AS s 

  INNER JOIN dbo.comm_salesperson_master AS m 
  ON s.salesperson_key_id = m.salesperson_key_id 

  INNER JOIN dbo.comm_branch AS b
  ON m.branch_cd = b.branch_cd 


WHERE     
  (m.comm_plan_id LIKE 'FSC%')
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

-- [dbo].[comm_summary_update_proc] 0

-- SELECT * FROM comm_statement_export

