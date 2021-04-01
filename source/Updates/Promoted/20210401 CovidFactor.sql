-- CovidFactor, tmc, 1 Apr 21

CREATE TABLE [dbo].[BRS_FiscalYearFactor](
	[YearFactor] [int] NOT NULL,
	[Note] [nchar](30) NOT NULL,
 CONSTRAINT [BRS_FiscalYearFactor_c_pk] PRIMARY KEY CLUSTERED 
(
	[YearFactor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--
INSERT INTO [dbo].[BRS_FiscalYearFactor]
VALUES(1, '12 month (standard)'),
(2, '24 month (covid)')

