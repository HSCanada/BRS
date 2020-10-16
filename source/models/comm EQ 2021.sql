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
--d.HIST_comm_group_cd = 'ITMTEE'

(1=1)

-- update 2019 history
UPDATE       BRS_ItemHistory
SET                HIST_comm_group_cd = s.comm_group_cd
FROM            BRS_ItemHistory INNER JOIN
                         BRS_Item AS s ON BRS_ItemHistory.Item = s.Item AND BRS_ItemHistory.HIST_comm_group_cd <> s.comm_group_cd
WHERE        (BRS_ItemHistory.FiscalMonth >= 201901) AND (BRS_ItemHistory.Item > '') AND (s.comm_group_cd <> '') AND (1 = 1)


-- Teeth
-- add Teeth midline, based on ITMTEE
insert into [comm].[group]
(
	[comm_group_cd]
	,[comm_group_desc]
	,[source_cd]
	,[active_ind]
	,[note_txt]
	,[booking_rt]
	,[show_ind]
	,[sort_id]
	,[comm_group_scorecard_cd]
)
SELECT 'ITMTEM' as [comm_group_cd]
      ,'Teeth, Midline' as [comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,[note_txt]
      ,[booking_rt]
      ,[show_ind]
      ,1031 as [sort_id]
      ,[comm_group_scorecard_cd]
  FROM [comm].[group]
  where comm_group_cd = 'itmtee'
GO

-- add Teeth premium, based on ITMTEE

  insert into [comm].[group]
(
	[comm_group_cd]
	,[comm_group_desc]
	,[source_cd]
	,[active_ind]
	,[note_txt]
	,[booking_rt]
	,[show_ind]
	,[sort_id]
	,[comm_group_scorecard_cd]
)
SELECT 'ITMTEP' as [comm_group_cd]
      ,'Teeth, premium' as [comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,[note_txt]
      ,[booking_rt]
      ,[show_ind]
      ,1032 as [sort_id]
      ,[comm_group_scorecard_cd]
  FROM [comm].[group]
  where comm_group_cd = 'itmtee'
GO

-- add new group
delete from [Integration].[comm_item_Staging]
delete from [Integration].[comm_salesperson_master_Staging]
delete from [Integration].[comm_customer_Staging]

-- this will setup dummy teeth rows as a side-effect
EXEC comm.comm_stage_update_proc @bDebug=0

-- update new group

SELECT
d.comm_plan_id, d.item_comm_group_cd, d.cust_comm_group_cd, d.source_cd, d.disp_comm_group_cd, d.comm_rt, d.active_ind, d.note_txt, d.show_ind
FROM
comm.plan_group_rate AS d 
INNER JOIN comm.plan_group_rate AS s 
ON d.comm_plan_id = s.comm_plan_id AND 
d.cust_comm_group_cd = s.cust_comm_group_cd AND 
d.source_cd = s.source_cd AND 
s.item_comm_group_cd = 'ITMTEE'
WHERE        (d.item_comm_group_cd LIKE 'ITMTE[P M]%')

-- clone teeth params from source ITMTEE
UPDATE
	comm.plan_group_rate
SET
	disp_comm_group_cd = s.disp_comm_group_cd
	, comm_rt = s.comm_rt
	, active_ind = s.active_ind
	, note_txt = 'model2021'
	, show_ind = s.show_ind
FROM
	comm.plan_group_rate 
	INNER JOIN comm.plan_group_rate AS s 
	ON comm.plan_group_rate.comm_plan_id = s.comm_plan_id AND 
	comm.plan_group_rate.cust_comm_group_cd = s.cust_comm_group_cd AND 
	comm.plan_group_rate.source_cd = s.source_cd AND 
	s.item_comm_group_cd = 'ITMTEE'
WHERE
	(comm.plan_group_rate.item_comm_group_cd LIKE 'ITMTE[P M]%')

-- customize display
UPDATE
	comm.plan_group_rate
SET
	disp_comm_group_cd = item_comm_group_cd
FROM
	comm.plan_group_rate 
WHERE
	(comm.plan_group_rate.item_comm_group_cd LIKE 'ITMTE[P M]%')

-- set rates

/*
Line	Current	Plan 2	Plan 3
Focus 1 = Economy	18/21	19%	22%
Focus 2 = Mid-Line	18/21	17%	20%
Focus 3 = Premium	18/21	15%	18%
*/

UPDATE comm.plan_group_rate
SET [comm_rt] = 19
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEE') AND ([comm_plan_id] = 'FSCGP02'   ) AND ([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 17
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEM') AND ([comm_plan_id] = 'FSCGP02'   ) AND ([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 15
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEP') AND ([comm_plan_id] = 'FSCGP02'   ) AND ([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 22
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEE') AND ([comm_plan_id] = 'FSCGP03'   ) AND ([comm_rt] <> 0)
GO
UPDATE comm.plan_group_rate
SET [comm_rt] = 20
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEM') AND ([comm_plan_id] = 'FSCGP03'   ) AND ([comm_rt] <> 0)
GO
UPDATE comm.plan_group_rate
SET [comm_rt] = 18
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEP') AND ([comm_plan_id] = 'FSCGP03'   ) AND ([comm_rt] <> 0)
GO


-- set current items
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMTEE'
WHERE        (Item IN ('1671450', '1672540', '1672583', '1676434', '1676594', '2283013', '2283533', '2284506', '2286569', '2288490', '5441450', '5445743', '5820370', '5821324', '5822060', '5824559', '5828302', '5828531', '5829551', 
                         '5834239', '5835974', '5838393', '5838638', '5838699', '5839986', '5848192', '5848500', '5850813', '5852333', '5855411', '5855412', '5855417', '5855418', '5855419', '5855420', '5855421', '5855422', '5855423', '5855424', 
                         '5855467', '5855468', '5855469', '5855470', '5855471', '5855479', '6528956', '6528959', '8096775', '8099123', '9490170', '9496591', '9496592', '9497429', '9497430', '9497466', '9497467', '9498526', '9498529', '9498881', 
                         '9498887'))
GO

UPDATE       BRS_Item
SET                comm_group_cd = 'ITMTEM'
WHERE        (Item IN ('1670442', '1670444', '1671240', '1671470', '1672460', '1672767', '1674691', '1674692', '1674694', '1674695', '5444501', '5444513', '5445782', '5445859', '5820682', '5821933', '5826383', '5852331', '5852332', 
                         '5855413', '5855425', '5855426', '5855427', '5855445', '5855446', '5855456', '5855457', '5855458', '5855459', '5855460', '5855462', '5855463', '5855472', '5877105', '5877106', '5884362', '5884363', '5884594', '5884775', 
                         '5884999', '5885096', '5885349', '5887135', '5888052', '5888141', '5888923', '5889544', '6650516', '6650517', '6650518', '6650519', '9491245', '9492403', '9497442', '9497443', '9498536', '9498537', '9498897', '9498898'))
GO

UPDATE       BRS_Item
SET                comm_group_cd = 'ITMTEP'
WHERE        (Item IN ('1670114', '1670573', '1670951', '1671001', '1671451', '1671509', '1671510', '1671530', '1671589', '1672239', '1672520', '1672830', '1673962', '1674082', '1674163', '1674326', '1675612', '1675679', '1675969', 
                         '1676701', '1678205', '3334275', '3339436', '5440517', '5445298', '5445723', '5445732', '5445759', '5445791', '5445794', '5445844', '5827294', '5828313', '5831513', '5832110', '5832244', '5832641', '5834987', '5838146', 
                         '5838660', '5839196', '5839792', '5850770', '5850812', '5850814', '5850815', '5850818', '5850819', '5852328', '5852329', '5852334', '5852335', '5852336', '5854180', '5854198', '5854199', '5854201', '5854202', '5854203', 
                         '5855405', '5855406', '5855408', '5855409', '5855410', '5855414', '5855431', '5855434', '5855435', '5855436', '5855437', '5855438', '5855439', '5855440', '5855455', '5855461', '5855464', '5855465', '5855466', '5855475', 
                         '5855476', '5855477', '5857390', '5857391', '5857523', '5857524', '5857525', '5857526', '5872015', '5875329', '5875330', '5875339', '5875341', '5876028', '5877073', '5877114', '5878391', '5878517', '5884566', '5884567', 
                         '5884569', '5884570', '5884832', '5885646', '5886136', '5886364', '5886425', '5888634', '5888822', '5888823', '5888825', '5888899', '5891989', '5892124', '5893704', '5894152', '6522936', '6523685', '6525202', '6528693', 
                         '8091249', '8092069', '9491269', '9491270', '9496968', '9497427', '9498725', '9498726', '9498727', '9498728', '9498733', '9498734', '9498735', '9498736', '9498906'))
GO

-- set history items, run '-- update 2019 history' above
-- re-run calc above & dev model 

