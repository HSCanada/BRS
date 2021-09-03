-- msg top 15, tmc, 17 Aug 21

-- add top 15 to match US standard

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	top15_desc varchar(50) NOT NULL CONSTRAINT DF_BRS_ItemMPC_top15_desc DEFAULT ('')
GO
ALTER TABLE dbo.BRS_ItemMPC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- populate top 15 based on web report

-- 1 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Restorative materials'
WHERE        (MajorProductClass in ('004', '001') )
GO

-- 2 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Infection control products'
WHERE        (MajorProductClass in ('013') )
GO

-- 3 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Impression materials & access'
WHERE        (MajorProductClass in ('012') )
GO

-- 4 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Gloves'
WHERE        (MajorProductClass in ('054') )
GO

-- 5 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Preventive products'
WHERE        (MajorProductClass in ('020', '060', '915') )
GO

-- 6 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Rotary instruments'
WHERE        (MajorProductClass in ('021') )
GO

-- 7 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Dental anesthetic products'
WHERE        (MajorProductClass in ('002') )
GO

-- 8 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Dental hand instruments'
WHERE        (MajorProductClass in ('010') )
GO

-- 9 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Handpieces'
WHERE        (MajorProductClass in ('011') )
GO

-- 10 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Disposable exam room products'
WHERE        (MajorProductClass in ('006', '008', '124') )
GO

-- 11 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Cements - liners - bases'
WHERE        (MajorProductClass in ('003') )
GO

-- 12 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Endodontic products'
WHERE        (MajorProductClass in ('007') )
GO

-- 13 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'X-ray products'
WHERE        (MajorProductClass in ('025') )
GO

-- 14 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Dental small equipment'
WHERE        (MajorProductClass in ('023') )
GO

-- 15 of 15
UPDATE       BRS_ItemMPC
SET                top15_desc = 'Crown & bridge products'
WHERE        (MajorProductClass in ('005') )
GO

-- test, should be 15 + blank
SELECT distinct top15_desc
FROM   BRS_ItemMPC
GO






