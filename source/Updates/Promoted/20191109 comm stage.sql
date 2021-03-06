-- drop table [Integration].[F555115_commission_sales_extract_Staging]

CREATE TABLE [Integration].[F555115_commission_sales_extract_Staging](
	[WSCO___company] [char](5) NULL,
	[WSDOCO_salesorder_number] [numeric](8, 0) NOT NULL,
	[WSDCTO_order_type] [char](2) NOT NULL,
	[WSLNTY_line_type] [char](2)  NULL,
	[WSLNID_line_number] [numeric](15, 3) NOT NULL,
	[WS$OSC_order_source_code] [char](1) NULL,
	[WSAN8__billto] [numeric](8, 0) NULL,
	[WSSHAN_shipto] [numeric](8, 0) NULL,
	[WSDGL__gl_date] [date] NULL,
	[WSLITM_item_number] [char](25) NULL,
	[WSDSC1_description] [char](30) NULL,
	[WSDSC2_description_2] [char](30) NULL,
	[WSSRP1_major_product_class] [char](3) NULL,
	[WSSRP2_sub_major_product_class] [char](3) NULL,
	[WSSRP3_minor_product_class] [char](3) NULL,
	[WSSRP6_manufacturer] [char](6) NULL,
	[WSUORG_quantity] [numeric](15, 0) NULL,
	[WSSOQS_quantity_shipped] [numeric](15, 0) NULL,
	[WSAEXP_extended_price] [numeric](15, 2) NULL,
	[WSURAT_user_reserved_amount] [numeric](15, 2) NULL,
	[WS$UNC_sales_order_cost_markup] [numeric](15, 4) NULL,
	[WSOORN_original_order_number] [char](8) NULL,
	[WSOCTO_original_order_type] [char](2) NULL,
	[WSOGNO_original_line_number] [numeric](15, 3) NULL,
	[WSTRDJ_order_date] [date] NULL,
	[WSVR01_reference] [char](25) NULL,
	[WSVR02_reference_2] [char](25) NULL,
	[WSITM__item_number_short] [numeric](8, 0) NULL,
	[WSPROV_price_override_code] [char](1) NULL,
	[WSASN__adjustment_schedule] [char](8) NULL,
	[WSKCO__document_company] [char](5) NULL,
	[WSDOC__document_number] [numeric](8, 0) NULL,
	[WSDCT__document_type] [char](2) NULL,
	[WSPSN__pick_slip_number] [numeric](8, 0) NULL,
	[WSROUT_ship_method] [char](3) NULL,
	[WSZON__zone_number] [char](3) NULL,
	[WSFRTH_freight_handling_code] [char](3) NULL,
	[WSFRAT_rate_code_freightmisc] [char](10) NULL,
	[WSRATT_rate_type_freightmisc] [char](1) NULL,
	[WSGLC__gl_offset] [char](4) NULL,
	[WSSO08_price_adjustment_line_indicator] [char](1) NULL,
	[WSENTB_entered_by] [char](10) NULL,
	[WS$PMC_promotion_code_price_method] [char](2) NULL,
	[WSTKBY_order_taken_by] [char](10) NULL,
	[WSKTLN_kit_master_line_number] [numeric](15, 3) NULL,
	[WSCOMM_committed_hs] [char](1) NULL,
	[WSEMCU_header_business_unit] [char](12) NULL,
	[WS$SPC_supplier_code] [char](6) NULL,
	[WS$VCD_vendor_code] [char](6) NULL,
	[WS$CLC_classification_code] [char](3) NULL,
	[WSCYCL_cycle_count_category] [char](3) NULL,
	[WSORD__equipment_order] [char](15) NULL,
	[WSORDT_order_type] [char](2) NULL,
	[WSCAG__cagess_code] [char](10) NULL,
	[WSEST__employment_status] [char](10) NULL,
	[WS$ESS_equipment_specialist_code] [char](10) NULL,
	[WS$TSS_tech_specialist_code] [char](10) NULL,
	[WS$CCS_cadcam_specialist_code] [char](10) NULL,
	[WS$NM1__name_1] [char](30) NULL,
	[WS$NM3_researched_by] [char](30) NULL,
	[WS$NM4_completed_by] [char](30) NULL,
	[WS$NM5__name_5] [char](30) NULL,
	[WS$L01_level_code_01] [char](5) NULL,
	[WSSRP4_sub_minor_product_class] [char](3) NULL,
	[WSCITM_customersupplier_item_number] [char](25) NULL,
	[WSSIC__speciality] [char](10) NULL,
	[WSAC04_practice_type] [char](3) NULL,
	[WSAC10_division_code] [char](3) NULL,
	[WS$O01_number_equipment_serial_01] [char](30) NULL,
	[WS$O02_number_equipment_serial_02] [char](30) NULL,
	[WS$O03_number_equipment_serial_03] [char](30) NULL,
	[WS$O04_number_equipment_serial_04] [char](30) NULL,
	[WS$O05_number_equipment_serial_05] [char](30) NULL,
	[WS$O06_number_equipment_serial_06] [char](30) NULL,
	[WSDL03_description_03] [numeric](6, 0) NULL,
	[WS$ODS_order_discount_amount] [numeric](15, 2) NULL,
	[source_cd] [char](3) NULL,
 CONSTRAINT [F555115_commission_sales_extract_Staging2_c_pk] PRIMARY KEY CLUSTERED 
(
	[WSDOCO_salesorder_number] ASC,
	[WSDCTO_order_type] ASC,
	[WSLNID_line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

-- speed up fsc comm calc

BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_14 ON comm.transaction_F555115
	(
	WS$L01_level_code_01
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
