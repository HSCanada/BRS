-- Cube - add ace to exclusive, tmc, 1 Oct 19


INSERT INTO [hfm].[exclusive_product]
           ([Excl_Code]
           ,[Excl_Name]
           ,[BrandEquityCategory]
           ,[ProductCategory]
           ,[Owner]
           ,[DataSourceCode]
           ,[Excl_Code_Public])
     VALUES
           ('ZIRLUX'
           ,'ZIRLUX'
           ,'Exclusive'
           ,'Merchandise'
           ,'Barb Brown'
           ,'DW'
           ,'ZIRLUX')
GO


--delete from [hfm].[exclusive_product_rule] where [Excl_Code_TargKey] = 'ZIRLUX'

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
           ('%'
           ,'%'
           ,'372-01-05%'
           ,'%'
           ,'ZIRLUX'
           , 0
           , '.'
           , '8 oct 19'
           , '.'
           , 1
		   ),

           ('%'
           ,'%'
           ,'372-02-10%'
           ,'%'
           ,'ZIRLUX'
           , 0
           , '.'
           , '8 oct 19'
           , '.'
           , 1
		   ),

           ('%'
           ,'%'
           ,'372-02-40%'
           ,'%'
           ,'ZIRLUX'
           , 0
           , '.'
           , '8 oct 19'
           , '.'
           , 1
		   ),

           ('%'
           ,'%'
           ,'372-03-10%'
           ,'%'
           ,'ZIRLUX'
           , 0
           , '.'
           , '8 oct 19'
           , '.'
           , 1
		   )

GO


-- Test item, exclusive 1 or 2.  seems OK

SELECT 
	[Item]      
	,[ItemDescription]
	,[MinorProductClass]
	,[Supplier]

FROM [dbo].[BRS_Item]
where 
	[MinorProductClass] like '372-01-05%' OR
	[MinorProductClass] like '372-02-10%' OR
	[MinorProductClass] like '372-02-40%' OR
	[MinorProductClass] like '372-03-10%' 

-- Test, ok, Zirlux NOT tracking

SELECT TOP (1000) [Item_Number]
      ,[Item_Description]
      ,[Major_Product_Class]
      ,[Major_Product_Class_Description]
      ,[Sub_Minor_Prod_Class]
      ,[Sub_Minor_Prod_Class_Description]
      ,[Supplier]
      ,[Supplier_Description]
      ,[Item_Create_Date]
      ,[Item_Status]
      ,[Stocking_Type]
FROM [eps].[Item] 
where 
	[Sub_Minor_Prod_Class] like '372-01-05%' OR
	[Sub_Minor_Prod_Class] like '372-02-10%' OR
	[Sub_Minor_Prod_Class] like '372-02-40%' OR
	[Sub_Minor_Prod_Class] like '372-03-10%' 



---

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
	r.[Excl_Code_TargKey] = 'ZIRLUX' AND
	h.Excl_key not in (1,2) AND
	FiscalMonth BETWEEN 201801 AND 201910 AND
	(1=1)
GO

-- test good = 14024

print 'set Zirlux to Exclusives'
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
	r.[Excl_Code_TargKey] = 'ZIRLUX' AND
	FiscalMonth BETWEEN 201801 AND 201910
GO
