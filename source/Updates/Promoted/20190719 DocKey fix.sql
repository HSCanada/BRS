/****** Script for SelectTopNRows command from SSMS  ******/

-- test
SELECT  

[SalesOrderNumber]
,[DocType]

  FROM [DEV_BRSales].[dbo].[BRS_TransactionDW_Ext]
  group by 
  [SalesOrderNumber]
,[DocType]

having count (*) > 1

-- expand trans_ext PK Doc#, Doc type, 51s

BEGIN TRANSACTION
GO
ALTER TABLE hfm.account_adjustment_F0911
	DROP CONSTRAINT FK_account_adjustment_F0911_BRS_TransactionDW_Ext
GO
ALTER TABLE comm.free_goods_redeem
	DROP CONSTRAINT FK_free_goods_redeem_BRS_TransactionDW_Ext
GO
ALTER TABLE dbo.BRS_TransactionDW
	DROP CONSTRAINT FK_BRS_TransactionDW_BRS_TransactionDW_Ext
GO
ALTER TABLE comm.transaction_F555115
	DROP CONSTRAINT FK_transaction_F555115_BRS_TransactionDW_Ext
GO
ALTER TABLE dbo.BRS_Transaction
	DROP CONSTRAINT FK_BRS_Transaction_BRS_TransactionDW_Ext
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT BRS_TransactionDW_Ext_c_pk
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	BRS_TransactionDW_Ext_c_pk PRIMARY KEY CLUSTERED 
	(
	SalesOrderNumber,
	DocType
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE comm.free_goods_redeem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE hfm.account_adjustment_F0911 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- add RI back


-- Line this -> dbo.BRS_TransactionDW_Ext to:
-- dbo.BRS_Transaction_DW
-- dbo.BRS_Transaction 
-- comm.transaction_F555115 
-- hfm.account_adjustment_F0911 

-- todo
/*
ALTER TABLE comm.free_goods_redeem SET (LOCK_ESCALATION = TABLE)
*/

---
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW ADD CONSTRAINT
	FK_BRS_TransactionDW_BRS_TransactionDW_Ext FOREIGN KEY
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
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_BRS_TransactionDW_Ext FOREIGN KEY
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
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- test DW
SELECT * FROM dbo.BRS_Transaction s 
WHERE 
NOT EXISTS 
	(SELECT * FROM dbo.BRS_TransactionDW_Ext s2 WHERE s.SalesOrderNumber = s2.SalesOrderNumber and s.DocType = s2.DocType ) AND
--	s.DocType = 'AA' and s.SalesOrderNumber > 0 AND
	(1=1)

-- add the adj docs for RI
insert into BRS_TransactionDW_Ext
(SalesOrderNumber, DocType, NoteTxt)

SELECT distinct SalesOrderNumber, DocType, 'man.190719' FROM dbo.BRS_Transaction s 
WHERE 
NOT EXISTS 
	(SELECT * FROM dbo.BRS_TransactionDW_Ext s2 WHERE s.SalesOrderNumber = s2.SalesOrderNumber and s.DocType = s2.DocType ) AND
--	s.DocType = 'AA' and s.SalesOrderNumber > 0 AND
	(1=1)


-- improve perf index?
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX BRS_TransactionDW_idx_12 ON dbo.BRS_TransactionDW
	(
	SalesOrderNumber,
	DocType
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE dbo.BRS_TransactionDW SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- comm
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_BRS_TransactionDW_Ext FOREIGN KEY
	(
	WSDOCO_salesorder_number,
	WSDCTO_order_type
	) REFERENCES dbo.BRS_TransactionDW_Ext
	(
	SalesOrderNumber,
	DocType
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- test Comm
SELECT * FROM comm.transaction_F555115 s 
WHERE 
	NOT EXISTS (SELECT * FROM dbo.BRS_TransactionDW_Ext s2 WHERE s.[WSDOCO_salesorder_number] = s2.SalesOrderNumber and s.[WSDCTO_order_type] = s2.DocType ) AND
--	source_cd <> 'jde' AND
--	s.[WSDCTO_order_type] <> '' and 
--	s.SalesOrderNumber > 0 AND
	(1=1)

UPDATE comm.transaction_F555115 
SET [WSDCTO_order_type] = 'AA'
where [WSDCTO_order_type] = ''
GO

-- add the adj docs for RI
insert into BRS_TransactionDW_Ext
(SalesOrderNumber, DocType, NoteTxt)

--SELECT distinct source_cd FROM comm.transaction_F555115 s 
SELECT distinct s.[WSDOCO_salesorder_number], s.[WSDCTO_order_type], 'manc190719' FROM comm.transaction_F555115 s 
WHERE 
NOT EXISTS 
	(SELECT * FROM dbo.BRS_TransactionDW_Ext s2 WHERE s.[WSDOCO_salesorder_number] = s2.SalesOrderNumber and s.[WSDCTO_order_type] = s2.DocType ) AND
--	s.DocType = 'AA' and s.SalesOrderNumber > 0 AND
	(1=1)

--- adj

BEGIN TRANSACTION
GO
ALTER TABLE hfm.account_adjustment_F0911 ADD CONSTRAINT
	FK_account_adjustment_F0911_BRS_TransactionDW_Ext FOREIGN KEY
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
ALTER TABLE hfm.account_adjustment_F0911 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--- free goods

BEGIN TRANSACTION
GO
ALTER TABLE comm.free_goods_redeem ADD
	DocType char(2) NOT NULL CONSTRAINT DF_free_goods_redeem_DocType DEFAULT ''
GO
ALTER TABLE comm.free_goods_redeem
	DROP CONSTRAINT comm_free_goods_redeem_pk
GO
ALTER TABLE comm.free_goods_redeem ADD CONSTRAINT
	free_goods_redeem_c_pk PRIMARY KEY CLUSTERED 
	(
	FiscalMonth,
	Item,
	SalesOrderNumber,
	DocType
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE comm.free_goods_redeem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update doctype

UPDATE       comm.free_goods_redeem
SET                DocType = BRS_TransactionDW_Ext.DocType
FROM            comm.free_goods_redeem INNER JOIN
                         BRS_TransactionDW_Ext ON comm.free_goods_redeem.SalesOrderNumber = BRS_TransactionDW_Ext.SalesOrderNumber
GO

-- add RI

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX free_goods_redeem_idx_1 ON comm.free_goods_redeem
	(
	SalesOrderNumber,
	DocType
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.free_goods_redeem ADD CONSTRAINT
	FK_free_goods_redeem_BRS_TransactionDW_Ext FOREIGN KEY
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
ALTER TABLE comm.free_goods_redeem SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
