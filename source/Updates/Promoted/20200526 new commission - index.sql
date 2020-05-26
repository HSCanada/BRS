
-- RI pref indexes, break out to new script
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX F555115_commission_sales_extract_Staging_idx_03 ON Integration.F555115_commission_sales_extract_Staging
	(
	WSLITM_item_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


