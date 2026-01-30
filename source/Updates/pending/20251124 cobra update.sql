--cobra update, tmc, 24 Nov 25

BEGIN TRANSACTION
GO
ALTER TABLE pbi.item_cobra_xref ADD
	-- BrandItem
	us_item_subst char(10) NULL

	,us_match_type_cd char(4) NULL
	,us_match_type_brand_txt varchar(50) NULL
	,us_contents_per_uom_amt float(53) NULL
	,us_uom_conv_rt float(53) NULL
	,us_match_status_cd char(4) NULL
	,us_added_dt datetime NULL
	,us_note_txt varchar(50) NULL
	,us_status_cd smallint NULL
GO
ALTER TABLE pbi.item_cobra_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- truncate table integration.pbi_item_cobra_xref
-- drop table integration.pbi_item_cobra_xref


CREATE TABLE [Integration].[pbi_item_cobra_xref](
	[item] [char](10) NOT NULL,
	[us_item_subst] [char](10) NOT NULL,

	[us_match_type_txt] [varchar](50) NULL,
	[us_match_type_brand_txt] [varchar](50) NULL,
	[us_contents_per_uom_amt] [float] NULL,
	[us_uom_conv_rt] [float] NULL,
	[us_match_status_txt] [varchar](50) NULL,
	[us_added_dt] [datetime] NULL,
	[us_note_txt] [varchar](50) NULL,
	[us_status_cd] [smallint] NULL
) ON [USERDATA]
GO

-- add_pk

BEGIN TRANSACTION
GO
ALTER TABLE Integration.pbi_item_cobra_xref ADD CONSTRAINT
	pbi_item_cobra_xref_int_c_pk PRIMARY KEY CLUSTERED 
	(
	item,
	us_item_subst
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE Integration.pbi_item_cobra_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- fix match type

select distinct [us_match_type_txt] from Integration.pbi_item_cobra_xref  order by 1

UPDATE  Integration.pbi_item_cobra_xref
SET        us_match_type_txt = 'EDLP'
WHERE   (us_match_type_txt = 'EB1')
GO

UPDATE  Integration.pbi_item_cobra_xref
SET        us_match_type_txt = 'OWN1'
WHERE   (us_match_type_txt = 'OB1')
GO

UPDATE  Integration.pbi_item_cobra_xref
SET        us_match_type_txt = 'OWN2'
WHERE   (us_match_type_txt = 'OB2')
GO

UPDATE  Integration.pbi_item_cobra_xref
SET        us_match_type_txt = 'STRB'
WHERE   (us_match_type_txt = 'SB1')
GO


-- AAAA


-- fix match status

select distinct [us_match_status_txt] from Integration.pbi_item_cobra_xref  order by 1

UPDATE  Integration.pbi_item_cobra_xref
SET        [us_match_status_txt] = '2EQU'
WHERE   ([us_match_status_txt] = 'Equivalent')
GO

UPDATE  Integration.pbi_item_cobra_xref
SET        [us_match_status_txt] = '1EXA'
WHERE   ([us_match_status_txt] = 'Exact')
GO


UPDATE  Integration.pbi_item_cobra_xref
SET        [us_match_status_txt] = '3SIM'
WHERE   ([us_match_status_txt] in('Similar', '.'))
GO

-- add US
insert into [pbi].[item_cobra_xref_master]
(item)
SELECT Item
FROM     [usd].[BRS_Item] s
where not exists(SELECT * FROM [pbi].[item_cobra_xref_master] where item = s.item)

-- add CA
insert into [pbi].[item_cobra_xref_master]
(item)
SELECT Item
FROM     [dbo].[BRS_Item] s
where not exists(SELECT * FROM [pbi].[item_cobra_xref_master] where item = s.item)

-- test RI

UPDATE  Integration.pbi_item_cobra_xref
SET        us_status_cd = NULL
GO

UPDATE  Integration.pbi_item_cobra_xref
SET        us_status_cd = 0
FROM     Integration.pbi_item_cobra_xref INNER JOIN
             [pbi].[item_cobra_xref_master] s ON Integration.pbi_item_cobra_xref.item = s.Item
GO

select * from Integration.pbi_item_cobra_xref    s
where not exists (select * from [pbi].[item_cobra_xref] m where m.item = s.item )
ORDER BY us_status_cd
GO


--- add new

SELECT   s.item, s.us_item_subst
FROM     pbi.item_cobra_xref RIGHT OUTER JOIN
             Integration.pbi_item_cobra_xref AS s ON pbi.item_cobra_xref.item = s.item AND pbi.item_cobra_xref.item_subst = s.us_item_subst
WHERE pbi.item_cobra_xref.item is null AND
s.item <> s.us_item_subst

INSERT INTO pbi.item_cobra_xref
             (item, item_subst)
SELECT   s.item, s.us_item_subst
FROM     pbi.item_cobra_xref AS item_cobra_xref_1 RIGHT OUTER JOIN
             Integration.pbi_item_cobra_xref AS s ON item_cobra_xref_1.item = s.item AND item_cobra_xref_1.item_subst = s.us_item_subst
WHERE   (item_cobra_xref_1.item IS NULL) AND (s.item <> s.us_item_subst)


-- update where match
UPDATE  
	pbi.item_cobra_xref
SET        
us_item_subst = s.us_item_subst
, us_match_type_cd = s.us_match_type_txt
, us_match_type_brand_txt = s.us_match_type_brand_txt
, us_contents_per_uom_amt = s.us_contents_per_uom_amt
, us_uom_conv_rt = s.us_uom_conv_rt
, us_match_status_cd = s.us_match_status_txt
, us_added_dt = s.us_added_dt
, us_note_txt = s.us_note_txt
, us_status_cd = 0
FROM     pbi.item_cobra_xref INNER JOIN
             Integration.pbi_item_cobra_xref s ON pbi.item_cobra_xref.item = s.item AND pbi.item_cobra_xref.item_subst = s.us_item_subst
GO



select count( * )FROM Integration.pbi_item_cobra_xref

