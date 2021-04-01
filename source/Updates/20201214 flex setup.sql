-- flex setup, tmc, 14 Dec 20

CREATE SCHEMA [flex] AUTHORIZATION [dbo]
GO


/****** Object:  DatabaseRole [flex_operator]    Script Date: 20/12/14 5:54:44 PM ******/
CREATE ROLE [flex_operator]
GO

--

-- drop TABLE [Integration].[flex_order_lines_Staging]
CREATE TABLE [Integration].[flex_order_lines_Staging](
	[order_file_name] [varchar](50) NOT NULL,
	[line_id] [int] NOT NULL,

	[flex_code] [char](6) NULL,

	[status_code] [smallint] NOT NULL Default (-1),

	[ORDERNO] [varchar](50)  NULL,
	[ACCOUNT] [varchar](50)  NULL,
	[BILL_XREF] [varchar](50)  NULL,
	[ITEMNO] [varchar](50)  NULL,
	[QTY] [smallint]  NULL,

	[REFERENCE] [varchar](50) NULL,
	[ITEMDESC] [varchar](50) NULL,
	[UPC] [varchar](50) NULL,
	[PRICE] [money] NULL,
	[FREEGDS] [varchar](50) NULL,
	[DATE] datetime NULL,
	[DATE_TEXT] [varchar](50) NULL,
	[REF2] [varchar](50) NULL,
	[COMPANY] [varchar](50) NULL,
	[FIRSTLAST] [varchar](50) NULL,
	[ADDRESS1] [varchar](50) NULL,
	[ADDRESS2] [varchar](50) NULL,
	[ADDRESS3] [varchar](50) NULL,
	[CITY] [varchar](50) NULL,
	[ST] [varchar](50) NULL,
	[POSTALCODE] [varchar](50) NULL,
	[PHONE] [varchar](50) NULL,
	[COUNTRY] [varchar](50) NULL,
	[PROMOCODE] [varchar](50) NULL,
	[PROGRAMCODE] [varchar](50) NULL,
	[ORIGINAL_INVOICE] [varchar](50) NULL
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE Integration.flex_order_lines_Staging ADD CONSTRAINT
	idx_flex_order_lines_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	[order_file_name],
	line_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.flex_order_lines_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- drop TABLE [flex].[order_file]
CREATE TABLE [flex].[order_file](
	[order_file_name] [varchar](50) NOT NULL,

	[flex_code] [char](6) NOT NULL,
	[Supplier] [char](6) NOT NULL,
	[order_file_key] [int] IDENTITY(1,1) NOT NULL,

	[status_code] [smallint] NOT NULL Default (-1),
	[batch_id] [int] NULL,
	order_count	[int] NULL,
	line_count [int] NULL,
	order_error_count	[int] NULL,
	line_error_count [int] NULL,

	[note] [varchar](50) NULL,
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE flex.order_file ADD CONSTRAINT
	idx_flex_order_file_c_pk PRIMARY KEY CLUSTERED 
	(
	order_file_name
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
CREATE UNIQUE NONCLUSTERED INDEX idx_flex_order_file_u_idx_01 ON flex.order_file
	(
	order_file_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE flex.order_file SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- drop TABLE [flex].[order_header]
CREATE TABLE [flex].[order_header](
	[Supplier] [char](6) NOT NULL,
	[ORDERNO] [char](10) NOT NULL,

	[order_file_key] [int] NOT NULL,
	[ACCOUNT] [int] NOT NULL,

	[status_code] [smallint] NOT NULL Default (-1),
	[ShipTo] [int] NOT NULL Default(0), 
	[batch_id] [int] NULL,
	[SalesOrderNumber] [int] NULL,
	[DocType] [char](2) NULL,
	[note] [varchar](50) NULL,

	[REFERENCE] [varchar](30) NULL,
	[DATE] [date] NULL,
	[DUEDATE] [date] NULL,
	[REF2] [varchar](30) NULL,
	[COMPANY] [varchar](50) NULL,
	[FIRSTLAST] [varchar](50) NULL,
	[ADDRESS1] [varchar](50) NULL,
	[ADDRESS2] [varchar](50) NULL,
	[ADDRESS3] [varchar](50) NULL,
	[CITY] [varchar](30) NULL,
	[ST] [char](2) NULL,
	[POSTALCODE] [char](10) NULL,
	[PHONE] [varchar](15) NULL,
	[COUNTRY] [char](5) NULL,
	[ORIGINAL_INVOICE] [int] NULL

) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE flex.order_header ADD CONSTRAINT
	flex_order_header_c_pk PRIMARY KEY CLUSTERED 
	(
	ORDERNO,
	Supplier
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE flex.order_header SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- drop TABLE [flex].[order_detail]
CREATE TABLE [flex].[order_detail](
	[Supplier] [char](6) NOT NULL,
	[ORDERNO] [char](10) NOT NULL,
	[line_id] [int] NOT NULL,

	[ITEMNO] [char](15) NOT NULL,
	[QTY] [smallint] NOT NULL,

	[status_code] [smallint] NOT NULL Default (-1),
	[Item] [char](10) NOT NULL Default(''), 
	[batch_id] [int] NULL,
	[note] [varchar](50) NULL,

	[ID] [int] IDENTITY(1,1) NOT NULL,

	[ITEMDESC] [varchar](50) NULL,
	[UPC] [varchar](15) NULL,
	[PRICE] [money] NULL,
	[FREEGDS] [char](1) NULL,
	[PROMOCODE] [char](10) NULL,
	[PROGRAMCODE] [nchar](10) NULL,
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE flex.order_detail ADD CONSTRAINT
	idx_flex_order_detail_c_pk PRIMARY KEY CLUSTERED 
	(
	ORDERNO,
	Supplier,
	line_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE flex.order_detail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- drop TABLE [flex].[customer_xref]
CREATE TABLE [flex].[customer_xref](
	[Supplier] [char](6) NOT NULL,
	[ACCOUNT] [int] NOT NULL,

	[status_code] [smallint] NOT NULL Default (-1),
	[ShipTo] [int] NOT NULL Default(0), 
	[ShipTo_Suggest] [varchar](50) NULL,
	[note] [varchar](50) NULL,
	[create_date] [date] NOT NULL Default(GETDATE()),

	[COMPANY] [varchar](50) NULL,
	[FIRSTLAST] [varchar](50) NULL,
	[ADDRESS1] [varchar](50) NULL,
	[ADDRESS2] [varchar](50) NULL,
	[ADDRESS3] [varchar](50) NULL,
	[CITY] [varchar](30) NULL,
	[ST] [char](2) NULL,
	[POSTALCODE] [char](10) NULL,
	[PHONE] [varchar](15) NULL,
	[COUNTRY] [char](5) NULL,

) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE flex.customer_xref ADD CONSTRAINT
	idx_customer_xref_c_pk PRIMARY KEY CLUSTERED 
	(
	ACCOUNT,
	Supplier
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE flex.customer_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- drop TABLE [flex].[item_xref]
CREATE TABLE [flex].[item_xref](
	[Supplier] [char](6) NOT NULL,
	[ITEMNO] [char](15) NOT NULL,

	[ITEMDESC] [varchar](50) NULL,
	[UPC] [varchar](15) NULL,


	[status_code] [smallint] NOT NULL Default (-1),
	[Item] [char](10) NOT NULL Default(''), 
	[Item_Suggest] [varchar](50) NULL,
	[note] [varchar](50) NULL,
	[create_date] [date] NOT NULL Default(GETDATE()),

) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE flex.item_xref ADD CONSTRAINT
	idx_item_xref_c_pk PRIMARY KEY CLUSTERED 
	(
	ITEMNO,
	Supplier
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE flex.item_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE flex.item_xref ADD
	product_type char(20) NOT NULL CONSTRAINT DF_item_xref_product_type DEFAULT ''
GO
ALTER TABLE flex.item_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- drop TABLE [flex].[batch_template]
CREATE TABLE [flex].[batch_template](
	[flex_code] [char](6) NOT NULL,

	[Supplier] [char](6) NOT NULL Default(''),
	[flex_descr] [varchar](50) NOT NULL Default(''),

	[flex_template] [varchar](20) NOT NULL Default(''),
	[flex_import_prefix] [varchar](10) NOT NULL Default(''),
	[flex_export_prefix] [varchar](10) NOT NULL Default(''),
	[flex_po_prefix] [varchar](10) NOT NULL Default(''),

	[need_customer_xref_ind] [smallint] NOT NULL Default (1),
	[need_item_xref_ind] [smallint] NOT NULL Default (1),
	[need_price_ind] [smallint] NOT NULL Default (1),
	[active_ind] [smallint] NOT NULL Default (0),

	[note] [varchar](50) NULL,
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE flex.batch_template ADD CONSTRAINT
	idx_batch_template_c_pk PRIMARY KEY CLUSTERED 
	(
	flex_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE flex.batch_template SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE flex.batch_template ADD
	order_pend char(2) NOT NULL CONSTRAINT DF_batch_template_order_pend DEFAULT ''
GO
ALTER TABLE flex.batch_template SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE flex.batch_template ADD
	dealer_code char(10) NOT NULL CONSTRAINT DF_batch_template_dealer_code DEFAULT ''
GO
ALTER TABLE flex.batch_template SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE flex.batch_template ADD
	LineTypeOrder char(2) NOT NULL CONSTRAINT DF_batch_template_LineTypeOrder DEFAULT '',
	DocType char(2) NOT NULL CONSTRAINT DF_batch_template_DocType DEFAULT '',
	OrderSourceCode char(1) NOT NULL CONSTRAINT DF_batch_template_OrderSourceCode DEFAULT '',
	OrderTakenBy char(10) NOT NULL CONSTRAINT DF_batch_template_OrderTakenBy DEFAULT '',
	refer_order char(2) NOT NULL CONSTRAINT DF_batch_template_refer_order DEFAULT ''

GO
ALTER TABLE flex.batch_template ADD CONSTRAINT
	FK_batch_template_BRS_LineTypeOrder FOREIGN KEY
	(
	LineTypeOrder
	) REFERENCES dbo.BRS_LineTypeOrder
	(
	LineTypeOrder
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.batch_template ADD CONSTRAINT
	FK_batch_template_BRS_DocType FOREIGN KEY
	(
	DocType
	) REFERENCES dbo.BRS_DocType
	(
	DocType
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.batch_template ADD CONSTRAINT
	FK_batch_template_BRS_OrderSource FOREIGN KEY
	(
	OrderSourceCode
	) REFERENCES dbo.BRS_OrderSource
	(
	OrderSourceCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.batch_template SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
/*
-- drop TABLE [flex].[batch]
CREATE TABLE [flex].[batch](
	[batch_id] [int] NOT NULL IDENTITY(1,1),

	[flex_code] [char](6) NOT NULL,
	[status_code] [smallint] NOT NULL Default (-1),

	[export_date] [date] NULL,
	[import_batch_id] [int] NULL,
	[note] [varchar](50) NULL,

) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE flex.batch ADD CONSTRAINT
	idx_batch_c_pk PRIMARY KEY CLUSTERED 
	(
	batch_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE flex.batch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
*/

-- RI

BEGIN TRANSACTION
GO
ALTER TABLE flex.order_file ADD CONSTRAINT
	FK_order_file_batch_template FOREIGN KEY
	(
	flex_code
	) REFERENCES flex.batch_template
	(
	flex_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_file ADD CONSTRAINT
	FK_order_file_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_file SET (LOCK_ESCALATION = TABLE)
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE flex.order_header ADD CONSTRAINT
	FK_order_header_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_header ADD CONSTRAINT
	FK_order_header_order_file FOREIGN KEY
	(
	order_file_key
	) REFERENCES flex.order_file
	(
	order_file_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_header ADD CONSTRAINT
	FK_order_header_customer_xref FOREIGN KEY
	(
	ACCOUNT,
	Supplier
	) REFERENCES flex.customer_xref
	(
	ACCOUNT,
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_header ADD CONSTRAINT
	FK_order_header_BRS_Customer FOREIGN KEY
	(
	ShipTo
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_header ADD CONSTRAINT
	FK_order_header_BRS_TransactionDW_Ext FOREIGN KEY
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
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE flex.order_detail ADD CONSTRAINT
	FK_order_detail_order_header FOREIGN KEY
	(
	ORDERNO,
	Supplier
	) REFERENCES flex.order_header
	(
	ORDERNO,
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_detail ADD CONSTRAINT
	FK_order_detail_item_xref FOREIGN KEY
	(
	ITEMNO,
	Supplier
	) REFERENCES flex.item_xref
	(
	ITEMNO,
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_detail ADD CONSTRAINT
	FK_order_detail_BRS_Item FOREIGN KEY
	(
	Item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
/*
ALTER TABLE flex.order_detail ADD CONSTRAINT
	FK_order_detail_batch FOREIGN KEY
	(
	batch_id
	) REFERENCES flex.batch
	(
	batch_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.order_detail SET (LOCK_ESCALATION = TABLE)
GO
*/
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE flex.customer_xref ADD CONSTRAINT
	FK_customer_xref_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.customer_xref ADD CONSTRAINT
	FK_customer_xref_BRS_Customer FOREIGN KEY
	(
	ShipTo
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.customer_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE flex.item_xref ADD CONSTRAINT
	FK_item_xref_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.item_xref ADD CONSTRAINT
	FK_item_xref_BRS_Item FOREIGN KEY
	(
	Item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.item_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE flex.batch_template ADD CONSTRAINT
	FK_batch_template_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.batch_template SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
--
/*
BEGIN TRANSACTION
GO
ALTER TABLE flex.batch ADD CONSTRAINT
	FK_batch_batch_template FOREIGN KEY
	(
	flex_code
	) REFERENCES flex.batch_template
	(
	flex_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE flex.batch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
*/
--
BEGIN TRANSACTION
GO
ALTER TABLE Integration.flex_order_lines_Staging ADD CONSTRAINT
	FK_flex_order_lines_Staging_batch_template FOREIGN KEY
	(
	flex_code
	) REFERENCES flex.batch_template
	(
	flex_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE Integration.flex_order_lines_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
GRANT SELECT ON [dbo].[BRS_Customer] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT SELECT ON [flex].[customer_xref] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT UPDATE ON [flex].[customer_xref] TO [flex_operator]
GO
use [DEV_BRSales]
GO
use [DEV_BRSales]
GO
GRANT SELECT ON [flex].[order_header] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT SELECT ON [flex].[batch_template] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT UPDATE ON [flex].[batch_template] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT SELECT ON [flex].[item_xref] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT UPDATE ON [flex].[item_xref] TO [flex_operator]
GO
use [DEV_BRSales]
GO
use [DEV_BRSales]
GO
GRANT SELECT ON [flex].[order_file] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT UPDATE ON [flex].[order_file] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT SELECT ON [dbo].[BRS_Item] TO [flex_operator]
GO
use [DEV_BRSales]
GO
GRANT SELECT ON [flex].[order_detail] TO [flex_operator]
GO

GRANT SELECT ON [Integration].[flex_order_lines_Staging] TO [flex_operator]
GO

GRANT INSERT ON [Integration].[flex_order_lines_Staging] TO [flex_operator]
GO

GO
GRANT UPDATE ON [Integration].[flex_order_lines_Staging] TO [flex_operator]
GO

-- create 2 procs

GRANT EXECUTE ON [flex].[order_update_proc] TO [flex_operator]
GO
GRANT EXECUTE ON [flex].[order_load_proc] TO [flex_operator]
GO

-- add users to flex role, manual

/*
-- clear
truncate table [Integration].[flex_order_lines_Staging]
truncate table [flex].[order_detail]
delete from [flex].[order_header]
delete from [flex].[order_file]
*/


