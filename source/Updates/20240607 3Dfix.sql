-- 3Dfix, tmc, 7 Jun 24

SELECT BRS_Transaction.FiscalMonth, BRS_Transaction.SalesDivision, BRS_Transaction.GLBU_Class, BRS_Transaction.GL_BusinessUnit, BRS_Transaction.OrderSourceCode, BRS_Transaction.MajorProductClass, BRS_Transaction.SalesOrderNumber, BRS_Transaction.InvoiceNumber, BRS_Transaction.SalesDate, BRS_Transaction.NetSalesAmt
FROM BRS_Transaction
WHERE (((BRS_Transaction.FiscalMonth)>=202301) AND ((BRS_Transaction.GLBU_Class)<>'EQDIG') AND ((BRS_Transaction.GL_BusinessUnit) Like '020051%' Or (BRS_Transaction.GL_BusinessUnit) Like '020023%') AND ((BRS_Transaction.MajorProductClass) Like '344%'))

UPDATE       BRS_Transaction
SET                GLBU_Class = 'EQDIG'
WHERE        (FiscalMonth >= 202301) AND (GLBU_Class <> 'EQDIG') AND (GL_BusinessUnit LIKE '020051%' OR
                         GL_BusinessUnit LIKE '020023%') AND (MajorProductClass LIKE '344%')
GO

