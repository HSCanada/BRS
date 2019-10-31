-- Free Good redeem model, tmc, 22 Oct 19

-- confirm FG map:  FG Act to DW Trans

SELECT 
	[CalMonth]
	,[SalesOrderNumber]
	,[DocType]
	,[Item]
	,[SourceCode]
	,[ShipTo]
	,[ExtFileCostCadAmt]
	,[ID]
FROM [CommBE].[dbo].[comm_free_goods_redeem] r
WHERE
	[SourceCode] IN ('ACT', 'ACR') AND
	[CalMonth] >= 201801 AND
	NOT EXISTS (
		SELECT * FROM [dbo].[BRS_TransactionDW] t 
		where 
			t.[SalesOrderNumber] = r.SalesOrderNumber AND
			t.[Item] = r.Item AND
			t.FreeGoodsInvoicedInd = 1 AND
			(1=1)
	) AND
	(1=1)

order by 7 desc


-- set redeem, test

SELECT * FROM [dbo].[BRS_TransactionDW] t 
where 
	t.CalMonth = 201907 AND
	t.FreeGoodsInvoicedInd = 1 AND	
	t.DocType = 'SE' AND

	NOT EXISTS (
		SELECT * FROM [CommBE].[dbo].[comm_free_goods_redeem] r
		WHERE 
			[SourceCode] IN ('ACT', 'ACR') AND
			t.[SalesOrderNumber] = r.SalesOrderNumber AND
			t.[Item] = r.Item AND
			(1=1)
		)


-- set redeem, do it!

SELECT * FROM [dbo].[BRS_TransactionDW] t 
where 
	t.CalMonth = 201712 AND
	t.FreeGoodsInvoicedInd = 1 AND	

	EXISTS (
		SELECT * FROM [CommBE].[dbo].[comm_free_goods_redeem] r
		WHERE 
			[SourceCode] IN ('ACT', 'ACR') AND
			t.[SalesOrderNumber] = r.SalesOrderNumber AND
			t.[Item] = r.Item AND
			(1=1)
		)


UPDATE
	BRS_TransactionDW
SET                
	FreeGoodsRedeemedInd = 1
WHERE
	(CalMonth >= 201712) AND 
	(FreeGoodsInvoicedInd = 1) AND 
	EXISTS (
		SELECT        * 
		FROM            CommBE.dbo.comm_free_goods_redeem AS r
		WHERE        (SourceCode IN ('ACT', 'ACR')) AND (BRS_TransactionDW.SalesOrderNumber = SalesOrderNumber) AND (BRS_TransactionDW.Item = Item) AND (1 = 1)
	)

---

-- 20191024 Free Goods model, tmc

ALTER TABLE dbo.BRS_CustomerVPA ADD
	FreeGoodsEstInd bit NOT NULL CONSTRAINT DF_BRS_CustomerVPA_FreeGoodsEstInd DEFAULT 1
GO

ALTER TABLE [dbo].[BRS_ItemSupplier] ADD
	FreeGoodsEstInd bit NOT NULL CONSTRAINT DF_BRS_ItemSupplierVPA_FreeGoodsEstInd DEFAULT 1
GO


-- Set supplier exceptions
UPDATE [dbo].[BRS_ItemSupplier]
	SET FreeGoodsEstInd = 0
WHERE 
	BRS_ItemSupplier.Supplier = 'PROCGA' 
GO


UPDATE
	BRS_CustomerVPA
SET
	FreeGoodsEstInd = 0
WHERE        
	EXISTS (
		SELECT        *
        FROM            Pricing.price_adjustment_schedule_F4070
        WHERE        (SNAST__adjustment_name = 'NULLADJ') AND (BRS_CustomerVPA.VPA = SNASN__adjustment_schedule)
	)


SELECT [VPA], [FreeGoodsEstInd] FROM [dbo].[BRS_CustomerVPA]
WHERE EXISTS (
	SELECT  *
     
	  FROM [Pricing].[price_adjustment_schedule_F4070]
	  WHERE[SNAST__adjustment_name] = 'NULLADJ' AND
	[VPA] = [SNASN__adjustment_schedule]
)
