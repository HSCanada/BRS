USE [BRSales]
GO

/****** Object:  Table [etl].[F5613_product_extension_file]    Script Date: 6/13/2017 5:40:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[F5613_product_extension_file](
	[QNITM__item_number_short] [numeric](8, 0) NOT NULL,
	[QNLITM_item_number] [char](25) NOT NULL,
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
	[QNUPMJ_date_updated] [date] NULL,
	[QNTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_F5613_product_extension_file] PRIMARY KEY CLUSTERED 
(
	[QNITM__item_number_short] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


