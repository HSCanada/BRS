-- model 2021 EQ changes 

/*
-- recalc model (11m30s)
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

-- recalc model 2020 (5m40s)
print 202001
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202001
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202002
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202002
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202003
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202003
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202004
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202004
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202005
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202005
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202006
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202006
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202007
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202007
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202008
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202008
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202009
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202009
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202010
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202010
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202011
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202011
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print 202012
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202012
Exec comm.transaction_commission_calc_proc @bDebug=0
GO


-- update model from DEV next
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 201912

*/

-- reset
UPDATE
	BRS_Item
SET
	comm_group_cd = s.comm_group_cd, 
	comm_note_txt = s.comm_note_txt
--SELECT 	BRS_Item.comm_group_cd, s.comm_group_cd, BRS_Item.comm_note_txt, s.comm_note_txt
FROM
	BRS_Item 

	INNER JOIN [BRSales].dbo.BRS_Item AS s 
	ON BRS_Item.Item = s.Item
WHERE
	BRS_Item.comm_group_cd <> s.comm_group_cd OR
	BRS_Item.comm_note_txt <> s.comm_note_txt
GO

/*
Focus 1:
Adec
Dentsply Sirona
DCI

Focus 2:
Planmeca/Triangle
Belmont
Midmark
Air Techniques
SciCan
Kavo Kerr Group
MCC

Focus 3:
EVERYTHING ELSE

-No changes to small equipment
-Keep Pelton removed from the analysis


*/

-- test
SELECT BRS_Item.Item, BRS_Item.ItemDescription, [SubMajorProdClass], BRS_Item.Supplier, BRS_Item.SalesCategory, BRS_Item.comm_group_cd, BRS_Item.comm_note_txt, BRS_Item.Est12MoSales
FROM BRS_Item
WHERE 
(Supplier IN (
 'ADEC'
 ,'SIRONC'
 ,'DENTZA'
 ,'DCI'
 ,'DENSCH'
 ,'SIRONG'
 ,'SDSINY'
 
 ,'D4DTEC'
 ,'PLANME'
 ,'TRIAFS'
 ,'BELTAK'
 ,'MIDMAK'
 ,'AIRTEC'
 ,'CAIRTE'
 ,'SCICAN'
 ,'MCC'
 ,'DEXISL'
 ,'GENDEN'
 ,'GENDEX'
 ,'IMASCI'
 ,'KAVOCA'
 ,'KAVODC'
 ,'KAVODG'
 ,'INSTRM'
 ,'PELCRA'
 ,'PELTON'

 
)) AND 
	(comm_group_cd like 'ITMFO%' ) AND
	(SalesCategory <> 'SMEQU') AND
	--
	(comm_group_cd <> 'ITMFO2') AND
	(1=1)
--	(SalesCategory not in('EQUIPM','HITECH','SMEQU')) AND
-- ORDER BY [SubMajorProdClass] desc
--ORDER BY comm_group_cd desc
ORDER BY Est12MoSales desc


-- a) Move Focus 1, less small EQ
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO1', comm_note_txt = 'model2021'
WHERE
(Supplier IN (

 'ADEC'
 ,'SIRONC'
 ,'DENTZA'
 ,'DCI'
 ,'DENSCH'
 ,'SIRONG'
 ,'SDSINY'

)) AND 
	(comm_group_cd in ('ITMFO1', 'ITMFO2', 'ITMFO3') ) AND
	(SalesCategory <> 'SMEQU') AND
	(1=1)
GO

-- b) Move Focus 2, less small EQ
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE
(Supplier IN (
 'D4DTEC'
 ,'PLANME'
 ,'TRIAFS'
 ,'BELTAK'
 ,'MIDMAK'
 ,'AIRTEC'
 ,'CAIRTE'
 ,'SCICAN'
 ,'MCC'
 ,'DEXISL'
 ,'GENDEN'
 ,'GENDEX'
 ,'IMASCI'
 ,'KAVOCA'
 ,'KAVODC'
 ,'KAVODG'
 ,'INSTRM'
 ,'PELCRA'
 ,'PELTON'

)) AND 
	(comm_group_cd in ('ITMFO1', 'ITMFO2', 'ITMFO3') ) AND
	(SalesCategory <> 'SMEQU') AND
	(1=1)
GO

-- b) Move rest to Focus 3, less small EQ
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO3', comm_note_txt = 'model2021'
WHERE
(Supplier NOT IN (
 'ADEC'
 ,'SIRONC'
 ,'DENTZA'
 ,'DCI'
 ,'DENSCH'
 ,'SIRONG'
 ,'SDSINY'
 
 ,'D4DTEC'
 ,'PLANME'
 ,'TRIAFS'
 ,'BELTAK'
 ,'MIDMAK'
 ,'AIRTEC'
 ,'CAIRTE'
 ,'SCICAN'
 ,'MCC'
 ,'DEXISL'
 ,'GENDEN'
 ,'GENDEX'
 ,'IMASCI'
 ,'KAVOCA'
 ,'KAVODC'
 ,'KAVODG'
 ,'INSTRM'
 ,'PELCRA'
 ,'PELTON'

)) AND 
	(comm_group_cd in ('ITMFO1', 'ITMFO2', 'ITMFO3') ) AND
	(SalesCategory <> 'SMEQU') AND
	(1=1)
GO

 
-- update 2019 item history - test
SELECT
 TOP (100) 
d.Item, d.FiscalMonth, d.HIST_comm_group_cd, s.comm_group_cd
FROM            BRS_ItemHistory AS d INNER JOIN
                         BRS_Item AS s ON d.Item = s.Item
WHERE
(d.FiscalMonth >= 201901) AND 
(d.Item > '') AND
(s.comm_group_cd<>'') AND
(s.comm_group_cd <> d.HIST_comm_group_cd) and
--d.HIST_comm_group_cd <> ''
--d.HIST_comm_group_cd = 'ITMTEE'
(1=1)

-- update 2019 item history
UPDATE       BRS_ItemHistory
SET                HIST_comm_group_cd = s.comm_group_cd
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item AS s ON BRS_ItemHistory.Item = s.Item AND BRS_ItemHistory.HIST_comm_group_cd <> s.comm_group_cd
WHERE        (BRS_ItemHistory.FiscalMonth >= 201901) AND (BRS_ItemHistory.Item > '') AND (s.comm_group_cd <> '') AND (1 = 1)
GO

-- set rates, WIP as of 14 Dec 20

-- part promtion logic
UPDATE
	BRS_Config
SET
	comm_partprom_supplier = 'PELTON', 
	comm_partprom_group_focus_cd = 'ITMFO2',
	comm_partprom_group_cd = 'ITMFO2'
GO

/*
-- EQ Plan 2 rates - NEW
UPDATE comm.plan_group_rate
SET [comm_rt] = 19
	,[note_txt]='model2021'
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'FSCGP02'   ) AND ([disp_comm_group_cd] = 'ITMFO1') AND 
([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 13
	,[note_txt]='model2021'
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'FSCGP02'   ) AND ([disp_comm_group_cd] = 'SPMFO1') AND 
([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 14
	,[note_txt]='model2021'
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'FSCGP02'   ) AND ([disp_comm_group_cd] = 'ITMFO2') AND 
([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 8
	,[note_txt]='model2021'
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'FSCGP02'   ) AND ([disp_comm_group_cd] = 'SPMFO2') AND 
([comm_rt] <> 0)
GO

-- EQ Plan 3 rates - NEW
UPDATE comm.plan_group_rate
SET [comm_rt] = 22
	,[note_txt]='model2021'
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'FSCGP03'   ) AND ([disp_comm_group_cd] = 'ITMFO1') AND 
([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 16
	,[note_txt]='model2021'
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'FSCGP03'   ) AND ([disp_comm_group_cd] = 'SPMFO1') AND 
([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 17
	,[note_txt]='model2021'
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'FSCGP03'   ) AND ([disp_comm_group_cd] = 'ITMFO2') AND 
([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 11
	,[note_txt]='model2021'
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'FSCGP03'   ) AND ([disp_comm_group_cd] = 'SPMFO2') AND 
([comm_rt] <> 0)
GO
*/
