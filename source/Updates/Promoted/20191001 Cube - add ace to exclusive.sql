-- Cube - add ace to exclusive, tmc, 1 Oct 19

INSERT INTO [hfm].[exclusive_product_rule]
           ([Supplier_WhereClauseLike]
           ,[Brand_WhereClauseLike]
           ,[MinorProductClass_WhereClauseLike]
           ,[Item_WhereClauseLike]
           ,[Excl_Code_TargKey]
           ,[Sequence]
           ,[RuleName]
           ,[LastReviewed]
           ,[Note]
           ,[StatusCd])
     VALUES
           ('ACESUR'
           ,'%'
           ,'%'
           ,'%'
           ,'ACE'
           , 0
           , '.'
           , '1 oct 19'
           , '.'
           , 1
		   )
GO


-- test

SELECT 
h.*, p.[Excl_Key] 
from
	BRS_ItemHistory h
	INNER JOIN hfm.exclusive_product_rule AS r 
	ON h.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		h.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		h.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		h.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		1 = 1 
	INNER JOIN hfm.exclusive_product AS p 
	ON r.Excl_Code_TargKey = p.Excl_Code  
WHERE        
	(r.StatusCd = 1) AND 
	h.Supplier = 'ACESUR' AND
	FiscalMonth BETWEEN 201901 AND 201908 AND
	
	h.Excl_key <>2

GO



print 'set ACE to Exclusives'
UPDATE       
	BRS_ItemHistory
SET
	Excl_key = p.[Excl_Key]
FROM
	BRS_ItemHistory 
	INNER JOIN hfm.exclusive_product_rule AS r 
	ON BRS_ItemHistory.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		BRS_ItemHistory.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		BRS_ItemHistory.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		BRS_ItemHistory.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		1 = 1 
	INNER JOIN hfm.exclusive_product AS p 
	ON r.Excl_Code_TargKey = p.Excl_Code  
WHERE        
	(r.StatusCd = 1) AND 
	BRS_ItemHistory.Supplier = 'ACESUR' AND
	FiscalMonth BETWEEN 201801 AND 201909
GO


