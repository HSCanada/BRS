
-- eps setup, 28 Mar 18

CREATE SCHEMA [eps] AUTHORIZATION [dbo]
GO

ALTER TABLE hfm.exclusive_product ADD
	eps_track_ind bit NOT NULL CONSTRAINT DF_exclusive_product_eps_track_ind DEFAULT (0)
GO

-- [group_type] = 'DEPS'

-- add new specialty

INSERT INTO BRS_CustomerSpecialty
                         (Specialty, SpecialtyNm, SegType, SegCd, SegName, AddedDt, NoteTxt, StatusCd, MarketClass, LastReviewDate)
SELECT        Specialty, SpecialtyNm, SegType, SegCd, SegName, AddedDt, NoteTxt, StatusCd, MarketClass, LastReviewDate
FROM            BRSales.dbo.BRS_CustomerSpecialty AS src
where not exists (SELECT * FROM BRS_CustomerSpecialty dst where dst.Specialty = src.Specialty)


-- add new tracking

INSERT INTO hfm.exclusive_product
                         (Excl_Code, Excl_Name, BrandEquityCategory, ProductCategory, Owner, DataContact, DataSourceCode, EffectivePeriod, ExpiredPeriod)
VALUES        (N'EDGE_ENDO', N'Edge Endo', N'', N'', N'', N'', 'DW', 201801, 204012)

INSERT INTO hfm.exclusive_product
                         (Excl_Code, Excl_Name, BrandEquityCategory, ProductCategory, Owner, DataContact, DataSourceCode, EffectivePeriod, ExpiredPeriod)
VALUES        (N'CHANNELS', N'Channels', N'', N'', N'', N'', 'DW', 201601, 204012)

INSERT INTO hfm.exclusive_product_rule
                         (Supplier_WhereClauseLike, Brand_WhereClauseLike, MinorProductClass_WhereClauseLike, Item_WhereClauseLike, Excl_Code_TargKey, Sequence, RuleName, 
                         StatusCd)
VALUES        ('USENDO', '%', '%', '%', N'EDGE_ENDO', 0, '.', 1)

INSERT INTO hfm.exclusive_product_rule
                         (Supplier_WhereClauseLike, Brand_WhereClauseLike, MinorProductClass_WhereClauseLike, Item_WhereClauseLike, Excl_Code_TargKey, Sequence, RuleName, 
                         StatusCd)
VALUES        ('%', 'INENDO', '%', '%', N'CHANNELS', 0, '.', 1)

UPDATE       hfm.exclusive_product
SET                eps_track_ind = 1
WHERE        (Excl_Code IN ('CAO', 'CAO_LASER', 'MILESTONE', 'ORTHO_TECHNOLOGIES', 'OSSTELL', 'EDGE_ENDO', 'CHANNELS'))

-- add fiscal week

ALTER TABLE dbo.BRS_SalesDay ADD
	FiscWeekName char(10) NOT NULL CONSTRAINT DF_BRS_SalesDay_FiscWeekName DEFAULT ('')
GO


CREATE TABLE [dbo].[zzzDay](
	[day] [date] NOT NULL,
	[week] [nchar](10) NOT NULL,
 CONSTRAINT [PK_zzzDay] PRIMARY KEY CLUSTERED 
(
	[day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

-- load from excel
[dbo].[zzzDay]

UPDATE       BRS_SalesDay
SET                FiscWeekName = s.week
FROM            DEV_BRSales.dbo.zzzDay s INNER JOIN
                         BRS_SalesDay ON s.day = BRS_SalesDay.SalesDate

-- SELECT * FROM BRS_SalesDay WHERE FiscWeekName =''

SELECT * FROM BRS_SalesDay where FiscalWeek = 12786

UPDATE       BRS_SalesDay
SET                FiscalWeek = w.fweek
FROM            
	BRS_SalesDay d 
	INNER JOIN 
	(
		SELECT        FiscWeekName, MIN(DaySeq) AS fweek
		FROM            BRS_SalesDay
		GROUP BY FiscWeekName
	) w
ON 
	d.FiscWeekName = w.FiscWeekName

-- test
SELECT        FiscalWeek, MIN(FiscalMonth) AS minf, MAX(FiscalMonth) AS maxf
FROM            BRS_SalesDay
where FiscalMonth between 201701 and 201812
GROUP BY FiscalWeek
HAVING MIN(FiscalMonth) <> MAX(FiscalMonth)

GRANT EXECUTE ON [eps].[Sales_proc] TO [dbo];

---
-- load new accts in dev using dimension batch file

select [TerritoryCd], [FSCName], [FSCStatusCode], [Branch], [group_type] from [dbo].[BRS_FSC_Rollup] where [Branch] = ''

-- set specialty to new
-- test
SELECT Shipto, salesdivision, Specialty, [UserAreaTxt]
FROM BRS_Customer
WHERE 
	salesdivision = 'AAD' AND
	Specialty <> [UserAreaTxt]
	

-- store
UPDATE       BRS_Customer
SET               [UserAreaTxt] = Specialty 
                       
-- update
UPDATE       BRS_Customer
SET                Specialty = STAGE_BRS_CustomerFull.Specialty
FROM            STAGE_BRS_CustomerFull INNER JOIN
                         BRS_Customer 
						 ON STAGE_BRS_CustomerFull.ShipTo = BRS_Customer.ShipTo AND 
--							STAGE_BRS_CustomerFull.Specialty = BRS_Customer.Specialty AND
							(1=1)

--XXX todo
-- recall
UPDATE       BRS_Customer
SET				Specialty = [UserAreaTxt]

SELECT        hfm.exclusive_product.Excl_Code, hfm.exclusive_product.Excl_Name, hfm.exclusive_product.eps_track_ind, hfm.exclusive_product_rule.StatusCd
FROM            hfm.exclusive_product INNER JOIN
                         hfm.exclusive_product_rule ON hfm.exclusive_product.Excl_Code = hfm.exclusive_product_rule.Excl_Code_TargKey
WHERE        (hfm.exclusive_product.eps_track_ind = 1)