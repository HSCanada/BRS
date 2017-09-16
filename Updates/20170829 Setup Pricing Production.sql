-- remove unused table
-- drop table [Integration].[F4101_item_master_StagingOLD]
-- drop table [Integration].adjustment_name_primary_customer_Staging
-- drop view CustomerPriceEnroll

-- Customer
-- drop view [Dimension].[CustomerBillto]
-- drop view [Dimension].[CustomerPriceEnroll]
-- drop view [Dimension].[Geography]
-- drop view [Dimension].[Salesperson]
-- drop view [Dimension].[SalesPlan]
-- drop view [Dimension].[PriceAdjustment]
-- drop view [Dimension].[CustomerGroup]
-- Item
-- drop view [Dimension].[ItemCategory]
-- drop view [Dimension].[Supplier]

-- Salesorder
-- drop view [Dimension].[Promotion]
-- drop view [Dimension].[DocType]
-- drop view [Dimension].[Ordersource]

-- Period
-- drop view [Dimension].[Date]

-- QuotePrice
-- drop view [Dimension].[Price]

---

ALTER TABLE dbo.BRS_ItemBaseHistoryDayLNK
	DROP CONSTRAINT FK_BRS_ItemBaseHistoryDayLNK_BRS_ItemBaseHistoryDAT

ALTER TABLE dbo.BRS_ItemBaseHistoryLNK
	DROP CONSTRAINT FK_BRS_ItemBaseHistoryLNK_BRS_ItemBaseHistoryDAT

DROP INDEX BRS_ItemBaseHistoryDAT_cu_idx_1 ON dbo.BRS_ItemBaseHistoryDAT

ALTER TABLE dbo.BRS_ItemBaseHistoryDAT
	DROP CONSTRAINT BRS_ItemBaseHistoryDAT_pk


BEGIN TRANSACTION

ALTER TABLE dbo.BRS_ItemBaseHistoryDAT ADD CONSTRAINT
	BRS_ItemBaseHistoryDAT_c_pk PRIMARY KEY CLUSTERED 
	(
	PriceID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


CREATE UNIQUE NONCLUSTERED INDEX BRS_ItemBaseHistoryDAT_u_idx_01 ON dbo.BRS_ItemBaseHistoryDAT
	(
	CorporatePrice,
	SupplierCost,
	SellPrcBrk2,
	Supplier,
	SellPrcBrk3,
	SellQtyBrk2,
	SellQtyBrk3,
	Currency,
	PriceID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

ALTER TABLE dbo.BRS_ItemBaseHistoryDAT SET (LOCK_ESCALATION = TABLE)

COMMIT

/*
SELECT        COUNT (distinct [SellQtyBrk3]) AS Expr1 FROM BRS_ItemBaseHistoryDAT

[CorporatePrice] = 71 878
[SupplierCost] = 46 383
[SellPrcBrk2] = 6 925
Supplier = 1 222
[SellPrcBrk3] = 1 250
[SellQtyBrk2] = 25
[SellQtyBrk3] = 19
[Currency] = 9
[PriceID] = 591 808

*/
BEGIN TRANSACTION

CREATE NONCLUSTERED INDEX BRS_ItemBaseHistoryDayLNK_idx_02 ON dbo.BRS_ItemBaseHistoryDayLNK
	(
	ItemKey,
	SalesDate,
	PriceKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

CREATE NONCLUSTERED INDEX BRS_ItemBaseHistoryDayLNK_idx_03 ON dbo.BRS_ItemBaseHistoryDayLNK
	(
	FamilySetLeaderKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

ALTER TABLE dbo.BRS_ItemBaseHistoryDayLNK SET (LOCK_ESCALATION = TABLE)

COMMIT

BEGIN TRANSACTION

DROP INDEX BRS_ItemBaseHistory_idx_2 ON dbo.BRS_ItemBaseHistoryLNK

DROP INDEX BRS_ItemBaseHistory_idx_1 ON dbo.BRS_ItemBaseHistoryLNK

ALTER TABLE dbo.BRS_ItemBaseHistoryLNK
	DROP CONSTRAINT BRS_ItemBaseHistory_c_pk

ALTER TABLE dbo.BRS_ItemBaseHistoryLNK SET (LOCK_ESCALATION = TABLE)

COMMIT

ALTER TABLE dbo.BRS_ItemBaseHistoryLNK ADD CONSTRAINT
	BRS_ItemBaseHistoryLNK_c_idx PRIMARY KEY CLUSTERED 
	(
	ItemID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX BRS_ItemBaseHistoryDayLNK_idx_04 ON dbo.BRS_ItemBaseHistoryDayLNK
	(
	PriceKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO

CREATE NONCLUSTERED INDEX BRS_ItemBaseHistoryDAT_idx_03 ON dbo.BRS_ItemBaseHistoryDAT
	(
	Currency
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO

CREATE NONCLUSTERED INDEX BRS_CurrencyHistory_idx_02 ON dbo.BRS_CurrencyHistory
	(
	FiscalMonth,
	Currency,
	FX_per_USD_pnl_rt,
	FX_per_CAD_mrk_rt
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO


drop table BRS_ItemBaseHistoryLNK


/****** Object:  Table [Integration].[F4071_price_adjustment_name_Staging]    Script Date: 8/29/2017 1:51:02 PM ******/

CREATE TABLE [Pricing].[price_adjustment_name_F4071](
	[ATAST__adjustment_name] [char](8) NOT NULL,
	[ATPRGR_item_price_group] [char](8) NOT NULL,
	[ATCPGP_customer_price_group] [char](8) NOT NULL,
	[ATSDGR_order_detail_group] [char](8) NOT NULL,
	[ATPRFR_preference_type] [char](2) NOT NULL,
	[ATLBT__level_break_type] [char](1) NOT NULL,
	[ATGLC__gl_offset] [char](4) NOT NULL,
	[ATSBIF_subledger_in_gl] [char](1) NOT NULL,
	[ATACNT_adjustment_control_code] [char](1) NOT NULL,
	[ATLNTY_line_type] [char](2) NOT NULL,
	[ATMDED_manual_addchange_yn] [char](1) NOT NULL,
	[ATABAS_override_price_yn] [char](1) NOT NULL,
	[ATOLVL_adjustment_level] [char](1) NOT NULL,
	[ATTXB__taxable_yn] [char](1) NOT NULL,
	[ATPA01_rebate_beneficiary] [char](1) NOT NULL,
	[ATPA02_mandatory_adjustment] [char](1) NOT NULL,
	[ATPA03_exclude_from_payment_discount] [char](1) NOT NULL,
	[ATPA04_target_application] [char](1) NOT NULL,
	[ATPA05_include_in_margin_calc] [char](1) NOT NULL,
	[ATPA06_final_price] [char](1) NOT NULL,
	[ATPA07_processing_type_free_good] [char](1) NOT NULL,
	[ATPA08_price_adjustment_code_08] [char](1) NOT NULL,
	[ATPA09_price_adjustment_code_09] [char](1) NOT NULL,
	[ATPA10_price_adjustment_code_10] [char](1) NOT NULL,
	[ATEFCN_excl_from_curr_net] [char](1) NOT NULL,
	[ATPTC__payment_terms] [char](3) NOT NULL,
	[ATURCD_user_reserved_code] [char](2) NOT NULL,
	[ATURDT_user_reserved_date_JDT] [numeric](6, 0) NOT NULL,
	[ATURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[ATURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[ATURRF_user_reserved_reference] [char](15) NOT NULL,
	[ATUSER_user_id] [char](10) NOT NULL,
	[ATPID__program_id] [char](10) NOT NULL,
	[ATJOBN_work_station_id] [char](10) NOT NULL,
	[ATUPMJ_date_updated] [date] NOT NULL,
	[ATTDAY_time_of_day] [numeric](6, 0) NOT NULL,
	[AdjustmentNameKey] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [price_adjustment_name_F4071_pk] PRIMARY KEY CLUSTERED 
(
	[ATAST__adjustment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

/****** Object:  Index [F4071_price_adjustment_name_u_idx]    Script Date: 8/29/2017 1:51:02 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [price_adjustment_name_F4071_u_idx] ON [Pricing].[price_adjustment_name_F4071]
(
	[AdjustmentNameKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

-- remove reduntance suragate key from stage
BEGIN TRANSACTION

DROP INDEX F4071_price_adjustment_name_u_idx ON Integration.F4071_price_adjustment_name_Staging

ALTER TABLE Integration.F4071_price_adjustment_name_Staging
	DROP COLUMN AdjustmentNameKey

ALTER TABLE Integration.F4071_price_adjustment_name_Staging SET (LOCK_ESCALATION = TABLE)

COMMIT

/****** Object:  Table [Integration].[F4072_price_adjustment_detail_Staging]    Script Date: 8/29/2017 2:16:16 PM ******/

CREATE TABLE [Pricing].[price_adjustment_detail_F4072](
	[ADATID_price_adjustment_key_id] [numeric](8, 0) NOT NULL,
	[ADAST__adjustment_name] [char](8) NOT NULL,
	[ADITM__item_number_short] [numeric](8, 0) NOT NULL,
	[ADLITM_item_number] [char](10) NOT NULL,
	[ADAITM__3rd_item_number] [char](25) NOT NULL,
	[ADAN8__billto] [int] NOT NULL,
	[ADICID_itemcustomer_key_id] [numeric](8, 0) NOT NULL,
	[ADSDGR_order_detail_group] [char](8) NOT NULL,
	[ADSDV1_sales_detail_value_01] [char](12) NOT NULL,
	[ADSDV2_sales_detail_value_02] [char](12) NOT NULL,
	[ADSDV3_sales_detail_value_03] [char](8) NOT NULL,
	[ADCRCD_currency_code] [char](3) NOT NULL,
	[ADUOM__um] [char](2) NOT NULL,
	[ADMNQ__quantity_from] [numeric](15, 0) NOT NULL,
	[ADEFTJ_effective_date] [date] NOT NULL,
	[ADEXDJ_expired_date] [date] NOT NULL,
	[ADBSCD_basis] [char](1) NOT NULL,
	[ADLEDG_cost_method] [char](2) NOT NULL,
	[ADFRMN_formula_name] [char](10) NOT NULL,
	[ADFCNM_function_name] [char](32) NOT NULL,
	[ADFVTR_factor_value] [numeric](15, 4) NOT NULL,
	[ADFGY__free_goods_yn] [char](1) NOT NULL,
	[ADURCD_user_reserved_code] [char](2) NOT NULL,
	[ADURDT_user_reserved_date_JDT] [numeric](6, 0) NOT NULL,
	[ADURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[ADURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[ADURRF_user_reserved_reference] [char](15) NOT NULL,
	[ADASTN_adjustment_for_net_price] [char](8) NOT NULL,
	[ADUSER_user_id] [char](10) NOT NULL,
	[ADPID__program_id] [char](10) NOT NULL,
	[ADJOBN_work_station_id] [char](10) NOT NULL,
	[ADUPMJ_date_updated] [date] NOT NULL,
	[ADTDAY_time_of_day] [numeric](6, 0) NOT NULL,
	[ADUPAJ_date_added] [date] NOT NULL,
	[ADTENT_time_entered] [numeric](6, 0) NOT NULL,
 CONSTRAINT [price_adjustment_detail_F4072_pk] PRIMARY KEY CLUSTERED 
(
	[ADAST__adjustment_name] ASC,
	[ADITM__item_number_short] ASC,
	[ADAN8__billto] ASC,
	[ADICID_itemcustomer_key_id] ASC,
	[ADCRCD_currency_code] ASC,
	[ADUOM__um] ASC,
	[ADMNQ__quantity_from] ASC,
	[ADEXDJ_expired_date] ASC,
	[ADATID_price_adjustment_key_id] ASC,
	[ADUPMJ_date_updated] ASC,
	[ADTDAY_time_of_day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


/****** Object:  Index [F4072_price_adjustment_detail_idx_01]    Script Date: 8/29/2017 2:16:16 PM ******/
CREATE NONCLUSTERED INDEX [price_adjustment_detail_F4072_idx_01] ON [Pricing].[price_adjustment_detail_F4072]
(
	[ADLITM_item_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

/****** Object:  Index [F4072_price_adjustment_detail_idx_02]    Script Date: 8/29/2017 2:16:16 PM ******/
CREATE NONCLUSTERED INDEX [price_adjustment_detail_F4072_idx_02] ON [Pricing].[price_adjustment_detail_F4072]
(
	[ADAN8__billto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

/****** Object:  Index [F4072_price_adjustment_detail_idx_03]    Script Date: 8/29/2017 2:16:16 PM ******/
CREATE NONCLUSTERED INDEX [price_adjustment_detail_F4072_idx_03] ON [Pricing].[price_adjustment_detail_F4072]
(
	[ADICID_itemcustomer_key_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

CREATE UNIQUE NONCLUSTERED INDEX price_adjustment_detail_F4072_u_idx_04 ON Pricing.price_adjustment_detail_F4072
	(
	ADATID_price_adjustment_key_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO

CREATE NONCLUSTERED INDEX price_adjustment_detail_F4072_idx_05 ON Pricing.price_adjustment_detail_F4072
	(
	ADITM__item_number_short,
	ADAST__adjustment_name,
	ADAN8__billto,
	ADATID_price_adjustment_key_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO


-- SELECT COUNT(DISTINCT [ADATID_price_adjustment_key_id]) FROM [Pricing].[price_adjustment_detail_F4072]
-- [ADITM__item_number_short] = 200022
-- [ADAN8__billto] = 3665
-- [ADAST__adjustment_name] = 548
-- [ADATID_price_adjustment_key_id] = 705925

/****** Object:  Table [Integration].[F40314_preference_price_adjustment_schedule_Staging]    Script Date: 8/29/2017 2:34:38 PM ******/

CREATE TABLE [Pricing].[price_adjustment_enroll_F40314](
	[PJAN8__billto] [int] NOT NULL,
	[PJCS14_customer_group_price_adjustment_sched] [char](8) NOT NULL,
	[PJITM__item_number_short] [numeric](8, 0) NOT NULL,
	[PJIT14_item_group_price_adjustment_schedule] [char](8) NOT NULL,
	[PJEFTJ_effective_date] [date] NOT NULL,
	[PJEXDJ_expired_date] [date] NOT NULL,
	[PJMNQ__quantity_from] [numeric](15, 0) NOT NULL,
	[PJMXQ__quantity_thru] [numeric](15, 0) NOT NULL,
	[PJUOM__um] [char](2) NOT NULL,
	[PJTXID_text_id_number] [numeric](8, 0) NOT NULL,
	[PJSTPR_preference_status] [char](1) NOT NULL,
	[PJOSEQ_sequence_number] [numeric](4, 0) NOT NULL,
	[PJMCU__business_unit] [char](12) NOT NULL,
	[PJASN__adjustment_schedule] [char](10) NOT NULL,
	[PJURCD_user_reserved_code] [char](2) NOT NULL,
	[PJURDT_user_reserved_date_JDT] [numeric](6, 0) NOT NULL,
	[PJURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[PJURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[PJURRF_user_reserved_reference] [char](15) NOT NULL,
	[PJUSER_user_id] [char](10) NOT NULL,
	[PJPID__program_id] [char](10) NOT NULL,
	[PJJOBN_work_station_id] [char](10) NOT NULL,
	[PJUPMJ_date_updated] [date] NOT NULL,
	[PJTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [price_adjustment_enroll_F40314_pk] PRIMARY KEY CLUSTERED 
(
	[PJAN8__billto] ASC,
	[PJCS14_customer_group_price_adjustment_sched] ASC,
	[PJITM__item_number_short] ASC,
	[PJIT14_item_group_price_adjustment_schedule] ASC,
	[PJEXDJ_expired_date] ASC,
	[PJMXQ__quantity_thru] ASC,
	[PJUOM__um] ASC,
	[PJOSEQ_sequence_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO



/****** Object:  Table [Integration].[F4070_price_adjustment_schedule_Staging]    Script Date: 8/29/2017 2:57:35 PM ******/

CREATE TABLE [Pricing].[price_adjustment_schedule_F4070](
	[SNASN__adjustment_schedule] [char](10) NOT NULL,
	[SNOSEQ_sequence_number] [numeric](4, 0) NOT NULL,
	[SNAST__adjustment_name] [char](8) NOT NULL,
	[SNURCD_user_reserved_code] [char](2) NOT NULL,
	[SNURDT_user_reserved_date_JDT] [numeric](6, 0) NOT NULL,
	[SNURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[SNURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[SNURRF_user_reserved_reference] [char](15) NOT NULL,
	[SNUSER_user_id] [char](10) NOT NULL,
	[SNPID__program_id] [char](10) NOT NULL,
	[SNJOBN_work_station_id] [char](10) NOT NULL,
	[SNUPMJ_date_updated] [date] NOT NULL,
	[SNTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [price_adjustment_schedule_F4070_pk] PRIMARY KEY CLUSTERED 
(
	[SNASN__adjustment_schedule] ASC,
	[SNOSEQ_sequence_number] ASC,
	[SNAST__adjustment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


/****** Object:  Table [Pricing].[price_adjustment_enroll_F40314]    Script Date: 8/30/2017 12:27:07 PM ******/

CREATE TABLE [Pricing].[price_adjustment_enroll](
	[BillTo] int NOT NULL,
	[PJASN__adjustment_schedule] [char](10) NOT NULL,
	[PJEFTJ_effective_date] [date] NOT NULL,
	[PJEXDJ_expired_date] [date] NOT NULL,
	[PJUPMJ_date_updated] [date] NOT NULL,
	[PJUSER_user_id] [char](10) NOT NULL,
	[SNAST__adjustment_name] [char](8) NOT NULL,
	[EnrollSource] [char](8) NOT NULL,
	[PriceMethod] [char](1) NOT NULL,


 CONSTRAINT [price_adjustment_enroll_pk] PRIMARY KEY CLUSTERED 
(
	[BillTo] ASC
	
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

CREATE NONCLUSTERED INDEX price_adjustment_enroll_idx_01 ON Pricing.price_adjustment_enroll
	(
	SNAST__adjustment_name,
	EnrollSource,
	PJEFTJ_effective_date,
	PJEXDJ_expired_date,
	PriceMethod,
	BillTo
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO

-- SELECT count(distinct [BillTo]) FROM Pricing.price_adjustment_enroll


/****** Object:  Table [Integration].[F4094_item_customer_keyid_master_file_Staging]    Script Date: 8/30/2017 2:07:47 PM ******/

CREATE TABLE [Pricing].[item_customer_keyid_master_file_F4094](
	[KIPRGR_item_price_group] [char](8) NOT NULL,
	[KIIGP1_item_group_category_code_01] [char](6) NOT NULL,
	[KIIGP2_item_group_category_code_02] [char](6) NOT NULL,
	[KIIGP3_item_group_category_code_03] [char](6) NOT NULL,
	[KIIGP4_item_group_category_code_04] [char](6) NOT NULL,
	[KICPGP_customer_price_group] [char](8) NOT NULL,
	[KICGP1_customer_group_category_code_01] [char](3) NOT NULL,
	[KICGP2_customer_group_category_code_02] [char](3) NOT NULL,
	[KICGP3_customer_group_category_code_03] [char](3) NOT NULL,
	[KICGP4_customer_group_category_code_04] [char](3) NOT NULL,
	[KIICID_itemcustomer_key_id] [numeric](8, 0) NOT NULL,
 CONSTRAINT [item_customer_keyid_master_file_F4094_pk] PRIMARY KEY CLUSTERED 
(
	[KIPRGR_item_price_group] ASC,
	[KIIGP1_item_group_category_code_01] ASC,
	[KIIGP2_item_group_category_code_02] ASC,
	[KIIGP3_item_group_category_code_03] ASC,
	[KIIGP4_item_group_category_code_04] ASC,
	[KICPGP_customer_price_group] ASC,
	[KICGP1_customer_group_category_code_01] ASC,
	[KICGP2_customer_group_category_code_02] ASC,
	[KICGP3_customer_group_category_code_03] ASC,
	[KICGP4_customer_group_category_code_04] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

/****** Object:  Index [F4094_item_customer_keyid_master_file_u_idx]    Script Date: 8/30/2017 2:07:47 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [item_customer_keyid_master_file_F4094_u_idx] ON [Pricing].[item_customer_keyid_master_file_F4094]
(
	[KIICID_itemcustomer_key_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO


/****** Object:  Table [Integration].[F4101_item_master_Staging]    Script Date: 8/30/2017 2:16:10 PM ******/

CREATE TABLE [Pricing].[item_master_F4101](
	[IMITM__item_number_short] [numeric](8, 0) NOT NULL,
	[IMLITM_item_number] [char](10) NOT NULL,
	[IMAITM__3rd_item_number] [char](25) NOT NULL,
	[IMDSC1_description] [char](30) NOT NULL,
	[IMDSC2_description_2] [char](30) NOT NULL,
	[IMSRTX_search_text] [char](30) NOT NULL,
	[IMALN__search_text_compressed] [char](30) NOT NULL,
	[IMSRP1_major_product_class] [char](3) NOT NULL,
	[IMSRP2_sub_major_product_class] [char](3) NOT NULL,
	[IMSRP3_minor_product_class] [char](3) NOT NULL,
	[IMSRP4_sub_minor_product_class] [char](3) NOT NULL,
	[IMSRP5_hazardous_class] [char](3) NOT NULL,
	[IMSRP6_manufacturer] [char](6) NOT NULL,
	[IMSRP7_drug_class] [char](6) NOT NULL,
	[IMSRP8_manuf_dspsearch] [char](6) NOT NULL,
	[IMSRP9_category_code_9] [char](6) NOT NULL,
	[IMSRP0_category_code_10] [char](6) NOT NULL,
	[IMPRP1_commodity_class] [char](3) NOT NULL,
	[IMPRP2_commodity_sub_class] [char](3) NOT NULL,
	[IMPRP3_supplier_rebate_code] [char](3) NOT NULL,
	[IMPRP4_tax_classification] [char](3) NOT NULL,
	[IMPRP5_landed_cost_rule] [char](3) NOT NULL,
	[IMPRP6_item_dimension_group] [char](6) NOT NULL,
	[IMPRP7_warehouse_process_grp_1] [char](6) NOT NULL,
	[IMPRP8_warehouse_process_grp_2] [char](6) NOT NULL,
	[IMPRP9_warehouse_process_grp_3] [char](6) NOT NULL,
	[IMPRP0_commodity_code] [char](6) NOT NULL,
	[IMCDCD_commodity_code] [char](15) NOT NULL,
	[IMPDGR_product_group] [char](3) NOT NULL,
	[IMDSGP_dispatch_group] [char](3) NOT NULL,
	[IMPRGR_item_price_group] [char](8) NOT NULL,
	[IMRPRC_basket_reprice_group] [char](8) NOT NULL,
	[IMORPR_order_reprice_group] [char](8) NOT NULL,
	[IMBUYR_buyer_number] [numeric](8, 0) NOT NULL,
	[IMDRAW_drawing_number] [char](20) NOT NULL,
	[IMRVNO_last_revision_no] [char](3) NOT NULL,
	[IMDSZE_drawing_size] [char](1) NOT NULL,
	[IMVCUD_volume_cubic_dimensions] [numeric](15, 4) NOT NULL,
	[IMCARS_carrier_number] [numeric](8, 0) NOT NULL,
	[IMCARP_preferred_carrier_purchasing] [numeric](8, 0) NOT NULL,
	[IMSHCN_shipping_conditions_code] [char](3) NOT NULL,
	[IMSHCM_shipping_commodity_class] [char](3) NOT NULL,
	[IMUOM1_unit_of_measure] [char](2) NOT NULL,
	[IMUOM2_secondary_uom] [char](2) NOT NULL,
	[IMUOM3_purchasing_uom] [char](2) NOT NULL,
	[IMUOM4_pricing_uom] [char](2) NOT NULL,
	[IMUOM6_shipping_uom] [char](2) NOT NULL,
	[IMUOM8_production_uom] [char](2) NOT NULL,
	[IMUOM9_component_uom] [char](2) NOT NULL,
	[IMUWUM_unit_of_measure_weight] [char](2) NOT NULL,
	[IMUVM1_unit_of_measure_volume] [char](2) NOT NULL,
	[IMSUTM_stocking_um] [char](2) NOT NULL,
	[IMUMVW_psauvolume_or_weight] [char](1) NOT NULL,
	[IMCYCL_cycle_count_category] [char](3) NOT NULL,
	[IMGLPT_gl_category] [char](4) NOT NULL,
	[IMPLEV_sales_price_level] [char](1) NOT NULL,
	[IMPPLV_purchase_price_level] [char](1) NOT NULL,
	[IMCLEV_inventory_cost_level] [char](1) NOT NULL,
	[IMPRPO_gradepotency_pricing] [char](1) NOT NULL,
	[IMCKAV_check_availability_yn] [char](1) NOT NULL,
	[IMBPFG_bulkpacked_flag] [char](1) NOT NULL,
	[IMSRCE_layer_code_source] [char](1) NOT NULL,
	[IMOT1Y_potency_control] [char](1) NOT NULL,
	[IMOT2Y_grade_control] [char](1) NOT NULL,
	[IMSTDP_standard_potency] [numeric](15, 3) NOT NULL,
	[IMFRMP_from_potency] [numeric](15, 3) NOT NULL,
	[IMTHRP_thru_potency] [numeric](15, 3) NOT NULL,
	[IMSTDG_standard_grade] [char](3) NOT NULL,
	[IMFRGD_from_grade] [char](3) NOT NULL,
	[IMTHGD_thru_grade] [char](3) NOT NULL,
	[IMCOTY_component_type] [char](1) NOT NULL,
	[IMSTKT_stocking_type] [char](1) NOT NULL,
	[IMLNTY_line_type] [char](2) NOT NULL,
	[IMCONT_contract_item] [char](1) NOT NULL,
	[IMBACK_backorders_allowed_yn] [char](1) NOT NULL,
	[IMIFLA_item_flash_message] [char](2) NOT NULL,
	[IMTFLA_std_uom_conversion] [char](2) NOT NULL,
	[IMINMG_print_message] [char](10) NOT NULL,
	[IMABCS_abc_code_1_sales] [char](1) NOT NULL,
	[IMABCM_abc_code_2_margin] [char](1) NOT NULL,
	[IMABCI_abc_code_3_investment] [char](1) NOT NULL,
	[IMOVR__abc_code_override_indicator] [char](1) NOT NULL,
	[IMWARR_warranty_item_group] [char](8) NOT NULL,
	[IMCMCG_commission_category] [char](8) NOT NULL,
	[IMSRNR_serial_no_required] [char](1) NOT NULL,
	[IMPMTH_kit_pricing_method] [char](1) NOT NULL,
	[IMFIFO_fifo_processing] [char](1) NOT NULL,
	[IMLOTS_lot_status_code] [char](1) NOT NULL,
	[IMSLD__shelf_life_days] [numeric](6, 0) NOT NULL,
	[IMANPL_planner_number] [numeric](8, 0) NOT NULL,
	[IMMPST_planning_code] [char](1) NOT NULL,
	[IMPCTM_percent_margin] [numeric](15, 3) NOT NULL,
	[IMMMPC_margin_maintenance_pct] [numeric](15, 3) NOT NULL,
	[IMPTSC_part_status_code] [char](2) NOT NULL,
	[IMSNS__round_to_whole_number] [char](1) NOT NULL,
	[IMLTLV_leadtime_level] [numeric](5, 0) NOT NULL,
	[IMLTMF_leadtime_manufacturing] [numeric](5, 0) NOT NULL,
	[IMLTCM_leadtime_cumulative] [numeric](5, 0) NOT NULL,
	[IMOPC__order_policy_code] [char](1) NOT NULL,
	[IMOPV__value_order_policy] [numeric](15, 0) NOT NULL,
	[IMACQ__accounting_cost_quantity] [numeric](15, 0) NOT NULL,
	[IMMLQ__mfg_leadtime_quantity] [numeric](15, 0) NOT NULL,
	[IMLTPU_leadtime_per_unit] [numeric](15, 2) NOT NULL,
	[IMMPSP_planning_fence_rule] [char](1) NOT NULL,
	[IMMRPP_fixedvariable_leadtime] [char](1) NOT NULL,
	[IMITC__issue_type_code] [char](1) NOT NULL,
	[IMORDW_order_with_yn] [char](1) NOT NULL,
	[IMMTF1_planning_fence] [numeric](5, 0) NOT NULL,
	[IMMTF2_freeze_fence] [numeric](5, 0) NOT NULL,
	[IMMTF3_message_display_fence] [numeric](5, 0) NOT NULL,
	[IMMTF4_time_fence] [numeric](5, 0) NOT NULL,
	[IMMTF5_shipment_leadtime_offset] [numeric](5, 0) NOT NULL,
	[IMMTF6_supply_time_fence] [numeric](5, 0) NOT NULL,
	[IMEXPD_expedite_damper_days] [numeric](5, 0) NOT NULL,
	[IMDEFD_defer_damper_days] [numeric](5, 0) NOT NULL,
	[IMSFLT_safety_leadtime] [numeric](5, 0) NOT NULL,
	[IMMAKE_makebuy_code] [char](1) NOT NULL,
	[IMCOBY_cobyproductintermediate] [char](1) NOT NULL,
	[IMLLX__low_level_code] [numeric](3, 0) NOT NULL,
	[IMCMGL_commitment_method] [char](1) NOT NULL,
	[IMCOMH_specific_commitment_days] [numeric](3, 0) NOT NULL,
	[IMCSNN_configured_string_id_next_number] [numeric](8, 0) NOT NULL,
	[IMURCD_user_reserved_code] [char](2) NOT NULL,
	[IMURDT_user_reserved_date] [date] NOT NULL,
	[IMURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[IMURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[IMURRF_user_reserved_reference] [char](15) NOT NULL,
	[IMAVRT_average_queue_hours] [numeric](15, 2) NOT NULL,
	[IMUPCN_upc_number] [char](13) NOT NULL,
	[IMSCC0_aggregate_scc_code_pi0] [char](14) NOT NULL,
	[IMUMUP_unit_of_measure_upc] [char](2) NOT NULL,
	[IMUMDF_unit_of_measure_aggregate_upc] [char](2) NOT NULL,
	[IMUMS0_unit_of_measure_sccpi0] [char](2) NOT NULL,
	[IMUMS1_unit_of_measure_sccpi1] [char](2) NOT NULL,
	[IMUMS2_unit_of_measure_sccpi2] [char](2) NOT NULL,
	[IMUMS3_unit_of_measure_sccpi3] [char](2) NOT NULL,
	[IMUMS4_unit_of_measure_sccpi4] [char](2) NOT NULL,
	[IMUMS5_unit_of_measure_sccpi5] [char](2) NOT NULL,
	[IMUMS6_unit_of_measure_sccpi6] [char](2) NOT NULL,
	[IMUMS7_unit_of_measure_sccpi7] [char](2) NOT NULL,
	[IMUMS8_unit_of_measure_sccpi8] [char](2) NOT NULL,
	[IMPILT_purchasing_internal_lead_time] [numeric](5, 0) NOT NULL,
	[IMWTRQ_item_weight_required_yn] [char](1) NOT NULL,
	[IMPOC__i] [char](1) NOT NULL,
	[IMEXPI_explode_item_10] [char](1) NOT NULL,
	[IMCONI_constraint_item_10] [char](1) NOT NULL,
	[IMORSP_allow_order_split_10] [char](1) NOT NULL,
	[IMCNSD_consolidation_days] [numeric](5, 0) NOT NULL,
	[IMCMDM_commitment_date_method] [char](1) NOT NULL,
	[IMLECM_exp_date_calc_method] [char](1) NOT NULL,
	[IMBBDD_best_before_default_days] [numeric](6, 0) NOT NULL,
	[IMSBDD_sell_by_default_days] [numeric](6, 0) NOT NULL,
	[IMLEDD_mfg_lot_effective_days] [numeric](6, 0) NOT NULL,
	[IMPEFD_purchasing_lot_effective_days] [numeric](6, 0) NOT NULL,
	[IMU1DD_user_lot_date_1_default_days] [numeric](6, 0) NOT NULL,
	[IMU2DD_user_lot_date_2_default_days] [numeric](6, 0) NOT NULL,
	[IMU3DD_user_lot_date_3_default_days] [numeric](6, 0) NOT NULL,
	[IMU4DD_user_lot_date_4_default_days] [numeric](6, 0) NOT NULL,
	[IMU5DD_user_lot_date_5_default_days] [numeric](6, 0) NOT NULL,
	[IMTORG_transaction_originator] [char](10) NOT NULL,
	[IMUSER_user_id] [char](10) NOT NULL,
	[IMPID__program_id] [char](10) NOT NULL,
	[IMJOBN_work_station_id] [char](10) NOT NULL,
	[IMUPMJ_date_updated] [date] NOT NULL,
	[IMTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [item_master_F4101_pk] PRIMARY KEY NONCLUSTERED 
(
	[IMITM__item_number_short] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

BEGIN TRANSACTION
GO
CREATE UNIQUE CLUSTERED INDEX item_master_F4101_u_idx_01 ON Pricing.item_master_F4101
	(
	IMLITM_item_number
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE Pricing.item_master_F4101 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


Alter Table [Integration].[F41061_supplier_catalog_price_file_Staging]
Add IdKey Int Identity(1, 1)
Go

CREATE UNIQUE NONCLUSTERED INDEX F41061_supplier_catalog_price_file_Staging_u_idx ON [Integration].[F41061_supplier_catalog_price_file_Staging]
	(
	IdKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

INSERT INTO Pricing.item_master_F4101
                         (IMITM__item_number_short, IMLITM_item_number, IMAITM__3rd_item_number, IMDSC1_description, IMDSC2_description_2, IMSRTX_search_text, 
                         IMALN__search_text_compressed, IMSRP1_major_product_class, IMSRP2_sub_major_product_class, IMSRP3_minor_product_class, 
                         IMSRP4_sub_minor_product_class, IMSRP5_hazardous_class, IMSRP6_manufacturer, IMSRP7_drug_class, IMSRP8_manuf_dspsearch, IMSRP9_category_code_9, 
                         IMSRP0_category_code_10, IMPRP1_commodity_class, IMPRP2_commodity_sub_class, IMPRP3_supplier_rebate_code, IMPRP4_tax_classification, 
                         IMPRP5_landed_cost_rule, IMPRP6_item_dimension_group, IMPRP7_warehouse_process_grp_1, IMPRP8_warehouse_process_grp_2, 
                         IMPRP9_warehouse_process_grp_3, IMPRP0_commodity_code, IMCDCD_commodity_code, IMPDGR_product_group, IMDSGP_dispatch_group, 
                         IMPRGR_item_price_group, IMRPRC_basket_reprice_group, IMORPR_order_reprice_group, IMBUYR_buyer_number, IMDRAW_drawing_number, 
                         IMRVNO_last_revision_no, IMDSZE_drawing_size, IMVCUD_volume_cubic_dimensions, IMCARS_carrier_number, IMCARP_preferred_carrier_purchasing, 
                         IMSHCN_shipping_conditions_code, IMSHCM_shipping_commodity_class, IMUOM1_unit_of_measure, IMUOM2_secondary_uom, IMUOM3_purchasing_uom, 
                         IMUOM4_pricing_uom, IMUOM6_shipping_uom, IMUOM8_production_uom, IMUOM9_component_uom, IMUWUM_unit_of_measure_weight, 
                         IMUVM1_unit_of_measure_volume, IMSUTM_stocking_um, IMUMVW_psauvolume_or_weight, IMCYCL_cycle_count_category, IMGLPT_gl_category, 
                         IMPLEV_sales_price_level, IMPPLV_purchase_price_level, IMCLEV_inventory_cost_level, IMPRPO_gradepotency_pricing, IMCKAV_check_availability_yn, 
                         IMBPFG_bulkpacked_flag, IMSRCE_layer_code_source, IMOT1Y_potency_control, IMOT2Y_grade_control, IMSTDP_standard_potency, IMFRMP_from_potency, 
                         IMTHRP_thru_potency, IMSTDG_standard_grade, IMFRGD_from_grade, IMTHGD_thru_grade, IMCOTY_component_type, IMSTKT_stocking_type, IMLNTY_line_type, 
                         IMCONT_contract_item, IMBACK_backorders_allowed_yn, IMIFLA_item_flash_message, IMTFLA_std_uom_conversion, IMINMG_print_message, 
                         IMABCS_abc_code_1_sales, IMABCM_abc_code_2_margin, IMABCI_abc_code_3_investment, IMOVR__abc_code_override_indicator, 
                         IMWARR_warranty_item_group, IMCMCG_commission_category, IMSRNR_serial_no_required, IMPMTH_kit_pricing_method, IMFIFO_fifo_processing, 
                         IMLOTS_lot_status_code, IMSLD__shelf_life_days, IMANPL_planner_number, IMMPST_planning_code, IMPCTM_percent_margin, 
                         IMMMPC_margin_maintenance_pct, IMPTSC_part_status_code, IMSNS__round_to_whole_number, IMLTLV_leadtime_level, IMLTMF_leadtime_manufacturing, 
                         IMLTCM_leadtime_cumulative, IMOPC__order_policy_code, IMOPV__value_order_policy, IMACQ__accounting_cost_quantity, IMMLQ__mfg_leadtime_quantity, 
                         IMLTPU_leadtime_per_unit, IMMPSP_planning_fence_rule, IMMRPP_fixedvariable_leadtime, IMITC__issue_type_code, IMORDW_order_with_yn, 
                         IMMTF1_planning_fence, IMMTF2_freeze_fence, IMMTF3_message_display_fence, IMMTF4_time_fence, IMMTF5_shipment_leadtime_offset, 
                         IMMTF6_supply_time_fence, IMEXPD_expedite_damper_days, IMDEFD_defer_damper_days, IMSFLT_safety_leadtime, IMMAKE_makebuy_code, 
                         IMCOBY_cobyproductintermediate, IMLLX__low_level_code, IMCMGL_commitment_method, IMCOMH_specific_commitment_days, 
                         IMCSNN_configured_string_id_next_number, IMURCD_user_reserved_code, IMURDT_user_reserved_date, IMURAT_user_reserved_amount, 
                         IMURAB_user_reserved_number, IMURRF_user_reserved_reference, IMAVRT_average_queue_hours, IMUPCN_upc_number, IMSCC0_aggregate_scc_code_pi0, 
                         IMUMUP_unit_of_measure_upc, IMUMDF_unit_of_measure_aggregate_upc, IMUMS0_unit_of_measure_sccpi0, IMUMS1_unit_of_measure_sccpi1, 
                         IMUMS2_unit_of_measure_sccpi2, IMUMS3_unit_of_measure_sccpi3, IMUMS4_unit_of_measure_sccpi4, IMUMS5_unit_of_measure_sccpi5, 
                         IMUMS6_unit_of_measure_sccpi6, IMUMS7_unit_of_measure_sccpi7, IMUMS8_unit_of_measure_sccpi8, IMPILT_purchasing_internal_lead_time, 
                         IMWTRQ_item_weight_required_yn, IMPOC__i, IMEXPI_explode_item_10, IMCONI_constraint_item_10, IMORSP_allow_order_split_10, 
                         IMCNSD_consolidation_days, IMCMDM_commitment_date_method, IMLECM_exp_date_calc_method, IMBBDD_best_before_default_days, 
                         IMSBDD_sell_by_default_days, IMLEDD_mfg_lot_effective_days, IMPEFD_purchasing_lot_effective_days, IMU1DD_user_lot_date_1_default_days, 
                         IMU2DD_user_lot_date_2_default_days, IMU3DD_user_lot_date_3_default_days, IMU4DD_user_lot_date_4_default_days, IMU5DD_user_lot_date_5_default_days, 
                         IMTORG_transaction_originator, IMUSER_user_id, IMPID__program_id, IMJOBN_work_station_id, IMUPMJ_date_updated, IMTDAY_time_of_day)
VALUES        (0,
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'1980-01-01',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'0',
'1980-01-01',
'0')

/****** Object:  Table [Integration].[F41061_supplier_catalog_price_file_Staging]    Script Date: 8/31/2017 10:53:38 AM ******/

CREATE TABLE [Pricing].[supplier_catalog_price_file_F41061](
	[CBMCU__business_unit] [char](12) NOT NULL,
	[CBAN8__billto] [int] NOT NULL,
	[CBITM__item_number_short] [numeric](8, 0) NOT NULL,
	[CBLITM_item_number] [char](10) NOT NULL,
	[CBAITM__3rd_item_number] [char](25) NOT NULL,
	[CBCATN_catalog] [char](8) NOT NULL,
	[CBDMCT_agreement_nbr] [char](12) NOT NULL,
	[CBDMCS_agreement_supplement] [numeric](3, 0) NOT NULL,
	[CBKCOO_order_company] [char](5) NOT NULL,
	[CBDOCO_salesorder_number] [numeric](8, 0) NOT NULL,
	[CBDCTO_order_type] [char](2) NOT NULL,
	[CBLNID_line_number] [numeric](15, 3) NOT NULL,
	[CBCRCD_currency_code] [char](3) NOT NULL,
	[CBUOM__um] [char](2) NOT NULL,
	[CBPRRC_unit_cost] [numeric](15, 4) NOT NULL,
	[CBUORG_quantity] [numeric](15, 0) NOT NULL,
	[CBEFTJ_effective_date] [date] NOT NULL,
	[CBEXDJ_expired_date] [date] NOT NULL,
	[CBUSER_user_id] [char](10) NOT NULL,
	[CBPID__program_id] [char](10) NOT NULL,
	[CBJOBN_work_station_id] [char](10) NOT NULL,
	[CBUPMJ_date_updated] [date] NOT NULL,
	[CBTDAY_time_of_day] [numeric](6, 0) NOT NULL
) ON [USERDATA]

GO

BEGIN TRANSACTION

ALTER TABLE Pricing.supplier_catalog_price_file_F41061 ADD CONSTRAINT
	supplier_catalog_price_file_F41061_c_pk PRIMARY KEY CLUSTERED 
	(
	CBMCU__business_unit,
	CBAN8__billto,
	CBITM__item_number_short,
	CBCATN_catalog,
	CBCRCD_currency_code,
	CBUOM__um,
	CBUORG_quantity,
	CBEXDJ_expired_date
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA


ALTER TABLE Pricing.supplier_catalog_price_file_F41061 SET (LOCK_ESCALATION = TABLE)

COMMIT


/****** Object:  Table [Integration].[F5613_product_extension_file_Staging]    Script Date: 8/31/2017 1:19:27 PM ******/

CREATE TABLE [Pricing].[item_extension_file_F5613](
	[QNITM__item_number_short] [numeric](8, 0) NOT NULL,
	[QNLITM_item_number] [char](10) NOT NULL,
	[QNAITM__3rd_item_number] [char](25) NOT NULL,
	[QN$FIN_force_item_notes] [char](1) NOT NULL,
	[QN$FRT_freightable_item] [char](1) NOT NULL,
	[QN$IVP_inventory_percentage] [numeric](15, 3) NOT NULL,
	[QN$CEM_ce_mark] [char](1) NOT NULL,
	[QN$CER_ce_mark_required] [char](1) NOT NULL,
	[QN$RPK_repack] [char](1) NOT NULL,
	[QN$SPC_supplier_code] [char](6) NOT NULL,
	[QN$SZE_size_packaged_units] [char](8) NOT NULL,
	[QN$STR_strength] [char](12) NOT NULL,
	[QN$MDC_multiple_drug_classes] [char](1) NOT NULL,
	[QN$STU_status] [char](1) NOT NULL,
	[QN$DS__drop_ship] [char](1) NOT NULL,
	[QN$IFP_inbound_frt_adj_pct] [numeric](5, 4) NOT NULL,
	[QN$IFD_inbound_frt_adj_amt] [numeric](15, 4) NOT NULL,
	[QN$SOM_sales_order_markup] [numeric](15, 4) NOT NULL,
	[QNLTDT_transit_days] [numeric](5, 0) NOT NULL,
	[QNINMG_print_message] [char](10) NOT NULL,
	[QNUSER_user_id] [char](10) NOT NULL,
	[QNPID__program_id] [char](10) NOT NULL,
	[QNJOBN_work_station_id] [char](10) NOT NULL,
	[QNUPMJ_date_updated] [date] NOT NULL,
	[QNTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [item_extension_file_F5613_pk] PRIMARY KEY CLUSTERED 
(
	[QNITM__item_number_short] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


/****** Object:  Table [Integration].[F40308_preference_profile_grade_and_potency_Staging]    Script Date: 9/1/2017 9:53:47 AM ******/

-- change grade from char(3) -> char(2) for promo match

CREATE TABLE [Pricing].[price_marketing_program_enroll_F40308](
	[GSAN8__billto] [int] NOT NULL,
	[GSCS08_customer_group_grade_and_potency] [char](8) NOT NULL,
	[GSITM__item_number_short] [numeric](8, 0) NOT NULL,
	[GSIT08_item_group_grade_and_potency] [char](8) NOT NULL,
	[GSEFTJ_effective_date] [date] NOT NULL,
	[GSEXDJ_expired_date] [date] NOT NULL,
	[GSMNQ__quantity_from] [numeric](15, 0) NOT NULL,
	[GSMXQ__quantity_thru] [numeric](15, 0) NOT NULL,
	[GSUOM__um] [char](2) NOT NULL,
	[GSTXID_text_id_number] [numeric](8, 0) NOT NULL,
	[GSSTPR_preference_status] [char](1) NOT NULL,
	[GSOSEQ_sequence_number] [int] NOT NULL,
	[GSFRGD_from_grade] [char](2) NOT NULL,
	[GSTHGD_thru_grade] [char](2) NOT NULL,
	[GSFRMP_from_potency] [numeric](15, 3) NOT NULL,
	[GSTHRP_thru_potency] [numeric](15, 3) NOT NULL,
	[GSEXDP_days_before_expiration] [numeric](5, 0) NOT NULL,
	[GSURCD_user_reserved_code] [char](2) NOT NULL,
	[GSURDT_user_reserved_date_JDT] [numeric](6, 0) NOT NULL,
	[GSURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[GSURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[GSURRF_user_reserved_reference] [char](15) NOT NULL,
	[GSUSER_user_id] [char](10) NOT NULL,
	[GSPID__program_id] [char](10) NOT NULL,
	[GSJOBN_work_station_id] [char](10) NOT NULL,
	[GSUPMJ_date_updated] [date] NOT NULL,
	[GSTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [price_marketing_program_enroll_F40308_pk] PRIMARY KEY CLUSTERED 
(
	[GSAN8__billto] ASC,
	[GSCS08_customer_group_grade_and_potency] ASC,
	[GSITM__item_number_short] ASC,
	[GSIT08_item_group_grade_and_potency] ASC,
	[GSEXDJ_expired_date] ASC,
	[GSMXQ__quantity_thru] ASC,
	[GSUOM__um] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

/****** Object:  Table [Integration].[F4073_free_goods_master_file_Staging]    Script Date: 9/1/2017 10:11:01 AM ******/

CREATE TABLE [Pricing].[free_goods_master_file_F4073](
	[FGAST__adjustment_name] [char](8) NOT NULL,
	[FGATID_price_adjustment_key_id] [numeric](8, 0) NOT NULL,
	[FGITMR_related_short_item_number] [numeric](8, 0) NOT NULL,
	[FGLITM_item_number] [char](10) NOT NULL,
	[FGAITM__3rd_item_number] [char](25) NOT NULL,
	[FGUORG_quantity] [numeric](15, 0) NOT NULL,
	[FGUOM__um] [char](2) NOT NULL,
	[FGRPRI_related_price] [numeric](15, 4) NOT NULL,
	[FGUNCS_unit_cost] [numeric](15, 4) NOT NULL,
	[FGGLC__gl_offset] [char](4) NOT NULL,
	[FGLNTY_line_type] [char](2) NOT NULL,
	[FGFQTY_quantity_per] [numeric](15, 2) NOT NULL,
	[FGFGTY_free_good_type] [char](1) NOT NULL,
	[FGFP01_free_good_process_code_01] [char](1) NOT NULL,
	[FGFP02_free_good_process_code_02] [char](1) NOT NULL,
	[FGFP03_free_good_process_code_03] [char](1) NOT NULL,
	[FGUSER_user_id] [char](10) NOT NULL,
	[FGPID__program_id] [char](10) NOT NULL,
	[FGJOBN_work_station_id] [char](10) NOT NULL,
	[FGUPMJ_date_updated] [date] NOT NULL,
	[FGTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [free_goods_master_file_F4073_pk] PRIMARY KEY CLUSTERED 
(
	[FGAST__adjustment_name] ASC,
	[FGATID_price_adjustment_key_id] ASC,
	[FGLITM_item_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO



-- add undefined entry

TRUNCATE TABLE [Pricing].[price_adjustment_name_F4071]

INSERT INTO [Pricing].[price_adjustment_name_F4071]
           ([ATAST__adjustment_name]
           ,[ATPRGR_item_price_group]
           ,[ATCPGP_customer_price_group]
           ,[ATSDGR_order_detail_group]
           ,[ATPRFR_preference_type]
           ,[ATLBT__level_break_type]
           ,[ATGLC__gl_offset]
           ,[ATSBIF_subledger_in_gl]
           ,[ATACNT_adjustment_control_code]
           ,[ATLNTY_line_type]
           ,[ATMDED_manual_addchange_yn]
           ,[ATABAS_override_price_yn]
           ,[ATOLVL_adjustment_level]
           ,[ATTXB__taxable_yn]
           ,[ATPA01_rebate_beneficiary]
           ,[ATPA02_mandatory_adjustment]
           ,[ATPA03_exclude_from_payment_discount]
           ,[ATPA04_target_application]
           ,[ATPA05_include_in_margin_calc]
           ,[ATPA06_final_price]
           ,[ATPA07_processing_type_free_good]
           ,[ATPA08_price_adjustment_code_08]
           ,[ATPA09_price_adjustment_code_09]
           ,[ATPA10_price_adjustment_code_10]
           ,[ATEFCN_excl_from_curr_net]
           ,[ATPTC__payment_terms]
           ,[ATURCD_user_reserved_code]
           ,[ATURDT_user_reserved_date_JDT]
           ,[ATURAT_user_reserved_amount]
           ,[ATURAB_user_reserved_number]
           ,[ATURRF_user_reserved_reference]
           ,[ATUSER_user_id]
           ,[ATPID__program_id]
		   ,[ATUPMJ_date_updated]
           ,[ATJOBN_work_station_id]
           ,[ATTDAY_time_of_day])
     VALUES
           (' '
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,0
           ,0
           ,0
           ,'.'
           ,'.'
           ,'.'
		   ,'1980-01-01'
           ,'.'
           ,0)

INSERT INTO [Pricing].[price_adjustment_name_F4071]
           ([ATAST__adjustment_name]
           ,[ATPRGR_item_price_group]
           ,[ATCPGP_customer_price_group]
           ,[ATSDGR_order_detail_group]
           ,[ATPRFR_preference_type]
           ,[ATLBT__level_break_type]
           ,[ATGLC__gl_offset]
           ,[ATSBIF_subledger_in_gl]
           ,[ATACNT_adjustment_control_code]
           ,[ATLNTY_line_type]
           ,[ATMDED_manual_addchange_yn]
           ,[ATABAS_override_price_yn]
           ,[ATOLVL_adjustment_level]
           ,[ATTXB__taxable_yn]
           ,[ATPA01_rebate_beneficiary]
           ,[ATPA02_mandatory_adjustment]
           ,[ATPA03_exclude_from_payment_discount]
           ,[ATPA04_target_application]
           ,[ATPA05_include_in_margin_calc]
           ,[ATPA06_final_price]
           ,[ATPA07_processing_type_free_good]
           ,[ATPA08_price_adjustment_code_08]
           ,[ATPA09_price_adjustment_code_09]
           ,[ATPA10_price_adjustment_code_10]
           ,[ATEFCN_excl_from_curr_net]
           ,[ATPTC__payment_terms]
           ,[ATURCD_user_reserved_code]
           ,[ATURDT_user_reserved_date_JDT]
           ,[ATURAT_user_reserved_amount]
           ,[ATURAB_user_reserved_number]
           ,[ATURRF_user_reserved_reference]
           ,[ATUSER_user_id]
           ,[ATPID__program_id]
		   ,[ATUPMJ_date_updated]
           ,[ATJOBN_work_station_id]
           ,[ATTDAY_time_of_day])
     VALUES
           ('MSRPPRC'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,0
           ,0
           ,0
           ,'.'
           ,'.'
           ,'.'
		   ,'1980-01-01'
           ,'.'
           ,0)

INSERT INTO [Pricing].[price_adjustment_name_F4071]
           ([ATAST__adjustment_name]
           ,[ATPRGR_item_price_group]
           ,[ATCPGP_customer_price_group]
           ,[ATSDGR_order_detail_group]
           ,[ATPRFR_preference_type]
           ,[ATLBT__level_break_type]
           ,[ATGLC__gl_offset]
           ,[ATSBIF_subledger_in_gl]
           ,[ATACNT_adjustment_control_code]
           ,[ATLNTY_line_type]
           ,[ATMDED_manual_addchange_yn]
           ,[ATABAS_override_price_yn]
           ,[ATOLVL_adjustment_level]
           ,[ATTXB__taxable_yn]
           ,[ATPA01_rebate_beneficiary]
           ,[ATPA02_mandatory_adjustment]
           ,[ATPA03_exclude_from_payment_discount]
           ,[ATPA04_target_application]
           ,[ATPA05_include_in_margin_calc]
           ,[ATPA06_final_price]
           ,[ATPA07_processing_type_free_good]
           ,[ATPA08_price_adjustment_code_08]
           ,[ATPA09_price_adjustment_code_09]
           ,[ATPA10_price_adjustment_code_10]
           ,[ATEFCN_excl_from_curr_net]
           ,[ATPTC__payment_terms]
           ,[ATURCD_user_reserved_code]
           ,[ATURDT_user_reserved_date_JDT]
           ,[ATURAT_user_reserved_amount]
           ,[ATURAB_user_reserved_number]
           ,[ATURRF_user_reserved_reference]
           ,[ATUSER_user_id]
           ,[ATPID__program_id]
		   ,[ATUPMJ_date_updated]
           ,[ATJOBN_work_station_id]
           ,[ATTDAY_time_of_day])
     VALUES
           ('DR10F3S2'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,'.'
           ,0
           ,0
           ,0
           ,'.'
           ,'.'
           ,'.'
		   ,'1980-01-01'
           ,'.'
           ,0)

GO

-- init tables 


INSERT INTO Pricing.price_adjustment_name_F4071
                         (ATAST__adjustment_name, ATPRGR_item_price_group, ATCPGP_customer_price_group, ATSDGR_order_detail_group, ATPRFR_preference_type, 
                         ATLBT__level_break_type, ATGLC__gl_offset, ATSBIF_subledger_in_gl, ATACNT_adjustment_control_code, ATLNTY_line_type, ATMDED_manual_addchange_yn, 
                         ATABAS_override_price_yn, ATOLVL_adjustment_level, ATTXB__taxable_yn, ATPA01_rebate_beneficiary, ATPA02_mandatory_adjustment, 
                         ATPA03_exclude_from_payment_discount, ATPA04_target_application, ATPA05_include_in_margin_calc, ATPA06_final_price, ATPA07_processing_type_free_good, 
                         ATPA08_price_adjustment_code_08, ATPA09_price_adjustment_code_09, ATPA10_price_adjustment_code_10, ATEFCN_excl_from_curr_net, 
                         ATPTC__payment_terms, ATURCD_user_reserved_code, ATURDT_user_reserved_date_JDT, ATURAT_user_reserved_amount, ATURAB_user_reserved_number, 
                         ATURRF_user_reserved_reference, ATUSER_user_id, ATPID__program_id, ATJOBN_work_station_id, ATUPMJ_date_updated, ATTDAY_time_of_day)
SELECT        ATAST__adjustment_name, ATPRGR_item_price_group, ATCPGP_customer_price_group, ATSDGR_order_detail_group, ATPRFR_preference_type, 
                         ATLBT__level_break_type, ATGLC__gl_offset, ATSBIF_subledger_in_gl, ATACNT_adjustment_control_code, ATLNTY_line_type, ATMDED_manual_addchange_yn, 
                         ATABAS_override_price_yn, ATOLVL_adjustment_level, ATTXB__taxable_yn, ATPA01_rebate_beneficiary, ATPA02_mandatory_adjustment, 
                         ATPA03_exclude_from_payment_discount, ATPA04_target_application, ATPA05_include_in_margin_calc, ATPA06_final_price, ATPA07_processing_type_free_good, 
                         ATPA08_price_adjustment_code_08, ATPA09_price_adjustment_code_09, ATPA10_price_adjustment_code_10, ATEFCN_excl_from_curr_net, 
                         ATPTC__payment_terms, ATURCD_user_reserved_code, ATURDT_user_reserved_date_JDT, ATURAT_user_reserved_amount, ATURAB_user_reserved_number, 
                         ATURRF_user_reserved_reference, ATUSER_user_id, ATPID__program_id, ATJOBN_work_station_id, ATUPMJ_date_updated, ATTDAY_time_of_day
FROM            Integration.F4071_price_adjustment_name_Staging



TRUNCATE TABLE Pricing.price_adjustment_enroll_F40314

INSERT INTO Pricing.price_adjustment_enroll_F40314
                         (PJAN8__billto, PJCS14_customer_group_price_adjustment_sched, PJITM__item_number_short, PJIT14_item_group_price_adjustment_schedule, 
                         PJEFTJ_effective_date, PJEXDJ_expired_date, PJMNQ__quantity_from, PJMXQ__quantity_thru, PJUOM__um, PJTXID_text_id_number, PJSTPR_preference_status, 
                         PJOSEQ_sequence_number, PJMCU__business_unit, PJASN__adjustment_schedule, PJURCD_user_reserved_code, PJURDT_user_reserved_date_JDT, 
                         PJURAT_user_reserved_amount, PJURAB_user_reserved_number, PJURRF_user_reserved_reference, PJUSER_user_id, PJPID__program_id, 
                         PJJOBN_work_station_id, PJUPMJ_date_updated, PJTDAY_time_of_day)
SELECT        PJAN8__billto, PJCS14_customer_group_price_adjustment_sched, PJITM__item_number_short, PJIT14_item_group_price_adjustment_schedule, 
                         PJEFTJ_effective_date, PJEXDJ_expired_date, PJMNQ__quantity_from, PJMXQ__quantity_thru, PJUOM__um, PJTXID_text_id_number, PJSTPR_preference_status, 
                         PJOSEQ_sequence_number, PJMCU__business_unit, PJASN__adjustment_schedule, PJURCD_user_reserved_code, PJURDT_user_reserved_date_JDT, 
                         PJURAT_user_reserved_amount, PJURAB_user_reserved_number, PJURRF_user_reserved_reference, PJUSER_user_id, PJPID__program_id, 
                         PJJOBN_work_station_id, PJUPMJ_date_updated, PJTDAY_time_of_day
FROM            Integration.F40314_preference_price_adjustment_schedule_Staging


-- TRUNCATE TABLE Pricing.price_adjustment_schedule_F4070

INSERT INTO Pricing.price_adjustment_schedule_F4070
                         (SNASN__adjustment_schedule, SNOSEQ_sequence_number, SNAST__adjustment_name, SNURCD_user_reserved_code, SNURDT_user_reserved_date_JDT, 
                         SNURAT_user_reserved_amount, SNURAB_user_reserved_number, SNURRF_user_reserved_reference, SNUSER_user_id, SNPID__program_id, 
                         SNJOBN_work_station_id, SNUPMJ_date_updated, SNTDAY_time_of_day)
SELECT        SNASN__adjustment_schedule, SNOSEQ_sequence_number, SNAST__adjustment_name, SNURCD_user_reserved_code, SNURDT_user_reserved_date_JDT, 
                         SNURAT_user_reserved_amount, SNURAB_user_reserved_number, SNURRF_user_reserved_reference, SNUSER_user_id, SNPID__program_id, 
                         SNJOBN_work_station_id, DATEADD (day , SNUPMJ_date_updated_JDT%1000-1, DATEADD(year, SNUPMJ_date_updated_JDT/1000, 0 ) ) AS SNUPMJ_date_updated, SNTDAY_time_of_day
FROM            Integration.F4070_price_adjustment_schedule_Staging
WHERE
EXISTS (SELECT * 
FROM [Pricing].[price_adjustment_name_F4071] b 
WHERE b.ATAST__adjustment_name = SNAST__adjustment_name
) AND
1=1


-- TRUNCATE TABLE Pricing.price_adjustment_detail_F4072

-- do not load bad shipto enrolled (fix at source)
INSERT INTO Pricing.price_adjustment_detail_F4072
(
	ADAST__adjustment_name,
	ADITM__item_number_short,
	ADLITM_item_number,
	ADAITM__3rd_item_number,
	ADAN8__billto,
	ADICID_itemcustomer_key_id,

	ADSDGR_order_detail_group,
	ADSDV1_sales_detail_value_01,
	ADSDV2_sales_detail_value_02,
	ADSDV3_sales_detail_value_03,
	ADCRCD_currency_code,

	ADUOM__um,
	ADMNQ__quantity_from,
	ADEFTJ_effective_date,
	ADEXDJ_expired_date,
	ADBSCD_basis,
	ADLEDG_cost_method,
	ADFRMN_formula_name,

	ADFCNM_function_name,
	ADFVTR_factor_value,
	ADFGY__free_goods_yn,
	ADATID_price_adjustment_key_id,
	ADURCD_user_reserved_code,

	ADURDT_user_reserved_date_JDT,
	ADURAT_user_reserved_amount,
	ADURAB_user_reserved_number,
	ADURRF_user_reserved_reference,

	ADASTN_adjustment_for_net_price,
	ADUSER_user_id,
	ADPID__program_id,
	ADJOBN_work_station_id,
	ADUPMJ_date_updated,
	ADTDAY_time_of_day,

	ADUPAJ_date_added,
	ADTENT_time_entered)

SELECT
	ADAST__adjustment_name,

--	im.IMITM__item_number_short,

	ADITM__item_number_short,
	LEFT(ADLITM_item_number,10) AS item_number,
	ADAITM__3rd_item_number,

	ADAN8__billto,
	ADICID_itemcustomer_key_id,

	ADSDGR_order_detail_group,
	ADSDV1_sales_detail_value_01,
	ADSDV2_sales_detail_value_02,
	ADSDV3_sales_detail_value_03,
	ADCRCD_currency_code,

	ADUOM__um,
	ADMNQ__quantity_from,
	ADEFTJ_effective_date,
	ADEXDJ_expired_date,
	ADBSCD_basis,
	ADLEDG_cost_method,
	ADFRMN_formula_name,

	ADFCNM_function_name,
	ADFVTR_factor_value,
	ADFGY__free_goods_yn,
	ADATID_price_adjustment_key_id,
	ADURCD_user_reserved_code,

	ADURDT_user_reserved_date_JDT,
	ADURAT_user_reserved_amount,
	ADURAB_user_reserved_number,
	ADURRF_user_reserved_reference,

	ADASTN_adjustment_for_net_price,
	ADUSER_user_id,
	ADPID__program_id,
	ADJOBN_work_station_id,
	DATEADD (day,ADUPMJ_date_updated_JDT%1000-1,DATEADD(year,ADUPMJ_date_updated_JDT/1000,
	0 ) ) AS ADUPMJ_date_updated,
	ADTDAY_time_of_day,
	DATEADD (day,ADUPAJ_date_added_JDT%1000-1,DATEADD(year,ADUPAJ_date_added_JDT/1000,0 ) ) AS ADUPAJ_date_added,
	ADTENT_time_entered

FROM
	Integration.F4072_price_adjustment_detail_Staging s


WHERE
	EXISTS (SELECT * FROM [dbo].[BRS_CustomerBT] b WHERE b.BillTo = s.[ADAN8__billto]) AND

-- test
--	ADITM__item_number_short <> im.IMITM__item_number_short AND
--	ISNULL(ADITM__item_number_short,0) =0 AND
--	ISNULL(im.IMITM__item_number_short,0)<>0 AND

	1=1

-- 705925 ORG

/*
SELECT        ADUPMJ_date_updated_JDT
	,DATEADD (day , ADUPMJ_date_updated_JDT%1000-1, DATEADD(year, ADUPMJ_date_updated_JDT/1000, 0 ) ) AS ADUPMJ_date_updated

FROM            Integration.F4072_price_adjustment_detail_Staging
*/

-- truncate table Pricing.item_customer_keyid_master_file_F4094

INSERT INTO Pricing.item_customer_keyid_master_file_F4094
                         (KIPRGR_item_price_group, KIIGP1_item_group_category_code_01, KIIGP2_item_group_category_code_02, KIIGP3_item_group_category_code_03, 
                         KIIGP4_item_group_category_code_04, KICPGP_customer_price_group, KICGP1_customer_group_category_code_01, KICGP2_customer_group_category_code_02, 
                         KICGP3_customer_group_category_code_03, KICGP4_customer_group_category_code_04, KIICID_itemcustomer_key_id)
SELECT        KIPRGR_item_price_group, KIIGP1_item_group_category_code_01, KIIGP2_item_group_category_code_02, KIIGP3_item_group_category_code_03, 
                         KIIGP4_item_group_category_code_04, KICPGP_customer_price_group, KICGP1_customer_group_category_code_01, KICGP2_customer_group_category_code_02, 
                         KICGP3_customer_group_category_code_03, KICGP4_customer_group_category_code_04, KIICID_itemcustomer_key_id
FROM            Integration.F4094_item_customer_keyid_master_file_Staging AS F4094_item_customer_keyid_master_file_Staging_1

-- truncate table Pricing.item_extension_file_F5613

INSERT INTO Pricing.item_extension_file_F5613
                         (QNITM__item_number_short, QNLITM_item_number, QNAITM__3rd_item_number, QN$FIN_force_item_notes, QN$FRT_freightable_item, 
                         QN$IVP_inventory_percentage, QN$CEM_ce_mark, QN$CER_ce_mark_required, QN$RPK_repack, QN$SPC_supplier_code, QN$SZE_size_packaged_units, 
                         QN$STR_strength, QN$MDC_multiple_drug_classes, QN$STU_status, QN$DS__drop_ship, QN$IFP_inbound_frt_adj_pct, QN$IFD_inbound_frt_adj_amt, 
                         QN$SOM_sales_order_markup, QNLTDT_transit_days, QNINMG_print_message, QNUSER_user_id, QNPID__program_id, QNJOBN_work_station_id, 
                         QNUPMJ_date_updated, QNTDAY_time_of_day)
SELECT        QNITM__item_number_short, LEFT(QNLITM_item_number,10), QNAITM__3rd_item_number, QN$FIN_force_item_notes, QN$FRT_freightable_item, 
                         QN$IVP_inventory_percentage, QN$CEM_ce_mark, QN$CER_ce_mark_required, QN$RPK_repack, QN$SPC_supplier_code, QN$SZE_size_packaged_units, 
                         QN$STR_strength, QN$MDC_multiple_drug_classes, QN$STU_status, QN$DS__drop_ship, QN$IFP_inbound_frt_adj_pct, QN$IFD_inbound_frt_adj_amt, 
                         QN$SOM_sales_order_markup, QNLTDT_transit_days, QNINMG_print_message, QNUSER_user_id, QNPID__program_id, QNJOBN_work_station_id, 
                         QNUPMJ_date_updated, QNTDAY_time_of_day
FROM            Integration.F5613_product_extension_file_Staging


-- Class Contract Map 1 of 3

truncate table Pricing.price_adjustment_enroll

INSERT INTO Pricing.price_adjustment_enroll
                         (BillTo, SNAST__adjustment_name, PJASN__adjustment_schedule, PJEFTJ_effective_date, PJEXDJ_expired_date, PJUPMJ_date_updated, PJUSER_user_id, 
                         EnrollSource, PriceMethod)
SELECT        
	pj.PJAN8__billto AS BillTo, 
	sn.SNAST__adjustment_name, 
	pj.PJASN__adjustment_schedule, 
	pj.PJEFTJ_effective_date, 
	pj.PJEXDJ_expired_date, 
	pj.PJUPMJ_date_updated, 
	pj.PJUSER_user_id, 
	'CLACTR' AS EnrollSource, 
	'C' AS PriceMethod
FROM            
	Pricing.price_adjustment_enroll_F40314 AS pj 

	INNER JOIN Pricing.price_adjustment_schedule_F4070 AS sn 
	ON pj.PJASN__adjustment_schedule = sn.SNASN__adjustment_schedule 

	INNER JOIN Pricing.price_adjustment_name_F4071 AS atn 
	ON sn.SNAST__adjustment_name = atn.ATAST__adjustment_name

	INNER JOIN [dbo].[BRS_CustomerBT] as bt
	ON pj.PJAN8__billto = bt.BillTo

WHERE        
	(atn.ATPRFR_preference_type = 'IG') AND 
	(atn.ATPRGR_item_price_group = '') AND 
	(atn.ATCPGP_customer_price_group = '') AND 
	(atn.ATSDGR_order_detail_group = '') AND 
	(atn.ATLBT__level_break_type = 1) AND 
	(1 = 1)

-- Contract Map 2 of 3
INSERT INTO Pricing.price_adjustment_enroll
                         (BillTo, SNAST__adjustment_name, PJASN__adjustment_schedule, PJEFTJ_effective_date, PJEXDJ_expired_date, PJUPMJ_date_updated, PJUSER_user_id, 
                         EnrollSource, PriceMethod)
SELECT 
	p.ADAN8__billto					AS BillTo
	,MIN(p.ADAST__adjustment_name)	AS ADAST__adjustment_name
	-- No Sales Plan for Special Pricing
	,''								AS PJASN__adjustment_schedule
	,MIN(p.ADEFTJ_effective_date)	AS PJEFTJ_effective_date
	,MAX(p.ADEXDJ_expired_date)		AS PJEXDJ_expired_date
	,MAX(p.ADUPMJ_date_updated)		AS PJUPMJ_date_updated
	,MAX(p.ADUSER_user_id)			AS PJUSER_user_id
	,'CUSCONTR'						AS EnrollSource
	,'C'							AS PriceMethod

FROM            
	[Pricing].[price_adjustment_detail_F4072]  p

	INNER JOIN [Pricing].price_adjustment_name_F4071 n
	ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

	INNER JOIN [dbo].[BRS_CustomerBT] as bt
	ON p.ADAN8__billto = bt.BillTo

WHERE
	n.ATPRFR_preference_type IN ('C') AND
	p.ADAST__adjustment_name = 'CUSCONTR' AND
	ADAN8__billto > 0 AND
	p.ADBSCD_basis = 5 AND
	p.ADMNQ__quantity_from = 1 AND

	-- remove reference were class contract to avoid double counting. bad data 
	NOT EXISTS (SELECT * 
				FROM [Pricing].[price_adjustment_enroll] b 
				WHERE b.BillTo = p.[ADAN8__billto]
				) AND
	(1=1)
GROUP BY
	p.ADAN8__billto


-- Special Pricing Map 3 of 3
INSERT INTO Pricing.price_adjustment_enroll
                         (BillTo, SNAST__adjustment_name, PJASN__adjustment_schedule, PJEFTJ_effective_date, PJEXDJ_expired_date, PJUPMJ_date_updated, PJUSER_user_id, 
                         EnrollSource, PriceMethod)
SELECT 
	p.ADAN8__billto					AS BillTo
	,MIN(p.ADAST__adjustment_name)	AS ADAST__adjustment_name
	-- No Sales Plan for Special Pricing
	,''								AS PJASN__adjustment_schedule
	,MIN(p.ADEFTJ_effective_date)	AS PJEFTJ_effective_date
	,MAX(p.ADEXDJ_expired_date)		AS PJEXDJ_expired_date
	,MAX(p.ADUPMJ_date_updated)		AS PJUPMJ_date_updated
	,MAX(p.ADUSER_user_id)			AS PJUSER_user_id
	,'SPLPRICE'						AS EnrollSource
	,'S'							AS PriceMethod

FROM            
	[Pricing].[price_adjustment_detail_F4072]  p

	INNER JOIN [Pricing].price_adjustment_name_F4071 n
	ON p.ADAST__adjustment_name = n.ATAST__adjustment_name

	INNER JOIN [dbo].[BRS_CustomerBT] as bt
	ON p.ADAN8__billto = bt.BillTo

WHERE
	n.ATPRFR_preference_type IN ('C') AND
	p.ADAST__adjustment_name = 'SPLPRICE' AND
	ADAN8__billto > 0 AND
	p.ADBSCD_basis = 5 AND
	p.ADMNQ__quantity_from = 1 AND

	-- remove reference were class contract to avoid double counting. bad data 
	NOT EXISTS (SELECT * 
				FROM [Pricing].[price_adjustment_enroll] b 
				WHERE b.BillTo = p.[ADAN8__billto]
				) AND
	(1=1)
GROUP BY
	p.ADAN8__billto

truncate table Pricing.item_master_F4101
	
INSERT INTO Pricing.item_master_F4101
(IMITM__item_number_short, IMLITM_item_number, IMAITM__3rd_item_number, IMDSC1_description, IMDSC2_description_2, IMSRTX_search_text, 
                         IMALN__search_text_compressed, IMSRP1_major_product_class, IMSRP2_sub_major_product_class, IMSRP3_minor_product_class, 
                         IMSRP4_sub_minor_product_class, IMSRP5_hazardous_class, IMSRP6_manufacturer, IMSRP7_drug_class, IMSRP8_manuf_dspsearch, IMSRP9_category_code_9, 
                         IMSRP0_category_code_10, IMPRP1_commodity_class, IMPRP2_commodity_sub_class, IMPRP3_supplier_rebate_code, IMPRP4_tax_classification, 
                         IMPRP5_landed_cost_rule, IMPRP6_item_dimension_group, IMPRP7_warehouse_process_grp_1, IMPRP8_warehouse_process_grp_2, 
                         IMPRP9_warehouse_process_grp_3, IMPRP0_commodity_code, IMCDCD_commodity_code, IMPDGR_product_group, IMDSGP_dispatch_group, 
                         IMPRGR_item_price_group, IMRPRC_basket_reprice_group, IMORPR_order_reprice_group, IMBUYR_buyer_number, IMDRAW_drawing_number, 
                         IMRVNO_last_revision_no, IMDSZE_drawing_size, IMVCUD_volume_cubic_dimensions, IMCARS_carrier_number, IMCARP_preferred_carrier_purchasing, 
                         IMSHCN_shipping_conditions_code, IMSHCM_shipping_commodity_class, IMUOM1_unit_of_measure, IMUOM2_secondary_uom, IMUOM3_purchasing_uom, 
                         IMUOM4_pricing_uom, IMUOM6_shipping_uom, IMUOM8_production_uom, IMUOM9_component_uom, IMUWUM_unit_of_measure_weight, 
                         IMUVM1_unit_of_measure_volume, IMSUTM_stocking_um, IMUMVW_psauvolume_or_weight, IMCYCL_cycle_count_category, IMGLPT_gl_category, 
                         IMPLEV_sales_price_level, IMPPLV_purchase_price_level, IMCLEV_inventory_cost_level, IMPRPO_gradepotency_pricing, IMCKAV_check_availability_yn, 
                         IMBPFG_bulkpacked_flag, IMSRCE_layer_code_source, IMOT1Y_potency_control, IMOT2Y_grade_control, IMSTDP_standard_potency, IMFRMP_from_potency, 
                         IMTHRP_thru_potency, IMSTDG_standard_grade, IMFRGD_from_grade, IMTHGD_thru_grade, IMCOTY_component_type, IMSTKT_stocking_type, IMLNTY_line_type, 
                         IMCONT_contract_item, IMBACK_backorders_allowed_yn, IMIFLA_item_flash_message, IMTFLA_std_uom_conversion, IMINMG_print_message, 
                         IMABCS_abc_code_1_sales, IMABCM_abc_code_2_margin, IMABCI_abc_code_3_investment, IMOVR__abc_code_override_indicator, 
                         IMWARR_warranty_item_group, IMCMCG_commission_category, IMSRNR_serial_no_required, IMPMTH_kit_pricing_method, IMFIFO_fifo_processing, 
                         IMLOTS_lot_status_code, IMSLD__shelf_life_days, IMANPL_planner_number, IMMPST_planning_code, IMPCTM_percent_margin, 
                         IMMMPC_margin_maintenance_pct, IMPTSC_part_status_code, IMSNS__round_to_whole_number, IMLTLV_leadtime_level, IMLTMF_leadtime_manufacturing, 
                         IMLTCM_leadtime_cumulative, IMOPC__order_policy_code, IMOPV__value_order_policy, IMACQ__accounting_cost_quantity, IMMLQ__mfg_leadtime_quantity, 
                         IMLTPU_leadtime_per_unit, IMMPSP_planning_fence_rule, IMMRPP_fixedvariable_leadtime, IMITC__issue_type_code, IMORDW_order_with_yn, 
                         IMMTF1_planning_fence, IMMTF2_freeze_fence, IMMTF3_message_display_fence, IMMTF4_time_fence, IMMTF5_shipment_leadtime_offset, 
                         IMMTF6_supply_time_fence, IMEXPD_expedite_damper_days, IMDEFD_defer_damper_days, IMSFLT_safety_leadtime, IMMAKE_makebuy_code, 
                         IMCOBY_cobyproductintermediate, IMLLX__low_level_code, IMCMGL_commitment_method, IMCOMH_specific_commitment_days, 
                         IMCSNN_configured_string_id_next_number, IMURCD_user_reserved_code, IMURDT_user_reserved_date, IMURAT_user_reserved_amount, 
                         IMURAB_user_reserved_number, IMURRF_user_reserved_reference, IMAVRT_average_queue_hours, IMUPCN_upc_number, IMSCC0_aggregate_scc_code_pi0, 
                         IMUMUP_unit_of_measure_upc, IMUMDF_unit_of_measure_aggregate_upc, IMUMS0_unit_of_measure_sccpi0, IMUMS1_unit_of_measure_sccpi1, 
                         IMUMS2_unit_of_measure_sccpi2, IMUMS3_unit_of_measure_sccpi3, IMUMS4_unit_of_measure_sccpi4, IMUMS5_unit_of_measure_sccpi5, 
                         IMUMS6_unit_of_measure_sccpi6, IMUMS7_unit_of_measure_sccpi7, IMUMS8_unit_of_measure_sccpi8, IMPILT_purchasing_internal_lead_time, 
                         IMWTRQ_item_weight_required_yn, IMPOC__i, IMEXPI_explode_item_10, IMCONI_constraint_item_10, IMORSP_allow_order_split_10, 
                         IMCNSD_consolidation_days, IMCMDM_commitment_date_method, IMLECM_exp_date_calc_method, IMBBDD_best_before_default_days, 
                         IMSBDD_sell_by_default_days, IMLEDD_mfg_lot_effective_days, IMPEFD_purchasing_lot_effective_days, IMU1DD_user_lot_date_1_default_days, 
                         IMU2DD_user_lot_date_2_default_days, IMU3DD_user_lot_date_3_default_days, IMU4DD_user_lot_date_4_default_days, IMU5DD_user_lot_date_5_default_days, 
                         IMTORG_transaction_originator, IMUSER_user_id, IMPID__program_id, IMJOBN_work_station_id, IMUPMJ_date_updated, IMTDAY_time_of_day
)
SELECT        
IMITM__item_number_short, LEFT(IMLITM_item_number,10), IMAITM__3rd_item_number, IMDSC1_description, IMDSC2_description_2, IMSRTX_search_text, 
                         IMALN__search_text_compressed, IMSRP1_major_product_class, IMSRP2_sub_major_product_class, IMSRP3_minor_product_class, 
                         IMSRP4_sub_minor_product_class, IMSRP5_hazardous_class, IMSRP6_manufacturer, IMSRP7_drug_class, IMSRP8_manuf_dspsearch, IMSRP9_category_code_9, 
                         IMSRP0_category_code_10, IMPRP1_commodity_class, IMPRP2_commodity_sub_class, IMPRP3_supplier_rebate_code, IMPRP4_tax_classification, 
                         IMPRP5_landed_cost_rule, IMPRP6_item_dimension_group, IMPRP7_warehouse_process_grp_1, IMPRP8_warehouse_process_grp_2, 
                         IMPRP9_warehouse_process_grp_3, IMPRP0_commodity_code, IMCDCD_commodity_code, IMPDGR_product_group, IMDSGP_dispatch_group, 
                         IMPRGR_item_price_group, IMRPRC_basket_reprice_group, IMORPR_order_reprice_group, IMBUYR_buyer_number, IMDRAW_drawing_number, 
                         IMRVNO_last_revision_no, IMDSZE_drawing_size, IMVCUD_volume_cubic_dimensions, IMCARS_carrier_number, IMCARP_preferred_carrier_purchasing, 
                         IMSHCN_shipping_conditions_code, IMSHCM_shipping_commodity_class, IMUOM1_unit_of_measure, IMUOM2_secondary_uom, IMUOM3_purchasing_uom, 
                         IMUOM4_pricing_uom, IMUOM6_shipping_uom, IMUOM8_production_uom, IMUOM9_component_uom, IMUWUM_unit_of_measure_weight, 
                         IMUVM1_unit_of_measure_volume, IMSUTM_stocking_um, IMUMVW_psauvolume_or_weight, IMCYCL_cycle_count_category, IMGLPT_gl_category, 
                         IMPLEV_sales_price_level, IMPPLV_purchase_price_level, IMCLEV_inventory_cost_level, IMPRPO_gradepotency_pricing, IMCKAV_check_availability_yn, 
                         IMBPFG_bulkpacked_flag, IMSRCE_layer_code_source, IMOT1Y_potency_control, IMOT2Y_grade_control, IMSTDP_standard_potency, IMFRMP_from_potency, 
                         IMTHRP_thru_potency, IMSTDG_standard_grade, IMFRGD_from_grade, IMTHGD_thru_grade, IMCOTY_component_type, IMSTKT_stocking_type, IMLNTY_line_type, 
                         IMCONT_contract_item, IMBACK_backorders_allowed_yn, IMIFLA_item_flash_message, IMTFLA_std_uom_conversion, IMINMG_print_message, 
                         IMABCS_abc_code_1_sales, IMABCM_abc_code_2_margin, IMABCI_abc_code_3_investment, IMOVR__abc_code_override_indicator, 
                         IMWARR_warranty_item_group, IMCMCG_commission_category, IMSRNR_serial_no_required, IMPMTH_kit_pricing_method, IMFIFO_fifo_processing, 
                         IMLOTS_lot_status_code, IMSLD__shelf_life_days, IMANPL_planner_number, IMMPST_planning_code, IMPCTM_percent_margin, 
                         IMMMPC_margin_maintenance_pct, IMPTSC_part_status_code, IMSNS__round_to_whole_number, IMLTLV_leadtime_level, IMLTMF_leadtime_manufacturing, 
                         IMLTCM_leadtime_cumulative, IMOPC__order_policy_code, IMOPV__value_order_policy, IMACQ__accounting_cost_quantity, IMMLQ__mfg_leadtime_quantity, 
                         IMLTPU_leadtime_per_unit, IMMPSP_planning_fence_rule, IMMRPP_fixedvariable_leadtime, IMITC__issue_type_code, IMORDW_order_with_yn, 
                         IMMTF1_planning_fence, IMMTF2_freeze_fence, IMMTF3_message_display_fence, IMMTF4_time_fence, IMMTF5_shipment_leadtime_offset, 
                         IMMTF6_supply_time_fence, IMEXPD_expedite_damper_days, IMDEFD_defer_damper_days, IMSFLT_safety_leadtime, IMMAKE_makebuy_code, 
                         IMCOBY_cobyproductintermediate, IMLLX__low_level_code, IMCMGL_commitment_method, IMCOMH_specific_commitment_days, 
                         IMCSNN_configured_string_id_next_number, IMURCD_user_reserved_code, IMURDT_user_reserved_date, IMURAT_user_reserved_amount, 
                         IMURAB_user_reserved_number, IMURRF_user_reserved_reference, IMAVRT_average_queue_hours, IMUPCN_upc_number, IMSCC0_aggregate_scc_code_pi0, 
                         IMUMUP_unit_of_measure_upc, IMUMDF_unit_of_measure_aggregate_upc, IMUMS0_unit_of_measure_sccpi0, IMUMS1_unit_of_measure_sccpi1, 
                         IMUMS2_unit_of_measure_sccpi2, IMUMS3_unit_of_measure_sccpi3, IMUMS4_unit_of_measure_sccpi4, IMUMS5_unit_of_measure_sccpi5, 
                         IMUMS6_unit_of_measure_sccpi6, IMUMS7_unit_of_measure_sccpi7, IMUMS8_unit_of_measure_sccpi8, IMPILT_purchasing_internal_lead_time, 
                         IMWTRQ_item_weight_required_yn, IMPOC__i, IMEXPI_explode_item_10, IMCONI_constraint_item_10, IMORSP_allow_order_split_10, 
                         IMCNSD_consolidation_days, IMCMDM_commitment_date_method, IMLECM_exp_date_calc_method, IMBBDD_best_before_default_days, 
                         IMSBDD_sell_by_default_days, IMLEDD_mfg_lot_effective_days, IMPEFD_purchasing_lot_effective_days, IMU1DD_user_lot_date_1_default_days, 
                         IMU2DD_user_lot_date_2_default_days, IMU3DD_user_lot_date_3_default_days, IMU4DD_user_lot_date_4_default_days, IMU5DD_user_lot_date_5_default_days, 
                         IMTORG_transaction_originator, IMUSER_user_id, IMPID__program_id, IMJOBN_work_station_id, IMUPMJ_date_updated, IMTDAY_time_of_day
FROM            Integration.F4101_item_master_Staging AS F4101_item_master_Staging_1


truncate table Pricing.supplier_catalog_price_file_F41061

-- de-dup
INSERT INTO Pricing.supplier_catalog_price_file_F41061
                         (CBMCU__business_unit, CBAN8__billto, CBITM__item_number_short, CBLITM_item_number, CBAITM__3rd_item_number, CBCATN_catalog, 
                         CBDMCT_agreement_nbr, CBDMCS_agreement_supplement, CBKCOO_order_company, CBDOCO_salesorder_number, CBDCTO_order_type, CBLNID_line_number, 
                         CBCRCD_currency_code, CBUOM__um, CBPRRC_unit_cost, CBUORG_quantity, CBEFTJ_effective_date, CBEXDJ_expired_date, CBUSER_user_id, 
                         CBPID__program_id, CBJOBN_work_station_id, CBUPMJ_date_updated, CBTDAY_time_of_day)

SELECT        CBMCU__business_unit, CBAN8__billto, CBITM__item_number_short, LEFT(CBLITM_item_number,10), CBAITM__3rd_item_number, CBCATN_catalog, 
                         CBDMCT_agreement_nbr, CBDMCS_agreement_supplement, CBKCOO_order_company, CBDOCO_salesorder_number, CBDCTO_order_type, CBLNID_line_number, 
                         CBCRCD_currency_code, CBUOM__um, CBPRRC_unit_cost, CBUORG_quantity, CBEFTJ_effective_date, CBEXDJ_expired_date, CBUSER_user_id, 
                         CBPID__program_id, CBJOBN_work_station_id, CBUPMJ_date_updated, CBTDAY_time_of_day
FROM            Integration.F41061_supplier_catalog_price_file_Staging AS s
WHERE EXISTS 
(
SELECT        MAX(s2.IdKey) AS id_unique
FROM            Integration.F41061_supplier_catalog_price_file_Staging s2
GROUP BY CBMCU__business_unit, CBAN8__billto, CBITM__item_number_short, CBCATN_catalog, CBCRCD_currency_code, CBUOM__um, CBUORG_quantity, 
                         CBEXDJ_expired_date
HAVING s.[IdKey] = MAX(s2.IdKey)
) 



-- truncate table Pricing.price_marketing_program_enroll_F40308

INSERT INTO Pricing.price_marketing_program_enroll_F40308
                         (GSAN8__billto, GSCS08_customer_group_grade_and_potency, GSITM__item_number_short, GSIT08_item_group_grade_and_potency, GSEFTJ_effective_date, 
                         GSEXDJ_expired_date, GSMNQ__quantity_from, GSMXQ__quantity_thru, GSUOM__um, GSTXID_text_id_number, GSSTPR_preference_status, 
                         GSOSEQ_sequence_number, GSFRGD_from_grade, GSTHGD_thru_grade, GSFRMP_from_potency, GSTHRP_thru_potency, GSEXDP_days_before_expiration, 
                         GSURCD_user_reserved_code, GSURDT_user_reserved_date_JDT, GSURAT_user_reserved_amount, GSURAB_user_reserved_number, 
                         GSURRF_user_reserved_reference, GSUSER_user_id, GSPID__program_id, GSJOBN_work_station_id,GSUPMJ_date_updated, GSTDAY_time_of_day)
SELECT        GSAN8__billto, GSCS08_customer_group_grade_and_potency, GSITM__item_number_short, GSIT08_item_group_grade_and_potency, DATEADD (day , GSEFTJ_effective_date_JDT%1000-1, DATEADD(year, GSEFTJ_effective_date_JDT/1000, 0 ) ) AS GSEFTJ_effective_date, 
                         GSEXDJ_expired_date, GSMNQ__quantity_from, GSMXQ__quantity_thru, GSUOM__um, GSTXID_text_id_number, GSSTPR_preference_status, 
                         GSOSEQ_sequence_number, GSFRGD_from_grade, GSTHGD_thru_grade, GSFRMP_from_potency, GSTHRP_thru_potency, GSEXDP_days_before_expiration, 
                         GSURCD_user_reserved_code, GSURDT_user_reserved_date_JDT, GSURAT_user_reserved_amount, GSURAB_user_reserved_number, 
                         GSURRF_user_reserved_reference, GSUSER_user_id, GSPID__program_id, GSJOBN_work_station_id, DATEADD (day , GSUPMJ_date_updated_JDT%1000-1, DATEADD(year, GSUPMJ_date_updated_JDT/1000, 0 ) ) AS GSUPMJ_date_updated, GSTDAY_time_of_day
FROM            Integration.F40308_preference_profile_grade_and_potency_Staging AS F40308_preference_profile_grade_and_potency_Staging_1
WHERE
EXISTS (SELECT * 
FROM [dbo].[BRS_CustomerBT] b 
WHERE b.BillTo = [GSAN8__billto]
) AND
1=1


truncate table Pricing.free_goods_master_file_F4073

INSERT INTO Pricing.free_goods_master_file_F4073
                         (FGAST__adjustment_name, FGATID_price_adjustment_key_id, FGITMR_related_short_item_number, FGLITM_item_number, FGAITM__3rd_item_number, 
                         FGUORG_quantity, FGUOM__um, FGRPRI_related_price, FGUNCS_unit_cost, FGGLC__gl_offset, FGLNTY_line_type, FGFQTY_quantity_per, 
                         FGFGTY_free_good_type, FGFP01_free_good_process_code_01, FGFP02_free_good_process_code_02, FGFP03_free_good_process_code_03, FGUSER_user_id, 
                         FGPID__program_id, FGJOBN_work_station_id,FGUPMJ_date_updated, FGTDAY_time_of_day)
SELECT        FGAST__adjustment_name, FGATID_price_adjustment_key_id, FGITMR_related_short_item_number, LEFT(FGLITM_item_number,10), FGAITM__3rd_item_number, 
                         FGUORG_quantity, FGUOM__um, FGRPRI_related_price, FGUNCS_unit_cost, FGGLC__gl_offset, FGLNTY_line_type, FGFQTY_quantity_per, 
                         FGFGTY_free_good_type, FGFP01_free_good_process_code_01, FGFP02_free_good_process_code_02, FGFP03_free_good_process_code_03, FGUSER_user_id, 
                         FGPID__program_id, FGJOBN_work_station_id, DATEADD (day , FGUPMJ_date_updated_JDT%1000-1, DATEADD(year, FGUPMJ_date_updated_JDT/1000, 0 ) ) AS FGUPMJ_date_updated, FGTDAY_time_of_day
FROM            Integration.F4073_free_goods_master_file_Staging

INSERT INTO BRS_CustomerVPA
(VPA)
SELECT        distinct (SNASN__adjustment_schedule)
FROM            Integration.F4070_price_adjustment_schedule_Staging s
WHERE
	NOT EXISTS(SELECT * FROM [dbo].[BRS_CustomerVPA] WHERE [VPA]=S.SNASN__adjustment_schedule)

-- Add Relationships <here>

-- free_goods_master_file_F4073
BEGIN TRANSACTION

ALTER TABLE Pricing.free_goods_master_file_F4073 ADD CONSTRAINT
	FK_free_goods_master_file_F4073_price_adjustment_name_F4071 FOREIGN KEY
	(
	FGAST__adjustment_name
	) REFERENCES Pricing.price_adjustment_name_F4071
	(
	ATAST__adjustment_name
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
/*
ALTER TABLE Pricing.free_goods_master_file_F4073 ADD CONSTRAINT
	FK_free_goods_master_file_F4073_price_adjustment_detail_F4072 FOREIGN KEY
	(
	FGATID_price_adjustment_key_id
	) REFERENCES Pricing.price_adjustment_detail_F4072
	(
	ADATID_price_adjustment_key_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
*/

ALTER TABLE Pricing.free_goods_master_file_F4073 ADD CONSTRAINT
	FK_free_goods_master_file_F4073_item_master_F4101 FOREIGN KEY
	(
	FGLITM_item_number
	) REFERENCES Pricing.item_master_F4101
	(
	IMLITM_item_number
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.free_goods_master_file_F4073 SET (LOCK_ESCALATION = TABLE)

COMMIT


-- item_customer_keyid_master_file_F4094
-- n/a

-- item_extension_file_F5613

BEGIN TRANSACTION

ALTER TABLE Pricing.item_extension_file_F5613 ADD CONSTRAINT
	FK_item_extension_file_F5613_item_master_F4101 FOREIGN KEY
	(
	QNITM__item_number_short
	) REFERENCES Pricing.item_master_F4101
	(
	IMITM__item_number_short
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
ALTER TABLE Pricing.item_extension_file_F5613 ADD CONSTRAINT
	FK_item_extension_file_F5613_item_master_F41011 FOREIGN KEY
	(
	QNLITM_item_number
	) REFERENCES Pricing.item_master_F4101
	(
	IMLITM_item_number
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
	

ALTER TABLE Pricing.item_extension_file_F5613 SET (LOCK_ESCALATION = TABLE)

COMMIT



-- item_master_F4101
-- n/a

-- price_adjustment_detail_F4072

BEGIN TRANSACTION

ALTER TABLE Pricing.price_adjustment_detail_F4072 ADD CONSTRAINT
	FK_price_adjustment_detail_F4072_price_adjustment_name_F4071 FOREIGN KEY
	(
	ADAST__adjustment_name
	) REFERENCES Pricing.price_adjustment_name_F4071
	(
	ATAST__adjustment_name
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	


ALTER TABLE Pricing.price_adjustment_detail_F4072 ADD CONSTRAINT
	FK_price_adjustment_detail_F4072_item_master_F4101 FOREIGN KEY
	(
	ADITM__item_number_short
	) REFERENCES Pricing.item_master_F4101
	(
	IMITM__item_number_short
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 

	 --- XXX ---
/*
SELECT        ADATID_price_adjustment_key_id, ADAST__adjustment_name, ADITM__item_number_short
FROM            Pricing.price_adjustment_detail_F4072
where not exists (select * from Pricing.item_master_F4101 i where i.IMITM__item_number_short = ADITM__item_number_short)
*/	

ALTER TABLE Pricing.price_adjustment_detail_F4072 ADD CONSTRAINT
	FK_price_adjustment_detail_F4072_BRS_CustomerBT FOREIGN KEY
	(
	ADAN8__billto
	) REFERENCES dbo.BRS_CustomerBT
	(
	BillTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_adjustment_detail_F4072 SET (LOCK_ESCALATION = TABLE)

COMMIT

-- price_adjustment_enroll

BEGIN TRANSACTION
ALTER TABLE Pricing.price_adjustment_enroll ADD CONSTRAINT
	FK_price_adjustment_enroll_BRS_CustomerBT1 FOREIGN KEY
	(
	BillTo
	) REFERENCES dbo.BRS_CustomerBT
	(
	BillTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_adjustment_enroll ADD CONSTRAINT
	FK_price_adjustment_enroll_BRS_CustomerVPA FOREIGN KEY
	(
	PJASN__adjustment_schedule
	) REFERENCES dbo.BRS_CustomerVPA
	(
	VPA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_adjustment_enroll ADD CONSTRAINT
	FK_price_adjustment_enroll_price_adjustment_name_F4071 FOREIGN KEY
	(
	SNAST__adjustment_name
	) REFERENCES Pricing.price_adjustment_name_F4071
	(
	ATAST__adjustment_name
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 

ALTER TABLE Pricing.price_adjustment_enroll ADD CONSTRAINT
	FK_price_adjustment_enroll_BRS_PriceMethod FOREIGN KEY
	(
	PriceMethod
	) REFERENCES dbo.BRS_PriceMethod
	(
	PriceMethod
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 

ALTER TABLE Pricing.price_adjustment_enroll SET (LOCK_ESCALATION = TABLE)

COMMIT


-- price_adjustment_enroll_F40314
BEGIN TRANSACTION

	

ALTER TABLE Pricing.price_adjustment_enroll_F40314 ADD CONSTRAINT
	FK_price_adjustment_enroll_F40314_item_master_F4101 FOREIGN KEY
	(
	PJITM__item_number_short
	) REFERENCES Pricing.item_master_F4101
	(
	IMITM__item_number_short
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_adjustment_enroll_F40314 ADD CONSTRAINT
	FK_price_adjustment_enroll_F40314_BRS_CustomerVPA FOREIGN KEY
	(
	PJASN__adjustment_schedule
	) REFERENCES dbo.BRS_CustomerVPA
	(
	VPA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_adjustment_enroll_F40314 SET (LOCK_ESCALATION = TABLE)

COMMIT


-- price_adjustment_name_F4071
-- n/a

-- price_adjustment_schedule_F4070
BEGIN TRANSACTION

ALTER TABLE Pricing.price_adjustment_schedule_F4070 ADD CONSTRAINT
	FK_price_adjustment_schedule_F4070_BRS_CustomerVPA FOREIGN KEY
	(
	SNASN__adjustment_schedule
	) REFERENCES dbo.BRS_CustomerVPA
	(
	VPA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_adjustment_schedule_F4070 ADD CONSTRAINT
	FK_price_adjustment_schedule_F4070_price_adjustment_name_F4071 FOREIGN KEY
	(
	SNAST__adjustment_name
	) REFERENCES Pricing.price_adjustment_name_F4071
	(
	ATAST__adjustment_name
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_adjustment_schedule_F4070 SET (LOCK_ESCALATION = TABLE)

COMMIT


-- price_marketing_program_enroll_F40308

BEGIN TRANSACTION

ALTER TABLE Pricing.price_marketing_program_enroll_F40308 ADD CONSTRAINT
	FK_price_marketing_program_enroll_F40308_BRS_CustomerBT FOREIGN KEY
	(
	GSAN8__billto
	) REFERENCES dbo.BRS_CustomerBT
	(
	BillTo
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_marketing_program_enroll_F40308 ADD CONSTRAINT
	FK_price_marketing_program_enroll_F40308_item_master_F4101 FOREIGN KEY
	(
	GSITM__item_number_short
	) REFERENCES Pricing.item_master_F4101
	(
	IMITM__item_number_short
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
ALTER TABLE Pricing.price_marketing_program_enroll_F40308 ADD CONSTRAINT
	FK_price_marketing_program_enroll_F40308_BRS_Promotion FOREIGN KEY
	(
	GSTHGD_thru_grade
	) REFERENCES dbo.BRS_Promotion
	(
	PromotionCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.price_marketing_program_enroll_F40308 SET (LOCK_ESCALATION = TABLE)

COMMIT


-- supplier_catalog_price_file_F41061

BEGIN TRANSACTION


ALTER TABLE Pricing.supplier_catalog_price_file_F41061 ADD CONSTRAINT
	FK_supplier_catalog_price_file_F41061_item_master_F4101 FOREIGN KEY
	(
	CBITM__item_number_short
	) REFERENCES Pricing.item_master_F4101
	(
	IMITM__item_number_short
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	

ALTER TABLE Pricing.supplier_catalog_price_file_F41061 SET (LOCK_ESCALATION = TABLE)

COMMIT

