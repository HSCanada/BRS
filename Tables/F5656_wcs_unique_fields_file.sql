USE [BRSales]
GO

/****** Object:  Table [etl].[F5656_wcs_unique_fields_file]    Script Date: 6/13/2017 5:40:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[F5656_wcs_unique_fields_file](
	[QVITM__item_number_short] [numeric](8, 0) NOT NULL,
	[QVLITM_item_number] [char](25) NOT NULL,
	[QVAITM__3rd_item_number] [char](25) NOT NULL,
	[QV$AVC_availability_code] [char](1) NOT NULL,
	[QV$RQT_restricted_qty] [numeric](5, 0) NOT NULL,
	[QV$CCD_case_code] [char](1) NOT NULL,
	[QV$CCQ_case_qty] [numeric](5, 0) NOT NULL,
	[QV$ITH_item_height] [numeric](15, 1) NOT NULL,
	[QV$ITW_item_width] [numeric](15, 1) NOT NULL,
	[QV$ITL_item_length] [numeric](15, 1) NOT NULL,
	[QV$IDC_importdomestic] [char](1) NOT NULL,
	[QV$CLC_classification_code] [char](3) NOT NULL,
	[QV$PRI_pricing_info] [char](20) NOT NULL,
	[QV$MMC_mix_match_code] [char](1) NOT NULL,
	[QV$VCD_vendor_code] [char](6) NOT NULL,
	[QV$LCT_location_type] [char](2) NOT NULL,
	[QV$PPL_print_on_pickticket] [char](1) NOT NULL,
	[QV$BKD_backorder_date_JDT] [numeric](6, 0) NOT NULL,
	[QV$ABD_abbr_descr] [char](25) NOT NULL,
	[QV$ASR_abbreviated_strength] [char](7) NOT NULL,
	[QVUSER_user_id] [char](10) NOT NULL,
	[QVPID__program_id] [char](10) NOT NULL,
	[QVJOBN_work_station_id] [char](10) NOT NULL,
	[QVUPMJ_date_updated] [date] NULL,
	[QVTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_F5656_wcs_unique_fields_file] PRIMARY KEY CLUSTERED 
(
	[QVITM__item_number_short] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


