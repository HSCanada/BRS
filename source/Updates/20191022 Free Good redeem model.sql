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

---

CREATE SCHEMA [fg] AUTHORIZATION [dbo]
go


BEGIN TRANSACTION
GO
CREATE TABLE fg.chargeback
	(
	cb_contract_num int NOT NULL,
	cb_reference nvarchar(30) NOT NULL,
	cb_description nvarchar(30) NOT NULL,
	cb_contract_cd char(10) NULL,
	Supplier char(6) NULL,
	CalMonth int NULL
	)  ON USERDATA
GO
ALTER TABLE fg.chargeback ADD CONSTRAINT
	DF_chargeback_cb_reference DEFAULT '' FOR cb_reference
GO
ALTER TABLE fg.chargeback ADD CONSTRAINT
	DF_chargeback_cb_description DEFAULT '' FOR cb_description
GO
ALTER TABLE fg.chargeback ADD CONSTRAINT
	chargeback_c_pk PRIMARY KEY CLUSTERED 
	(
	cb_contract_num
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE fg.chargeback SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Promotion ADD
	CalMonth int NULL,
	NoteTxt nvarchar(50) NULL
GO
ALTER TABLE dbo.BRS_Promotion ADD CONSTRAINT
	FK_BRS_Promotion_BRS_CalMonth FOREIGN KEY
	(
	CalMonth
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Promotion SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.chargeback ADD CONSTRAINT
	FK_chargeback_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.chargeback ADD CONSTRAINT
	FK_chargeback_BRS_CalMonth FOREIGN KEY
	(
	CalMonth
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.chargeback SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
CREATE TABLE fg.offer
	(
	offer_id int NOT NULL,
	CalMonth int NOT NULL,
	SalesDivision char(3) NOT NULL,
	offer_txt nvarchar(255) NULL,
	buy_txt nvarchar(255) NULL,
	get_txt nvarchar(255) NULL
	)  ON USERDATA
GO
ALTER TABLE fg.offer ADD CONSTRAINT
	DF_offer_CalMonth DEFAULT 0 FOR CalMonth
GO
ALTER TABLE fg.offer ADD CONSTRAINT
	DF_offer_SalesDivision DEFAULT '' FOR SalesDivision
GO
ALTER TABLE fg.offer ADD CONSTRAINT
	offer_c_pk PRIMARY KEY CLUSTERED 
	(
	offer_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE fg.offer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.offer ADD CONSTRAINT
	FK_offer_BRS_CalMonth FOREIGN KEY
	(
	CalMonth
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.offer ADD CONSTRAINT
	FK_offer_BRS_SalesDivision FOREIGN KEY
	(
	SalesDivision
	) REFERENCES dbo.BRS_SalesDivision
	(
	SalesDivision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.offer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
CREATE TABLE fg.offer_detail
	(
	offer_id int NOT NULL,
	buy_item char(10) NOT NULL,
	buy_qty smallint NOT NULL,
	get_item char(10) NOT NULL,
	get_qty smallint NOT NULL,
	buy_limit_qty smallint NOT NULL,
	get_default_ind bit NOT NULL,
	adjustment_name char(8) NOT NULL
	)  ON USERDATA
GO
ALTER TABLE fg.offer_detail ADD CONSTRAINT
	DF_offer_detail_buy_limit_qty DEFAULT 9 FOR buy_limit_qty
GO
ALTER TABLE fg.offer_detail ADD CONSTRAINT
	DF_offer_detail_get_default_ind DEFAULT 0 FOR get_default_ind
GO
ALTER TABLE fg.offer_detail ADD CONSTRAINT
	DF_offer_detail_adjustment_name DEFAULT '' FOR adjustment_name
GO
ALTER TABLE fg.offer_detail ADD CONSTRAINT
	offer_detail_c_pk PRIMARY KEY CLUSTERED 
	(
	offer_id,
	buy_item
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE fg.offer_detail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.offer_detail ADD CONSTRAINT
	FK_offer_detail_offer FOREIGN KEY
	(
	offer_id
	) REFERENCES fg.offer
	(
	offer_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.offer_detail ADD CONSTRAINT
	FK_offer_detail_BRS_Item FOREIGN KEY
	(
	buy_item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.offer_detail ADD CONSTRAINT
	FK_offer_detail_BRS_Item1 FOREIGN KEY
	(
	get_item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.offer_detail ADD CONSTRAINT
	FK_offer_detail_price_adjustment_name_F4071 FOREIGN KEY
	(
	adjustment_name
	) REFERENCES Pricing.price_adjustment_name_F4071
	(
	ATAST__adjustment_name
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.offer_detail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
CREATE TABLE fg.order_test
	(
	SalesOrderNumber int NOT NULL,
	DocType char(2) NOT NULL,
	ShipTo int NOT NULL,
	PromotionCode char(2) NOT NULL,
	offer_id int NULL,
	SalesDate datetime NOT NULL,
	catagory_code char(10) NOT NULL,
	note_txt varchar(50) NULL
	)  ON USERDATA
GO
ALTER TABLE fg.order_test ADD CONSTRAINT
	DF_order_test_catagory_code DEFAULT '' FOR catagory_code
GO
ALTER TABLE fg.order_test ADD CONSTRAINT
	PK_order_test PRIMARY KEY CLUSTERED 
	(
	SalesOrderNumber,
	DocType
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE fg.order_test SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO

ALTER TABLE fg.order_test ADD CONSTRAINT
	FK_order_test_BRS_TransactionDW_Ext FOREIGN KEY
	(
	SalesOrderNumber,
	DocType
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	SalesOrderNumber,
	DocType
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test ADD CONSTRAINT
	FK_order_test_BRS_Customer FOREIGN KEY
	(
	ShipTo
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test ADD CONSTRAINT
	FK_order_test_BRS_Promotion FOREIGN KEY
	(
	PromotionCode
	) REFERENCES dbo.BRS_Promotion
	(
	PromotionCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test ADD CONSTRAINT
	FK_order_test_offer FOREIGN KEY
	(
	offer_id
	) REFERENCES fg.offer
	(
	offer_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test ADD CONSTRAINT
	FK_order_test_BRS_SalesDay FOREIGN KEY
	(
	SalesDate
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
-- drop TABLE fg.order_test_detail
BEGIN TRANSACTION
GO
CREATE TABLE fg.order_test_detail
	(
	SalesOrderNumber int NOT NULL,
	DocType char(2) NOT NULL,
	buy_get_cd char(1) NOT NULL,
	item char(10) NOT NULL,
	qty smallint NOT NULL,
	cb_contract_num_ref int NULL,
	offer_id_ref int NULL,
	note_text nvarchar(50) NULL,
	id int NOT NULL IDENTITY (1, 1)
	)  ON USERDATA
GO
ALTER TABLE fg.order_test_detail ADD CONSTRAINT
	PK_order_test_detail PRIMARY KEY CLUSTERED 
	(
	SalesOrderNumber,
	DocType,
	buy_get_cd,
	item
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE fg.order_test_detail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.order_test_detail ADD CONSTRAINT
	FK_order_test_detail_BRS_TransactionDW_Ext FOREIGN KEY
	(
	SalesOrderNumber,
	DocType
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	SalesOrderNumber,
	DocType
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test_detail ADD CONSTRAINT
	FK_order_test_detail_BRS_Item FOREIGN KEY
	(
	item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test_detail ADD CONSTRAINT
	FK_order_test_detail_chargeback FOREIGN KEY
	(
	cb_contract_num_ref
	) REFERENCES fg.chargeback
	(
	cb_contract_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test_detail ADD CONSTRAINT
	FK_order_test_detail_offer FOREIGN KEY
	(
	offer_id_ref
	) REFERENCES fg.offer
	(
	offer_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.order_test_detail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

INSERT into [fg].[offer]
([offer_id])
VALUES(0)
go


INSERT into [fg].[chargeback]
([cb_contract_num])
VALUES(0)
go