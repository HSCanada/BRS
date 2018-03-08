-- create gps support tables, tmc, 2 Mar 18

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Transaction ADD
	GpsKey int NULL
GO
ALTER TABLE dbo.BRS_Transaction SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


CREATE TABLE [hfm].[gps_code](
	[GpsCode] [nchar](30) NOT NULL,
	[GpsDescr] [nvarchar](50) NOT NULL,
	[GpsRuleName] [nvarchar](100) NOT NULL,
	[GpsKey] [int] IDENTITY(1,1) NOT NULL,
	[Note] [nvarchar](100) NULL,
 CONSTRAINT [gps_code_c_pk] PRIMARY KEY CLUSTERED 
(
	[GpsCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA],
 CONSTRAINT [gps_code_u_idx_1] UNIQUE NONCLUSTERED 
(
	[GpsKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

GO


CREATE TABLE [hfm].[gps_code_rule](
	[GLBU_Class_WhereClauseLike] [varchar](30) NOT NULL,
	[BusinessUnit_WhereClauseLike] [varchar](30) NOT NULL,
	[MinorProductClass_WhereClauseLike] [varchar](30) NOT NULL,
	[Supplier_WhereClauseLike] [varchar](30) NOT NULL,
	[SalesDivision_WhereClauseLike] [varchar](30) NOT NULL,

	[Gps_Code_TargKey] [nchar](30) NOT NULL,
	[Sequence] [int] NOT NULL,
	[RuleName] [varchar](50) NULL,
	[LastReviewed] [date] NULL,
	[Note] [nvarchar](50) NULL,
	[StatusCd] [int] NULL,
 CONSTRAINT [gps_code_rule_c_pk] PRIMARY KEY CLUSTERED 
(
	[GLBU_Class_WhereClauseLike] ASC,
	[BusinessUnit_WhereClauseLike] ASC,
	[MinorProductClass_WhereClauseLike] ASC,
	[Supplier_WhereClauseLike] ASC,
	[SalesDivision_WhereClauseLike] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]

-- ri 
ALTER TABLE hfm.gps_code_rule ADD CONSTRAINT
	FK_gps_code_rule_gps_code FOREIGN KEY
	(
	Gps_Code_TargKey
	) REFERENCES hfm.gps_code
	(
	GpsCode
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO


ALTER TABLE dbo.BRS_Transaction ADD CONSTRAINT
	FK_BRS_Transaction_gps_code FOREIGN KEY
	(
	GpsKey
	) REFERENCES hfm.gps_code
	(
	GpsKey
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

--

-- add unassigned

INSERT INTO hfm.gps_code
                         (GpsCode, GpsDescr, GpsRuleName)
VALUES        (N'', N'Unassigned', N'Unassigned')

-- add gps code from excel

-- add gps rules from excel TBD

