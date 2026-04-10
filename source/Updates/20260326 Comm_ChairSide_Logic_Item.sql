-- Comm_ChairSide_Logic_Item, tmc, 23 Mar 26

BEGIN TRANSACTION
GO
ALTER TABLE dbo.BRS_ItemMPC ADD
	comm_css_include_ind bit NOT NULL CONSTRAINT DF_BRS_ItemMPC_comm_css_include_ind DEFAULT 0
GO
ALTER TABLE dbo.BRS_ItemMPC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE hfm.exclusive_product ADD
	comm_css_include_ind bit NOT NULL CONSTRAINT DF_exclusive_product_comm_css_include_ind DEFAULT 0
GO
ALTER TABLE hfm.exclusive_product SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


UPDATE dbo.BRS_ItemMPC 
SET comm_css_include_ind = 1
WHERE [MajorProductClass] in (
'001'
,'002'
,'003'
,'004'
,'005'
,'006'
,'008'
,'011'
,'012'
,'013'
,'014'
,'017'
,'018'
,'019'
,'020'
,'021'
,'022'
,'023'
,'024'
,'025'
,'029'
,'038'
,'045'
,'050'
,'054'
,'057'
,'058'
,'073'
,'081'
,'082'
,'083'
,'084'
)


UPDATE hfm.exclusive_product
set comm_css_include_ind = 1
WHERE 
[Excl_Code] in ('CARINA', 'CLINICIANS_CHOICE', 'CORPORATE_BRAND', 'ESSENTIALS_HEALTH', 'HPHQ', 'MICROCOPY', 'ORTHO_TECHNOLOGIES')
GO



-- review codes

SELECT        i.Item, i.ItemDescription, i.SalesCategory, i.Supplier, i.label, i.comm_bonus2_cd, mpc.comm_css_include_ind, excl.comm_css_include_ind AS Expr1, excl.Excl_Code, mpc.MajorProductClass, mpc.MajorProductClassDesc, i.comm_group_eps_cd
FROM            BRS_Item AS i INNER JOIN
                         BRS_ItemMPC AS mpc ON i.MajorProductClass = mpc.MajorProductClass INNER JOIN
                         hfm.exclusive_product AS excl ON i.Excl_Code = excl.Excl_Code
WHERE
	i.SalesCategory in ('MERCH', 'SMEQU') AND
	((mpc.comm_css_include_ind = 1) AND (excl.comm_css_include_ind = 1)) AND
	(excl.Excl_Code = 'CLINICIANS_CHOICE') AND
	 (mpc.MajorProductClass = '021') AND
	(excl.Excl_Code = 'CORPORATE_BRAND') AND
	(1=1)
ORDER BY i.Excl_Code, i.MajorProductClass

UPDATE
	BRS_Item
SET
	comm_bonus2_cd = null


UPDATE
	BRS_Item
SET
	comm_bonus2_cd = 'EPSCRD'
FROM
	BRS_Item 
	
	INNER JOIN BRS_ItemMPC AS mpc 
	ON BRS_Item.MajorProductClass = mpc.MajorProductClass 
	
	INNER JOIN hfm.exclusive_product AS excl 
	ON BRS_Item.Excl_Code = excl.Excl_Code

WHERE 
	(BRS_Item.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	(mpc.comm_css_include_ind = 1) AND (excl.comm_css_include_ind = 1) AND 
	(excl.Excl_Code = 'CLINICIANS_CHOICE') AND
	(1 = 1)

UPDATE
	BRS_Item
SET
	comm_bonus2_cd = 'EPSPRI'
FROM
	BRS_Item 
	
	INNER JOIN BRS_ItemMPC AS mpc 
	ON BRS_Item.MajorProductClass = mpc.MajorProductClass 
	
	INNER JOIN hfm.exclusive_product AS excl 
	ON BRS_Item.Excl_Code = excl.Excl_Code

WHERE 
	(BRS_Item.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	(mpc.comm_css_include_ind = 1) AND (excl.comm_css_include_ind = 1) AND 
	not (excl.Excl_Code = 'CLINICIANS_CHOICE') AND
	(mpc.MajorProductClass = '021') AND
	(1 = 1)

UPDATE
	BRS_Item
SET
	comm_bonus2_cd = 'EPSPRI'
FROM
	BRS_Item 
	
	INNER JOIN BRS_ItemMPC AS mpc 
	ON BRS_Item.MajorProductClass = mpc.MajorProductClass 
	
	INNER JOIN hfm.exclusive_product AS excl 
	ON BRS_Item.Excl_Code = excl.Excl_Code

WHERE 
	(BRS_Item.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	(BRS_Item.comm_group_eps_cd = 'EPSPRI') and
	(1 = 1)


UPDATE
	BRS_Item
SET
	comm_bonus2_cd = 'ITMPVT'
FROM
	BRS_Item 
	
	INNER JOIN BRS_ItemMPC AS mpc 
	ON BRS_Item.MajorProductClass = mpc.MajorProductClass 
	
	INNER JOIN hfm.exclusive_product AS excl 
	ON BRS_Item.Excl_Code = excl.Excl_Code

WHERE 
	(BRS_Item.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	(mpc.comm_css_include_ind = 1) AND (excl.comm_css_include_ind = 1) AND 
	not (excl.Excl_Code = 'CLINICIANS_CHOICE') AND
	not (mpc.MajorProductClass = '021') AND
	(1 = 1)


UPDATE
	BRS_Item
SET
	comm_bonus2_cd = 'ITMSND'
-- select BRS_Item.comm_bonus2_cd
FROM
	BRS_Item 
	
	INNER JOIN BRS_ItemMPC AS mpc 
	ON BRS_Item.MajorProductClass = mpc.MajorProductClass 
	
	INNER JOIN hfm.exclusive_product AS excl 
	ON BRS_Item.Excl_Code = excl.Excl_Code

WHERE 
	(BRS_Item.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	not (mpc.comm_css_include_ind = 1) AND (excl.comm_css_include_ind = 1) AND 
	not (excl.Excl_Code = 'CLINICIANS_CHOICE') AND
	not (mpc.MajorProductClass = '021') AND
	(1 = 1)


UPDATE
	BRS_Item
SET
	comm_bonus2_cd = 'ITMSND'
-- select BRS_Item.comm_bonus2_cd
FROM
	BRS_Item 
	
	INNER JOIN BRS_ItemMPC AS mpc 
	ON BRS_Item.MajorProductClass = mpc.MajorProductClass 
	
	INNER JOIN hfm.exclusive_product AS excl 
	ON BRS_Item.Excl_Code = excl.Excl_Code

WHERE 
	(BRS_Item.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	(ISNULL(BRS_Item.comm_bonus2_cd, '')) = '' AND
	(1 = 1)

-- wound care fix
UPDATE
	BRS_Item
SET
	comm_bonus2_cd = 'ITMPVT'
FROM
	BRS_Item 
	
	INNER JOIN BRS_ItemMPC AS mpc 
	ON BRS_Item.MajorProductClass = mpc.MajorProductClass 
	
	INNER JOIN hfm.exclusive_product AS excl 
	ON BRS_Item.Excl_Code = excl.Excl_Code

WHERE 
	(BRS_Item.SalesCategory IN ('MERCH', 'SMEQU')) AND 
	mpc.MajorProductClass = '124' and
	BRS_Item.Brand in ('CRITON', 'ESSHEA') and
	(1 = 1)



-- fix Jen burrs
-- fix wound care
--	i.comm_group_eps_cd = 'EPSPRI' AND


/*
Jess	Products		Willen overlap	
2		CCI				yes	25%
3		Burrs			yes	25%
1		HS Brand		yes	25%
4		Merch & Small EQ	25%

	total (1-3)		
*/


SELECT        i.Item, i.ItemDescription, i.SalesCategory, i.Supplier, i.brand, i.label, i.comm_bonus2_cd, mpc.comm_css_include_ind as mpc_incl, excl.comm_css_include_ind AS excl_incl, excl.Excl_Code, mpc.MajorProductClass, mpc.MajorProductClassDesc, i.comm_group_eps_cd, i.Est12MoSales
FROM            BRS_Item AS i INNER JOIN
                         BRS_ItemMPC AS mpc ON i.MajorProductClass = mpc.MajorProductClass INNER JOIN
                         hfm.exclusive_product AS excl ON i.Excl_Code = excl.Excl_Code
WHERE
	i.SalesCategory in ('MERCH', 'SMEQU') AND
--	mpc.MajorProductClass = '124' and
--	i.Brand in ('CRITON', 'ESSHEA') and

--	(ISNULL(i.comm_bonus2_cd, '')) = '' AND
--	i.comm_group_eps_cd = 'EPSPRI' and

	-- not ((mpc.comm_css_include_ind = 1) AND (excl.comm_css_include_ind = 1)) AND

--	(excl.Excl_Code = 'CLINICIANS_CHOICE') AND
	 --(mpc.MajorProductClass = '021') AND
--	(excl.Excl_Code = 'CORPORATE_BRAND') AND
	(1=1)
ORDER BY i.Excl_Code, i.MajorProductClass

