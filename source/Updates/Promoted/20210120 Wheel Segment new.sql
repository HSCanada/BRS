--Wheel Segment 2021, tmc 20 Jan 20

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_BusinessUnitClass ADD
	CategoriesServed varchar(50) NOT NULL CONSTRAINT DF_BRS_BusinessUnitClass_CategoriesServed DEFAULT ''
GO
ALTER TABLE dbo.BRS_BusinessUnitClass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- populate

UPDATE [dbo].[BRS_BusinessUnitClass]
   SET 
      [CategoriesServed]='7.Practice Services'
 WHERE 
   [GLBU_Class] in('BSOLN', 'LEASE')

GO

--
UPDATE [dbo].[BRS_BusinessUnitClass]
   SET 
      [CategoriesServed]='5.Henry Schein One'
 WHERE 
   [GLBU_Class] in('DTXSP')

GO
--
UPDATE [dbo].[BRS_BusinessUnitClass]
   SET 
      [CategoriesServed]='3.Equipment and Hi Tech'
 WHERE 
   [GLBU_Class] in('EQUIP', 'HITEC', 'DTXHW' )

GO

--
UPDATE [dbo].[BRS_BusinessUnitClass]
   SET 
      [CategoriesServed]='4.Digital Tech'
 WHERE 
   [GLBU_Class] in('EQDIG', 'HICAD' )

GO

--
UPDATE [dbo].[BRS_BusinessUnitClass]
   SET 
      [CategoriesServed]='1+2.Merchandise (Total)'
 WHERE 
   [GLBU_Class] in('MECAD', 'MERCH', 'SMEQU', 'MECAZ', 'MEDIC', 'VETER' )

GO

UPDATE [dbo].[BRS_BusinessUnitClass]
   SET 
      [CategoriesServed]='6.Equipment Service'
 WHERE 
   [GLBU_Class] in('PARTS', 'LABOU' )

GO

--
UPDATE [dbo].[BRS_BusinessUnitClass]
   SET 
      [CategoriesServed]='zOther'
 WHERE 
   [GLBU_Class] in('FREIG', 'FRTEQ', 'TEETH', 'EXNSW' )

GO

--

UPDATE [dbo].[BRS_BusinessUnitClass]
   SET 
      [CategoriesServed]='zOther'
 WHERE 
   [CategoriesServed]=''

GO

--
