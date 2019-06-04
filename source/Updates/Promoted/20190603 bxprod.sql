INSERT INTO [nes].[bx_role](
	[role_cd],
	[role_descr])
     VALUES
           ('design', ''),
           ('coord', ''),
           ('install', ''),
		   ('service',''),
		   ('operations',''),
		   ('finance','')

GO


INSERT INTO nes.bx_role_branch
                         (Branch, role_key, unique_id)
SELECT        BRS_Branch.Branch, nes.bx_role.role_key, 1 AS unique_id
FROM            BRS_Branch CROSS JOIN
                         nes.bx_role
WHERE        (nes.bx_role.role_key > 1)
ORDER BY BRS_Branch.Branch
go


UPDATE nes.bx_role_branch
SET bx_active_ind = 1
where Branch = 'OTTWA'
go
