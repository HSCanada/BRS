
DELETE FROM Integration.F4072_price_adjustment_detail_Staging
WHERE   (NOT EXISTS
                 (SELECT   NULL AS Expr1
                 FROM     Pricing.item_master_F4101
                 WHERE   (Integration.F4072_price_adjustment_detail_Staging.ADITM__item_number_short = IMITM__item_number_short)))

SELECT
		Q3KCOO_order_number_document_company,
		Q3DCTO_order_type,
		Q3DOCO_salesorder_number,
		Q3LNID_line_number,
		Q3$APC_application_code,
		Q3$PMQ_program_parameter,
		Q3LNGP_language,
		Q3INMG_print_message,
		Q3$SNB_sequence_number,
		QCTRDJ_order_date,
		chksum
		,ID

	FROM
		Integration.F5503_canned_message_file_parameters_Staging s
	WHERE 
		-- hack to exclude duplicate order.   Remove French?  
		s.Q3LNGP_language <> 'F' AND
		s.Q3DOCO_salesorder_number = 1469774

delete from Integration.F5503_canned_message_file_parameters_Staging 
	WHERE ID = 870110
