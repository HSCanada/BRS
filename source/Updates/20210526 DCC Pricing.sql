-- DCC Pricing, tmc, 26 May 21

USE [DEV_BRSales]
GO

/****** Object:  Table [Pricing].[item_price_dcc]    Script Date: 2021/05/26 5:44:40 PM ******/

-- drop table [Pricing].[item_price_dcc]
CREATE TABLE [Pricing].[item_price_dcc](
	[Item] [char](10) NOT NULL,
	[CurrentPrice] [money] NOT NULL,
	[UnitChargeback] [money] NOT NULL Default(0),
	[note_txt] [varchar](10) NULL,
 CONSTRAINT [item_price_dcc_c_pk] PRIMARY KEY CLUSTERED 
(
	[Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

ALTER TABLE [Pricing].[item_price_dcc]  WITH CHECK ADD  CONSTRAINT [FK_item_price_dcc_BRS_Item] FOREIGN KEY([Item])
REFERENCES [dbo].[BRS_Item] ([Item])
GO

ALTER TABLE [Pricing].[item_price_dcc] CHECK CONSTRAINT [FK_item_price_dcc_BRS_Item]
GO

-- populate table, ETL

-- drop table Integration.stage_dcc_price

-- truncate table [Pricing].[item_price_dcc]
--
-- append from integration -> pricing table
INSERT INTO [Pricing].[item_price_dcc]
([Item],[CurrentPrice],[UnitChargeback], [note_txt] )
SELECT        item, Price, cb, note
FROM            Integration.stage_dcc_price
GO
