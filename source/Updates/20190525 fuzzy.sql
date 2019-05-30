--fuzzy match backend support tables

CREATE SCHEMA [mdm] AUTHORIZATION [dbo]

-- filter
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	mdm_match_ind bit NOT NULL CONSTRAINT DF_BRS_ItemMPC_mdm_match_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_ItemMPC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

UPDATE dbo.BRS_ItemMPC
SET mdm_match_ind = 1
WHERE [MajorProductClass] = '054'
GO

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	mdm_match_usd_ind bit NOT NULL CONSTRAINT DF_BRS_ItemMPC_mdm_match_usd_ind DEFAULT 1
GO
ALTER TABLE dbo.BRS_ItemMPC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
go


UPDATE dbo.BRS_ItemMPC
SET mdm_match_usd_ind = 0
WHERE [MajorProductClass] in ('901', '902', '904','X28')
GO

--

CREATE TABLE [usd].[BRS_ItemSupplier](
	[Supplier] [char](6) NOT NULL,
	[supplier_nm] [nvarchar](50) NOT NULL,
	[CountryGroup] [nchar](30) NOT NULL,
	[SupplierKey] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [usd_BRS_ItemSupplier_c_pk] PRIMARY KEY CLUSTERED 
(
	[Supplier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

insert into [usd].[BRS_ItemSupplier]
(
	[Supplier], [supplier_nm], [CountryGroup] 
)
VALUES ('', 'unassigned', '')


insert into [usd].[BRS_ItemSupplier]
(
	[Supplier], [supplier_nm], [CountryGroup] 
)
select distinct (supplier), '' subname, '' countrygrp from usd.BRS_Item


-- results

-- drop table [mdm].[item_match_t4]
CREATE TABLE [mdm].[item_match_t4](
	item_code [varchar](10) NOT NULL,
	item_code_ref [varchar](10) NULL,

	description_strength [varchar](55) NULL,
	description_strength_ref [varchar](55) NULL,

	size [varchar](8) NULL,
	size_usd [varchar](8) NULL,

	manuf_part_number [varchar](15) NULL,
	manuf_part_number_ref [varchar](15) NULL,

	mpc_code [varchar](3) NULL,
	mpc_code_ref [varchar](3) NULL,

	supplier [varchar](6) NULL,
	supplier_ref [varchar](6) NULL,

	supplier_global [nvarchar](30) NULL,
	supplier_global_ref [nvarchar](30) NULL,

	item_create_date [datetime] NULL,
	item_create_date_ref [datetime] NULL,

	current_file_cost [money] NULL,
	current_file_cost_ref [money] NULL,

	[_Similarity] [float] NULL,
	[_Confidence] [float] NULL,

	[_Similarity_DescrStrength] [float] NULL,
	[_Similarity_ManufPartNumber] [float] NULL,
	[_Similarity_Size] [float] NULL

 CONSTRAINT [mdm_item_match_t4_c_pk] PRIMARY KEY CLUSTERED 
(
	item_code ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--


-- drop table [mdm].[item_match_t3]
CREATE TABLE [mdm].[item_match_t3](
	item_code [varchar](10) NOT NULL,
	item_code_ref [varchar](10) NULL,

	description_strength [varchar](55) NULL,
	description_strength_ref [varchar](55) NULL,

	size [varchar](8) NULL,
	size_usd [varchar](8) NULL,

	manuf_part_number [varchar](15) NULL,
	manuf_part_number_ref [varchar](15) NULL,

	mpc_code [varchar](3) NULL,
	mpc_code_ref [varchar](3) NULL,

	supplier [varchar](6) NULL,
	supplier_ref [varchar](6) NULL,

	supplier_global [nvarchar](30) NULL,
	supplier_global_ref [nvarchar](30) NULL,

	item_create_date [datetime] NULL,
	item_create_date_ref [datetime] NULL,

	current_file_cost [money] NULL,
	current_file_cost_ref [money] NULL,

	[_Similarity] [float] NULL,
	[_Confidence] [float] NULL,

	[_Similarity_DescrStrength] [float] NULL,
	[_Similarity_ManufPartNumber] [float] NULL,
	[_Similarity_Size] [float] NULL

 CONSTRAINT [mdm_item_match_t3_c_pk] PRIMARY KEY CLUSTERED 
(
	item_code ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--


-- drop table [mdm].[item_match_t2]
CREATE TABLE [mdm].[item_match_t2](
	item_code [varchar](10) NOT NULL,
	item_code_ref [varchar](10) NULL,

	description_strength [varchar](55) NULL,
	description_strength_ref [varchar](55) NULL,

	size [varchar](8) NULL,
	size_usd [varchar](8) NULL,

	manuf_part_number [varchar](15) NULL,
	manuf_part_number_ref [varchar](15) NULL,

	mpc_code [varchar](3) NULL,
	mpc_code_ref [varchar](3) NULL,

	supplier [varchar](6) NULL,
	supplier_ref [varchar](6) NULL,

	supplier_global [nvarchar](30) NULL,
	supplier_global_ref [nvarchar](30) NULL,

	item_create_date [datetime] NULL,
	item_create_date_ref [datetime] NULL,

	current_file_cost [money] NULL,
	current_file_cost_ref [money] NULL,

	[_Similarity] [float] NULL,
	[_Confidence] [float] NULL,

	[_Similarity_DescrStrength] [float] NULL,
	[_Similarity_ManufPartNumber] [float] NULL,
	[_Similarity_Size] [float] NULL

 CONSTRAINT [mdm_item_match_t2_c_pk] PRIMARY KEY CLUSTERED 
(
	item_code ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO


-- drop table [mdm].[item_match_t1]
CREATE TABLE [mdm].[item_match_t1](
	item_code [varchar](10) NOT NULL,
	item_code_ref [varchar](10) NULL,

	description_strength [varchar](55) NULL,
	description_strength_ref [varchar](55) NULL,

	size [varchar](8) NULL,
	size_usd [varchar](8) NULL,

	manuf_part_number [varchar](15) NULL,
	manuf_part_number_ref [varchar](15) NULL,

	mpc_code [varchar](3) NULL,
	mpc_code_ref [varchar](3) NULL,

	supplier [varchar](6) NULL,
	supplier_ref [varchar](6) NULL,

	supplier_global [nvarchar](30) NULL,
	supplier_global_ref [nvarchar](30) NULL,

	item_create_date [datetime] NULL,
	item_create_date_ref [datetime] NULL,

	current_file_cost [money] NULL,
	current_file_cost_ref [money] NULL,

	[_Similarity] [float] NULL,
	[_Confidence] [float] NULL,

	[_Similarity_DescrStrength] [float] NULL,
	[_Similarity_ManufPartNumber] [float] NULL,
	[_Similarity_Size] [float] NULL

 CONSTRAINT [mdm_item_match_t1_c_pk] PRIMARY KEY CLUSTERED 
(
	item_code ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--

-- drop table [mdm].[item_match_review]
CREATE TABLE [mdm].[item_match_review](
	item_code [varchar](10) NOT NULL,
	item_code_ref [varchar](10) NOT NULL,
	
	match_type [char](2) NOT NULL,

	description_strength [varchar](55) NULL,
	description_strength_ref [varchar](55) NULL,

	size [varchar](8) NULL,
	size_usd [varchar](8) NULL,

	manuf_part_number [varchar](15) NULL,
	manuf_part_number_ref [varchar](15) NULL,

	mpc_code [varchar](3) NULL,
	mpc_code_ref [varchar](3) NULL,

	supplier [varchar](6) NULL,
	supplier_ref [varchar](6) NULL,

	supplier_global [nvarchar](30) NULL,
	supplier_global_ref [nvarchar](30) NULL,

	item_create_date [datetime] NULL,
	item_create_date_ref [datetime] NULL,

	current_file_cost [money] NULL,
	current_file_cost_ref [money] NULL,

	[_Similarity] [float] NULL,
	[_Confidence] [float] NULL,

	[_Similarity_DescrStrength] [float] NULL,
	[_Similarity_ManufPartNumber] [float] NULL,
	[_Similarity_Size] [float] NULL,

	match_key [integer] identity(1,1) NOT NULL

 CONSTRAINT [mdm_item_match_review_c_pk] PRIMARY KEY CLUSTERED 
(
	item_code ASC,
	item_code_ref ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

---
BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_Item ADD
	item_usd char(10) NULL,
	item_usd_conversion_rt float(53) NULL
GO
ALTER TABLE dbo.BRS_Item ADD CONSTRAINT
	FK_BRS_Item_BRS_Item2 FOREIGN KEY
	(
	item_usd
	) REFERENCES usd.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.BRS_Item SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update match_review

-- truncate table mdm.item_match_review

-- t4
INSERT INTO mdm.item_match_review
                         (item_code, item_code_ref, description_strength, description_strength_ref, size, size_usd, manuf_part_number, manuf_part_number_ref, mpc_code, mpc_code_ref, 
                         supplier, supplier_ref, supplier_global, supplier_global_ref, item_create_date, item_create_date_ref, current_file_cost, current_file_cost_ref, _Similarity, 
                         _Confidence, _Similarity_DescrStrength, _Similarity_ManufPartNumber, _Similarity_Size, match_type)
SELECT        item_code, item_code_ref, description_strength, description_strength_ref, size, size_usd, manuf_part_number, manuf_part_number_ref, mpc_code, mpc_code_ref, 
                         supplier, supplier_ref, supplier_global, supplier_global_ref, item_create_date, item_create_date_ref, current_file_cost, current_file_cost_ref, _Similarity, 
                         _Confidence, _Similarity_DescrStrength, _Similarity_ManufPartNumber, _Similarity_Size, 'T4' AS match_type
FROM            mdm.item_match_t4 s 
WHERE        (item_code_ref <> '') AND NOT Exists(select * from mdm.item_match_review d where s.item_code = d.item_code and s.item_code_ref = d.item_code_ref)
go


-- t3
INSERT INTO mdm.item_match_review
                         (item_code, item_code_ref, description_strength, description_strength_ref, size, size_usd, manuf_part_number, manuf_part_number_ref, mpc_code, mpc_code_ref, 
                         supplier, supplier_ref, supplier_global, supplier_global_ref, item_create_date, item_create_date_ref, current_file_cost, current_file_cost_ref, _Similarity, 
                         _Confidence, _Similarity_DescrStrength, _Similarity_ManufPartNumber, _Similarity_Size, match_type)
SELECT        item_code, item_code_ref, description_strength, description_strength_ref, size, size_usd, manuf_part_number, manuf_part_number_ref, mpc_code, mpc_code_ref, 
                         supplier, supplier_ref, supplier_global, supplier_global_ref, item_create_date, item_create_date_ref, current_file_cost, current_file_cost_ref, _Similarity, 
                         _Confidence, _Similarity_DescrStrength, _Similarity_ManufPartNumber, _Similarity_Size, 'T3' AS match_type
FROM            mdm.item_match_t3 s
WHERE        (item_code_ref <> '') AND NOT Exists(select * from mdm.item_match_review d where s.item_code = d.item_code and s.item_code_ref = d.item_code_ref)
go

-- t2
INSERT INTO mdm.item_match_review
                         (item_code, item_code_ref, description_strength, description_strength_ref, size, size_usd, manuf_part_number, manuf_part_number_ref, mpc_code, mpc_code_ref, 
                         supplier, supplier_ref, supplier_global, supplier_global_ref, item_create_date, item_create_date_ref, current_file_cost, current_file_cost_ref, _Similarity, 
                         _Confidence, _Similarity_DescrStrength, _Similarity_ManufPartNumber, _Similarity_Size, match_type)
SELECT        item_code, item_code_ref, description_strength, description_strength_ref, size, size_usd, manuf_part_number, manuf_part_number_ref, mpc_code, mpc_code_ref, 
                         supplier, supplier_ref, supplier_global, supplier_global_ref, item_create_date, item_create_date_ref, current_file_cost, current_file_cost_ref, _Similarity, 
                         _Confidence, _Similarity_DescrStrength, _Similarity_ManufPartNumber, _Similarity_Size, 'T2' AS match_type
FROM            mdm.item_match_t2 s
WHERE        (item_code_ref <> '') AND NOT Exists(select * from mdm.item_match_review d where s.item_code = d.item_code and s.item_code_ref = d.item_code_ref)
go

-- t1
INSERT INTO mdm.item_match_review
                         (item_code, item_code_ref, description_strength, description_strength_ref, size, size_usd, manuf_part_number, manuf_part_number_ref, mpc_code, mpc_code_ref, 
                         supplier, supplier_ref, supplier_global, supplier_global_ref, item_create_date, item_create_date_ref, current_file_cost, current_file_cost_ref, _Similarity, 
                         _Confidence, _Similarity_DescrStrength, _Similarity_ManufPartNumber, _Similarity_Size, match_type)
SELECT        item_code, item_code_ref, description_strength, description_strength_ref, size, size_usd, manuf_part_number, manuf_part_number_ref, mpc_code, mpc_code_ref, 
                         supplier, supplier_ref, supplier_global, supplier_global_ref, item_create_date, item_create_date_ref, current_file_cost, current_file_cost_ref, _Similarity, 
                         _Confidence, _Similarity_DescrStrength, _Similarity_ManufPartNumber, _Similarity_Size, 'T1' AS match_type
FROM            mdm.item_match_t1 s
WHERE        (item_code_ref <> '') AND NOT Exists(select * from mdm.item_match_review d where s.item_code = d.item_code and s.item_code_ref = d.item_code_ref)
go

-- no match
INSERT INTO mdm.item_match_review
                         (item_code, item_code_ref, description_strength, size, manuf_part_number, mpc_code, supplier, supplier_global, item_create_date, current_file_cost, match_type)
SELECT        item_code, '', description_strength, size, manuf_part_number, mpc_code, supplier, supplier_global, item_create_date, current_file_cost, 'NO'
FROM            mdm.item_match_t1 AS s
WHERE        NOT Exists(select * from mdm.item_match_review d where s.item_code = d.item_code)
go

--

--drop table [mdm].[item_match_standard]

CREATE TABLE [mdm].[item_match_standard](
	item_code [char](10) NOT NULL,
	item_code_standard [char](10) NULL,


 CONSTRAINT [mdm_item_match_standard_c_pk] PRIMARY KEY CLUSTERED 
(
	item_code ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [USERDATA]
) ON [USERDATA]
GO

--

BEGIN TRANSACTION
GO
ALTER TABLE mdm.item_match_standard ADD CONSTRAINT
	FK_item_match_standard_BRS_Item FOREIGN KEY
	(
	item_code
	) REFERENCES dbo.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE mdm.item_match_standard ADD CONSTRAINT
	FK_item_match_standard_BRS_Item1 FOREIGN KEY
	(
	item_code_standard
	) REFERENCES usd.BRS_Item
	(
	Item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE mdm.item_match_standard SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- testing


SELECT
	m.item_code, 
	m.item_code_ref, 
	std.item_code_standard, 

	CASE 
		WHEN m.item_code_ref = ''
		THEN 'Z' 
		ELSE  
			CASE 
				WHEN m.item_code = m.item_code_ref
				THEN 'S'
				ELSE 'F'
			END
	END AS match_status,
	m.match_type, 
	ROUND(m._Confidence,1) _Confidence,

	ROUND(m._Similarity,1) _Similarity,
	ROUND(m._Similarity_DescrStrength,1) _Similarity_DescrStrength,
	ROUND(m._Similarity_ManufPartNumber,1) _Similarity_ManufPartNumber,
	ROUND(m._Similarity_Size,1) _Similarity_Size,


	m.description_strength, 
	m.description_strength_ref, 

	m.supplier_global, 
	m.supplier_global_ref, 

	m.manuf_part_number, 
	m.manuf_part_number_ref, 

	m.size, 
	m.size_usd, 

	m.match_key,

	m.mpc_code, 
	m.mpc_code_ref, 
	m.supplier, 
	m.supplier_ref, 
	m.item_create_date, 
	m.item_create_date_ref, 
	m.current_file_cost, 
	m.current_file_cost_ref 


FROM            
	mdm.item_match_review AS m 

	INNER JOIN mdm.item_match_standard AS std 
	ON m.item_code = std.item_code


