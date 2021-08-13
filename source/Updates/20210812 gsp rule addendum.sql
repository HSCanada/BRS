-- gsp rule addendum, tmc, 12 Aug 21
-- extend EQDIG rule to picked all not Dental.  triggered by odd case of Mecical account bying 3D printer

SELECT        *
FROM            hfm.gps_code_rule
WHERE        RuleName = '17a'

SELECT * 
FROM hfm.gps_code
WHERE GpsCode = 'DIGIIMPRES'
GO

INSERT INTO hfm.gps_code_rule
                         (GLBU_Class_WhereClauseLike, BusinessUnit_WhereClauseLike, MinorProductClass_WhereClauseLike, Supplier_WhereClauseLike, SalesDivision_WhereClauseLike, Gps_Code_TargKey, Sequence, RuleName, 
                         LastReviewed, Note, StatusCd)
SELECT        GLBU_Class_WhereClauseLike, BusinessUnit_WhereClauseLike, MinorProductClass_WhereClauseLike, Supplier_WhereClauseLike, 'AAM' AS div, Gps_Code_TargKey, Sequence, '17a2' AS RuleName, 
                         LastReviewed, Note, StatusCd
FROM            hfm.gps_code_rule AS gps_code_rule_1
WHERE        (RuleName = '17a')
GO

INSERT INTO hfm.gps_code_rule
                         (GLBU_Class_WhereClauseLike, BusinessUnit_WhereClauseLike, MinorProductClass_WhereClauseLike, Supplier_WhereClauseLike, SalesDivision_WhereClauseLike, Gps_Code_TargKey, Sequence, RuleName, 
                         LastReviewed, Note, StatusCd)
SELECT        GLBU_Class_WhereClauseLike, BusinessUnit_WhereClauseLike, MinorProductClass_WhereClauseLike, Supplier_WhereClauseLike, 'AAV' AS div, Gps_Code_TargKey, Sequence, '17a3' AS RuleName, 
                         LastReviewed, Note, StatusCd
FROM            hfm.gps_code_rule AS gps_code_rule_1
WHERE        (RuleName = '17a')
GO

-- test, 
SELECT * from [dbo].[BRS_Transaction] where SalesOrderNumber = 14458918
-- success:  EQDIG mapped to 5
