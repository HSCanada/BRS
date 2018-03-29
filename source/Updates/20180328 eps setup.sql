
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

-- load new accts in dev using dimension batch file

-- set specialty to new
UPDATE       BRS_Customer
SET                Specialty = STAGE_BRS_CustomerFull.Specialty
FROM            STAGE_BRS_CustomerFull INNER JOIN
                         BRS_Customer ON STAGE_BRS_CustomerFull.ShipTo = BRS_Customer.ShipTo AND STAGE_BRS_CustomerFull.Specialty = BRS_Customer.Specialty

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





