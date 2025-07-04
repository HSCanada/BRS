
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW hfm.exclusive_product_rule_item
AS

/******************************************************************************
**	File: 
**	Name: hfm.exclusive_product_rule_item
**	Desc: convert hfm.exclusive_product_rule to item view to update tables
**		
**
**              
**	Return values:  
**
**	Called by:   Access as a sub-query
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 04 Mar 25
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
**	14 Apr 25	tmc		add Owned / Private Label split logic
*******************************************************************************/


-- Rule based (1 of 2)

SELECT 
	 i.item,
	i.ItemDescription,
	i.Label,
	i.Supplier,
	i.Brand,
	i.MinorProductClass,

	-- if an owned line has private label, override the BrandEquitiy

	CASE WHEN i.Label = 'P' AND r.StatusCd = 2
		THEN 'CORPORATE_BRAND' 
		ELSE p.Excl_Code 
	END  AS Excl_Code,

--	p.Excl_Code,

	CASE WHEN i.Label = 'P' AND r.StatusCd = 2
		THEN 'CorporateBrand' 
		ELSE p.BrandEquityCategory 
	END BrandEquityCategory
	-- test
	,'rule' as testsrc
FROM 
	BRS_Item i

	-- rule join
	INNER JOIN hfm.exclusive_product_rule AS r 
	ON i.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		i.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		i.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		i.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		--
		i.MinorProductClass NOT LIKE RTRIM(r.MinorProductClass_Not_WhereClauseLike) AND 
		--
		-- status 1 = honor Equity; 2 = split P Label
		(r.StatusCd between 1 and 2) AND 
		-- test
--		i.label = 'P' AND
		--
		1 = 1 

	INNER JOIN hfm.exclusive_product AS p 
	ON r.Excl_Code_TargKey = p.Excl_Code  
WHERE  
--	(FiscalMonth = @nCurrentFiscalYearmoNum)
	(1=1)

UNION ALL

-- Non-Rule based (2 of 2)

SELECT 
	 i.item,
	i.ItemDescription,
	i.Label,
	i.Supplier,
	i.Brand,
	i.MinorProductClass,

	-- supply defaults
	CASE WHEN i.Label = 'P' 
		THEN 'CORPORATE_BRAND' 
		ELSE 'BRANDED'
	END  AS Excl_Code,

	CASE WHEN i.Label = 'P' 
		THEN 'CorporateBrand' 
		ELSE 'Branded'
	END BrandEquityCategory
	-- test
	,'rule not' as testsrc

FROM 
	BRS_Item i

	-- allow non-rule
	LEFT JOIN hfm.exclusive_product_rule AS r 
	ON i.Supplier LIKE RTRIM(r.Supplier_WhereClauseLike) AND 
		i.Brand LIKE RTRIM(r.Brand_WhereClauseLike) AND 
		i.MinorProductClass LIKE RTRIM(r.MinorProductClass_WhereClauseLike) AND 
		i.Item LIKE RTRIM(r.Item_WhereClauseLike) AND 
		--
		i.MinorProductClass NOT LIKE RTRIM(r.MinorProductClass_Not_WhereClauseLike) AND 
		--
		(r.StatusCd between 1 and 2) AND 
		-- test
--		i.label = 'P' AND
		--
		1 = 1 

WHERE  
	-- exclude rules
	r.Excl_Code_TargKey is null AND
--	(FiscalMonth = @nCurrentFiscalYearmoNum)
	(1=1)


/*

	If (@nErrorCode = 0) 
	Begin
		print '10. set Exclusives - Excl_key, 1s, 1 OF 3'

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
			(FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		print '11. set private - Excl_key, 2 OF 3'

		UPDATE
			BRS_ItemHistory
		SET
			Excl_key = 1
		FROM
			BRS_ItemHistory 

			INNER JOIN BRS_ItemMPC AS mpc 
			ON mpc.MajorProductClass = LEFT(BRS_ItemHistory.MinorProductClass, 3)

		WHERE
			(BRS_ItemHistory.Label = 'P') AND 
			(mpc.PrivateLabelScopeInd = 1) AND 
			(BRS_ItemHistory.Excl_key IS NULL) AND
			(FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End


	If (@nErrorCode = 0) 
	Begin
		print '12. set Branded - Excl_key, 3 of 3'

		UPDATE
			BRS_ItemHistory
		SET
			Excl_key = 2
		FROM
			BRS_ItemHistory 
		WHERE 
			(Excl_key IS NULL) and
			(FiscalMonth = @nCurrentFiscalYearmoNum)

		Set @nErrorCode = @@Error
	End

*/
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



--

-- select top 10 * from hfm.exclusive_product_rule_item where excl_code = 'NORDENT'

-- select count(*) from hfm.exclusive_product_rule_item
-- org 20 723, 11s

/*
-- test for dups , sb Zero lines
select item, count(*) cnt from hfm.exclusive_product_rule_item
group by item
having count(*) > 1

*/

/*
select BrandEquityCategory, Excl_Code, count(*) cnt from hfm.exclusive_product_rule_item
group by BrandEquityCategory, Excl_Code
*/

/*

excl_code	BrandEquityCategory	P status
CARINA              	Owned	Ignore P
ESSENTIALS_HEALTH   	Owned	Ignore P
ORTHO_ORGANIZERS    	Owned	Ignore P
ZIRLUX              	Owned	Ignore P

CLINICIANS_CHOICE   	Owned	Split P
NORDENT             	Owned	Split P
DUKAL               	Strategic	Split P
MDT                 	Strategic	Split P
MICROCOPY           	Strategic	Split P

*/

-- select distinct excl_code, BrandEquityCategory from [hfm].[exclusive_product]

select Excl_Code, BrandEquityCategory, count(*) cnt from hfm.exclusive_product_rule_item
where Excl_Code in (
'CARINA'
,'ESSENTIALS_HEALTH'
,'ORTHO_ORGANIZERS'
,'ZIRLUX'

,'CLINICIANS_CHOICE'
,'NORDENT'
,'DUKAL'
,'MDT'
,'MICROCOPY'
)
group by 
BrandEquityCategory
,excl_code
order by 1

/*

select * from hfm.exclusive_product_rule
where
statuscd <>0 and
[Excl_Code_TargKey] in (
'CLINICIANS_CHOICE'
,'NORDENT'
,'DUKAL'
,'MDT'
,'MICROCOPY'
)

UPDATE  hfm.exclusive_product_rule
SET        StatusCd = 2
WHERE   (StatusCd <> 0) AND (Excl_Code_TargKey IN ('CLINICIANS_CHOICE', 'NORDENT', 'DUKAL', 'MDT', 'MICROCOPY'))
*/


/*
-- ORG
Excl_Code            BrandEquityCategory            cnt
-------------------- ------------------------------ -----------
CARINA               CorporateBrand                 2
CLINICIANS_CHOICE    Owned                          2251
CLINICIANS_CHOICE    CorporateBrand                 91
DUKAL                Strategic                      55
DUKAL                CorporateBrand                 19
MDT                  CorporateBrand                 390
MICROCOPY            CorporateBrand                 3
MICROCOPY            Strategic                      472
NORDENT              Owned                          741
NORDENT              CorporateBrand                 64
ORTHO_ORGANIZERS     CorporateBrand                 971
ORTHO_ORGANIZERS     Owned                          97
ZIRLUX               CorporateBrand                 495

(13 rows affected)
*/

/*
-- new
Excl_Code            BrandEquityCategory            cnt
-------------------- ------------------------------ -----------
CARINA               Owned                          2
CLINICIANS_CHOICE    Owned                          2251
DUKAL                Strategic                      55
MICROCOPY            Strategic                      472
NORDENT              Owned                          741
ORTHO_ORGANIZERS     Owned                          1068
ZIRLUX               Owned                          495

(12 rows affected)
*/

/*
-- prod org
Excl_Code            BrandEquityCategory            cnt
-------------------- ------------------------------ -----------
CLINICIANS_CHOICE    Owned                          2342
DUKAL                Strategic                      538
ESSENTIALS_HEALTH    Owned                          86
MDT                  Strategic                      390
MICROCOPY            Strategic                      475
NORDENT              Owned                          815
ORTHO_ORGANIZERS     Owned                          1066
ZIRLUX               Owned                          489

-- prod new
Excl_Code            BrandEquityCategory            cnt
-------------------- ------------------------------ -----------
CLINICIANS_CHOICE    Owned                          2251
DUKAL                Strategic                      518
ESSENTIALS_HEALTH    Owned                          86
MICROCOPY            Strategic                      472
NORDENT              Owned                          751
ORTHO_ORGANIZERS     Owned                          1066
ZIRLUX               Owned                          489



*/


select item, ItemDescription, MinorProductClass, BrandEquityCategory, Excl_Code, label, testsrc from hfm.exclusive_product_rule_item where item in ('1426551', '5703122')
