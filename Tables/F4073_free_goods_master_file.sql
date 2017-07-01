

/****** Object:  Table [etl].[F4073_free_goods_master_file]    Script Date: 6/13/2017 5:36:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Integration].[F4073_free_goods_master_file_Staging](
	[FGAST__adjustment_name] [char](8) NOT NULL,
	[FGATID_price_adjustment_key_id] [numeric](8, 0) NOT NULL,
	[FGITMR_related_short_item_number] [numeric](8, 0) NOT NULL,
	[FGLITM_item_number] [char](25) NOT NULL,
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
	[FGUPMJ_date_updated_JDT] [numeric](6, 0) NOT NULL,
	[FGTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_F4073_free_goods_master_file] PRIMARY KEY CLUSTERED 
(
	[FGAST__adjustment_name] ASC,
	[FGATID_price_adjustment_key_id] ASC,
	[FGLITM_item_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


