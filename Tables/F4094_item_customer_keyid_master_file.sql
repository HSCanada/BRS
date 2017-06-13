USE [BRSales]
GO

/****** Object:  Table [etl].[F4094_item_customer_keyid_master_file]    Script Date: 6/13/2017 5:39:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[F4094_item_customer_keyid_master_file](
	[KIPRGR_item_price_group] [char](8) NOT NULL,
	[KIIGP1_item_group_category_code_01] [char](6) NOT NULL,
	[KIIGP2_item_group_category_code_02] [char](6) NOT NULL,
	[KIIGP3_item_group_category_code_03] [char](6) NOT NULL,
	[KIIGP4_item_group_category_code_04] [char](6) NOT NULL,
	[KICPGP_customer_price_group] [char](8) NOT NULL,
	[KICGP1_customer_group_category_code_01] [char](3) NOT NULL,
	[KICGP2_customer_group_category_code_02] [char](3) NOT NULL,
	[KICGP3_customer_group_category_code_03] [char](3) NOT NULL,
	[KICGP4_customer_group_category_code_04] [char](3) NOT NULL,
	[KIICID_itemcustomer_key_id] [numeric](8, 0) NOT NULL,
 CONSTRAINT [PK_F4094_item_customer_keyid_master_file] PRIMARY KEY CLUSTERED 
(
	[KIPRGR_item_price_group] ASC,
	[KIIGP1_item_group_category_code_01] ASC,
	[KIIGP2_item_group_category_code_02] ASC,
	[KIIGP3_item_group_category_code_03] ASC,
	[KIIGP4_item_group_category_code_04] ASC,
	[KICPGP_customer_price_group] ASC,
	[KICGP1_customer_group_category_code_01] ASC,
	[KICGP2_customer_group_category_code_02] ASC,
	[KICGP3_customer_group_category_code_03] ASC,
	[KICGP4_customer_group_category_code_04] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Index [F4094_item_customer_keyid_master_file_u_idx]    Script Date: 6/13/2017 5:39:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [F4094_item_customer_keyid_master_file_u_idx] ON [etl].[F4094_item_customer_keyid_master_file]
(
	[KIICID_itemcustomer_key_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


