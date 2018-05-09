-- Special Market update for 2018
-- 26 Apr 18

-- prod

-- archive current status

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
*/


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


--- update Customer MarketClass_NEW

print '0. show current groups'
SELECT   MarketClass_New, COUNT(*) as cust_count
FROM BRS_Customer
GROUP BY MarketClass_New


print '1. clear'
UPDATE       BRS_Customer
SET                MarketClass_New = ''
GO

print ' 2. Set non Dental based on Division'
UPDATE       BRS_Customer
SET                MarketClass_New = d.MarketClass_New
FROM            BRS_Customer INNER JOIN
                         BRS_SalesDivision AS d 
						 ON BRS_Customer.SalesDivision = d.SalesDivision
WHERE        (BRS_Customer.SalesDivision <> 'AAD')
GO

print '3. Set DCC based on BT=2613256 (Elite)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'ELITE'
WHERE        (BillTo = 2613256) AND (MarketClass_New = '')
GO

print '3b. Set DCC based on Specialty (Various)'
UPDATE       BRS_Customer
SET                MarketClass_New = s.MarketClass_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerSpecialty AS s ON BRS_Customer.Specialty = s.Specialty
WHERE        
	(BRS_Customer.MarketClass_New = '') AND 
	(BRS_Customer.CustGrpWrk = 'Dental Corp') AND
	(s.MarketClass_New <> '') 
GO

print '3c. Set DCC based on DSO (Exception)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'PVTPRC'
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
SET                MarketClass_New = 'ELITE'
WHERE        (BillTo = 1765054) AND (MarketClass_New = '')

GO

/*
SELECT   MarketClass_New, COUNT(*) as cust_count
FROM BRS_Customer
where BillTo = 1765054
GROUP BY MarketClass_New
*/

print '5. Set Dental Students (INSTIT)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'INSTIT'
WHERE        (Specialty	LIKE 'STU%') AND (MarketClass_New = '')
/*
SELECT   MarketClass_New, COUNT(*) as cust_count
FROM BRS_Customer
WHERE Specialty	LIKE 'STU%'
GROUP BY MarketClass_New
*/

-- data cleanup - done

print '6. MM Groups with VPAs'
UPDATE       BRS_Customer
SET                MarketClass_New = g.MarketClass_New
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
SET                MarketClass_New = g.MarketClass_New 
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
SET                MarketClass_New = s.MarketClass_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerSpecialty AS s ON BRS_Customer.Specialty = s.Specialty
WHERE        (BRS_Customer.MarketClass_New = '') AND (s.MarketClass_New <> '')
GO

/*
SELECT        c.MarketClass_New
FROM            BRS_Customer AS c INNER JOIN
                         BRS_CustomerSpecialty AS s 
						 ON c.Specialty = s.Specialty 
WHERE        (c.MarketClass_New = '') AND (s.MarketClass_New <> '')
*/

-- 9. Exceptions - Specialty? missing?

UPDATE       BRS_CustomerFSC_History
SET                HIST_MarketClass_New = BRS_Customer.MarketClass_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerFSC_History ON BRS_Customer.ShipTo = BRS_CustomerFSC_History.Shipto


GO





