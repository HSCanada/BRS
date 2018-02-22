-- Zirlux work-around for Vendor rebates, tmc, 15 Feb 18

insert into [dbo].[BRS_ItemSupplier] ([Supplier]) values ('HSCZIR')

insert into [dbo].[BRS_ItemSupplierFamily] ([SupplierFamily]) values ('HSCZIR')

update [dbo].[BRS_ItemSupplier] 
set [SupplierFamily] = 'HSCZIR', [RebateRollup] = 'Zirlux', [supplier_nm] = 'Fake Zirlux vendor for rebate'
where [Supplier] = 'HSCZIR'


select * from [dbo].[BRS_ItemSupplier] where [Supplier] = 'HSCZIR'

-- Change historical

UPDATE       BRS_ItemHistory
SET                Supplier = 'HSCZIR'
WHERE        (Supplier = 'HENSCH') AND (MinorProductClass = '372-02-10')

