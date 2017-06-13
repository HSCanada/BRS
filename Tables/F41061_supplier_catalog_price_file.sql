USE [BRSales]
GO

/****** Object:  Table [etl].[F41061_supplier_catalog_price_file]    Script Date: 6/13/2017 5:39:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[F41061_supplier_catalog_price_file](
	[CBMCU__business_unit] [char](12) NOT NULL,
	[CBAN8__billto] [numeric](8, 0) NOT NULL,
	[CBITM__item_number_short] [numeric](8, 0) NOT NULL,
	[CBLITM_item_number] [char](25) NOT NULL,
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
	[CBUPMJ_date_updated] [date] NULL,
	[CBTDAY_time_of_day] [numeric](6, 0) NOT NULL
) ON [PRIMARY]

GO


