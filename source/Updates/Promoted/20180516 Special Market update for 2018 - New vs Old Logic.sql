-- Special Market update for 2018
-- 16 May 18


-- update NEW
UPDATE       BRS_Customer
SET                Specialty = STAGE_BRS_CustomerFull.Specialty
FROM            STAGE_BRS_CustomerFull INNER JOIN
                         BRS_Customer 
						 ON STAGE_BRS_CustomerFull.ShipTo = BRS_Customer.ShipTo AND 
							(1=1)

-- set to NEW
UPDATE       
	BRS_Customer
SET
	SegCd = [SegCd_New],
	MarketClass = [MarketClass_New]
FROM BRS_Customer 

GO

-- set historical NEW
UPDATE       BRS_CustomerFSC_History
SET                HIST_MarketClass = HIST_MarketClass_New, HIST_SegCd = HIST_SegCd_New
							
-- revert OLD
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
GO

-- revert OLD history
UPDATE       BRS_CustomerFSC_History
SET                HIST_MarketClass = HIST_MarketClass_Old, HIST_SegCd = HIST_SegCd_Old
GO

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

---
/*

-- SM reset
print '1. clear'
UPDATE       BRS_Customer
SET                MarketClass = '', SegCd = ''
GO


UPDATE       BRS_Customer
SET                MarketClass = [HIST_MarketClass], SegCd = [HIST_SegCd]
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerFSC_History ON BRS_Customer.ShipTo = BRS_CustomerFSC_History.Shipto
WHERE
	BRS_CustomerFSC_History.FiscalMonth = 201804

SELECT        BRS_Customer.shipto, BRS_Customer.MarketClass, BRS_Customer.SegCd
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerFSC_History ON BRS_Customer.ShipTo = BRS_CustomerFSC_History.Shipto
WHERE        
(BRS_CustomerFSC_History.FiscalMonth = 201805) AND
(MarketClass <> [HIST_MarketClass] OR
SegCd <> [HIST_SegCd])

UPDATE       BRS_CustomerFSC_History
SET                [HIST_MarketClass] = MarketClass,  [HIST_SegCd] = SegCd 
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerFSC_History ON BRS_Customer.ShipTo = BRS_CustomerFSC_History.Shipto
WHERE
	BRS_CustomerFSC_History.FiscalMonth = 201805

*/



--> START

print '1. clear'
UPDATE       BRS_Customer
SET                MarketClass_New = '', SegCd_New = ''
GO

-- Division Set
print ' 2. Set non Dental based on Division'
UPDATE       BRS_Customer
SET                MarketClass_New = d.MarketClass_New, SegCd_New = '' 
FROM            
	BRS_Customer INNER JOIN

    BRS_SalesDivision AS d 
	ON BRS_Customer.SalesDivision = d.SalesDivision
WHERE        
	(BRS_Customer.SalesDivision <> 'AAD') AND 
	(BRS_Customer.MarketClass_New = '') 
GO

-- DCC BT set
print '3. Set DCC based on BT=2613256 (Elite)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'ELITE', SegCd_New = 'NDSO'
WHERE        (BillTo = 2613256) AND (MarketClass_New = '')
GO

print '3b. Set DCC based on BT=2613256 (Zahn -> ZahnSM)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'ZAHNSM', SegCd_New = 'DSO'
WHERE        (BillTo = 2613256) AND (SalesDivision = 'AAL')
GO

print '3c. Set DCC based on Specialty (Various)'
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

print '3d. Set DCC based on DSO (Exception)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'PVTPRC', SegCd_New = ''
FROM            BRS_Customer 
WHERE        
	(BRS_Customer.MarketClass_New = '') AND 
	(BRS_Customer.CustGrpWrk = 'Dental Corp') AND
	(BRS_Customer.Specialty = 'DSO')
GO	

-- AO BT Set
print '4. Set Alpha Omega based on BT=1765054 (ELITE)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'ELITE', SegCd_New = 'NDSO'
WHERE        (BillTo = 1765054) AND (MarketClass_New = '')
GO

print '5a. Set Dental Students - Primary (INSTIT)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'INSTIT', SegCd_New = 'PDS'
WHERE        (Specialty	= 'STUD') AND (MarketClass_New = '')
GO

print '5b. Set Dental Students (INSTIT)'
UPDATE       BRS_Customer
SET                MarketClass_New = 'INSTIT', SegCd_New = 'DSH'
WHERE        (Specialty	= 'STUA') AND (MarketClass_New = '')
GO

print '6. Zahn SM Exception'
UPDATE       BRS_Customer
SET                MarketClass_New = 'ZAHNSM', SegCd_New = 'DSO'
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerGroup AS g ON BRS_Customer.CustGrpWrk = g.CustGrp
WHERE        (BRS_Customer.MarketClass_New = 'ZAHN') AND (g.MarketClass_New = 'ZAHNSM')
GO

print '7. MM Groups with VPAs'
UPDATE       BRS_Customer
SET                MarketClass_New = g.MarketClass_New, SegCd_New = g.SegCd_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerVPA AS v 
						 ON BRS_Customer.VPA = v.VPA AND BRS_Customer.VPA = v.VPA 

						 INNER JOIN BRS_CustomerGroup AS g 
						 ON v.CustGrp = g.CustGrp
WHERE        (BRS_Customer.MarketClass_New = '') AND (v.CustGrp <> '') AND (g.MarketClass_New <> '')
GO

print '8. MM Groups with no VPAs'
UPDATE       BRS_Customer
SET                MarketClass_New = g.MarketClass_New, SegCd_New = g.SegCd_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerGroup AS g ON BRS_Customer.CustGrpWrk = g.CustGrp
WHERE        (BRS_Customer.MarketClass_New = '') AND (g.MarketClass_New <> '')
GO

print '9. Set No Group based on Specialty'
UPDATE       BRS_Customer
SET                MarketClass_New = s.MarketClass_New, SegCd_New = s.SegCd_New
FROM            BRS_Customer INNER JOIN
                         BRS_CustomerSpecialty AS s ON BRS_Customer.Specialty = s.Specialty
WHERE        (BRS_Customer.MarketClass_New = '') AND (s.MarketClass_New <> '')
GO

print '10. Zahn SM exception correction'
UPDATE       BRS_Customer
SET                MarketClass_New = 'MIDMKT', SegCd_New = 'DSO'
WHERE        (SalesDivision = 'AAD') AND (MarketClass_New = 'ZAHNSM')
GO

print '11. Dental Specialty exception correction'
UPDATE       BRS_Customer
SET                MarketClass_New = 'PVTPRC', SegCd_New = ''
WHERE        (SalesDivision = 'AAD') AND (MarketClass_New In ('ANIMAL','MEDICL','ZAHN'))
GO

--> STOP


BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT FK_BRS_CustomerGroup_BRS_CustomerSpecialty
GO
ALTER TABLE dbo.BRS_CustomerSpecialty SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT FK_BRS_CustomerGroup_BRS_CustomerMarketClass
GO
ALTER TABLE dbo.BRS_CustomerMarketClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT DF_BRS_CustomerGroup_MarketClass
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP CONSTRAINT DF_BRS_CustomerGroup_Specialty
GO
ALTER TABLE dbo.BRS_CustomerGroup
	DROP COLUMN MarketClass, Specialty
GO
ALTER TABLE dbo.BRS_CustomerGroup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
