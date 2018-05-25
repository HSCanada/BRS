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

--

-- DROP TABLE [Integration].[open_order_prorepr]

CREATE TABLE [Integration].[open_order_prorepr](
	[work_order_num] [char](10) NOT NULL,
	[d1_branch] [char](4) NULL,
	[rma_code] [char](5) NULL,
	[order_status] [char](2) NULL,
	[proj_arr_date] [date] NULL,
	[proj_comp_date] [date] NULL,
	[arrival_date] [date] NULL,
	[shipto] [int] NULL,
	[practice_name] [varchar](40) NULL,
	[priv_code] [char](5) NULL,
	[model_number] [varchar](20) NULL,
	[est_num] [char](6) NOT NULL,
	[call_type_code] [char](5) NULL,
	[problem_code] [char](5) NULL,
	[problem_descr] [varchar](20) NULL,
	[cause_code] [char](5) NULL,
	[cause_descr] [varchar](20) NULL,
	[d1_user_id] [char](10) NULL,

 CONSTRAINT [open_order_prorepr_pk] PRIMARY KEY NONCLUSTERED 
(
	[work_order_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO

--

-- DROP TABLE [Integration].[inventory_valuation_whvalrpt]

CREATE TABLE [Integration].[inventory_valuation_whvalrpt](
	[item] [char](10) NULL,
	[d1_warehouse] [char](10) NULL,
	[tag_number] [varchar](20) NULL,
	[supplier] [char](6) NULL,
	[model_number] [varchar](20) NULL,
	[item_description] [varchar](40) NULL,
	[bin_code] [char](10) NULL,
	[item_class_code] [char](10) NULL,
	[available_qty] [int] NULL,
	[allocation_qty] [int] NULL,
	[reserved_qty] [int] NULL,
	[total_qty] [int] NULL,
	[cost_unit] [char](2) NULL,
	[tag_or_avg_cost] [money] NULL,
	[tag_cost_ind] [char](1) NULL,
	[available_extended_value] [money] NULL,
	[reserved_extended_value] [money] NULL,
	[reservation_quantity_list] [varchar](25) NULL,
	[total_extended_value] [money] NULL,
	[IdKey] [integer] identity(1,1) NOT NULL

 CONSTRAINT [inventory_valuation_whvalrpt_pk] PRIMARY KEY NONCLUSTERED 
(
	[IdKey]  ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO
