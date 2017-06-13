USE [BRSales]
GO

/****** Object:  Table [etl].[F40308_preference_profile_grade_and_potency]    Script Date: 6/13/2017 5:29:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[F40308_preference_profile_grade_and_potency](
	[GSAN8__billto] [numeric](8, 0) NOT NULL,
	[GSCS08_customer_group_grade_and_potency] [char](8) NOT NULL,
	[GSITM__item_number_short] [numeric](8, 0) NOT NULL,
	[GSIT08_item_group_grade_and_potency] [char](8) NOT NULL,
	[GSEFTJ_effective_date_JDT] [numeric](6, 0) NOT NULL,
	[GSEXDJ_expired_date] [date] NOT NULL,
	[GSMNQ__quantity_from] [numeric](15, 0) NOT NULL,
	[GSMXQ__quantity_thru] [numeric](15, 0) NOT NULL,
	[GSUOM__um] [char](2) NOT NULL,
	[GSTXID_text_id_number] [numeric](8, 0) NOT NULL,
	[GSSTPR_preference_status] [char](1) NOT NULL,
	[GSOSEQ_sequence_number] [int] NOT NULL,
	[GSFRGD_from_grade] [char](3) NOT NULL,
	[GSTHGD_thru_grade] [char](3) NOT NULL,
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
	[GSUPMJ_date_updated_JDT] [numeric](6, 0) NOT NULL,
	[GSTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_F40308_preference_profile_grade_and_potency] PRIMARY KEY CLUSTERED 
(
	[GSAN8__billto] ASC,
	[GSCS08_customer_group_grade_and_potency] ASC,
	[GSITM__item_number_short] ASC,
	[GSIT08_item_group_grade_and_potency] ASC,
	[GSEXDJ_expired_date] ASC,
	[GSMXQ__quantity_thru] ASC,
	[GSUOM__um] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


