

/****** Object:  Table [etl].[F0150_address_organization_master_file]    Script Date: 6/13/2017 8:20:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Integration].[F0150_address_organization_master_file_Staging](
	[MAOSTP_structure_type] [char](3) NOT NULL,
	[MAPA8__parent_number] [numeric](8, 0) NOT NULL,
	[MAAN8__billto] [numeric](8, 0) NOT NULL,
	[MADSS7_display_sequence] [numeric](7, 2) NOT NULL,
	[MABEFD_beginning_effective_date_JDT] [numeric](6, 0) NOT NULL,
	[MAEEFD_ending_effective_date_JDT] [numeric](6, 0) NOT NULL,
	[MARMK__remark] [char](30) NOT NULL,
	[MAUSER_user_id] [char](10) NOT NULL,
	[MAUPMJ_date_updated] [date] NULL,
	[MAPID__program_id] [char](10) NOT NULL,
	[MAJOBN_work_station_id] [char](10) NOT NULL,
	[MAUPMT_time_last_updated] [numeric](6, 0) NOT NULL,
 CONSTRAINT [F0150_address_organization_master_file_c_pk] PRIMARY KEY CLUSTERED 
(
	[MAOSTP_structure_type] ASC,
	[MAPA8__parent_number] ASC,
	[MAAN8__billto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


