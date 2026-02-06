
-- translate East to West codes

SELECT count (*)
  FROM [dbo].[zzzItem]


SELECT        TOP (10) x.item, x.item_subst, s.Note1 AS item_subst, x.match_status_cd, 'HSB3' as match_type_cd, x.uom_conv_rt, x.active_ind, x.note_txt, id, [us_item_subst]
FROM            zzzItem AS s INNER JOIN
                         pbi.item_cobra_xref AS x ON s.Item = x.item

GO

INSERT INTO pbi.item_cobra_xref
                         (item, item_subst, match_status_cd, match_type_cd, uom_conv_rt, active_ind, note_txt, us_item_subst)
SELECT         x.item, s.Note1 AS item_subst, x.match_status_cd, 'HSB3' AS match_type_cd, x.uom_conv_rt, x.active_ind, x.note_txt, x.id
FROM            zzzItem AS s INNER JOIN
                         pbi.item_cobra_xref AS x ON s.Item = x.item
WHERE 
	 not exists (SELECT * from [pbi].[item_cobra_xref] xx where x.item = xx.item and s.Note1 = x.item_subst) and
--	 x.item in ('1811568') and
	 (1=1)
