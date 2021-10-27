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

	[CalMonth] [int] NOT NULL,
	[status_code] smallint not null default (-1),
	[fg_exempt_cd] char(6) null,

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
	[WKDATE_order_date] [char](8)  NULL,
	[WKFRGD_from_grade] [char](3)  NULL,
	[WKTHGD_thru_grade] [char](3)  NULL,
	[WKLNTY_line_type] [char](2)  NULL,
	[WKPSN__invoice_number] [numeric](8, 0)  NULL,
	[WK$ODN_free_goods_contract_number] [char](12)  NULL,
	[WKDL01_promo_description] [char](30)  NULL,
	[WKPMID_promo_code] [char] (2) NULL,
	[WKLNNO_line_number] [float] NULL,

	ID int identity(1,1) NOT NULL
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

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX F5554240_fg_redeem_Staging_u_idx01 ON Integration.F5554240_fg_redeem_Staging
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Integration.F5554240_fg_redeem_Staging SET (LOCK_ESCALATION = TABLE)
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

-- [BRS_TransactionDW_Ext] (3min)
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_TransactionDW_Ext ADD
	freegoods_exempt_cd smallint NOT NULL CONSTRAINT DF_BRS_TransactionDW_Ext_freegoods_exempt_cd DEFAULT 0
	,freegoods_exempt_note varchar(50) NULL
GO
COMMIT

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

-- set freegoods_exempt_cd values

-- [BRS_SalesDivision]
UPDATE dbo.BRS_SalesDivision 
	Set freegoods_exempt_cd = 1
WHERE SalesDivision = 'AZA'
GO


-- [BRS_DocType]
UPDATE dbo.BRS_DocType
	Set freegoods_exempt_cd = 1
WHERE DocType in ('CO', 'SX')
GO

-- [BRS_ItemSupplier]
UPDATE dbo.BRS_ItemSupplier
	SET freegoods_exempt_cd = 1
WHERE Supplier in('HENSCH', 'HENGLB', 'HSCAT', 'HSDENT', 'DELL', 'CDWCA')
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
	set freegoods_exempt_cd = 1
WHERE SalesOrderNumber = '-1'
GO

-- [BRS_Promotion]
UPDATE dbo.BRS_Promotion 
	set freegoods_exempt_cd = 1
WHERE PromotionCode = 'xxx'
GO



-- set freegoods_exempt_cd values

-- drop table fg.exempt_code

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

-- link fg to TransDW via sytheic PK

SELECT
	row_number() over(PARTITION BY WKDOCO_salesorder_number order by ID) rno_dst,
	WKDOCO_salesorder_number, WKLITM_item_number, line_id, ID
FROM            Integration.F5554240_fg_redeem_Staging
WHERE        (WKDOCO_salesorder_number in(14498659, 14503431)) AND (WKLITM_item_number in('5874352', '1019778'))


SELECT
	row_number() over(PARTITION BY [SalesOrderNumber] order by ID) rno,
	[SalesOrderNumber], [Item], [LineNumber], ID
FROM            [dbo].[BRS_TransactionDW]
WHERE        ([SalesOrderNumber]in(14498659, 14503431)) AND ( [Item]in('5874352', '1019778'))


--
SELECT
	row_number() over(PARTITION BY [SalesOrderNumber] order by ID) rno_src,
	[SalesOrderNumber], [DocType], [LineNumber], ID
FROM            [dbo].[BRS_TransactionDW]
WHERE 
	EXISTS (SELECT * FROM Integration.F5554240_fg_redeem_Staging WHERE [SalesOrderNumber] = WKDOCO_salesorder_number) AND
	(DocType <> 'AA') AND
	([ShippedQty] <> 0) AND
	([NetSalesAmt] = 0) AND
--	(FreeGoodsInvoicedInd = 1) AND
	([SalesOrderNumber] = 14498659) AND
	(1=1)


SELECT * 
FROM 
	(
	SELECT
		row_number() over(PARTITION BY WKDOCO_salesorder_number order by ID) rno_dst,
		WKDOCO_salesorder_number, [WKDCTO_order_type], WKLITM_item_number, line_id, ID
	FROM
		Integration.F5554240_fg_redeem_Staging 
	) d
	INNER JOIN 
	(
	SELECT
		row_number() over(PARTITION BY [SalesOrderNumber] order by ID) rno_src,
		[SalesOrderNumber], [DocType], [LineNumber], ID
	FROM
		[dbo].[BRS_TransactionDW]
	WHERE 
		EXISTS (SELECT * FROM Integration.F5554240_fg_redeem_Staging WHERE [SalesOrderNumber] = WKDOCO_salesorder_number) AND
		(DocType <> 'AA') AND
		([ShippedQty] <> 0) AND
		([NetSalesAmt] = 0) AND
		-- test
		--(SalesOrderNumber in(14498659, 14503431)) AND
		--(item in ('5874352', '1019778')) AND
		(1=1)
	) s
	ON WKDOCO_salesorder_number = [SalesOrderNumber] AND
		[WKDCTO_order_type] = [DocType] AND
		WKLITM_item_number = [WKLITM_item_number] AND
		s.rno_src = d.rno_dst
WHERE
	-- test
	(WKDOCO_salesorder_number in(14498659, 14503431)) AND 
	(WKLITM_item_number in('5874352', '1019778'))


--
-- UPDATE Integration.F5554240_fg_redeem_Staging SET [WKLNNO_line_number] = null

UPDATE Integration.F5554240_fg_redeem_Staging 
SET [WKLNNO_line_number] = s.LineNumber
--test
-- SELECT * 
FROM Integration.F5554240_fg_redeem_Staging
INNER JOIN
	(
	SELECT
		WKDOCO_salesorder_number, [WKDCTO_order_type], WKLITM_item_number, line_id, ID,
		row_number() over(PARTITION BY WKDOCO_salesorder_number order by WKLITM_item_number, ID) rno_dst
	FROM
		Integration.F5554240_fg_redeem_Staging 
	WHERE
		-- no internal
		([WKAC10_division_code]<>'AZA') AND
		-- by definition, no adjustments or NON free goods included (ensure stage and DW match)
		-- test
		--(WKDOCO_salesorder_number in(14492625)) AND (WKLITM_item_number in('3783903')) AND
		--(WKDOCO_salesorder_number in(14498659)) AND (WKLITM_item_number in('5874352')) AND
		(1=1)
	) d
	ON Integration.F5554240_fg_redeem_Staging.ID = d.ID

	INNER JOIN 
--	LEFT JOIN 
	(
	SELECT
		[SalesOrderNumber], [DocType], [item], [LineNumber], ID,
		row_number() over(PARTITION BY [SalesOrderNumber] order by [item], ID) rno_src
	FROM
		[dbo].[BRS_TransactionDW]
	WHERE 
		EXISTS (SELECT * FROM Integration.F5554240_fg_redeem_Staging WHERE [SalesOrderNumber] = WKDOCO_salesorder_number) AND
		-- no internal
		([SalesDivision]<>'AZA') AND
		-- no adjustments
		(DocType <> 'AA') AND
		-- free goods only
		([ShippedQty] <> 0) AND
		([NetSalesAmt] = 0) AND
		-- test
		--(SalesOrderNumber in(14492625)) AND (item in ('3783903')) AND
		--(SalesOrderNumber in(14498659)) AND (item in ('5874352')) AND
		(1=1)
	) s
	ON d.WKDOCO_salesorder_number = s.[SalesOrderNumber] AND
		d.[WKDCTO_order_type] = s.[DocType] AND
		RTRIM(d.WKLITM_item_number) = RTRIM(s.[item]) AND
		d.rno_dst = s.rno_src AND
		(1=1)
WHERE
	-- test
	(Integration.F5554240_fg_redeem_Staging.WKDOCO_salesorder_number in(14492625)) AND (Integration.F5554240_fg_redeem_Staging.WKLITM_item_number in ('3783903')) AND

--	(Integration.F5554240_fg_redeem_Staging.WKDOCO_salesorder_number in(14498659)) AND (Integration.F5554240_fg_redeem_Staging.WKLITM_item_number in('5874352')) AND
--	(Integration.F5554240_fg_redeem_Staging.ID = 4263) AND
	(1=1)

--

