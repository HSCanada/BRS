USE [BRSales]
GO

/****** Object:  Table [etl].[F40314_preference_price_adjustment_schedule]    Script Date: 6/13/2017 5:30:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[F40314_preference_price_adjustment_schedule](
	[PJAN8__billto] [numeric](8, 0) NOT NULL,
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
	[PJASN__adjustment_schedule] [char](8) NOT NULL,
	[PJURCD_user_reserved_code] [char](2) NOT NULL,
	[PJURDT_user_reserved_date_JDT] [numeric](6, 0) NOT NULL,
	[PJURAT_user_reserved_amount] [numeric](15, 2) NOT NULL,
	[PJURAB_user_reserved_number] [numeric](8, 0) NOT NULL,
	[PJURRF_user_reserved_reference] [char](15) NOT NULL,
	[PJUSER_user_id] [char](10) NOT NULL,
	[PJPID__program_id] [char](10) NOT NULL,
	[PJJOBN_work_station_id] [char](10) NOT NULL,
	[PJUPMJ_date_updated] [date] NULL,
	[PJTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_F40314_preference_price_adjustment_schedule] PRIMARY KEY CLUSTERED 
(
	[PJAN8__billto] ASC,
	[PJCS14_customer_group_price_adjustment_sched] ASC,
	[PJITM__item_number_short] ASC,
	[PJIT14_item_group_price_adjustment_schedule] ASC,
	[PJEXDJ_expired_date] ASC,
	[PJMXQ__quantity_thru] ASC,
	[PJUOM__um] ASC,
	[PJOSEQ_sequence_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


