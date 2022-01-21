
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD
	WKECST_extended_cost_redeem money NULL
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

UPDATE       fg.transaction_F5554240
SET                WKECST_extended_cost_redeem = WKECST_extended_cost
GO

UPDATE       fg.transaction_F5554240
SET                WKECST_extended_cost_redeem = 0
where fg_redeem_ind <> 1