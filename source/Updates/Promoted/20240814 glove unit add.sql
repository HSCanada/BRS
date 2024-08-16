--glove_unit add, tmc 14 Aug 24

--> Prod
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	size_unit_rate int NULL,
	size_unit_rate_note varchar(50) NULL
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


select size_unit_rate, size_unit_rate_note from  dbo.BRS_Item where MajorProductClass = '054'

update dbo.BRS_Item
set size_unit_rate = 2, size_unit_rate_note = 'test' 
where MajorProductClass = '054'

--< Prod