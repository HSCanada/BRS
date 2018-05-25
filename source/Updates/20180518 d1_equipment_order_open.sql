-- D1 Equipment order open 
-- 18 May 18, tmc

CREATE SCHEMA [nes] AUTHORIZATION [dbo]
GO

-- DROP TABLE [Integration].[open_order_opordrpt]

CREATE TABLE [Integration].[open_order_opordrpt](
	[est_num] [char](6) NOT NULL,
	[line_number] [int] NOT NULL,
	[d1_branch] [char](4) NULL,
	[order_status] [char](2) NULL,
	[work_order_num] [char](10) NULL,
	[work_order_date] [date] NULL,
	[shipto] [int] NULL,
	[practice_name] [varchar](40) NULL,
	[install_date] [date] NULL,
	[item_status] [char](10) NULL,
	[item] [char](10) NULL,
	[item_description] [varchar](40) NULL,
	[supplier] [char](6) NULL,
	[order_qty] [int] NULL,
	[received_qty] [int] NULL,
	[received_date] [date] NULL,
	[net_sales_amount] [money] NULL,
	[extended_cost_amount] [money] NULL,
	[ess_code] [char](5) NULL,
	[dts_code] [char](5) NULL,
	[cps_code] [char](5) NULL,
	[fsc_code] [char](5) NULL,
 CONSTRAINT [open_order_opordrpt_pk] PRIMARY KEY NONCLUSTERED 
(
	[est_num] ASC,
	[line_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

