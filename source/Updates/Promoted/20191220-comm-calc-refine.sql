-- comm-calc-refine, tmc, 20 Dec 19

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_16 ON comm.transaction_F555115
	(
	fsc_calc_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO

CREATE NONCLUSTERED INDEX transaction_F555115_idx_17 ON comm.transaction_F555115
	(
	ess_calc_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO

CREATE NONCLUSTERED INDEX transaction_F555115_idx_18 ON comm.transaction_F555115
	(
	cps_calc_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO

CREATE NONCLUSTERED INDEX transaction_F555115_idx_19 ON comm.transaction_F555115
	(
	eps_calc_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--< updated in prod

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX F555115_commission_sales_extract_Staging_idx_01 ON Integration.F555115_commission_sales_extract_Staging
	(
	WSDGL__gl_date
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
CREATE NONCLUSTERED INDEX F555115_commission_sales_extract_Staging_idx_02 ON Integration.F555115_commission_sales_extract_Staging
	(
	WSSHAN_shipto
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Integration.F555115_commission_sales_extract_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--< updated in Dev
