-- setup e3 snapshot tables, tmc, 11 Aug 20
CREATE SCHEMA [e3] AUTHORIZATION [dbo]
GO

/*
system = E
table = E3ITEMA
schema = ATOEARCIM
*/

-- drop table [Integration].[E3ITEMA_trim_Staging]
CREATE TABLE [Integration].[E3ITEMA_trim_Staging](
	[IITEM__item_id] [char](18) NOT NULL,
	[IWHSE__warehouse_id] [char](3) NOT NULL,
	[IVNDR__vendor_id] [char](8) NOT NULL,
	[ISUBV__subvendor_id] [char](4) NOT NULL,
	[IBUYR__buyer_id] [char](3) NOT NULL,
	[IDEM52_demand_forecast_weekly] [numeric](9, 2) NOT NULL,
	[IDMPRF_item_demand_profile_id] [char](10) NOT NULL,
 CONSTRAINT [PK_E3ITEMA_trim_Staging] PRIMARY KEY CLUSTERED 
(
	[IITEM__item_id] ASC,
	[IWHSE__warehouse_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

-- drop table [Integration].[E3PRFL_profile_Staging]
CREATE TABLE [Integration].[E3PRFL_profile_Staging](
	[PPRFL__profile_id] [char](10) NOT NULL,
	[PBIRDT_birth_date] [numeric](7, 0) NOT NULL,
	[PPTYPE_profile_type] [char](1) NOT NULL,
	[PNAME__profile_name] [char](20) NOT NULL,
	[PPERD__periodicity] [numeric](3, 0) NOT NULL,
	[PMESG__message_switch] [numeric](1, 0) NOT NULL,
	[PUSEDT_use_date] [numeric](7, 0) NOT NULL,
	[PIX01__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX02__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX03__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX04__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX05__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX06__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX07__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX08__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX09__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX10__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX11__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX12__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX13__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX14__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX15__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX16__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX17__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX18__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX19__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX20__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX21__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX22__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX23__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX24__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX25__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX26__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX27__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX28__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX29__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX30__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX31__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX32__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX33__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX34__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX35__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX36__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX37__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX38__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX39__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX40__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX41__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX42__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX43__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX44__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX45__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX46__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX47__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX48__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX49__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX50__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX51__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX52__seasonal_index] [numeric](5, 2) NOT NULL,
	[PMSGSW_message_switch] [numeric](1, 0) NOT NULL,
 CONSTRAINT [PK_E3PRFL_profile_Staging] PRIMARY KEY CLUSTERED 
(
	[PPRFL__profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

-- drop TABLE [e3].[demand_E3ITEMA_dimension]
CREATE TABLE [e3].[demand_E3ITEMA_dimension](
	[IVNDR__vendor_id] [char](6) NOT NULL,
	[ISUBV__subvendor_id] [char](4) NOT NULL,
	[IBUYR__buyer_id] [char](3) NOT NULL,
	[IDMPRF_item_demand_profile_id] [char](10) NOT NULL,
	[demand_dim_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [demand_E3ITEMA_dimension_c_pk] PRIMARY KEY CLUSTERED 
(
	[IVNDR__vendor_id] ASC,
	[ISUBV__subvendor_id] ASC,
	[IBUYR__buyer_id] ASC,
	[IDMPRF_item_demand_profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


INSERT INTO [e3].[demand_E3ITEMA_dimension]
           ([IVNDR__vendor_id]
           ,[ISUBV__subvendor_id]
           ,[IBUYR__buyer_id]
           ,[IDMPRF_item_demand_profile_id])
     VALUES
           (''
           ,''
           ,''
           ,'')
GO


-- drop TABLE [e3].[profile_E3PRFL]
CREATE TABLE [e3].[profile_E3PRFL](
	[PPRFL__profile_id] [char](10) NOT NULL,
	[PBIRDT_birth_date] [numeric](7, 0) NOT NULL,
	[PPTYPE_profile_type] [char](1) NOT NULL,
	[PNAME__profile_name] [char](20) NOT NULL,
	[PPERD__periodicity] [numeric](3, 0) NOT NULL,
	[PMESG__message_switch] [numeric](1, 0) NOT NULL,
	[PUSEDT_use_date] [numeric](7, 0) NOT NULL,
	[PIX01__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX02__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX03__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX04__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX05__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX06__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX07__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX08__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX09__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX10__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX11__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX12__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX13__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX14__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX15__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX16__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX17__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX18__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX19__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX20__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX21__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX22__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX23__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX24__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX25__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX26__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX27__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX28__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX29__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX30__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX31__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX32__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX33__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX34__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX35__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX36__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX37__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX38__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX39__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX40__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX41__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX42__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX43__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX44__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX45__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX46__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX47__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX48__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX49__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX50__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX51__seasonal_index] [numeric](5, 2) NOT NULL,
	[PIX52__seasonal_index] [numeric](5, 2) NOT NULL,
	[PMSGSW_message_switch] [numeric](1, 0) NOT NULL,
 CONSTRAINT [e3_profile_E3PRFL_c_pk] PRIMARY KEY CLUSTERED 
(
	[PPRFL__profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

INSERT INTO [e3].[profile_E3PRFL]
           ([PPRFL__profile_id]
           ,[PBIRDT_birth_date]
           ,[PPTYPE_profile_type]
           ,[PNAME__profile_name]
           ,[PPERD__periodicity]
           ,[PMESG__message_switch]
           ,[PUSEDT_use_date]
           ,[PIX01__seasonal_index]
           ,[PIX02__seasonal_index]
           ,[PIX03__seasonal_index]
           ,[PIX04__seasonal_index]
           ,[PIX05__seasonal_index]
           ,[PIX06__seasonal_index]
           ,[PIX07__seasonal_index]
           ,[PIX08__seasonal_index]
           ,[PIX09__seasonal_index]
           ,[PIX10__seasonal_index]
           ,[PIX11__seasonal_index]
           ,[PIX12__seasonal_index]
           ,[PIX13__seasonal_index]
           ,[PIX14__seasonal_index]
           ,[PIX15__seasonal_index]
           ,[PIX16__seasonal_index]
           ,[PIX17__seasonal_index]
           ,[PIX18__seasonal_index]
           ,[PIX19__seasonal_index]
           ,[PIX20__seasonal_index]
           ,[PIX21__seasonal_index]
           ,[PIX22__seasonal_index]
           ,[PIX23__seasonal_index]
           ,[PIX24__seasonal_index]
           ,[PIX25__seasonal_index]
           ,[PIX26__seasonal_index]
           ,[PIX27__seasonal_index]
           ,[PIX28__seasonal_index]
           ,[PIX29__seasonal_index]
           ,[PIX30__seasonal_index]
           ,[PIX31__seasonal_index]
           ,[PIX32__seasonal_index]
           ,[PIX33__seasonal_index]
           ,[PIX34__seasonal_index]
           ,[PIX35__seasonal_index]
           ,[PIX36__seasonal_index]
           ,[PIX37__seasonal_index]
           ,[PIX38__seasonal_index]
           ,[PIX39__seasonal_index]
           ,[PIX40__seasonal_index]
           ,[PIX41__seasonal_index]
           ,[PIX42__seasonal_index]
           ,[PIX43__seasonal_index]
           ,[PIX44__seasonal_index]
           ,[PIX45__seasonal_index]
           ,[PIX46__seasonal_index]
           ,[PIX47__seasonal_index]
           ,[PIX48__seasonal_index]
           ,[PIX49__seasonal_index]
           ,[PIX50__seasonal_index]
           ,[PIX51__seasonal_index]
           ,[PIX52__seasonal_index]
           ,[PMSGSW_message_switch])
     VALUES
           (''
           ,0
           ,''
           ,'unassigned'
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0
           ,0)
GO

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX demand_E3ITEMA_dimension_u_idx_01 ON e3.demand_E3ITEMA_dimension
	(
	demand_dim_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE e3.demand_E3ITEMA_dimension SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE e3.demand_E3ITEMA_dimension ADD CONSTRAINT
	FK_demand_E3ITEMA_dimension_BRS_ItemSupplier FOREIGN KEY
	(
	IVNDR__vendor_id
	) REFERENCES dbo.BRS_ItemSupplier
	(
	Supplier
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE e3.demand_E3ITEMA_dimension ADD CONSTRAINT
	FK_demand_E3ITEMA_dimension_profile_E3PRFL FOREIGN KEY
	(
	IDMPRF_item_demand_profile_id
	) REFERENCES e3.profile_E3PRFL
	(
	PPRFL__profile_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE e3.demand_E3ITEMA_dimension SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- drop TABLE [e3].[demand_E3ITEMA]
CREATE TABLE [e3].[demand_E3ITEMA](
	[SalesDay] [date] NOT NULL,
	[ItemKey] [int] NOT NULL,
	[IWHSE__warehouse_id] [tinyint] NOT NULL,
	[IDEM52_demand_forecast_weekly] real NOT NULL,
	[demand_dim_id] [int] NOT NULL

 CONSTRAINT [PK_E3ITEMA_trim_Staging] PRIMARY KEY CLUSTERED 
(
	[SalesDay] ASC,
	[ItemKey] ASC,
	[IWHSE__warehouse_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


INSERT INTO [e3].[demand_E3ITEMA]
           ([SalesDay]
           ,[ItemKey]
           ,[IWHSE__warehouse_id]
           ,[IDEM52_demand_forecast_weekly]
           ,[demand_dim_id])
     VALUES
           ('1980-01-01'
           ,1
           ,0
           ,0
           ,1)
GO

BEGIN TRANSACTION
GO
ALTER TABLE e3.demand_E3ITEMA ADD CONSTRAINT
	FK_demand_E3ITEMA_BRS_Item FOREIGN KEY
	(
	ItemKey
	) REFERENCES dbo.BRS_Item
	(
	ItemKey
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE e3.demand_E3ITEMA SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE e3.demand_E3ITEMA ADD CONSTRAINT
	FK_demand_E3ITEMA_demand_E3ITEMA_dimension FOREIGN KEY
	(
	demand_dim_id
	) REFERENCES e3.demand_E3ITEMA_dimension
	(
	demand_dim_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE e3.demand_E3ITEMA SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



--------------------------------------------------------------------------------
-- DROP TABLE Integration.E3TARC_E3ITEMA_<instert_friendly_name_here>
--------------------------------------------------------------------------------
-- truncate table Integration.E3ITEMA_trim
SELECT 
--	Top 5 
	"IITEM" AS IITEM__item_id
	,"IWHSE" AS IWHSE__warehouse_id
	,"IVNDR" AS IVNDR__vendor_id
	,"ISUBV" AS ISUBV__subvendor_id
	,"IBUYR" AS IBUYR__buyer_id
	,"IDEM52" AS IDEM52_demand_forecast_weekly
	,"IDMPRF" AS IDMPRF_item_demand_profile_id 
INTO Integration.E3ITEMA_trim_Staging2e
FROM 
    OPENQUERY (ESYS_PROD
--    OPENQUERY (ASYS_PROD
,'
	SELECT
		IITEM
		,IWHSE
		,IVNDR
		,ISUBV
		,IBUYR
		,IDEM52
		,IDMPRF

	FROM
		ATOEARCIM.E3ITEMA
--		E3TARC.E3ITEMA
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

-- A system; rows=201754, time=47s
-- E system; rows=201754, time=44s
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- DROP TABLE Integration.E3TARC_E3PRFL_<instert_friendly_name_here>
--------------------------------------------------------------------------------
SELECT 
    Top 5 
    "PBIRDT" AS PBIRDT_birth_date
	,"PPRFL" AS PPRFL__profile_id
	,"PPTYPE" AS PPTYPE_profile_type
	,"PNAME" AS PNAME__profile_name
	,"PPERD" AS PPERD__periodicity
	,"PMESG" AS PMESG__message_switch
	,"PUSEDT" AS PUSEDT_use_date
	,"PIX01" AS PIX01__seasonal_index
	,"PIX02" AS PIX02__seasonal_index
	,"PIX03" AS PIX03__seasonal_index
	,"PIX04" AS PIX04__seasonal_index
	,"PIX05" AS PIX05__seasonal_index
	,"PIX06" AS PIX06__seasonal_index
	,"PIX07" AS PIX07__seasonal_index
	,"PIX08" AS PIX08__seasonal_index
	,"PIX09" AS PIX09__seasonal_index
	,"PIX10" AS PIX10__seasonal_index
	,"PIX11" AS PIX11__seasonal_index
	,"PIX12" AS PIX12__seasonal_index
	,"PIX13" AS PIX13__seasonal_index
	,"PIX14" AS PIX14__seasonal_index
	,"PIX15" AS PIX15__seasonal_index
	,"PIX16" AS PIX16__seasonal_index
	,"PIX17" AS PIX17__seasonal_index
	,"PIX18" AS PIX18__seasonal_index
	,"PIX19" AS PIX19__seasonal_index
	,"PIX20" AS PIX20__seasonal_index
	,"PIX21" AS PIX21__seasonal_index
	,"PIX22" AS PIX22__seasonal_index
	,"PIX23" AS PIX23__seasonal_index
	,"PIX24" AS PIX24__seasonal_index
	,"PIX25" AS PIX25__seasonal_index
	,"PIX26" AS PIX26__seasonal_index
	,"PIX27" AS PIX27__seasonal_index
	,"PIX28" AS PIX28__seasonal_index
	,"PIX29" AS PIX29__seasonal_index
	,"PIX30" AS PIX30__seasonal_index
	,"PIX31" AS PIX31__seasonal_index
	,"PIX32" AS PIX32__seasonal_index
	,"PIX33" AS PIX33__seasonal_index
	,"PIX34" AS PIX34__seasonal_index
	,"PIX35" AS PIX35__seasonal_index
	,"PIX36" AS PIX36__seasonal_index
	,"PIX37" AS PIX37__seasonal_index
	,"PIX38" AS PIX38__seasonal_index
	,"PIX39" AS PIX39__seasonal_index
	,"PIX40" AS PIX40__seasonal_index
	,"PIX41" AS PIX41__seasonal_index
	,"PIX42" AS PIX42__seasonal_index
	,"PIX43" AS PIX43__seasonal_index
	,"PIX44" AS PIX44__seasonal_index
	,"PIX45" AS PIX45__seasonal_index
	,"PIX46" AS PIX46__seasonal_index
	,"PIX47" AS PIX47__seasonal_index
	,"PIX48" AS PIX48__seasonal_index
	,"PIX49" AS PIX49__seasonal_index
	,"PIX50" AS PIX50__seasonal_index
	,"PIX51" AS PIX51__seasonal_index
	,"PIX52" AS PIX52__seasonal_index
	,"PMSGSW" AS PMSGSW_message_switch 

--INTO Integration.E3PRFL_profile_Staging

FROM 
    OPENQUERY (ASYS_PROD, '

	SELECT
		PBIRDT
		,PPRFL
		,PPTYPE
		,PNAME
		,PPERD
		,PMESG
		,PUSEDT
		,PIX01
		,PIX02
		,PIX03
		,PIX04
		,PIX05
		,PIX06
		,PIX07
		,PIX08
		,PIX09
		,PIX10
		,PIX11
		,PIX12
		,PIX13
		,PIX14
		,PIX15
		,PIX16
		,PIX17
		,PIX18
		,PIX19
		,PIX20
		,PIX21
		,PIX22
		,PIX23
		,PIX24
		,PIX25
		,PIX26
		,PIX27
		,PIX28
		,PIX29
		,PIX30
		,PIX31
		,PIX32
		,PIX33
		,PIX34
		,PIX35
		,PIX36
		,PIX37
		,PIX38
		,PIX39
		,PIX40
		,PIX41
		,PIX42
		,PIX43
		,PIX44
		,PIX45
		,PIX46
		,PIX47
		,PIX48
		,PIX49
		,PIX50
		,PIX51
		,PIX52
		,PMSGSW

	FROM
		E3TARC.E3PRFL
--    WHERE
--        <insert custom code here>
--    ORDER BY
--        <insert custom code here>
')

--------------------------------------------------------------------------------

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	[PPRFL__profile_id], 
	seasonal_index as current_index
FROM 
(
	SELECT 
		[PPRFL__profile_id]
		,[PIX01__seasonal_index]
		,[PIX02__seasonal_index]
		,[PIX03__seasonal_index]
		,[PIX04__seasonal_index]
		,[PIX05__seasonal_index]
		,[PIX06__seasonal_index]
		,[PIX07__seasonal_index]
		,[PIX08__seasonal_index]
		,[PIX09__seasonal_index]
		,[PIX10__seasonal_index]
		,[PIX11__seasonal_index]
		,[PIX12__seasonal_index]
		,[PIX13__seasonal_index]
		,[PIX14__seasonal_index]
		,[PIX15__seasonal_index]
		,[PIX16__seasonal_index]
		,[PIX17__seasonal_index]
		,[PIX18__seasonal_index]
		,[PIX19__seasonal_index]
		,[PIX20__seasonal_index]
		,[PIX21__seasonal_index]
		,[PIX22__seasonal_index]
		,[PIX23__seasonal_index]
		,[PIX24__seasonal_index]
		,[PIX25__seasonal_index]
		,[PIX26__seasonal_index]
		,[PIX27__seasonal_index]
		,[PIX28__seasonal_index]
		,[PIX29__seasonal_index]
		,[PIX30__seasonal_index]
		,[PIX31__seasonal_index]
		,[PIX32__seasonal_index]
		,[PIX33__seasonal_index]
		,[PIX34__seasonal_index]
		,[PIX35__seasonal_index]
		,[PIX36__seasonal_index]
		,[PIX37__seasonal_index]
		,[PIX38__seasonal_index]
		,[PIX39__seasonal_index]
		,[PIX40__seasonal_index]
		,[PIX41__seasonal_index]
		,[PIX42__seasonal_index]
		,[PIX43__seasonal_index]
		,[PIX44__seasonal_index]
		,[PIX45__seasonal_index]
		,[PIX46__seasonal_index]
		,[PIX47__seasonal_index]
		,[PIX48__seasonal_index]
		,[PIX49__seasonal_index]
		,[PIX50__seasonal_index]
		,[PIX51__seasonal_index]
		,[PIX52__seasonal_index]
		,[PMSGSW_message_switch]
  FROM 
	[Integration].[E3PRFL_profile_Staging]
) piv
UNPIVOT 
(
	seasonal_index FOR weeks in
    (
		[PIX01__seasonal_index]
		,[PIX02__seasonal_index]
		,[PIX03__seasonal_index]
		,[PIX04__seasonal_index]
		,[PIX05__seasonal_index]
		,[PIX06__seasonal_index]
		,[PIX07__seasonal_index]
		,[PIX08__seasonal_index]
		,[PIX09__seasonal_index]
		,[PIX10__seasonal_index]
		,[PIX11__seasonal_index]
		,[PIX12__seasonal_index]
		,[PIX13__seasonal_index]
		,[PIX14__seasonal_index]
		,[PIX15__seasonal_index]
		,[PIX16__seasonal_index]
		,[PIX17__seasonal_index]
		,[PIX18__seasonal_index]
		,[PIX19__seasonal_index]
		,[PIX20__seasonal_index]
		,[PIX21__seasonal_index]
		,[PIX22__seasonal_index]
		,[PIX23__seasonal_index]
		,[PIX24__seasonal_index]
		,[PIX25__seasonal_index]
		,[PIX26__seasonal_index]
		,[PIX27__seasonal_index]
		,[PIX28__seasonal_index]
		,[PIX29__seasonal_index]
		,[PIX30__seasonal_index]
		,[PIX31__seasonal_index]
		,[PIX32__seasonal_index]
		,[PIX33__seasonal_index]
		,[PIX34__seasonal_index]
		,[PIX35__seasonal_index]
		,[PIX36__seasonal_index]
		,[PIX37__seasonal_index]
		,[PIX38__seasonal_index]
		,[PIX39__seasonal_index]
		,[PIX40__seasonal_index]
		,[PIX41__seasonal_index]
		,[PIX42__seasonal_index]
		,[PIX43__seasonal_index]
		,[PIX44__seasonal_index]
		,[PIX45__seasonal_index]
		,[PIX46__seasonal_index]
		,[PIX47__seasonal_index]
		,[PIX48__seasonal_index]
		,[PIX49__seasonal_index]
		,[PIX50__seasonal_index]
		,[PIX51__seasonal_index]
		,[PIX52__seasonal_index]
      )
  ) AS unpvt
WHERE
	CAST(SUBSTRING(weeks,4,2) as int) = 
	(select [CalWeek] from [dbo].[BRS_Config], [dbo].[BRS_SalesDay] d where [SalesDateLastWeekly] = d.[SalesDate])
