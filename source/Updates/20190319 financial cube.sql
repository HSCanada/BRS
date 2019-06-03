-- finacial cube, 28 Mar 19

-- pop country group from DW into zzzItem

UPDATE       BRS_ItemSupplier
SET                CountryGroup = i.Note1 
FROM            zzzItem AS i INNER JOIN
                         BRS_ItemSupplier ON i.Item = BRS_ItemSupplier.Supplier AND i.Note1 <> BRS_ItemSupplier.CountryGroup
GO


-- temp load sub-minor via dw dump

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	SubMinorProductClassCode char(9) NOT NULL CONSTRAINT DF_BRS_Item_SubMinorProductClassCode DEFAULT ''
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO


UPDATE       BRS_Item
SET                SubMinorProductClassCode = s.[sum_minor]
FROM            zzz_item_subminor AS s INNER JOIN
                         BRS_Item ON s.Item = BRS_Item.Item
GO



-- drop table  [hfm].[global_taxonomy_map]

CREATE TABLE [hfm].[global_taxonomy_map](
	[SubMinorProductClassCode] [char](9) NOT NULL,
	[global_taxonomy_code] [char](9) NOT NULL CONSTRAINT [DF_hfm_global_taxonomy_map_global_taxonomy_code]  DEFAULT (''),
	[global_taxonomy_key] int Identity(1,1) NOT NULL,
	[note] [nvarchar](100) NULL,
 CONSTRAINT [hfm_global_taxonomy_map_c_pk] PRIMARY KEY CLUSTERED 
(
	[SubMinorProductClassCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

insert into [hfm].[global_taxonomy_map]
([SubMinorProductClassCode])
values ('')
GO


INSERT INTO hfm.global_taxonomy_map
                         (SubMinorProductClassCode)
SELECT DISTINCT SubMinorProductClassCode
FROM            BRS_Item where SubMinorProductClassCode <>''
GO


SELECT TOP 10 SubMinorProductClassCode, REPLACE ( SubMinorProductClassCode , '*' , '0' )   FROM hfm.global_taxonomy_map 

UPDATE       hfm.global_taxonomy_map
SET                global_taxonomy_code = REPLACE ( SubMinorProductClassCode , '*' , '0' )

go

--

ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_global_taxonomy_map FOREIGN KEY
	(
	SubMinorProductClassCode
	) REFERENCES hfm.global_taxonomy_map
	(
	SubMinorProductClassCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO



-- fix entity here...

  insert into  [hfm].[entity] 
  (  [Entity]
      ,[EntityDescr]
      ,[EntityParent]
      ,[LevelNum]
      ,[ActiveInd]
      ,[Note]
	)
  
  SELECT  'HSCanadaBusSol' as [Entity]
      ,[EntityDescr]
      ,[EntityParent]
      ,[LevelNum]
      ,[ActiveInd]
      ,[Note]
  FROM [hfm].[entity]  where [Entity] in ('HSCBS')

  update [hfm].[cost_center] 
  set  [Entity] = 'HSCanadaBusSol'
   where [Entity] in ('HSCBS')


--


  insert into  [hfm].[entity] 
  (  [Entity]
      ,[EntityDescr]
      ,[EntityParent]
      ,[LevelNum]
      ,[ActiveInd]
      ,[Note]
	)
  
  SELECT  'DentrixCanJV' as [Entity]
      ,[EntityDescr]
      ,[EntityParent]
      ,[LevelNum]
      ,[ActiveInd]
      ,[Note]
  FROM [hfm].[entity]  where [Entity] in ('CanadaDentrx')

  update [hfm].[cost_center] 
  set  [Entity] = 'DentrixCanJV'
   where [Entity] in ('CanadaDentrx')


update      [hfm].[entity]
set       [ActiveInd] = 0
where [Entity] in ('HSCBS')
go

update      [hfm].[entity]
set       [ActiveInd] = 0
where [Entity] in ('CanadaDentrx')


-- >> set RDSO, 2 Jun 19


INSERT INTO BRS_CustomerSpecialty
                         (Specialty, SpecialtyNm, SegType, SegCd, SegName, NoteTxt, StatusCd, MarketClass, LastReviewDate, MarketClass_New, SegCd_New)
SELECT        'RDSO' AS Expr2, 'regional DSO' AS Expr3, SegType, 'RDSO' AS Expr4, 'RDSO' as segname, NoteTxt, StatusCd, MarketClass, LastReviewDate, MarketClass_New, 
                         'RDSO' AS Expr1
FROM            BRS_CustomerSpecialty AS BRS_CustomerSpecialty_1
WHERE        (Specialty = 'DSO')
go


UPDATE       BRS_CustomerFSC_History
SET                HIST_Specialty = 'RDSO'
WHERE        (HIST_SegCd = 'rdso') AND (HIST_MarketClass = 'MIDMKT') AND (1 = 1)
go

-- << added