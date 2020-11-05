
-- fix dup PK in stage, 2 Nov 20

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging
	DROP CONSTRAINT F555115_commission_sales_extract_Staging2_c_pk
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging ADD CONSTRAINT
	F555115_commission_sales_extract_Staging2_c_pk PRIMARY KEY CLUSTERED 
	(
	WSDOCO_salesorder_number,
	WSDCTO_order_type,
	WSLNID_line_number,
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
