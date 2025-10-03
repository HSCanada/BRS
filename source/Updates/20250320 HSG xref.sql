-- HSG xref, tmc, 20 Mar 25

/*

-- update CAD item sales
SELECT   TOP (1000) zzzItem2.zzzItem, zzzItem2.val1, BRS_Item.Est12MoSales
FROM     zzzItem2 INNER JOIN
             BRS_Item ON zzzItem2.zzzItem = BRS_Item.Item

update BRS_Item set Est12MoSales = 0 where Est12MoSales <> 0


UPDATE  BRS_Item
SET        Est12MoSales = val1
FROM     zzzItem2 INNER JOIN
             BRS_Item ON zzzItem2.zzzItem = BRS_Item.Item
*/

BEGIN TRANSACTION
GO
CREATE TABLE pbi.item_cobra_xref
	(
	item char(10) NOT NULL,
	item_subst char(10) NOT NULL,
	match_status_cd char(4) NOT NULL,

	match_type_cd char(4) NOT NULL,
	uom_conv_rt float(53) NOT NULL,
	active_ind bit NOT NULL,
	note_txt nchar(50) NULL,
	id int NOT NULL IDENTITY (1, 1),
	last_review_dt date NULL,
	exclude_ind bit NOT NULL
	)  ON USERDATA
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	DF_item_cobra_xref_match_status_cd DEFAULT '' FOR match_status_cd
GO

ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	DF_item_cobra_xref_match_type_cd DEFAULT '' FOR match_type_cd
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	DF_item_cobra_xref_uom_conv_rt DEFAULT 0 FOR uom_conv_rt
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	DF_item_cobra_xref_active_ind DEFAULT 0 FOR active_ind
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	DF_item_cobra_xref_exclude_ind DEFAULT 0 FOR exclude_ind
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	item_cobra_xref_c_pk PRIMARY KEY CLUSTERED 
	(
	item,
	item_subst
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE pbi.item_cobra_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX item_cobra_xref_u_idx_1 ON pbi.item_cobra_xref
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE pbi.item_cobra_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


--
BEGIN TRANSACTION
GO
CREATE TABLE pbi.item_cobra_xref_match_type
	(
	match_type_cd char(4) NOT NULL,
	match_type_nm nchar(50) NOT NULL,
	active_ind bit NOT NULL,
	)  ON USERDATA
GO

ALTER TABLE pbi.item_cobra_xref_match_type ADD CONSTRAINT
	item_cobra_xref_match_type_c_pk PRIMARY KEY CLUSTERED 
	(
	match_type_cd
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE pbi.item_cobra_xref_match_type SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- populate

INSERT INTO [pbi].[item_cobra_xref_match_type]
           ([match_type_cd]
           ,[match_type_nm]
           ,[active_ind])
     VALUES
           (''
           ,'Branded'
           ,0)
GO

INSERT INTO [pbi].[item_cobra_xref_match_type]
           ([match_type_cd]
           ,[match_type_nm]
           ,[active_ind])
     VALUES
           ('HSB1'
           ,'HS Brand match 1'
           ,1)
GO

INSERT INTO [pbi].[item_cobra_xref_match_type]
           ([match_type_cd]
           ,[match_type_nm]
           ,[active_ind])
     VALUES
           ('HSB2'
           ,'HS Brand match 2'
           ,1)
GO

INSERT INTO [pbi].[item_cobra_xref_match_type]
           ([match_type_cd]
           ,[match_type_nm]
           ,[active_ind])
     VALUES
           ('OWN1'
           ,'HS Owned match 1'
           ,1)
GO

INSERT INTO [pbi].[item_cobra_xref_match_type]
           ([match_type_cd]
           ,[match_type_nm]
           ,[active_ind])
     VALUES
           ('OWN2'
           ,'HS Owned match 2'
           ,1)
GO

INSERT INTO [pbi].[item_cobra_xref_match_type]
           ([match_type_cd]
           ,[match_type_nm]
           ,[active_ind])
     VALUES
           ('EDLP'
           ,'Essentials Brand match (Dental only)'
           ,1)
GO


INSERT INTO [pbi].[item_cobra_xref_match_type]
           ([match_type_cd]
           ,[match_type_nm]
           ,[active_ind])
     VALUES
           ('EDLP'
           ,'Essentials Brand match (Dental only)'
           ,1)
GO


--
BEGIN TRANSACTION
GO
CREATE TABLE pbi.item_cobra_xref_match_status
	(
	match_status_cd char(4) NOT NULL,
	[match_status_nm] nchar(50) NOT NULL,
	active_ind bit NOT NULL,

	)  ON USERDATA
GO

ALTER TABLE pbi.item_cobra_xref_match_status ADD CONSTRAINT
	item_cobra_xref_match_status_c_pk PRIMARY KEY CLUSTERED 
	(
	match_status_cd
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
ALTER TABLE pbi.item_cobra_xref_match_status SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- pop

INSERT INTO [pbi].[item_cobra_xref_match_status]
           ([match_status_cd]
           ,[match_status_nm]
		   ,active_ind)
     VALUES
           (''
           ,'Unmatched'
		   ,0)
GO

INSERT INTO [pbi].[item_cobra_xref_match_status]
           ([match_status_cd]
           ,[match_status_nm]
		   ,active_ind)
     VALUES
           ('1EXA'
           ,'Exact'
		   ,1)
GO

INSERT INTO [pbi].[item_cobra_xref_match_status]
           ([match_status_cd]
           ,[match_status_nm]
		   ,active_ind)
     VALUES
           ('2EQU'
           ,'Equivalent'
		   ,1)
GO

INSERT INTO [pbi].[item_cobra_xref_match_status]
           ([match_status_cd]
           ,[match_status_nm]
		   ,active_ind)
     VALUES
           ('3SIM'
           ,'Similar'
		   ,0)
GO

INSERT INTO [pbi].[item_cobra_xref_match_status]
           ([match_status_cd]
           ,[match_status_nm]
		   ,active_ind)
     VALUES
           ('4NOT'
           ,'No Match'
		   ,0)
GO

-- RI
BEGIN TRANSACTION
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	FK_item_cobra_xref_item_cobra_xref_match_status FOREIGN KEY
	(
	match_status_cd
	) REFERENCES pbi.item_cobra_xref_match_status
	(
	match_status_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	FK_item_cobra_xref_item_cobra_xref_match_type FOREIGN KEY
	(
	match_type_cd
	) REFERENCES pbi.item_cobra_xref_match_type
	(
	match_type_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE pbi.item_cobra_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--

BEGIN TRANSACTION
GO
CREATE TABLE pbi.item_cobra_xref_master
	(
	item char(10) NOT NULL,
	id int NOT NULL IDENTITY (1, 1),
	active_ca_ind bit NOT NULL DEFAULT 0,
	active_us_ind bit NOT NULL DEFAULT 0

	)  ON USERDATA
GO
COMMIT


-- item master for RI

BEGIN TRANSACTION
GO
ALTER TABLE pbi.item_cobra_xref_master ADD CONSTRAINT
	item_cobra_xref_master_c_pk PRIMARY KEY CLUSTERED 
	(
	item
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA

GO
CREATE UNIQUE NONCLUSTERED INDEX item_cobra_xref_master_u_idx ON pbi.item_cobra_xref_master
	(
	id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE pbi.item_cobra_xref_master SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

INSERT INTO [pbi].item_cobra_xref_master
           ([item])
     VALUES
           ('')
GO

-- ri2

BEGIN TRANSACTION
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	FK_item_cobra_xref_item_cobra_xref_master FOREIGN KEY
	(
	item
	) REFERENCES pbi.item_cobra_xref_master
	(
	item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE pbi.item_cobra_xref ADD CONSTRAINT
	FK_item_cobra_xref_item_cobra_xref_master1 FOREIGN KEY
	(
	item_subst
	) REFERENCES pbi.item_cobra_xref_master
	(
	item
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE pbi.item_cobra_xref SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


-- pop


SELECT distinct [Note1]
  FROM [dbo].[zzzItem]
 union 
select distinct Item
  FROM [dbo].[zzzItem]
GO


--> cobra2 adhoc accesss load -- START
truncate table [dbo].[zzzItem]
GO

insert into [pbi].[item_cobra_xref_master]
(item)
select  * from (SELECT DISTINCT Note1 AS item
FROM     zzzItem
UNION
SELECT DISTINCT Item
FROM     zzzItem AS zzzItem_1 ) as s
where not exists(SELECT * FROM [pbi].[item_cobra_xref_master] where item = s.item)

--< cobra2 adhoc accesss load
--


UPDATE  pbi.item_cobra_xref_master
SET        active_ca_ind = 0
where active_ca_ind = 1



UPDATE  pbi.item_cobra_xref_master
SET        active_ca_ind = 1
FROM     pbi.item_cobra_xref_master INNER JOIN
             pbi.item_cobra_xref AS ref ON pbi.item_cobra_xref_master.item = ref.item
WHERE   (ref.item_subst = '9007437') OR
             (ref.item = '9007437')

GO



SELECT   TOP (30) pbi.item_cobra_xref.item, pbi.item_cobra_xref.item_subst, pbi.item_cobra_xref.match_status_cd, pbi.item_cobra_xref.match_type_cd, BRS_Item.ItemDescription, BRS_Item.Supplier, BRS_Item.Size, BRS_Item.Strength, BRS_Item_1.ItemDescription AS Expr1, BRS_Item_1.Supplier AS Expr2, BRS_Item_1.Size AS Expr3, 
             BRS_Item_1.Strength AS Expr4
FROM     pbi.item_cobra_xref INNER JOIN
             BRS_Item ON pbi.item_cobra_xref.item = BRS_Item.Item INNER JOIN
             BRS_Item AS BRS_Item_1 ON pbi.item_cobra_xref.item_subst = BRS_Item_1.Item
where item_subst = '9007437   '
order by 3

SELECT   TOP (100) pbi.item_cobra_xref.item_subst, match_type_cd, COUNT(pbi.item_cobra_xref.item) AS Expr1
FROM     pbi.item_cobra_xref INNER JOIN
             BRS_Item ON pbi.item_cobra_xref.item = BRS_Item.Item INNER JOIN
             BRS_Item AS BRS_Item_1 ON pbi.item_cobra_xref.item_subst = BRS_Item_1.Item
GROUP BY pbi.item_cobra_xref.item_subst, match_type_cd
having count(*) > 10
order by 1 desc


--

INSERT INTO [pbi].[item_cobra_xref_match_type]
           ([match_type_cd]
           ,[match_type_nm]
           ,[active_ind])
     VALUES
           ('AAAA'
           ,'Substitution Match'
           ,1)
GO


select * from [pbi].[item_cobra_xref] where [item] in ('1014229', '1126994', '9007437')

truncate table zzzItem

INSERT INTO [pbi].[item_cobra_xref]
           ([item]
           ,[item_subst]
           ,[match_status_cd]
		   ,[match_type_cd])

INSERT INTO zzzItem
([Item], [Note1], [Note2], [Note3])
SELECT distinct [item_subst], [item_subst], '', 'AAAA'  FROM [pbi].[item_cobra_xref] 


--
