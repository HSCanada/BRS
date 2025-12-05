
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW pbi.item_cobra_xref_review
AS

/******************************************************************************
**	File: 
**	Name: pbi.item_cobra_xref_review
**	Desc: how cobra xref in vertical view
**		
**
**              
**	Return values:  
**
**	Called by:   Access as a sub-query
**             
**	Parameters:
**	Input					Output
**	----------				-----------
**
**	Auth: tmc
**	Date: 21 Mar 25
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:	Author:		Description:
**	-----	----------	--------------------------------------------
--	19 Sep 25	tmc		open list to show all items for review / update
--	25 Nov 25	tmc		cleanup fields to simplify 
*******************************************************************************/



SELECT   
	s.item
	,i.FamilySetLeader
	,s.item_subst
	,s.match_type_cd
	,s.match_status_cd
	,i.MinorProductClass
	,RTRIM(icat.major_desc) + ' | ' + RTRIM(icat.submajor_desc) + ' | ' + RTRIM(icat.minor_desc) product_class_descr
	,i.ItemDescription
	,'' AS Match_yn
	,i.Strength
	,i.Size
	,i.CurrentCorporatePrice
	,i.Excl_Code
	,i.Supplier
	,i.Est12MoSales
	,'' AS Priority

	,ISNULL(s.note_txt, '') AS note_text
--	,s.last_review_dt
	,s.active_ind

	,i.ItemStatus
	,i.SubMinorProductCodec



--	,i.ManufPartNumber

--	,i.size_unit_rate
--	,s.uom_conv_rt


--	,i.Brand


FROM
	pbi.item_cobra_xref AS s 

	LEFT JOIN BRS_Item AS i 
--	INNER JOIN BRS_Item AS i 
	ON s.item = i.Item 

	LEFT JOIN pbi.item_cobra_xref_match_status AS status 
--	INNER JOIN pbi.item_cobra_xref_match_status AS status 
	ON s.match_status_cd = status.match_status_cd 

	LEFT JOIN pbi.item_cobra_xref_match_type AS type 
--	INNER JOIN pbi.item_cobra_xref_match_type AS type 
	ON s.match_type_cd = type.match_type_cd 

	LEFT JOIN BRS_ItemCategory AS icat 
--	INNER JOIN BRS_ItemCategory AS icat 
	ON i.MinorProductClass = icat.MinorProductClass 

WHERE   
--	(m.active_ca_ind = 1) AND 
	-- remove Purged, discontinued items
--	(i.ItemStatus in ('P','D')) AND
	(i.ItemStatus not in ('P','D')) AND

--	(s.item_subst = '') AND
--	(s.item_subst <> '') AND

--	(s.item <> s.item_subst) AND
	(1 = 1)

GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


-- select  top 100 * from pbi.item_cobra_xref_review order by 4,1
-- select  count (*) from pbi.item_cobra_xref_review 

select  top 100 * from pbi.item_cobra_xref_review where item = '5702566' 

-- select  count(*) from pbi.item_cobra_xref_review
