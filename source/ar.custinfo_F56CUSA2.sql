
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW ar.custinfo_F56CUSA2
AS

/******************************************************************************
**	File: 
**	Name: Item
**	Desc:  
**		
**
**              
**	Return values:  
**
**	Called by:   SSAS
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 25 Oct 24
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**    
*******************************************************************************/

SELECT        
-- TOP (10) 
A5AN8__billto, ABALPH_alpha_name, ABAC01_category_code_01, ABAC04_geographic_region, ABAC10_category_code_10, ABCM___credit_message, A5ACL__credit_limit
, A5CLMG_collection_manager, A5CMGR_credit_manager
,cr.Credit_Rep_nm [Credit_Representative_Name]
, A5AVD__average_days_late, A5URAB_user_reserved_number, A5TSTA_temporary_credit_message, A5AFC__apply_finance_charges_yn, A5DLC__date_of_last_credit_review, 
A5CYCN_statement_cycle, MAPA8__parent_number, MAOSTP_structure_type, A5BADT_billing_address_type, ALADDS_state, ALADDZ_postal_code, ABATPR_user_code, ABAN82__2nd_address_number, 
ABEFTB_start_effective_date, A5DLP__date_last_paid, QC$FLG_reason_code, QB$A04_address_flag_future_4, A5RYIN_payment_instrument, A5TRAR_payment_terms_ar, WPAR1__prefix, WPPH1__phone_number, 
ALADD1_address_line_1, ALADD2_address_line_2, ALADD3_address_line_3, ALADD4_address_line_4, ALCTY1_city, A5EXR1_tax_expl_code, ABTAX__tax_id, ABTX2__addl_ind_tax_id, ABTXCT_certificate, ALCTR__country, 
ABAC03_category_code_03, QB$RPC_representative_preference_code
FROM
	Integration.F56CUSA2_CUSINF2A AS s

	LEFT JOIN [ar].[credit_rep] cr
	ON s.A5CMGR_credit_manager = cr.Credit_Rep


WHERE        (1 = 1)	





GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


SELECT * from ar.custinfo_F56CUSA2
GO