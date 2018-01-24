

/****** Object:  DatabaseRole [pricing_role]    Script Date: 23/01/2018 4:06:55 PM ******/
CREATE ROLE [pricing_role]
GO

CREATE USER [CAHSI\CSchormann] FOR LOGIN [CAHSI\CSchormann]
GO

ALTER ROLE [pricing_role] ADD MEMBER [CAHSI\CSchormann]
GO

ALTER ROLE [pricing_role] ADD MEMBER [CAHSI\Lauren.Preston]
GO
ALTER ROLE [pricing_role] ADD MEMBER [CAHSI\TCrowley]
GO


GRANT SELECT ON [dbo].[BRS_ItemBaseHistory] TO [pricing_role]
GO
GRANT SELECT ON [dbo].[BRS_ItemSupplier] TO [pricing_role]
GO
GRANT SELECT ON [dbo].[BRS_ItemMPC] TO [pricing_role]
GO
GRANT SELECT ON [dbo].[BRS_Item] TO [pricing_role]
GO
GRANT SELECT ON [dbo].[BRS_ItemCategory] TO [pricing_role]
GO
GRANT SELECT ON [dbo].[PRO_Item] TO [pricing_role]
GO
