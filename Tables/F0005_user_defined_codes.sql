USE [BRSales]
GO

/****** Object:  Table [etl].[F0005_user_defined_codes]    Script Date: 6/13/2017 5:29:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[F0005_user_defined_codes](
	[DRSY___product_code] [char](4) NOT NULL,
	[DRRT___user_defined_codes] [char](2) NOT NULL,
	[DRKY___user_defined_code] [char](10) NOT NULL,
	[DRDL01_description] [char](30) NOT NULL,
	[DRDL02_description_02] [char](30) NOT NULL,
	[DRSPHD_special_handling_code] [char](10) NOT NULL,
	[DRUDCO_active_flag_yn] [char](1) NOT NULL,
	[DRHRDC_hard_coded_yn] [char](1) NOT NULL,
	[DRUSER_user_id] [char](10) NOT NULL,
	[DRPID__program_id] [char](10) NOT NULL,
	[DRUPMJ_date_updated] [date] NULL,
	[DRJOBN_work_station_id] [char](10) NOT NULL,
	[DRUPMT_time_last_updated] [numeric](6, 0) NOT NULL,
 CONSTRAINT [PK_F0005_user_defined_codes] PRIMARY KEY CLUSTERED 
(
	[DRSY___product_code] ASC,
	[DRRT___user_defined_codes] ASC,
	[DRKY___user_defined_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


