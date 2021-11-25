--------------------------------------------------------------------------------
-- DROP TABLE Integration.ARCPDTA71_F5554240_<instert_friendly_name_here>
--------------------------------------------------------------------------------
/*
SELECT

    Top 5 
	"WKTEXT2" AS WKTEXT2_run_period,
	"WKROW" AS WKROW__totaled_by,
	"WKKEY" AS WKKEY__key,
	"WKDSC" AS WKDSC__um_description,
	"WKAC10" AS WKAC10_division_code,
	"WK$SPC" AS WK$SPC_supplier_code,
	"WKLITM" AS WKLITM_item_number,
	"WKCITM" AS WKCITM_customersupplier_item_number,
	"WKUORG" AS WKUORG_quantity,
	"WKUOM" AS WKUOM__um,
	"WKUNCS" AS WKUNCS_unit_cost,
	"WKCRCD" AS WKCRCD_currency_code,
	"WKECST" AS WKECST_extended_cost,
	"WKDSC1" AS WKDSC1_description,
	"WKDSC2" AS WKDSC2_pricing_adjustment_line,
	"WKAN8" AS WKAN8__billto,
	"WKALPH" AS WKALPH_billto_name,
	"WKSHAN" AS WKSHAN_shipto,
	"WKNAME" AS WKNAME_shipto_name,
	"WKDOCO" AS WKDOCO_salesorder_number,
	"WKDCTO" AS WKDCTO_order_type,
	"WK$HGS" AS WK$HGS_status_code_high,
	"WKDATE" AS WKDATE_order_date,
	"WKFRGD" AS WKFRGD_from_grade,
	"WKTHGD" AS WKTHGD_thru_grade,
	"WKLNTY" AS WKLNTY_line_type,
	"WKPSN" AS WKPSN__invoice_number,
	"WK$ODN" AS WK$ODN_free_goods_contract_number,
	"WKDL01" AS WKDL01_promo_description

 INTO Integration.F5554240_fg_redeem_Staging

FROM 
    OPENQUERY (ESYS_PROD, '

	SELECT
		WKTEXT2, WKROW, WKKEY, WKDSC, WKAC10, WK$SPC, WKLITM, WKCITM, WKUORG, WKUOM, CAST((WKUNCS)/10000.0 AS DEC(15,4)) AS WKUNCS, WKCRCD, CAST((WKECST)/100.0 AS DEC(15,2)) AS WKECST, WKDSC1, WKDSC2, WKAN8, WKALPH, WKSHAN, WKNAME, WKDOCO, WKDCTO, WK$HGS, WKDATE, WKFRGD, WKTHGD, WKLNTY, WKPSN, WK$ODN, WKDL01

	FROM
		ARCPDTA71.F5554240
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')
*/

--------------------------------------------------------------------------------

-- drop table [Integration].[F5554240_fg_redeem_Staging]

CREATE TABLE [Integration].[F5554240_fg_redeem_Staging](
	[order_file_name] varchar(50) not null,
	[line_id] int not null,

	[WKKEY__key] [char](20)  NULL,
	[WKAC10_division_code] [char](3)  NULL,
	[WK$SPC_supplier_code] [char](6)  NULL,
	[WKLITM_item_number] [char](25)  NULL,
	[WKCITM_customersupplier_item_number] [char](25)  NULL,
	[WKUORG_quantity] [numeric](9, 0)  NULL,
	[WKUOM__um] [char](2)  NULL,
	[WKUNCS_unit_cost] [numeric](15, 4)  NULL,
	[WKCRCD_currency_code] [char](3)  NULL,
	[WKECST_extended_cost] [numeric](15, 2)  NULL,
	[WKDSC1_description] [char](30)  NULL,
	[WKDSC2_pricing_adjustment_line] [char](30)  NULL,
	[WKAN8__billto] [numeric](8, 0)  NULL,
	[WKALPH_billto_name] [char](40)  NULL,
	[WKSHAN_shipto] [numeric](8, 0)  NULL,
	[WKNAME_shipto_name] [char](30)  NULL,
	[WKDOCO_salesorder_number] [numeric](8, 0)  NULL,
	[WKDCTO_order_type] [char](2)  NULL,
	[WK$HGS_status_code_high] [char](3)  NULL,
	[WKDATE_order_date_text] [char](8)  NULL,
	[WKFRGD_from_grade] [char](3)  NULL,
	[WKTHGD_thru_grade] [char](3)  NULL,
	[WKLNTY_line_type] [char](2)  NULL,
	[WKPSN__invoice_number] [numeric](8, 0)  NULL,
	[WK$ODN_free_goods_contract_number] [char](12)  NULL,
	[WKDL01_promo_description] [char](30)  NULL,

	ID int identity(1,1) NOT NULL,
	[status_code] smallint not null default (-1),

	-- staging pre-load helpers
	[WKLNNO_line_number] [float] NULL,
	[ID_source_ref] [int] NULL,

	[WKDATE_order_date] [date]  NULL,
	[CalMonthOrder] [int] NULL,
	[CalMonthRedeem] [int] NULL,
	[WKPMID_promo_code] [char] (2) NULL,

	-- need in stage?  
	[fg_exempt_cd] char(6) NULL,

) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F5554240_fg_redeem_Staging ADD CONSTRAINT
	F5554240_fg_redeem_Staging_c_pk PRIMARY KEY CLUSTERED 
	(
	order_file_name,
	line_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.F5554240_fg_redeem_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--


-- add config flag
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_FiscalMonth ADD
	fg_status_cd smallint NOT NULL CONSTRAINT DF_BRS_FiscalMonth_fg_status_cd DEFAULT 0
GO
ALTER TABLE dbo.BRS_FiscalMonth SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



--
-- exclude / except flags

-- add freegoods_exempt_cd to tables

-- [BRS_SalesDivision]
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_SalesDivision ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_BRS_SalesDivision_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- [BRS_DocType]
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_DocType ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_BRS_DocType_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- [BRS_ItemSupplier]
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemSupplier ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_BRS_ItemSupplier_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- [BRS_ItemMPC]
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_BRS_ItemMPC_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- [BRS_CustomerVPA]
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerVPA ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_BRS_CustomerVPA_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- [BRS_CustomerSpecialty]
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_CustomerSpecialty ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_BRS_CustomerSpecialty_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- [BRS_TransactionDW_Ext] 
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD
	fg_CalMonthRedeem int NULL
	,fg_exempt_cd char(6) NULL 
	,fg_exempt_note varchar(50) NULL
GO
COMMIT


--
/*
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP CONSTRAINT DF_BRS_TransactionDW_Ext_freegoods_exempt_cd
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext
	DROP COLUMN freegoods_exempt_cd, freegoods_exempt_note
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
*/
--
-- [BRS_Promotion]
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Promotion ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_BRS_Promotion_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- [hfm].[exclusive_product]
BEGIN TRANSACTION
GO
ALTER TABLE [hfm].[exclusive_product] ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_hfm_exclusive_product_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- BRS_LineTypeOrder
BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_LineTypeOrder] ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_brs_LineTypeOrder_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

-- BRS_LineTypeOrder
BEGIN TRANSACTION
GO
ALTER TABLE [dbo].[BRS_ItemLabel] ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_brs_ItemLabel_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT


-- set freegoods_exempt_cd values

-- [BRS_SalesDivision]
UPDATE dbo.BRS_SalesDivision 
	Set freegoods_exempt_cd = 1
WHERE SalesDivision = 'AZA'
GO


-- [BRS_DocType]
UPDATE dbo.BRS_DocType
	Set freegoods_exempt_cd = 1
WHERE DocType in ('CO', 'CM', 'SX')
GO

--[dbo].[BRS_LineTypeOrder]
UPDATE [dbo].[BRS_LineTypeOrder]
	Set freegoods_exempt_cd = 1
WHERE [LineTypeOrder] IN ('M2', 'MS')
GO



-- [BRS_ItemSupplier], docs
UPDATE dbo.BRS_ItemSupplier
	SET freegoods_exempt_cd = 1
WHERE Supplier in('HENSCH', 'HENGLB', 'HSCAT', 'HSDENT', 'DELL', 'CDWCA')
GO

-- [BRS_ItemSupplier], John exclude excel 29 Oct 21
UPDATE dbo.BRS_ItemSupplier
	SET freegoods_exempt_cd = 1
WHERE Supplier in('DECMAT', 'SIRONC', 'BAINTE', 'CARDIN', 'GLHEAL', 'HANDLR', 'HEDYCA', 'IMPEXW', 'IVOCZA', 'MORITA', 'ORTHOT', 'PROCGA', 'ROSSCH', 'SABLEI', 'SOUDEN', 'SSWBUR', 'TALLAD', 'USENDO', 'AMAGIR')
GO

-- [BRS_ItemMPC]
UPDATE dbo.BRS_ItemMPC
	SET freegoods_exempt_cd = 1
WHERE ( MajorProductClass like '8%' or MajorProductClass like '9%' or MajorProductClass = '373')
GO

-- [hfm].[exclusive_product]
UPDATE [hfm].[exclusive_product]
	SET freegoods_exempt_cd = 2
WHERE [BrandEquityCategory] in('Owned', 'Exclusive', 'CorporateBrand')
GO

--- TBD
UPDATE dbo.BRS_CustomerVPA
	set freegoods_exempt_cd = 1
WHERE VPA = 'xxx'
GO

-- [BRS_CustomerSpecialty]
UPDATE dbo.BRS_CustomerSpecialty 
	set freegoods_exempt_cd = 1
WHERE Specialty = 'xxx'
GO

-- [BRS_TransactionDW_Ext] (3min)
UPDATE dbo.BRS_TransactionDW_Ext
	set fg_exempt_cd = ''
WHERE SalesOrderNumber = '-1'
GO

-- [BRS_Promotion]
UPDATE dbo.BRS_Promotion 
	set freegoods_exempt_cd = 1
WHERE PromotionCode = 'xxx'
GO

-- [BRS_Promotion]
UPDATE [dbo].[BRS_ItemLabel]
	set freegoods_exempt_cd = 1
WHERE [Label] = 'P'
GO

--
BEGIN TRANSACTION
GO

CREATE TABLE fg.exempt_code
	(
	fg_exempt_cd char(6) NOT NULL,
	fg_exempt_desc varchar(50) NOT NULL,
	source_cd char(3) NOT NULL,
	active_ind bit NOT NULL,
	sequence_num smallint NOT NULL DEFAULT(0),
	creation_dt date NOT NULL,
	fg_exempt_key int NOT NULL IDENTITY (1, 1),
	note_txt nchar(10) NULL
	)  ON USERDATA
GO
ALTER TABLE fg.exempt_code ADD CONSTRAINT
	DF_exempt_code_source_cd DEFAULT '' FOR source_cd
GO
ALTER TABLE fg.exempt_code ADD CONSTRAINT
	DF_exempt_code_active_ind DEFAULT 0 FOR active_ind
GO
ALTER TABLE fg.exempt_code ADD CONSTRAINT
	DF_exempt_code_creation_dt DEFAULT getdate() FOR creation_dt
GO
ALTER TABLE fg.exempt_code ADD CONSTRAINT
	PK_exempt_code PRIMARY KEY CLUSTERED 
	(
	fg_exempt_cd
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE fg.exempt_code SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE fg.exempt_code ADD
	show_ind bit NOT NULL CONSTRAINT DF_exempt_code_show_ind DEFAULT 1
GO
ALTER TABLE fg.exempt_code SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE Integration.F5554240_fg_redeem_Staging ADD CONSTRAINT
	FK_F5554240_fg_redeem_Staging_exempt_code FOREIGN KEY
	(
	fg_exempt_cd
	) REFERENCES fg.exempt_code
	(
	fg_exempt_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

CREATE UNIQUE NONCLUSTERED INDEX F5554240_fg_redeem_Staging_u_idx01 ON Integration.F5554240_fg_redeem_Staging
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Integration.F5554240_fg_redeem_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- set freegoods_exempt_cd values

INSERT INTO [fg].[exempt_code]
           ([fg_exempt_cd]
           ,[fg_exempt_desc]
           ,[source_cd]
           ,[active_ind]
           ,[sequence_num]
           ,[note_txt])
     VALUES
           (''
           ,'unassigned'
           ,''
           ,0
           ,0
           ,'.')
GO
-- pop exempt rules
INSERT INTO [fg].[exempt_code]
           ([fg_exempt_cd]
           ,[fg_exempt_desc]
           ,[source_cd]
           ,[active_ind]
           ,[sequence_num]
           ,[note_txt])
VALUES
	('ZZZDIV','[BRS_SalesDivision]','',1,10,'.')
	,('ZZZLNT','[BRS_LineTypeOrder]','',1,10,'.')

	,('XXXDOC','[BRS_DocType]','',1,10,'.')
	,('XXXMPC','[BRS_ItemMPC]','',1,10,'.')

	,('XXXSUP','[BRS_ItemSupplier]','',1,10,'.')
	,('XXXHSB','[BRS_ItemLabel]','',1,10,'.')

	,('XXXVPA','[BRS_CustomerVPA]','',1,10,'.')
	,('XXXSPC','[BRS_CustomerSpecialty]','',1,10,'.')
	,('XXXPRO','[BRS_Promotion]','',1,10,'.')

	,('XXXCBM','Chargeback Multi [fg].[exempt_supplier_rule]','',1,10,'.')

	,('FGAUTO','Auto Add','',1,10,'.')
	,('FGMANU','Manual Add','',1,10,'.')

	,('FGMMGR','Manager Excpt [BRS_TransactionDW_Ext]','',1,10,'.')

GO

INSERT INTO [fg].[exempt_code]
           ([fg_exempt_cd]
           ,[fg_exempt_desc]
           ,[source_cd]
           ,[active_ind]
           ,[sequence_num]
           ,[note_txt])
VALUES
	('FGDEAL','xxx','',1,10,'.')
	,('FGGOOD','xxx','',1,10,'.')
	,('XXCRRB','xxx','',1,10,'.')
	,('XXLITR','xxx','',1,10,'.')
	,('XXNQAL','xxx','',1,10,'.')
	,('XXDEAL','xxx','',1,10,'.')



--DELETE FROM [fg].[exempt_code] WHERE [fg_exempt_cd] in('XXXCBV', 'XXXCBS', 'FGMXXX', 'FGMMGR')

-- create prod table
-- use history for fsc / cust / item views (tie to finacial) CalMonthOrder

-- TRUNCATE TABLE  [fg].[transaction_F5554240]
-- drop TABLE [fg].[transaction_F5554240]
CREATE TABLE [fg].[transaction_F5554240](
	[WKDOCO_salesorder_number] [int] NOT NULL,
	[WKDCTO_order_type] [char](2) NOT NULL,
	[WKLNNO_line_number] [int] NOT NULL,

	[ID_source_ref] [int] NOT NULL,
	[CalMonthRedeem] [int] NOT NULL,
	[CalMonthOrder] [int] NOT NULL,

	[fg_exempt_cd] [char](6) NOT NULL,
	[fg_offer_id] [int] NOT NULL,
	[fg_offer_note] [varchar](30) NOT NULL,
	[WK$ODN_free_goods_contract_number] int NOT NULL,

	[WKDATE_order_date] [datetime] NOT NULL,
	[WKSHAN_shipto] [int] NOT NULL,
	[WKLITM_item_number] [char](10) NOT NULL,
	[WKUORG_quantity] [int] NOT NULL,

	[WKECST_extended_cost] [money] NOT NULL,
	[WKUNCS_unit_cost] [money] NOT NULL,
	[WKCRCD_currency_code] [char](3) NOT NULL,

	[WKDSC1_description] [varchar](30) NOT NULL,
	[WKPMID_promo_code] [char](2) NOT NULL,
	[VPA] [char](10) NOT NULL,

	[Specialty] [char](10) NOT NULL,

	[WKLNTY_line_type] [char](2) NOT NULL,
	[WKAC10_division_code] [char](3) NOT NULL,
	[MajorProductClass] [char](3) NOT NULL,

	[Label] [char](1) NOT NULL,

	[WK$SPC_supplier_code] [char](6) NOT NULL,
	[WKPSN__invoice_number] [int] NOT NULL,
	[OriginalSalesOrderNumber] [int] NOT NULL,
	[WKDSC2_pricing_adjustment_line] [varchar](30) NOT NULL,
	[WKAN8__billto] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
--
	[WKKEY__key] [varchar](20) NOT NULL,
	[WKCITM_customersupplier_item_number] [varchar](25) NOT NULL,
	[WKUOM__um] [char](2) NOT NULL,
	[WKALPH_billto_name] [varchar](40) NOT NULL,
	[WKNAME_shipto_name] [varchar](30) NOT NULL,
	[WK$HGS_status_code_high] [char](3) NOT NULL,
	[WKFRGD_from_grade] [char](3) NOT NULL,
	[WKTHGD_thru_grade] [char](3) NOT NULL,
	[WKDL01_promo_description] [varchar](30) NOT NULL,

	[status_code] [smallint] NOT NULL,

	[WKECST_extended_cost_org] [money] NULL,
	[WKUNCS_unit_cost_org] [money] NULL,
	[WKCRCD_currency_code_org] [char](3) NULL,

	[order_file_name] [varchar](50) NOT NULL,
	[line_id] [int] NOT NULL,

	[exempt_supplier_rule_key] [int] NULL,


 CONSTRAINT [fg_transaction_F5554240_pk] PRIMARY KEY  
(
	[WKDOCO_salesorder_number] ASC,
	[WKDCTO_order_type] ASC,
	[WKLNNO_line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD
	fg_redeem_ind bit NULL
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD
	ExtFileCostCadAmt money NULL
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

-- fg RI 
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_BRS_CalMonth FOREIGN KEY
	(
	fg_CalMonthRedeem
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD CONSTRAINT
	FK_BRS_TransactionDW_Ext_exempt_code FOREIGN KEY
	(
	fg_exempt_cd
	) REFERENCES fg.exempt_code
	(
	fg_exempt_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

--


BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_TransactionDW FOREIGN KEY
	(
	WKDOCO_salesorder_number,
	WKDCTO_order_type,
	WKLNNO_line_number
	) REFERENCES dbo.BRS_TransactionDW
	(
	SalesOrderNumber,
	DocType,
	LineNumber
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_TransactionDW1 FOREIGN KEY
	(
	ID_source_ref
	) REFERENCES dbo.BRS_TransactionDW
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_CalMonth FOREIGN KEY
	(
	CalMonthRedeem
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_CalMonth1 FOREIGN KEY
	(
	CalMonthOrder
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_exempt_code FOREIGN KEY
	(
	fg_exempt_cd
	) REFERENCES fg.exempt_code
	(
	fg_exempt_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_offer FOREIGN KEY
	(
	fg_offer_id
	) REFERENCES fg.offer
	(
	offer_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_SalesDay FOREIGN KEY
	(
	WKDATE_order_date
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_Customer FOREIGN KEY
	(
	WKSHAN_shipto
	) REFERENCES dbo.BRS_Customer
	(
	ShipTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_Item FOREIGN KEY
	(
	WKLITM_item_number
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_Currency FOREIGN KEY
	(
	WKCRCD_currency_code
	) REFERENCES dbo.BRS_Currency
	(
	Currency
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_Promotion FOREIGN KEY
	(
	WKPMID_promo_code
	) REFERENCES dbo.BRS_Promotion
	(
	PromotionCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_CustomerVPA FOREIGN KEY
	(
	VPA
	) REFERENCES dbo.BRS_CustomerVPA
	(
	VPA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_LineTypeOrder FOREIGN KEY
	(
	WKLNTY_line_type
	) REFERENCES dbo.BRS_LineTypeOrder
	(
	LineTypeOrder
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_SalesDivision FOREIGN KEY
	(
	WKAC10_division_code
	) REFERENCES dbo.BRS_SalesDivision
	(
	SalesDivision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_ItemMPC FOREIGN KEY
	(
	MajorProductClass
	) REFERENCES dbo.BRS_ItemMPC
	(
	MajorProductClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_ItemSupplier FOREIGN KEY
	(
	WK$SPC_supplier_code
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_CustomerBT FOREIGN KEY
	(
	WKAN8__billto
	) REFERENCES dbo.BRS_CustomerBT
	(
	BillTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_transaction_F5554240 FOREIGN KEY
	(
	WKDOCO_salesorder_number,
	WKDCTO_order_type,
	WKLNNO_line_number
	) REFERENCES fg.transaction_F5554240
	(
	WKDOCO_salesorder_number,
	WKDCTO_order_type,
	WKLNNO_line_number
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_CustomerSpecialty FOREIGN KEY
	(
	Specialty
	) REFERENCES dbo.BRS_CustomerSpecialty
	(
	Specialty
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_ItemLabel FOREIGN KEY
	(
	Label
	) REFERENCES dbo.BRS_ItemLabel
	(
	Label
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- add after
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD
	EnteredBy char(10) NOT NULL CONSTRAINT DF_transaction_F5554240_EnteredBy DEFAULT ''
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_entered_by FOREIGN KEY
	(
	EnteredBy
	) REFERENCES Pricing.entered_by
	(
	entered_by_code
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD
	OriginalOrderDocumentType char(2) NOT NULL CONSTRAINT DF_transaction_F5554240_OriginalOrderDocumentType DEFAULT (''),
	OriginalOrderLineNumber int NOT NULL CONSTRAINT DF_transaction_F5554240_OriginalOrderLineNumber DEFAULT ((0))
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_chargeback FOREIGN KEY
	(
	WK$ODN_free_goods_contract_number
	) REFERENCES fg.chargeback
	(
	cb_contract_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- drop TABLE [fg].[exempt_supplier_rule]

CREATE TABLE [fg].[exempt_supplier_rule](
	[ChargebackContractNumber] [int] NOT NULL,
	[Supplier] [char](6) NOT NULL,
	[VPA] [char](10) NOT NULL,

	[fg_exempt_cd_target] [char](6) NOT NULL,

	[rule_name_txt] [varchar](50) NOT NULL,

	[active_ind] [bit] NOT NULL DEFAULT(0),
	[sequence_num] [smallint] NOT NULL DEFAULT(0),
	[signoff_note_txt] [varchar](50) NULL,
	[creation_dt] [date] NOT NULL DEFAULT(GETDATE()),
	[exempt_supplier_rule_key] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [exempt_supplier_rule_c_pk] PRIMARY KEY CLUSTERED 
(
	[ChargebackContractNumber] ASC,
	[Supplier] ASC,
	[VPA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
ALTER TABLE fg.exempt_supplier_rule ADD CONSTRAINT
	FK_exempt_supplier_rule_exempt_code FOREIGN KEY
	(
	fg_exempt_cd_target
	) REFERENCES fg.exempt_code
	(
	fg_exempt_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.exempt_supplier_rule SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_exempt_supplier_rule FOREIGN KEY
	(
	exempt_supplier_rule_key
	) REFERENCES fg.exempt_supplier_rule
	(
	exempt_supplier_rule_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


BEGIN TRANSACTION
GO
ALTER TABLE fg.exempt_supplier_rule ADD CONSTRAINT
	FK_exempt_supplier_rule_chargeback FOREIGN KEY
	(
	ChargebackContractNumber
	) REFERENCES fg.chargeback
	(
	cb_contract_num
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.exempt_supplier_rule ADD CONSTRAINT
	FK_exempt_supplier_rule_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.exempt_supplier_rule ADD CONSTRAINT
	FK_exempt_supplier_rule_BRS_CustomerVPA FOREIGN KEY
	(
	VPA
	) REFERENCES dbo.BRS_CustomerVPA
	(
	VPA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.exempt_supplier_rule SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- 
INSERT INTO [fg].[exempt_supplier_rule]
           (
		   [ChargebackContractNumber]
		   ,[Supplier]
           ,[VPA]

           ,[fg_exempt_cd_target]
           ,[rule_name_txt]
           ,[active_ind]
           ,[sequence_num]
           ,[signoff_note_txt])
     VALUES
           (
		   0
			,''
           ,''

           ,''
           ,'.'
		   ,0
		   ,0
           ,'.'
           )
GO

/*
--- TBD, cost fix
-- build dynamic logic to find last day of month (fg view?)
SELECT 
	top 10
	m.CalMonth
	,l.SalesDate
	,l.Item
	,l.Supplier
	,l.Currency
	,l.SupplierCost

	,l.PriceKey

FROM         
	[dbo].[BRS_ItemBaseHistoryDay] AS l 

	INNER JOIN [dbo].[BRS_CalMonth] as m
	ON l.FiscalMonth = m.CalMonth AND
		l.SalesDate = '2021-08-27' AND
--		l.SalesDate = m.BCI_BenchmarkDay AND
		(1=1)
WHERE
	m.CalMonth = 202108
order by 2 asc
*/

-- line commission free goods redeem to DW so that we can complare model with actual via DW 

-- stage
BEGIN TRANSACTION
GO
ALTER TABLE Integration.comm_freegoods_Staging ADD
	WKLNNO_line_number int NULL,
	ID_source_ref int NULL
GO
ALTER TABLE Integration.comm_freegoods_Staging SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- prod (null as we are not updating historical for full RI)
BEGIN TRANSACTION
GO
ALTER TABLE [comm].[freegoods] ADD
	WKLNNO_line_number int NULL,
	ID_source_ref int NULL
GO
ALTER TABLE [comm].[freegoods] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE [comm].[freegoods] ADD CONSTRAINT
	FK_comm_freegoods_BRS_TransactionDW FOREIGN KEY
	(
	ID_source_ref
	) REFERENCES dbo.BRS_TransactionDW
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE [comm].[freegoods] SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-----------------------------------------------------------------
-- add chargebacks -- one-time
BEGIN TRANSACTION
GO
ALTER TABLE fg.chargeback ADD
	creation_dt date NULL,
	note_txt nchar(10) NULL
GO
ALTER TABLE fg.chargeback ADD CONSTRAINT
	DF_chargeback_creation_dt DEFAULT getdate() FOR creation_dt
GO
ALTER TABLE fg.chargeback SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- 1min
INSERT INTO [fg].[chargeback]
(
[cb_contract_num]
,[note_txt]
)
select distinct [ChargebackContractNumber], 'init' from [dbo].[BRS_TransactionDW] where [ChargebackContractNumber] > 0
GO

--truncate table zzzitem
--truncate table zzzitem2

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_FiscalMonth ADD
	fg_cost_date datetime NULL
GO
ALTER TABLE dbo.BRS_FiscalMonth ADD CONSTRAINT
	FK_BRS_FiscalMonth_BRS_SalesDay FOREIGN KEY
	(
	fg_cost_date
	) REFERENCES dbo.BRS_SalesDay
	(
	SalesDate
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_FiscalMonth SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD
	PriceKey int NULL
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_BRS_ItemBaseHistoryDAT FOREIGN KEY
	(
	PriceKey
	) REFERENCES dbo.BRS_ItemBaseHistoryDAT
	(
	PriceID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
--
-- UPDATE [fg].[transaction_F5554240] set fg_exempt_cd = ''

-- drop TABLE [fg].[item_cost_extract_override]
CREATE TABLE [fg].[item_cost_extract_override](
	[calmonth] [int] NOT NULL,
	[item] [char](10) NOT NULL,
	[unit_cost] [money] NOT NULL,
	[currency_code] [char](3) NOT NULL,
	[note_txt] [nchar](10) NULL,
	[create_dt] [datetime] NOT NULL Default (GETDATE()),
	item_cost_extract_override_key int NOT NULL Identity(1,1)
 CONSTRAINT [item_cost_extract_override_c_pk] PRIMARY KEY CLUSTERED 
(
	[calmonth] ASC,
	[item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX item_cost_extract_override_u_idx ON fg.item_cost_extract_override
	(
	item_cost_extract_override_key
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE fg.item_cost_extract_override SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD
	item_cost_extract_override_key int NULL
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_item_cost_extract_override FOREIGN KEY
	(
	item_cost_extract_override_key
	) REFERENCES fg.item_cost_extract_override
	(
	item_cost_extract_override_key
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.item_cost_extract_override ADD CONSTRAINT
	FK_item_cost_extract_override_BRS_CalMonth FOREIGN KEY
	(
	calmonth
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.item_cost_extract_override ADD CONSTRAINT
	FK_item_cost_extract_override_BRS_Item FOREIGN KEY
	(
	item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.item_cost_extract_override ADD CONSTRAINT
	FK_item_cost_extract_override_BRS_Currency FOREIGN KEY
	(
	currency_code
	) REFERENCES dbo.BRS_Currency
	(
	Currency
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.item_cost_extract_override SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/*
SELECT        MAX(s.SalesDate) AS Expr1
FROM            BRS_Config AS c INNER JOIN
                         BRS_SalesDay AS d ON c.PriorFiscalMonth = d.CalMonth INNER JOIN
                         BRS_ItemBaseHistoryDayLNK AS s ON d.SalesDate = s.SalesDate
GROUP BY 
d.FiscalMonth


UPDATE       BRS_FiscalMonth
SET                fg_cost_date =  0
FROM
BRS_FiscalMonth dd
INNER JOIN
(
	SELECT        d.FiscalMonth, MAX(s.SalesDate) AS Expr1
	FROM            BRS_Config AS c INNER JOIN
							 BRS_SalesDay AS d ON c.PriorFiscalMonth = d.CalMonth INNER JOIN
							 BRS_ItemBaseHistoryDayLNK AS s ON d.SalesDate = s.SalesDate
	GROUP BY 
	d.FiscalMonth
) ss
ON dd.FiscalMonth = ss.FiscalMonth

*/

--
-- drop TABLE [Integration].[F5554240_fg_redeem_finalize_Staging]
CREATE TABLE [Integration].[F5554240_fg_redeem_finalize_Staging](
	-- PK must match fg.transaction_F555115!ID
	[ID] [int] NOT NULL,

	-- check
	[CalMonthRedeem] [int] NOT NULL,
	[WK$SPC_supplier_code] [char](6) NOT NULL,
	[WKDOCO_salesorder_number] [int] NOT NULL,
	[WKSHAN_shipto] [int] NOT NULL,
	[WKLITM_item_number] [char](10) NOT NULL,

	-- update primary
	[fg_redeem_ind] [char](1) NOT NULL,
	[fg_offer_id] [int] NOT NULL,
	[fg_exempt_cd] [char](6) NOT NULL,
	[fg_offer_note] [varchar](30) NOT NULL,
	[OriginalSalesOrderNumber] [int] NOT NULL ,

	-- update secondary
	[WKECST_extended_cost] [money] NULL ,
	[WKCRCD_currency_code] [char](3) NULL,

	[status_code] [smallint] NOT NULL Default(-1),

 CONSTRAINT [Integration_F5554240_fg_redeem_finalize_Staging_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--
/****** Object:  Table [fg].[order_test]    Script Date: 2021/11/23 1:14:30 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fg].[order_test]') AND type in (N'U'))
DROP TABLE [fg].[order_test]
GO

/****** Object:  Table [fg].[order_test_detail]    Script Date: 2021/11/23 1:57:23 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fg].[order_test_detail]') AND type in (N'U'))
DROP TABLE [fg].[order_test_detail]
GO

/****** Object:  Table [fg].[offer_detail]    Script Date: 2021/11/23 1:59:33 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fg].[offer_detail]') AND type in (N'U'))
DROP TABLE [fg].[offer_detail]
GO

BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240
	DROP CONSTRAINT FK_transaction_F5554240_offer
GO
ALTER TABLE fg.offer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/****** Object:  Table [fg].[offer]    Script Date: 2021/11/23 2:00:14 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fg].[offer]') AND type in (N'U'))
DROP TABLE [fg].[offer]
GO

--
-- drop TABLE [fg].[deal]
CREATE TABLE [fg].[deal](
	[deal_id] [int] NOT NULL
	,[SalesDivision] [char](3) NOT NULL

	,[Supplier] [char](6) NOT NULL

	,buy_txt [varchar](50) NOT NULL default('.')
	,get_txt [varchar](50) NOT NULL default('.')
	,deal_txt [varchar](50) NOT NULL default('.')
	,[deal_type_cd] [char](6) NOT NULL Default ('')
	,buy_qty [smallint] NOT NULL default(0)
	,get_qty [smallint] NOT NULL default(0)

	,[EffDate] [date] NOT NULL
	,[Expired] [date] NOT NULL
	,[auto_add_ind] [bit] NOT NULL 
	,[active_ind] [bit] NOT NULL default(0)

	,[supplier_nmOrg] [nvarchar](50) NOT NULL
	,[BuyOrg] [nvarchar](255) NOT NULL
	,[GetOrg] [nvarchar](255) NOT NULL

	,[RedeemOrg] [nvarchar](1000) NOT NULL
	,[QuarterOrg] [nvarchar](255) NOT NULL
	,[SummaryOrg] [nvarchar](255) NOT NULL
	,[NoteOrg] [ntext] NOT NULL

 CONSTRAINT [fg_deal_c_pk] PRIMARY KEY CLUSTERED 
(
	[deal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [USERDATA] TEXTIMAGE_ON [USERDATA]
GO

--
-- drop TABLE [fg].[deal_item]
CREATE TABLE [fg].[deal_item](
	-- pk, ensure an item maps to one and only one deal
	[CalMonthRedeem] [int] NOT NULL
	,[item] [char](10) NOT NULL

	,[deal_id] [int] NOT NULL
	-- historical family set, used to consolidate orders for deals
	,[FamilySetLeader] [char](10) NOT NULL

	-- track imported vs LEARNED codes
	,[deal_source_cd] [char](6) NOT NULL Default ('')

	-- assume codes are all buy / get interchangable.  Mix and Max handled manually
	,buy_ind [bit] NOT NULL default (1)
	,get_ind [bit] NOT NULL default (1)
	,get_default_ind [bit] NOT NULL default(0)
	,active_ind [bit] NOT NULL default(1)

	,note_txt varchar(50) NULL
	,create_dt [date] NOT NULL default (getdate())
	,ID [int] NOT NULL identity(1,1)

 CONSTRAINT [fg_deal_item_c_pk] PRIMARY KEY CLUSTERED 
(
	[CalMonthRedeem] ASC
	,[item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

-- add default / na deal
INSERT INTO [fg].[deal]
           ([deal_id]
           ,[SalesDivision]
           ,[Supplier]
           ,[buy_txt]
           ,[get_txt]
           ,[deal_txt]
           ,[deal_type_cd]
           ,[buy_qty]
           ,[get_qty]
           ,[EffDate]
           ,[Expired]
           ,[auto_add_ind]
           ,[active_ind]
           ,[supplier_nmOrg]
           ,[BuyOrg]
           ,[GetOrg]
           ,[RedeemOrg]
           ,[QuarterOrg]
           ,[SummaryOrg]
           ,[NoteOrg])
     VALUES
           (0
           ,''
           ,''
           ,''
           ,''
           ,'na'
           ,''
           ,''
           ,''
           ,'1980-01-01'
           ,'1980-01-01'
           ,0
           ,0
           ,''
           ,''
           ,''
           ,''
           ,''
           ,''
           ,'')
GO


-- deal RI...
BEGIN TRANSACTION
GO
ALTER TABLE fg.transaction_F5554240 ADD CONSTRAINT
	FK_transaction_F5554240_deal FOREIGN KEY
	(
	fg_offer_id
	) REFERENCES fg.deal
	(
	deal_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.transaction_F5554240 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- deal RI
BEGIN TRANSACTION
GO
ALTER TABLE fg.deal ADD CONSTRAINT
	FK_deal_BRS_SalesDivision FOREIGN KEY
	(
	SalesDivision
	) REFERENCES dbo.BRS_SalesDivision
	(
	SalesDivision
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.deal ADD CONSTRAINT
	FK_deal_BRS_ItemSupplier FOREIGN KEY
	(
	Supplier
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.deal SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
ALTER TABLE fg.deal_item ADD CONSTRAINT
	FK_deal_item_BRS_CalMonth FOREIGN KEY
	(
	CalMonthRedeem
	) REFERENCES dbo.BRS_CalMonth
	(
	CalMonth
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.deal_item ADD CONSTRAINT
	FK_deal_item_BRS_Item FOREIGN KEY
	(
	item
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.deal_item ADD CONSTRAINT
	FK_deal_item_deal FOREIGN KEY
	(
	deal_id
	) REFERENCES fg.deal
	(
	deal_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.deal_item ADD CONSTRAINT
	FK_deal_item_BRS_Item1 FOREIGN KEY
	(
	FamilySetLeader
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE fg.deal_item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- fix prior error
-- UPDATE BRS_TransactionDW_Ext SET freegoods_exempt_cd = ' ' where freegoods_exempt_cd = '0'

BEGIN TRANSACTION
GO
ALTER TABLE dbo.Redemptions_tbl_Main ADD
	Setleader nvarchar(50) NULL,
	VendorID nvarchar(50) NULL,
	SetLeader_Name nvarchar(255) NULL,
	AutoAdd bit NULL
GO
ALTER TABLE dbo.Redemptions_tbl_Main SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-------------------------------------------------------------------------------
-- Map Actual FG to DW - BEGIN 
-------------------------------------------------------------------------------

-- clear
truncate table [Integration].[comm_freegoods_Staging]
GO

-- copy target (set dates)
INSERT INTO [Integration].[comm_freegoods_Staging]
(
	[FiscalMonth]
	,[SalesOrderNumber]
	,[DocType]
	,[original_line_number]
	,[SourceCode]
	,[Item]
	,ShipTo
	,Supplier
	,ExtFileCostCadAmt
)
SELECT
	[FiscalMonth]
	,[SalesOrderNumber]
	,[DocType]
	,[original_line_number]
	,[SourceCode]
	,[Item]
	,ShipTo
	,Supplier
	,ExtFileCostCadAmt
FROM [comm].[freegoods]
where
	[SourceCode] = 'ACT' AND
	[FiscalMonth] between 202101 and 202110 AND
	(1=1)
GO


-- update target
-- move this to comm prep proc, TBD

	-- clear values
	UPDATE 
		[Integration].[comm_freegoods_Staging]
			SET [WKLNNO_line_number] = null
			, ID_source_ref = null

	-- link free good transactions to [dbo].[STAGE_BRS_TransactionDW]
	UPDATE 
		[Integration].[comm_freegoods_Staging]
	SET 
		[WKLNNO_line_number] = s.LineNumber
		,ID_source_ref = s.id
	--test
	-- SELECT * 
	FROM
		[Integration].[comm_freegoods_Staging]
		INNER JOIN
			(
			SELECT
				[SalesOrderNumber], [Item], [original_line_number], ID,
				row_number() over(PARTITION BY [SalesOrderNumber], [Item] order by ID) rno_dst2
			FROM
				[Integration].[comm_freegoods_Staging]
			WHERE
				-- no internal, not avail
				--([WKAC10_division_code]<>'AZA') AND
				--([WKLNTY_line_type] NOT IN ('M2', 'MS')) AND
				([SourceCode] = 'ACT') AND
				--
				-- by definition, no adjustments or NON free goods included (ensure stage and DW match)
				-- test
				--(WKDOCO_salesorder_number in(14492625)) AND (WKLITM_item_number in('3783903')) AND
				--(WKDOCO_salesorder_number in(14498659)) AND (WKLITM_item_number in('5874352')) AND
				(1=1)
			) d
			ON [Integration].[comm_freegoods_Staging].ID = d.ID

			INNER JOIN 
			(
			SELECT
				[SalesOrderNumber], [DocType], [item], [LineNumber], ID,
				row_number() over(PARTITION BY [SalesOrderNumber], [item] order by ID) rno_src2
			FROM
				[dbo].[BRS_TransactionDW]
			WHERE 
				EXISTS (SELECT * FROM [Integration].[comm_freegoods_Staging] WHERE [SalesOrderNumber] = [SalesOrderNumber]) AND
				-- no internal
				([SalesDivision]<>'AZA') AND
				-- no adjustments
				(DocType <> 'AA') AND
				-- free goods only (relax qty = 0 for price adj, likely be to be ignored downstream
		--		([ShippedQty] <> 0) AND
				([NetSalesAmt] = 0) AND
				-- test
				--(SalesOrderNumber in(14492625)) AND (item in ('3783903')) AND
				--(SalesOrderNumber in(14498659)) AND (item in ('5874352')) AND
				(1=1)
			) s
			ON d.[SalesOrderNumber] = s.[SalesOrderNumber] AND
				-- not avail
				-- d.[WKDCTO_order_type] = s.[DocType] AND
				RTRIM(d.[item]) = RTRIM(s.[item]) AND
				d.rno_dst2 = s.rno_src2 AND
				(1=1)
		WHERE
			-- test
			--(Integration.F5554240_fg_redeem_Staging.WKDOCO_salesorder_number in(14492625)) AND (Integration.F5554240_fg_redeem_Staging.WKLITM_item_number in ('3783903')) AND
			--(Integration.F5554240_fg_redeem_Staging.WKDOCO_salesorder_number in(14498659)) AND (Integration.F5554240_fg_redeem_Staging.WKLITM_item_number in('5874352')) AND
			--(Integration.F5554240_fg_redeem_Staging.ID = 4263) AND
			(1=1)


-- copy back

UPDATE
	comm.freegoods
SET
	WKLNNO_line_number = s.WKLNNO_line_number
	,ID_source_ref = s.ID_source_ref
--SELECT *
FROM
	comm.freegoods
	INNER JOIN Integration.comm_freegoods_Staging AS s 
	ON comm.freegoods.FiscalMonth = s.FiscalMonth AND 
	comm.freegoods.SalesOrderNumber = s.SalesOrderNumber AND 
	comm.freegoods.original_line_number = s.original_line_number AND 
	comm.freegoods.SourceCode = s.SourceCode AND 
	comm.freegoods.DocType = s.DocType
WHERE
	s.WKLNNO_line_number is not null

-- ORG 51474
-- NEW 51283
-- 191 missed, pre 202108

-- clear
truncate table [Integration].[comm_freegoods_Staging]
GO

-------------------------------------------------------------------------------
-- Map Actual FG to DW - END
-------------------------------------------------------------------------------
/*
-- create views and procs:
[Dimension].[Item]
[Dimension].[Salesorder_note]
pricing.order_note_post_proc
fg.redeem_actual_commission
fg.item_cost_extract
[fg].[order_load_proc]
[fg].[order_update_proc]
fg.redeem_working
fg.redeem_working_notes
*/
-- test!
