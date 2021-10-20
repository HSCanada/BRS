-- 20211019 fsc playhbook wheel update, tmc

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	wheel_thresh1_sales_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_active_ind1 DEFAULT ((0)),
	wheel_thresh2_recent_order_ind smallint NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_wheel_active_ind2 DEFAULT ((0))
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- break active into 2
update dbo.BRS_CustomerFSC_History
set wheel_thresh1_sales_ind = 1,
wheel_thresh2_recent_order_ind = 1
WHERE wheel_active_ind = 2

-- break active into 2
update dbo.BRS_CustomerFSC_History
set wheel_thresh1_sales_ind = 1,
wheel_thresh2_recent_order_ind = 0
WHERE wheel_active_ind = 1

-- remove active (not needed and replace by view logic)
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History
	DROP CONSTRAINT DF_BRS_CustomerFSC_History_wheel_active_ind
GO
ALTER TABLE dbo.BRS_CustomerFSC_History
	DROP COLUMN wheel_active_ind
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

