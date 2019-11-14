-- comm new datafeed setup, tmc, 14 Nov 19

-- delete  FROM [comm].[transaction_F555115] where FiscalMonth = 0

-- item history - add missing codes
insert into [dbo].[BRS_ItemHistory]
(FiscalMonth, Item, Supplier) 

SELECT
FiscalMonth, WSLITM_item_number, WS$SPC_supplier_code
FROM
comm.transaction_F555115 AS t

INNER JOIN
	(SELECT
		max(ID) as max_id
	FROM            comm.transaction_F555115 AS t

	where not exists (
		select * from [dbo].[BRS_ItemHistory] h
		where h.FiscalMonth = t.FiscalMonth AND
			h.Item = t.WSLITM_item_number
	)
	group by FiscalMonth, WSLITM_item_number
	) as  sel
	ON t.id = sel.max_id

-- item add RI

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_ItemHistory FOREIGN KEY
	(
	FiscalMonth,
	WSLITM_item_number
	) REFERENCES dbo.BRS_ItemHistory
	(
	FiscalMonth,
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- customer history - check

SELECT
FiscalMonth, WSSHAN_shipto, fsc_code, WSAC10_division_code
FROM
comm.transaction_F555115 AS t

INNER JOIN
	(SELECT
		max(ID) as max_id
	FROM            comm.transaction_F555115 AS t

	where not exists (
		select * from [dbo].[BRS_CustomerFSC_History] h
		where h.FiscalMonth = t.FiscalMonth AND
			h.Shipto = t.WSSHAN_shipto
	)
	group by FiscalMonth, WSSHAN_shipto
	) as  sel
	ON t.id = sel.max_id


--

-- customer add RI

BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_CustomerFSC_History FOREIGN KEY
	(
	FiscalMonth,
	WSSHAN_shipto
	) REFERENCES dbo.BRS_CustomerFSC_History
	(
	FiscalMonth,
	Shipto
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
