

/****** Object:  Table [etl].[adjustment_name_primary_customer]    Script Date: 6/13/2017 5:28:24 PM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Integration].[adjustment_name_primary_customer_Staging](
	[adjustment_name] [varchar](8) NOT NULL,
	[ShipToPrimary] [int] NOT NULL,
	[Est12MoTotal] [money] NOT NULL,
 CONSTRAINT [PK_adjustment_name_primary_customer] PRIMARY KEY CLUSTERED 
(
	[adjustment_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [USERDATA]

GO


