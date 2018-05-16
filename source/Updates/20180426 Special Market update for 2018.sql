-- Special Market update for 2018
-- 26 Apr 18

-- prod

-- archive current status

/*

SELECT        ShipTo, Specialty, SpecialtyWrk, StatusCd, CustGrpWrk, UserAreaTxt, SegCd, MarketClass
INTO              zzzCustomerSM
FROM            BRS_Customer

ALTER TABLE dbo.zzzCustomerSM ADD CONSTRAINT
	PK_zzzCustomerSM PRIMARY KEY CLUSTERED 
	(
	ShipTo
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerVPA ADD
	CustGrp varchar(100) NOT NULL CONSTRAINT DF_BRS_CustomerVPA_CustGrp DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerVPA ADD CONSTRAINT
	FK_BRS_CustomerVPA_BRS_CustomerGroup FOREIGN KEY
	(
	CustGrp
	) REFERENCES dbo.BRS_CustomerGroup
	(
	CustGrp
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerVPA SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- load changes, update VPA, Specialty

-- clear goup info

/*
UPDATE       BRS_CustomerGroup
SET                PotentialSpendAmt = 0
*/
-- add new groups


--- add new Marketclass

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerSpecialty ADD
	MarketClass_New char(6) NOT NULL CONSTRAINT DF_BRS_CustomerSpecialty_MarketClass1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerSpecialty ADD CONSTRAINT
	FK_BRS_CustomerSpecialty_BRS_CustomerMarketClass1 FOREIGN KEY
	(
	MarketClass_New
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerSpecialty SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerGroup ADD
	MarketClass_New char(6) NOT NULL CONSTRAINT DF_BRS_CustomerGroup_MarketClass1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerGroup ADD CONSTRAINT
	FK_BRS_CustomerGroup_BRS_CustomerMarketClass1 FOREIGN KEY
	(
	MarketClass_New
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerGroup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD
	HIST_MarketClass_New char(6) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_HIST_MarketClass1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_BRS_CustomerMarketClass1 FOREIGN KEY
	(
	HIST_MarketClass_New
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_CustomerFSC_History SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Customer ADD
	MarketClass_New char(6) NOT NULL CONSTRAINT DF_BRS_Customer_MarketClass1 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_CustomerMarketClass1 FOREIGN KEY
	(
	MarketClass_New
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Customer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDivision ADD
	MarketClass_New char(6) NOT NULL CONSTRAINT DF_BRS_SalesDivision_MarketClass_New DEFAULT ('')
GO
ALTER TABLE dbo.BRS_SalesDivision ADD CONSTRAINT
	FK_BRS_SalesDivision_BRS_CustomerMarketClass FOREIGN KEY
	(
	MarketClass_New
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_SalesDivision SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- 

CREATE TABLE [dbo].[BRS_CustomerSegment](
	[SegCd] [char](20) NOT NULL,
	[SegName] [nvarchar](50) NOT NULL,
	[NoteTxt] [nvarchar](50) NULL,
	[SegKey] int identity(1,1) NOT NULL
 CONSTRAINT [BRS_CustomerSegment_c_pk] PRIMARY KEY CLUSTERED 
(
	[SegCd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

ALTER TABLE dbo.BRS_Customer ADD
	SegCd_New char(20) NOT NULL CONSTRAINT DF_BRS_Customer_SegCd_New DEFAULT ('')
GO

ALTER TABLE [dbo].[BRS_CustomerGroup] ADD
	SegCd_New char(20) NOT NULL CONSTRAINT DF_BRS_CustomerGroup_SegCd_New DEFAULT ('')
GO

ALTER TABLE [dbo].[BRS_CustomerSpecialty] ADD
	SegCd_New char(20) NOT NULL CONSTRAINT DF_BRS_CustomerSpecialty_SegCd_New DEFAULT ('')
GO

ALTER TABLE [dbo].[BRS_CustomerFSC_History] ADD
	HIST_SegCd_New char(20) NOT NULL CONSTRAINT DF_BRS_CustomerFSC_History_SegCd_New DEFAULT ('')
GO

INSERT INTO [dbo].[BRS_CustomerSegment]
	([SegCd], [SegName])
VALUES ('', 'UNDEFINED')

--
ALTER TABLE dbo.BRS_Customer ADD CONSTRAINT
	FK_BRS_Customer_BRS_CustomerSegment FOREIGN KEY
	(
	SegCd_New
	) REFERENCES dbo.BRS_CustomerSegment
	(
	SegCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.BRS_CustomerGroup ADD CONSTRAINT
	FK_BRS_CustomerGroup_BRS_CustomerSegment FOREIGN KEY
	(
	SegCd_New
	) REFERENCES dbo.BRS_CustomerSegment
	(
	SegCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.BRS_CustomerSpecialty ADD CONSTRAINT
	FK_BRS_CustomerSpecialty_BRS_CustomerSegment FOREIGN KEY
	(
	SegCd_New
	) REFERENCES dbo.BRS_CustomerSegment
	(
	SegCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.BRS_CustomerFSC_History ADD CONSTRAINT
	FK_BRS_CustomerFSC_History_BRS_CustomerSegment FOREIGN KEY
	(
	HIST_SegCd_New
	) REFERENCES dbo.BRS_CustomerSegment
	(
	SegCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

-- xxx
INSERT INTO [dbo].[BRS_CustomerSegment]
	([SegCd], [SegName])
VALUES 
('DFED', 'Dental/Fed'),
('DI', 'Dental Institution'),
('DSH', 'Dental Schools'),
('DSO', 'Local Dental Service Org'),
('EDSO', 'Elite Dental Service Org'),
('MFED', 'Medical/Fed'),
('MI', 'Medical Institution'),
('NDSO', 'National Accounts'),
('OTHER', 'Other'),
('PDS', 'Primary Dental School'),
('PHC', 'Community Health Center'),
('RDSO', 'Regional Accounts')


--
UPDATE       BRS_CustomerFSC_History
SET                
HIST_SegCd = BRS_Customer.SegCd_New, 
HIST_MarketClass = BRS_Customer.MarketClass_New, 
HIST_MarketClass_New = BRS_Customer.MarketClass_New, 
HIST_SegCd_New = BRS_Customer.SegCd_New
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_Customer ON BRS_CustomerFSC_History.Shipto = BRS_Customer.ShipTo
WHERE        (BRS_CustomerFSC_History.FiscalMonth >= 201701)

---

-- fix historical SM sales division reclass
SELECT        BRS_Transaction.FiscalMonth, BRS_Transaction.Shipto, BRS_Transaction.SalesOrderNumberKEY, BRS_Transaction.DocType, BRS_Transaction.LineNumber, 
                         BRS_Transaction.SalesOrderNumber, BRS_Transaction.SalesDivision AS SalesDivision_Trans, BRS_Customer.SalesDivision, BRS_Transaction.NetSalesAmt, 
                         BRS_Transaction.ExtendedCostAmt, BRS_Customer.PracticeName, BRS_Customer.CustGrpWrk, BRS_Customer.VPA, BRS_Transaction.AdjCode, 
                         BRS_Transaction.AdjNum, BRS_Transaction.AdjNote
FROM            BRS_Customer INNER JOIN
                         BRS_Transaction ON BRS_Customer.ShipTo = BRS_Transaction.Shipto AND BRS_Customer.SalesDivision <> BRS_Transaction.SalesDivision
WHERE        (BRS_Transaction.FiscalMonth >= 201701)


--
/*
UPDATE       BRS_CustomerFSC_History
SET                HIST_SalesDivision = BRS_Customer.SalesDivision
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_Customer ON BRS_CustomerFSC_History.Shipto = BRS_Customer.ShipTo
WHERE        (BRS_CustomerFSC_History.FiscalMonth >= 201701) AND (BRS_CustomerFSC_History.HIST_SalesDivision = '')
*/

SELECT        h.Shipto, h.FiscalMonth, h.HIST_SalesDivision, h.HIST_MarketClass, h.HIST_MarketClass_New, h.HIST_SegCd, h.HIST_SegCd_New, d.MarketClass_New
FROM            BRS_CustomerFSC_History AS h INNER JOIN
                         BRS_SalesDivision AS d ON h.HIST_SalesDivision = d.SalesDivision
WHERE        (h.FiscalMonth >= 201701) AND (h.HIST_SalesDivision <> 'AAD') AND (h.HIST_MarketClass <> d.MarketClass_New) and (h.HIST_MarketClass <> 'ZAHNSM')
ORDER BY HIST_MarketClass_New

UPDATE       BRS_CustomerFSC_History
SET                
	HIST_MarketClass = d.MarketClass_New, 
	HIST_MarketClass_New = d.MarketClass_New, 
	HIST_SegCd = '', 
	HIST_SegCd_New = ''
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_SalesDivision AS d ON BRS_CustomerFSC_History.HIST_SalesDivision = d.SalesDivision AND 
                         BRS_CustomerFSC_History.HIST_MarketClass <> d.MarketClass_New
WHERE        (BRS_CustomerFSC_History.FiscalMonth >= 201701) AND (BRS_CustomerFSC_History.HIST_SalesDivision <> 'AAD') AND 
                         (BRS_CustomerFSC_History.HIST_MarketClass <> 'ZAHNSM')

--

SELECT        h.Shipto, h.FiscalMonth, h.HIST_SalesDivision, h.HIST_MarketClass, h.HIST_MarketClass_New, h.HIST_SegCd, h.HIST_SegCd_New, d.MarketClass_New
FROM            BRS_CustomerFSC_History AS h INNER JOIN
                         BRS_SalesDivision AS d ON h.HIST_SalesDivision = d.SalesDivision
WHERE        (h.FiscalMonth >= 201701) AND (h.HIST_SalesDivision = 'AAD') AND (h.HIST_MarketClass in('MEDICL', 'ANIMAL', 'ZAHN') ) 
ORDER BY HIST_MarketClass_New

UPDATE       BRS_CustomerFSC_History
SET                HIST_MarketClass = 'PVTPRC', HIST_MarketClass_New = 'PVTPRC', HIST_SegCd = '', HIST_SegCd_New = ''
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_SalesDivision AS d ON BRS_CustomerFSC_History.HIST_SalesDivision = d.SalesDivision
WHERE        (BRS_CustomerFSC_History.FiscalMonth >= 201701) AND (BRS_CustomerFSC_History.HIST_SalesDivision = 'AAD') AND 
                         (BRS_CustomerFSC_History.HIST_MarketClass IN ('MEDICL', 'ANIMAL', 'ZAHN'))

SELECT        h.Shipto, h.FiscalMonth, h.HIST_SalesDivision, h.HIST_MarketClass, h.HIST_MarketClass_New, h.HIST_SegCd, h.HIST_SegCd_New, d.MarketClass_New, 
                         BRS_Customer.PracticeName, BRS_Customer.CustGrpWrk, BRS_Customer.MarketClass_New AS Expr1, BRS_Customer.SegCd_New
FROM            BRS_CustomerFSC_History AS h INNER JOIN
                         BRS_SalesDivision AS d ON h.HIST_SalesDivision = d.SalesDivision INNER JOIN
                         BRS_Customer ON h.Shipto = BRS_Customer.ShipTo
WHERE        (h.FiscalMonth >= 201701) AND (h.HIST_SalesDivision = 'AAD') AND (h.HIST_MarketClass IN ('ZAHNSM'))
ORDER BY h.HIST_MarketClass_New

UPDATE       BRS_CustomerFSC_History
SET                HIST_MarketClass = 'MIDMKT', HIST_MarketClass_New = 'MIDMKT', HIST_SegCd = 'DSO', HIST_SegCd_New = 'DSO'
WHERE        (FiscalMonth >= 201701) AND (HIST_SalesDivision = 'AAD') AND (HIST_MarketClass IN ('ZAHNSM'))

SELECT        distinct h.HIST_MarketClass
FROM            BRS_CustomerFSC_History AS h INNER JOIN
                         BRS_SalesDivision AS d ON h.HIST_SalesDivision = d.SalesDivision
WHERE        
(h.FiscalMonth >= 201701) AND (h.HIST_SalesDivision = 'AAD') AND 
--(h.HIST_MarketClass <> d.MarketClass_New) AND
(1=1)

SELECT        distinct h.HIST_MarketClass
FROM            BRS_CustomerFSC_History AS h INNER JOIN
                         BRS_SalesDivision AS d ON h.HIST_SalesDivision = d.SalesDivision
WHERE        
(h.FiscalMonth >= 201701) AND (h.HIST_SegCd <> h.HIST_SegCd_New) AND 
--(h.HIST_MarketClass <> d.MarketClass_New) AND
(1=1)

*/


---

-- revert
/*
UPDATE       BRS_Customer
SET
	Specialty = zzzCustomerSM.Specialty, 
	SpecialtyWrk =zzzCustomerSM.SpecialtyWrk, 
	StatusCd =zzzCustomerSM.StatusCd, 
	UserAreaTxt =zzzCustomerSM.UserAreaTxt, 
	SegCd =zzzCustomerSM.SegCd, 
	MarketClass = zzzCustomerSM.MarketClass

FROM BRS_Customer INNER JOIN
zzzCustomerSM ON BRS_Customer.ShipTo = zzzCustomerSM.ShipTo


UPDATE       BRS_CustomerFSC_History
SET                HIST_MarketClass = hs.HIST_MarketClass, HIST_SegCd = hs.HIST_SegCd
FROM            
	BRS_CustomerFSC_History 
	INNER JOIN DEV_BRSales.dbo.BRS_CustomerFSC_History AS hs 
	ON BRS_CustomerFSC_History.Shipto = hs.Shipto AND 
		BRS_CustomerFSC_History.FiscalMonth = hs.FiscalMonth 
	
WHERE        (BRS_CustomerFSC_History.FiscalMonth >= 201701)

*/

--- update Customer MarketClass_NEW

print '0. show current groups - NEW'
SELECT   MarketClass_New, SegCd_New, COUNT(*) as cust_count
FROM BRS_Customer
GROUP BY MarketClass_New, SegCd_New
ORDER BY 1, 2

print '0. show current groups - OLD'
SELECT   MarketClass, SegCd, COUNT(*) as cust_count
FROM BRS_Customer
GROUP BY MarketClass, SegCd
ORDER BY 1, 2

print '1. clear'
UPDATE       BRS_Customer
SET                MarketClass_New = '', SegCd_New = ''
GO

print ' 2. Set non Dental based on Division'
UPDATE       BRS_Customer
SET                MarketClass_New = d.MarketClass_New, SegCd_New = '' 
FROM            BRS_Customer INNER JOIN
                         BRS_SalesDivision AS d 
						 ON BRS_Customer.SalesDivision = d.SalesDivision
WHERE        
	(BRS_Customer.SalesDivision <> 'AAD') AND 
	(BRS_Customer.MarketClass_New = '')
GO

print '3. Set DCC based on BT=2613256 (Elite)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'ELITE', SegCd_New = 'NDSO'
WHERE        (BillTo = 2613256) AND (MarketClass_New = '')
GO

print '3b. Set DCC based on Specialty (Various)'
UPDATE       BRS_Customer
SET                MarketClass_New = s.MarketClass_New,
					SegCd_New = s.SegCd_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerSpecialty AS s ON BRS_Customer.Specialty = s.Specialty
WHERE        
	(BRS_Customer.MarketClass_New = '') AND 
	(BRS_Customer.CustGrpWrk = 'Dental Corp') AND
	(s.MarketClass_New <> '') 
GO

print '3c. Set DCC based on DSO (Exception)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'PVTPRC', SegCd_New = ''
FROM            BRS_Customer 
WHERE        
	(BRS_Customer.MarketClass_New = '') AND 
	(BRS_Customer.CustGrpWrk = 'Dental Corp') AND
	(BRS_Customer.Specialty = 'DSO')
GO	

/*
SELECT   MarketClass_New, COUNT(*) as cust_count
FROM BRS_Customer
where BillTo = 2613256
GROUP BY MarketClass_New
*/

print '4. Set Alpha Omega based on BT=1765054 (ELITE)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'ELITE', SegCd_New = 'NDSO'
WHERE        (BillTo = 1765054) AND (MarketClass_New = '')

GO

/*
SELECT   MarketClass_New, COUNT(*) as cust_count
FROM BRS_Customer
where BillTo = 1765054
GROUP BY MarketClass_New
*/

print '5. Set Dental Students - Primary (INSTIT)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'INSTIT', SegCd_New = 'PDS'
WHERE        (Specialty	= 'STUD') AND (MarketClass_New = '')
GO

print '5. Set Dental Students (INSTIT)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'INSTIT', SegCd_New = 'DSH'
WHERE        (Specialty	= 'STUA') AND (MarketClass_New = '')
GO

/*
SELECT   MarketClass_New, COUNT(*) as cust_count
FROM BRS_Customer
WHERE Specialty	LIKE 'STU%'
GROUP BY MarketClass_New
*/

-- data cleanup - done

print '6. MM Groups with VPAs'
UPDATE       BRS_Customer
SET                MarketClass_New = g.MarketClass_New, SegCd_New = g.SegCd_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerVPA AS v ON BRS_Customer.VPA = v.VPA AND BRS_Customer.VPA = v.VPA INNER JOIN
                         BRS_CustomerGroup AS g ON v.CustGrp = g.CustGrp
WHERE        (BRS_Customer.MarketClass_New = '') AND (v.CustGrp <> '') AND (g.MarketClass_New <> '')
GO

/*
SELECT        c.MarketClass_New, g.MarketClass_New AS Expr1
FROM            BRS_Customer AS c INNER JOIN
                         BRS_CustomerVPA AS v ON c.VPA = v.VPA AND c.VPA = v.VPA INNER JOIN
                         BRS_CustomerGroup AS g ON v.CustGrp = g.CustGrp
WHERE        
	(c.MarketClass_New = '') AND
	(v.CustGrp <>'') AND
	(g.MarketClass_New <> '')
*/

print '7. MM Groups with no VPAs'
UPDATE       BRS_Customer
SET                MarketClass_New = g.MarketClass_New, SegCd_New = g.SegCd_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerGroup AS g ON BRS_Customer.CustGrpWrk = g.CustGrp
WHERE        (BRS_Customer.MarketClass_New = '') AND (g.MarketClass_New <> '')
GO

/*
SELECT        c.MarketClass_New, g.MarketClass_New AS Expr1
FROM            BRS_Customer AS c INNER JOIN
                         BRS_CustomerGroup AS g ON c.CustGrpWrk = g.CustGrp
WHERE        (c.MarketClass_New = '') AND (g.MarketClass_New <> '')
*/

print '8. Set No Group based on Specialty'
UPDATE       BRS_Customer
SET                MarketClass_New = s.MarketClass_New, SegCd_New = s.SegCd_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerSpecialty AS s ON BRS_Customer.Specialty = s.Specialty
WHERE        (BRS_Customer.MarketClass_New = '') AND (s.MarketClass_New <> '')
GO


print '9. Zahn SM exception correction'
UPDATE       BRS_Customer
SET                MarketClass_New = 'MIDMKT', SegCd_New = 'DSO'
WHERE        (SalesDivision = 'AAD') AND (MarketClass_New = 'ZAHNSM')
GO

--- XXX look for cross over fixes TBD (compare curr with history - manual fixed)

/*
SELECT        c.MarketClass_New
FROM            BRS_Customer AS c INNER JOIN
                         BRS_CustomerSpecialty AS s 
						 ON c.Specialty = s.Specialty 
WHERE        (c.MarketClass_New = '') AND (s.MarketClass_New <> '')
*/

-- 9. Exceptions - Specialty? missing?
/*
UPDATE       BRS_CustomerFSC_History
SET                HIST_MarketClass_New = BRS_Customer.MarketClass_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerFSC_History ON BRS_Customer.ShipTo = BRS_CustomerFSC_History.Shipto
*/

GO

