--gp model backend, tmc 15 Mar 22

-- DS vs DW, test

SELECT        ds.FiscalMonth, ds.SalesOrderNumberKEY, ds.DocType, ds.LineNumber, ds.GLBU_Class, dw.SalesOrderNumber, ds.NetSalesAmt, ds.ExtendedCostAmt, ds.LineTypeOrder
FROM            BRS_Transaction AS ds LEFT OUTER JOIN
                         BRS_TransactionDW AS dw ON ds.LineNumber = dw.LineNumber AND ds.DocType = dw.DocType AND ds.SalesOrderNumber = dw.SalesOrderNumber
WHERE
(ds.DocType not in ('AA', 'SX')) AND
(ds.GLBU_Class not in ('FREIG', 'FRTEQ')) AND
(ds.FiscalMonth >= 201901) AND 
(dw.SalesOrderNumber IS NULL)
order by 1

/*
SELECT        *
FROM           BRS_TransactionDW 
WHERE
(DocType ='SX') 
*/

-- add ID to ref DS to DW
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	ID_source_ref int NULL
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_BRS_TransactionDW FOREIGN KEY
	(
	ID_source_ref
	) REFERENCES dbo.BRS_TransactionDW
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- run update data history (by year), past fix

UPDATE
	BRS_Transaction
SET
	ID_source_ref = dw.ID
FROM
	BRS_Transaction 
	INNER JOIN BRS_TransactionDW AS dw 
	ON BRS_Transaction.LineNumber = dw.LineNumber AND BRS_Transaction.DocType = dw.DocType AND BRS_Transaction.SalesOrderNumber = dw.SalesOrderNumber
WHERE
	(BRS_Transaction.DocType NOT IN ('AA', 'SX')) AND 
	(BRS_Transaction.GLBU_Class NOT IN ('FREIG', 'FRTEQ')) AND 
	(BRS_Transaction.ID_source_ref IS NULL) AND
	(BRS_Transaction.FiscalMonth BETWEEN 202101 AND 202112)
GO

-- run update for future fix
-- [dbo].[BRS_BE_Transaction_post_proc] 

--test
SELECT        ds.FiscalMonth, ds.SalesDate, ds.SalesOrderNumberKEY, ds.DocType, ds.LineNumber, ds.GLBU_Class, dw.SalesOrderNumber, ds.NetSalesAmt, ds.ExtendedCostAmt, ds.LineTypeOrder
FROM            BRS_Transaction AS ds INNER JOIN
                         BRS_TransactionDW AS dw ON ds.LineNumber = dw.LineNumber AND ds.DocType = dw.DocType AND ds.SalesOrderNumber = dw.SalesOrderNumber
WHERE
(ds.DocType not in ('AA', 'SX')) AND
(ds.GLBU_Class not in ('FREIG', 'FRTEQ')) AND
(ds.FiscalMonth between 202201 and 202212) AND 
(ds.ID_source_ref IS NULL)
order by 2

-- Q -> L
INSERT INTO BRS_Customer_Spend_Category
                         (SalesDivision, Spend_From, Spend_To, Spend_Display, Spend_Rank, Spend_Discount_Rate, Spend_Category)
SELECT        'AAM' AS SalesDivision, Spend_From, Spend_To, Spend_Display, Spend_Rank, Spend_Discount_Rate, 'L' AS Spend_Category
FROM            BRS_Customer_Spend_Category AS BRS_Customer_Spend_Category_1
WHERE        (Spend_Category = N'Q')


SELECT        EntityKey, HFM_Account_key, global_product_class_key, Excl_Key, MarketClassKey, gps_key, SupplierKey, DocTypeKey, FiscalMonth, ID, GLBU_ClassKey, SalesDivision_key, SalesDate_ORG, day_key, Shipto, ItemKey, 
                         BranchKey, AdjCodeKey, SalesOrderNumber, LineNumber, FreeGoodsEstInd, sales_amt, gp_amt, gm_line, gm_line_key, PriceMethodKey
FROM            Fact.global_cube