-- market class DW, tmc, 19 Jun 22

BEGIN TRANSACTION
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull ADD
	SegCd char(20) NULL,
	MarketClass char(6) NULL
GO
ALTER TABLE dbo.STAGE_BRS_CustomerFull SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_Customer] ADD
	SegCd_JDE char(20) NOT NULL Default (''),
	MarketClass_JDE char(6) NOT NULL Default ('')
GO
ALTER TABLE [dbo].[BRS_Customer] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerSegment ADD
	MarketClass_map char(6) NOT NULL CONSTRAINT DF_BRS_CustomerSegment_MarketClass_map DEFAULT ''
GO
ALTER TABLE dbo.BRS_CustomerSegment SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- ri

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_CustomerSegment1 FOREIGN KEY
	(
	SegCd_JDE
	) REFERENCES dbo.BRS_CustomerSegment
	(
	SegCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_CustomerMarketClass2 FOREIGN KEY
	(
	MarketClass_JDE
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerSegment ADD CONSTRAINT
	FK_BRS_CustomerSegment_BRS_CustomerMarketClass FOREIGN KEY
	(
	MarketClass_map
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerSegment SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- update segment
insert into
	[dbo].[BRS_CustomerSegment]
	(SEGCd, [SegName])

select distinct ISNULL([SegCd],'') seg, '' as seg_name
from [dbo].[STAGE_BRS_CustomerFull] d
where not exists(select * from [dbo].[BRS_CustomerSegment] s where ISNULL(s.[SegCd],'') = ISNULL(d.[SegCd],''))


-- test market
select distinct ISNULL([MarketClass],'') market, '' as market_name
from [dbo].[STAGE_BRS_CustomerFull] d
where not exists(select * from [dbo].[BRS_CustomerMarketClass] s where ISNULL(s.[MarketClass],'') = ISNULL(d.[MarketClass],''))

