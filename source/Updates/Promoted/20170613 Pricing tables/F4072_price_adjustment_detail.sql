

/****** Object:  Table [etl].[F4072_price_adjustment_detail]    Script Date: 6/13/2017 5:31:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Integration].[F4072_price_adjustment_detail_Staging](
	[ADAST__adjustment_name] [char](8) NOT NULL,
	[ADITM__item_number_short] [numeric](8, 0) NOT NULL,
	[ADLITM_item_number] [char](25) NOT NULL,
	[ADAITM__3rd_item_number] [char](25) NOT NULL,
	[ADAN8__billto] [numeric](8, 0) NOT NULL,
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
	[ADATID_price_adjustment_key_id] [numeric](8, 0) NOT NULL,
	[ADURCD_user_reserved_code] [char](2) NOT NULL,
	[ADURDT_user_reserved_date_JDT] [numeric](6, 0) NOT NULL,
	[ADURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[ADURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[ADURRF_user_reserved_reference] [char](15) NOT NULL,
	[ADASTN_adjustment_for_net_price] [char](8) NOT NULL,
	[ADUSER_user_id] [char](10) NOT NULL,
	[ADPID__program_id] [char](10) NOT NULL,
	[ADJOBN_work_station_id] [char](10) NOT NULL,
	[ADUPMJ_date_updated_JDT] [numeric](6, 0) NOT NULL,
	[ADTDAY_time_of_day] [numeric](6, 0) NOT NULL,
	[ADUPAJ_date_added_JDT] [numeric](6, 0) NOT NULL,
	[ADTENT_time_entered] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_F4072_price_adjustment_detail] PRIMARY KEY CLUSTERED 
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
	[ADUPMJ_date_updated_JDT] ASC,
	[ADTDAY_time_of_day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

SET ANSI_PADDING ON

GO

/****** Object:  Index [F4072_price_adjustment_detail_idx_01]    Script Date: 6/13/2017 5:31:13 PM ******/
CREATE NONCLUSTERED INDEX [F4072_price_adjustment_detail_idx_01] ON [Integration].[F4072_price_adjustment_detail_Staging]
(
	[ADLITM_item_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

/****** Object:  Index [F4072_price_adjustment_detail_idx_02]    Script Date: 6/13/2017 5:31:13 PM ******/
CREATE NONCLUSTERED INDEX [F4072_price_adjustment_detail_idx_02] ON [Integration].[F4072_price_adjustment_detail_Staging]
(
	[ADAN8__billto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO

/****** Object:  Index [F4072_price_adjustment_detail_idx_03]    Script Date: 6/13/2017 5:31:13 PM ******/
CREATE NONCLUSTERED INDEX [F4072_price_adjustment_detail_idx_03] ON [Integration].[F4072_price_adjustment_detail_Staging]
(
	[ADICID_itemcustomer_key_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
GO


