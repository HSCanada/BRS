
-- keep full script from being run
print 'hi'
go
raiserror('Oh no a fatal error', 20, -1) with log
go
print 'ho, no go!'


-- update master with new codes

truncate table zzzItem2

INSERT INTO zzzItem2 
([zzzItem], [val1])
SELECT        Item, SUM(NetSalesAmt) AS sales
FROM            BRS_TransactionDW
WHERE        (CalMonth BETWEEN 202503 AND 202602)
GROUP BY Item


UPDATE        [dbo].[BRS_Item]
SET                [Est12MoSales] = 0

UPDATE        [dbo].[BRS_Item]
SET                Est12MoSales = [val1]
FROM            [dbo].[BRS_Item] INNER JOIN
                         zzzItem2 ON [dbo].[BRS_Item].Item = [dbo].[zzzItem2].[zzzItem]


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

-- add CA Branded
-- 1. apple -> apple
-- 2. apple -> Grape
-- 3. apple -> nothing

-- Stock / Non-Stock and 1k sales

-- add match candidates

-- 
--- add new US



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


-- add new CA




-- translate East to West codes

SELECT count (*)
  FROM [dbo].[zzzItem]


INSERT INTO pbi.item_cobra_xref
                         (item, item_subst, match_status_cd, match_type_cd, note_txt)
SELECT
-- TOP (10)
item, item AS item_subst, '' AS match_status_cd, 'AAAA' as match_type_cd, 'TC20260326' AS note_txt
FROM            [dbo].[BRS_Item] i
WHERE
    (
        ((SalesCategory) IN ('SMEQU', 'MERCH')) AND 
		((ItemStatus) = 'A') AND 
		(Excl_Code <> 'BRANDED' OR i.comm_group_eps_cd  = 'EPSPRI') AND 
        ((Est12MoSales) >= 1000) AND
		(not exists (select * from [pbi].[item_cobra_xref] m where m.item = i.item and m.item = m.item_subst ))  and
		(1=1)
    )
GO

INSERT INTO pbi.item_cobra_xref
                         (item, item_subst, match_status_cd, match_type_cd, note_txt)
SELECT
 -- TOP (10)
item, '' AS item_subst, '' AS match_status_cd, 'HSB3' as match_type_cd, 'TC20260326' AS note_txt
FROM            [dbo].[BRS_Item] i
WHERE
    (
        ((SalesCategory) IN ('SMEQU', 'MERCH')) AND 
		((ItemStatus) = 'A') AND 
		((Excl_Code) = 'BRANDED') AND 
		(i.StockingType = 'S') AND
		-- avoid jet burrs
		(i.comm_group_eps_cd <> 'EPSPRI') and
--        ((Est12MoSales) < 1000) AND
		(not exists (select * from [pbi].[item_cobra_xref] m where m.item = i.item  ))  and
		(1=1)
    )
GO


