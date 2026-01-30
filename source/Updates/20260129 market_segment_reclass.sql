-- market_segment_reclass, tmc, 29 Jan 26

-- keep full script from being run
print 'hi'
go
raiserror('Oh no a fatal error', 20, -1) with log
go
print 'ho, no go!'


-- update Current  Market&Seg, Current Old -> Current New

-- look at biggest accounts
SELECT   TOP (10) ShipTo, BillTo, SalesDivision, MarketClass_New, SegCd_New, MarketClass, SegCd, Est12MoMerch FROM     BRS_Customer
where ShipTo <> BillTo and BillTo > 0
order by Est12MoMerch desc
GO

-- how many total Shipto?
SELECT   count(*)  FROM     BRS_Customer
where ShipTo <> BillTo and BillTo > 0
GO
-- 80,365 

-- org 80348

SELECT  
--top 10 
ShipTo, BillTo, SalesDivision, MarketClass_New, SegCd_New, MarketClass, SegCd, vpa, Specialty, CustGrpWrk, Est12MoMerch FROM     BRS_Customer
where 
	--> cyber corrections
	ShipTo <> BillTo and 
	BillTo > 0 and
	--<
	-- back out edge cases where MarketClass more accurate than New
	  not (
		(MarketClass = 'INSTIT') OR
		(CustGrpWrk in ('Dental Corp','123 Dentist (Heartland)')) OR
		MarketClass in ('PVTPRC', 'PVTSPC') AND MarketClass_New in ('PVTPRC', 'PVTSPC') 
	)
	and MarketClass_New <> MarketClass
order by Est12MoMerch desc
GO
--

-- 

-- truncate table zzzshipto


-- Set Market Finance  to New rules, excluding exceptions (Update 1 of 2)
UPDATE  BRS_Customer
SET MarketClass = MarketClass_New
, SegCd = SegCd_New
where 
	--> cyber corrections
	ShipTo <> BillTo and 
	BillTo > 0 and
	--<
	-- back out edge cases where MarketClass more accurate than New
	  not (
		(MarketClass = 'INSTIT') OR
		(CustGrpWrk in ('Dental Corp','123 Dentist (Heartland)')) OR
		MarketClass in ('PVTPRC', 'PVTSPC') AND MarketClass_New in ('PVTPRC', 'PVTSPC') 
	)
	and MarketClass_New <> MarketClass


-- updates = 138979


-- update History Market&Seg, Current Old -> History Old, where SalesDiv NOT changed

-- review where the SalesDiv has changes.  Whould should not change Market (different hats)
SELECT   TOP (100) c.ShipTo, c.BillTo, c.PracticeName, c.SalesDivision, c.MarketClass, c.SegCd, h.FiscalMonth, h.HIST_SalesDivision, h.HIST_MarketClass, h.HIST_SegCd, h.HIST_MarketClass_Old, h.HIST_SegCd_Old
FROM     BRS_Customer AS c INNER JOIN
             BRS_CustomerFSC_History AS h ON c.ShipTo = h.Shipto
WHERE   
(h.FiscalMonth BETWEEN 202501 AND 202512) AND 
--(c.SalesDivision = h.HIST_SalesDivision) AND
(c.SalesDivision <> h.HIST_SalesDivision) AND
--(c.ShipTo = 4271748) AND 
(1 = 1)
order by 
h.HIST_SalesDivision
GO
-- 45 rows

-- review proposed changes
SELECT   TOP (500) c.ShipTo, c.BillTo, c.PracticeName, c.vpa, c.[CustGrpWrkNote], c.SalesDivision, c.MarketClass, c.SegCd, h.FiscalMonth, h.HIST_SalesDivision, h.HIST_MarketClass, h.HIST_SegCd, h.HIST_MarketClass_Old, h.HIST_SegCd_Old, Est12MoMerch
FROM     BRS_Customer AS c INNER JOIN
             BRS_CustomerFSC_History AS h ON c.ShipTo = h.Shipto
WHERE
-- time periood
(h.FiscalMonth BETWEEN 202501 AND 202512) AND 
-- only change where the sales div are the same, current and history
(c.SalesDivision = h.HIST_SalesDivision) AND
-- ID marketclass financial vs historical changes
(
	(c.MarketClass <> h.HIST_MarketClass) OR
	(c.SegCd <> h.HIST_SegCd) 
) AND
-- cyber corrections (ignore junk data)
c.ShipTo <> c.BillTo and c.BillTo > 0 and
(1 = 1)
ORDER BY Est12MoMerch desc
GO

SELECT   count(*)
FROM     BRS_Customer AS c INNER JOIN
             BRS_CustomerFSC_History AS h ON c.ShipTo = h.Shipto
WHERE   
-- time periood
(h.FiscalMonth BETWEEN 202501 AND 202512) AND 
-- only change where the sales div are the same, current and history
(c.SalesDivision = h.HIST_SalesDivision) AND
-- ID marketclass financial vs historical changes
(
	(c.MarketClass <> h.HIST_MarketClass) OR
	(c.SegCd <> h.HIST_SegCd) 
) AND
-- cyber corrections (ignore junk data)
c.ShipTo <> c.BillTo and c.BillTo > 0 and
(1 = 1)

-- diff = 5043


-- update (2 of 2)
UPDATE  BRS_CustomerFSC_History
SET
	HIST_MarketClass = c.MarketClass
	, HIST_SegCd = c.SegCd
	, HIST_MarketClass_Old = HIST_MarketClass
	, HIST_SegCd_Old = HIST_SegCd
FROM     BRS_Customer AS c INNER JOIN
             BRS_CustomerFSC_History AS h ON c.ShipTo = h.Shipto
WHERE   
-- time periood
(h.FiscalMonth BETWEEN 202501 AND 202512) AND 
-- only change where the sales div are the same, current and history
(c.SalesDivision = h.HIST_SalesDivision) AND
-- ID marketclass financial vs historical changes
(
	(c.MarketClass <> h.HIST_MarketClass) OR
	(c.SegCd <> h.HIST_SegCd) 
) AND
-- cyber corrections (ignore junk data)
c.ShipTo <> c.BillTo and c.BillTo > 0 and
(1 = 1)
-- updated = 5043




