
-- add reveal & denmat, tmc, 29 Mar 20

INSERT INTO [comm].[group]
           ([comm_group_cd]
           ,[comm_group_desc]
           ,[source_cd]
           ,[active_ind]
		   )
     VALUES
           ('EPSREV'
           ,'Reveal'
           ,'JDE'
           ,1
           ),
           ('EPSDEN'
           ,'DenMat'
           ,'JDE'
           ,1
           )
GO

---

--delete from [hfm].[exclusive_product_rule] where [Excl_Code_TargKey] in ('reveal', 'denmat')
--delete from [hfm].[exclusive_product] where [Excl_Code] in ('reveal', 'denmat')

INSERT INTO [hfm].[exclusive_product]
           ([Excl_Code]
           ,[Excl_Name]
           ,[BrandEquityCategory]
           ,[ProductCategory]
           ,[Owner]
           ,[DataSourceCode]
           ,[Excl_Code_Public]
		   ,[eps_track_ind])
     VALUES
           ('REVEAL'
           ,'REVEAL'
           ,'Exclusive'
           ,'Merchandise'
           ,'David Marks'
           ,'DW'
           ,'REVEAL'
		   ,1),
           ('DENMAT'
           ,'DENMAT'
           ,'Exclusive'
           ,'Merchandise'
           ,'David Marks'
           ,'DW'
           ,'DENMAT'
		   ,1)
GO

--delete from [hfm].[exclusive_product_rule] where [Excl_Code_TargKey] = 'REVEAL'
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
           ('MASEL%'
           ,'%'
           ,'088%'
           ,'%'
           ,'REVEAL'
           , 0
           , '.'
           , '29 Mar 20'
           , '.'
           , 1
		   )
GO

-- Test tracking reveal
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
	[Sub_Minor_Prod_Class] like '088%' 

-- denmat
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
           ('DECMAT%'
           ,'%'
           ,'022-50-10%'
           ,'%'
           ,'DENMAT'
           , 0
           , '.'
           , '29 Mar 20'
           , '.'
           , 1
		   ),
           ('DECMAT%'
           ,'%'
           ,'022-50-20%'
           ,'%'
           ,'DENMAT'
           , 0
           , '.'
           , '29 Mar 20'
           , '.'
           , 1
		   ),
           ('DECMAT%'
           ,'%'
           ,'022-50-45%'
           ,'%'
           ,'DENMAT'
           , 0
           , '.'
           , '29 Mar 20'
           , '.'
           , 1
		   ),
           ('DECMAT%'
           ,'%'
           ,'022-50-90%'
           ,'%'
           ,'DENMAT'
           , 0
           , '.'
           , '29 Mar 20'
           , '.'
           , 1
		   ),
           ('DECMAT%'
           ,'%'
           ,'023-50-20%'
           ,'%'
           ,'DENMAT'
           , 0
           , '.'
           , '29 Mar 20'
           , '.'
           , 1
		   ),
           ('DECMAT%'
           ,'%'
           ,'800-19-02%'
           ,'%'
           ,'DENMAT'
           , 0
           , '.'
           , '29 Mar 20'
           , '.'
           , 1
		   )
GO

-- Test tracking denmat
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
	[Supplier] like 'DENMAT%' 

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
	r.[Excl_Code_TargKey] IN ('REVEAL', 'DENMAT') AND
--	h.Excl_key not in (1,2) AND
	FiscalMonth BETWEEN 202001 AND 202003 AND
	(1=1)
GO




---

