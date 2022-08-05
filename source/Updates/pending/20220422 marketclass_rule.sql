
-- marketclass_rule, tmc, 4 Apr 22

--drop table [hfm].[marketclass_rule]

CREATE TABLE [hfm].[marketclass_rule](
	[SalesDivision_WhereClauseLike] [varchar](100) NOT NULL
	,[VPA_WhereClauseLike] [varchar](100) NOT NULL
	,[CustGrp_WhereClauseLike] [varchar](100) NOT NULL
	,[Specialty_WhereClauseLike] [varchar](100) NOT NULL
	,[MarketClass_WhereClauseLike] [varchar](100) NOT NULL

	,[MarketClass_Target] [char](6) NOT NULL
	,[SegCd_Target] [char](20) NOT NULL
	,cust_comm_group_cd_Target [char](6) NULL

	,[MarketClass_TargetKey] [int] NOT NULL Identity(1,1)

	,[Sequence] [int] not null Default (-1)
	,[RuleName] [varchar](50) NULL
	,[CreateDate] [date] NULL default (GetDate())
	,[LastUpdateDate] [date] NULL 
	,[Note] [nvarchar](50) NULL
	,[active_ind] [smallint] NOT NULL default(0)

 CONSTRAINT [marketclass_rule_c_pk] PRIMARY KEY CLUSTERED 
(
	[SalesDivision_WhereClauseLike] ASC,
	[VPA_WhereClauseLike] ASC,
	[CustGrp_WhereClauseLike] ASC,
	[Specialty_WhereClauseLike] ASC,
	[MarketClass_WhereClauseLike] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX marketclass_rule_u_idx_01 ON hfm.marketclass_rule
	(
	MarketClass_TargetKey
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE hfm.marketclass_rule ADD CONSTRAINT
	FK_marketclass_rule_BRS_CustomerMarketClass FOREIGN KEY
	(
	MarketClass_Target
	) REFERENCES dbo.BRS_CustomerMarketClass
	(
	MarketClass
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.marketclass_rule ADD CONSTRAINT
	FK_marketclass_rule_BRS_CustomerSegment FOREIGN KEY
	(
	SegCd_Target
	) REFERENCES dbo.BRS_CustomerSegment
	(
	SegCd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.marketclass_rule SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE hfm.marketclass_rule ADD CONSTRAINT
	FK_marketclass_rule_group FOREIGN KEY
	(
	cust_comm_group_cd_Target
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE hfm.marketclass_rule SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

print ('1. setup medical')

INSERT INTO [hfm].[marketclass_rule]
           ([SalesDivision_WhereClauseLike]
           ,[VPA_WhereClauseLike]
           ,[CustGrp_WhereClauseLike]
           ,[Specialty_WhereClauseLike]
           ,[MarketClass_WhereClauseLike]
           ,[MarketClass_Target]
           ,[SegCd_Target]
           ,[Sequence]
           ,[Note]
           ,[active_ind])
     VALUES
           ('AAM'
           ,'%'
           ,'%'
           ,'%'
           ,'%'
           ,'MEDICL'
           ,''
           ,1
           ,'init'
           ,1)
GO

print ('2. setup vet')

INSERT INTO [hfm].[marketclass_rule]
           ([SalesDivision_WhereClauseLike]
           ,[VPA_WhereClauseLike]
           ,[CustGrp_WhereClauseLike]
           ,[Specialty_WhereClauseLike]
           ,[MarketClass_WhereClauseLike]
           ,[MarketClass_Target]
           ,[SegCd_Target]
           ,[Sequence]
           ,[Note]
           ,[active_ind])
     VALUES
           ('AAV'
           ,'%'
           ,'%'
           ,'%'
           ,'%'
           ,'ANIMAL'
           ,''
           ,1
           ,'init'
           ,1)
GO

print ('3a. setup Elite DCC')

INSERT INTO [hfm].[marketclass_rule]
           ([SalesDivision_WhereClauseLike]
           ,[VPA_WhereClauseLike]
           ,[CustGrp_WhereClauseLike]
           ,[Specialty_WhereClauseLike]
           ,[MarketClass_WhereClauseLike]
           ,[MarketClass_Target]
           ,[SegCd_Target]
           ,[Sequence]
           ,[Note]
           ,[active_ind])
     VALUES
           ('%'
           ,'DENCORP'
           ,'%'
           ,'%'
           ,'%'
           ,'ELITE'
           ,''
           ,2
           ,'init'
           ,1)
GO


print ('3b. setup Elite 123')

INSERT INTO [hfm].[marketclass_rule]
           ([SalesDivision_WhereClauseLike]
           ,[VPA_WhereClauseLike]
           ,[CustGrp_WhereClauseLike]
           ,[Specialty_WhereClauseLike]
           ,[MarketClass_WhereClauseLike]
           ,[MarketClass_Target]
           ,[SegCd_Target]
           ,[Sequence]
           ,[Note]
           ,[active_ind])
     VALUES
           ('%'
           ,'123DENNC'
           ,'%'
           ,'%'
           ,'%'
           ,'ELITE'
           ,''
           ,2
           ,'init'
           ,1)
GO

print ('3c. setup Elite 123')

INSERT INTO [hfm].[marketclass_rule]
           ([SalesDivision_WhereClauseLike]
           ,[VPA_WhereClauseLike]
           ,[CustGrp_WhereClauseLike]
           ,[Specialty_WhereClauseLike]
           ,[MarketClass_WhereClauseLike]
           ,[MarketClass_Target]
           ,[SegCd_Target]
           ,[Sequence]
           ,[Note]
           ,[active_ind])
     VALUES
           ('%'
           ,'123DENTA'
           ,'%'
           ,'%'
           ,'%'
           ,'ELITE'
           ,''
           ,2
           ,'init'
           ,1)
GO



