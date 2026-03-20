SELECT
u.name AS 'UserName',
p.permission_name AS 'PermissionName',
o.name AS 'ObjectName'
FROM sys.database_permissions p
JOIN sys.objects o ON p.major_id = o.object_id
JOIN sys.database_principals u ON p.grantee_principal_id = u.principal_id
WHERE p.class = 1
ORDER BY u.name, p.permission_name, o.name