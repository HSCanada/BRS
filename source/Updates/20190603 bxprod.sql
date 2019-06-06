
INSERT INTO [nes].[bx_role](
	[role_cd],
	[role_descr])
     VALUES
		   ('branchmgr',''),
		   ('project',''),
		   ('digital','')

GO

/*
role_key	role_cd	role_descr	bx_active_ind
1	                              		0
2	design                        		1
3	coord                         		1
4	install                       		1
5	service                       		1
6	operations                    		1
7	finance                       		1
8	salesmgr                      		1
15	branchmgr                     		0
16	project                       		0
17	digital                       		0

*/



INSERT INTO nes.bx_role_branch
                         (Branch, role_key, unique_id)
SELECT        BRS_Branch.Branch, nes.bx_role.role_key, 1 AS unique_id
FROM            BRS_Branch CROSS JOIN
                         nes.bx_role
WHERE        (nes.bx_role.role_key > 8)
ORDER BY BRS_Branch.Branch
go


UPDATE nes.bx_role_branch
SET bx_active_ind = 1
where Branch = 'OTTWA'
go
