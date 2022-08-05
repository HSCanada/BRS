-- rebate model, tmc, 19 Jul 22
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemCategory ADD
	minor_adhoc_model_code1 varchar(50) NOT NULL CONSTRAINT DF_BRS_ItemCategory_minor_adhoc_model_code1 DEFAULT (''),
	minor_adhoc_model_code2 varchar(50) NOT NULL CONSTRAINT DF_BRS_ItemCategory_minor_adhoc_model_code2 DEFAULT ('')
GO
ALTER TABLE dbo.BRS_ItemCategory SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [MinorProductClass]
		,'vpa non-qualify ' + RTRIM(submajor_cd) + ' | ' + submajor_desc
      ,[minor_adhoc_model_code2]
  FROM [dbo].[BRS_ItemCategory] where LEFT([MinorProductClass],6) in(
'001-01'
,'X22-01'
,'002-01'
,'374-01'
,'012-70'
,'X25-01'
,'899-02'
,'088-15'
,'025-01'
,'900-**'
)
GO

UPDATE       BRS_ItemCategory
SET                minor_adhoc_model_code2 = 'vpa non-qualify | ' + RTRIM(submajor_cd) + ' | ' + submajor_desc
WHERE        (LEFT(MinorProductClass, 6) IN ('001-01', 'X22-01', '002-01', '374-01', '012-70', 'X25-01', '899-02', '088-15', '025-01', '900-**'))

/*
001-01	Alloys
X22-01	Demandforce
002-01	Dental anesthetic products
374-01	Digital teeth
012-70	Impression materials & access
X25-01	Orapharma agency items
899-02	Practice marketing
088-15	Reveal aligner
025-01	X-ray products
900-**	
*/

SELECT        PromotionCode, PromotionDescription, PromotionTypeTracking
FROM            BRS_Promotion
WHERE PromotionCode in ('E1', 'E2', 'GS', 'OB')
GO


UPDATE       BRS_Promotion
SET                PromotionTypeTracking = 'vpa non-qualify program'
WHERE        (PromotionCode IN ('E1', 'E2', 'GS', 'OB'))
GO


