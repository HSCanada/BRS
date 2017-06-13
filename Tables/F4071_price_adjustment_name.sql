USE [BRSales]
GO

/****** Object:  Table [etl].[F4071_price_adjustment_name]    Script Date: 6/13/2017 5:30:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[F4071_price_adjustment_name](
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
	[ATUPMJ_date_updated] [date] NULL,
	[ATTDAY_time_of_day] [numeric](6, 0) NOT NULL,
	[AdjustmentNameKey] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_F4071_price_adjustment_name] PRIMARY KEY CLUSTERED 
(
	[ATAST__adjustment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Index [F4071_price_adjustment_name_u_idx]    Script Date: 6/13/2017 5:30:56 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [F4071_price_adjustment_name_u_idx] ON [etl].[F4071_price_adjustment_name]
(
	[AdjustmentNameKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


