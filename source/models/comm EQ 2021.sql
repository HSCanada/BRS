-- model 2021 EQ changes 

/*
-- recalc model (4m25s)
print 201901
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201901
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201902
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201902
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201903
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201903
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201904
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201904
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201905
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201905
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201906
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201906
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201907
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201907
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201908
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201908
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201909
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201909
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201910
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201910
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201911
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201911
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 201912
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201912
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
-- update model from DEV next
*/

-- 3. Vendor Focus Levels:

-- test
SELECT BRS_Item.Item, BRS_Item.ItemDescription, [SubMajorProdClass], BRS_Item.Supplier, BRS_Item.SalesCategory, BRS_Item.comm_group_cd, BRS_Item.comm_note_txt, BRS_Item.Est12MoSales
FROM BRS_Item
WHERE 
--(BRS_Item.Supplier = 'MIDMAK')  AND 
(Supplier IN ('MCC', 'MCCCAB')) AND (comm_group_cd NOT IN ('ITMFO2', 'ITMEQ0', 'ITMPAR','ITMSND','DIGIMP','ITMSOF'))
--(SalesCategory not in('EQUIPM','HITECH','SMEQU')) AND
-- ORDER BY [SubMajorProdClass] desc
ORDER BY comm_group_cd desc
--ORDER BY Est12MoSales desc


-- a) Move MCC to Focus 2
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE        (Supplier IN ('MCC', 'MCCCAB')) AND (comm_group_cd NOT IN ('ITMFO2', 'ITMEQ0', 'ITMPAR','ITMSND','DIGIMP','ITMSOF'))
GO

-- b) Move Kavo to Focus 2
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE        (BRS_Item.Supplier in ('DEXISL', 'GENDEN', 'GENDEX', 'IMASCI', 'KAVOCA', 'KAVODC', 'KAVODG', 'INSTRM', 'PELCRA', 'PELTON')) AND (comm_group_cd NOT IN ('ITMFO2', 'ITMEQ0', 'ITMPAR','ITMSND','DIGIMP','ITMSOF', 'ITMCAM', 'ITMSER', 'ITMCPU',''))
GO


-- c) Midmark to Focus 2
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE        (BRS_Item.Supplier = 'MIDMAK') AND (comm_group_cd NOT IN ('ITMFO2', 'ITMEQ0', 'ITMPAR','ITMSND','DIGIMP','ITMSOF','ITMSER',''))
GO

-- d) Eliminate Special category for iCAT. Now Pay  Focus 2
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE        
((BRS_Item.comm_group_cd) in ('ITMISC'))
GO

-- e) Re-swirl focus 3 category to include all Traditional: 
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO3', comm_note_txt = 'model2021'
WHERE        
((BRS_Item.comm_group_cd) not in ('ITMFO3', 'ITMEQ0')) AND [SubMajorProdClass] in('800-01', '800-12', '800-14', '800-30', '800-32')
GO

-- e2) Re-swirl focus 2 category to include all NON Traditional: 
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE        
((BRS_Item.comm_group_cd) in ('ITMFO3')) AND [SubMajorProdClass] not in('800-01', '800-12', '800-14', '800-30', '800-32')
GO


-- update 2019 history
SELECT
-- TOP (100) 
d.Item, d.FiscalMonth, d.HIST_comm_group_cd, s.comm_group_cd, d.HIST_comm_group_cd
FROM            BRS_ItemHistory AS d INNER JOIN
                         BRS_Item AS s ON d.Item = s.Item
WHERE
(d.FiscalMonth >= 201901) AND 
(d.Item > '') AND
(s.comm_group_cd<>'') AND
(s.comm_group_cd <> d.HIST_comm_group_cd) and
--d.HIST_comm_group_cd <> ''
(1=1)

-- update 2019 history
UPDATE       BRS_ItemHistory
SET                HIST_comm_group_cd = s.comm_group_cd
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item AS s ON BRS_ItemHistory.Item = s.Item AND BRS_ItemHistory.HIST_comm_group_cd <> s.comm_group_cd
WHERE        (BRS_ItemHistory.FiscalMonth >= 201901) AND (BRS_ItemHistory.Item > '') AND (s.comm_group_cd <> '') AND (1 = 1)




