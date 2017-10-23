

/****** Object:  Table [etl].[F4070_price_adjustment_schedule]    Script Date: 6/13/2017 5:30:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Integration].[F4070_price_adjustment_schedule_Staging](
	[SNASN__adjustment_schedule] [char](8) NOT NULL,
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
	[SNUPMJ_date_updated_JDT] [numeric](6, 0) NOT NULL,
	[SNTDAY_time_of_day] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_F4070_price_adjustment_schedule] PRIMARY KEY CLUSTERED 
(
	[SNASN__adjustment_schedule] ASC,
	[SNOSEQ_sequence_number] ASC,
	[SNAST__adjustment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


