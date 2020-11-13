-- model 2021 EQ changes 

/*
-- recalc model (5m40s)
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
	BRS_Item.comm_group_cd <> s.comm_group_cd


-- test
SELECT BRS_Item.Item, BRS_Item.ItemDescription, [SubMajorProdClass], BRS_Item.Supplier, BRS_Item.SalesCategory, BRS_Item.comm_group_cd, BRS_Item.comm_note_txt, BRS_Item.Est12MoSales
FROM BRS_Item
WHERE 
--(BRS_Item.Supplier = 'MIDMAK')  AND 
(Supplier IN (
'ADEC'
 ,'SIRONC'
 ,'DENTZA'
 ,'MIDMAK'
 ,'SCICAN'
 ,'CAIRTE'
 ,'BELTAK'
 ,'DCI'
 ,'MCC'
 ,'DENSCH'
 ,'BAINTE'
 ,'TRIAFS'
 ,'AIRTEC'
 ,'SIRONG'
 ,'SDSINY'
 ,'D4DTEC'
 ,'PLANME'
)) AND 
(comm_group_cd like 'ITMF%' )
--(SalesCategory not in('EQUIPM','HITECH','SMEQU')) AND
-- ORDER BY [SubMajorProdClass] desc
ORDER BY comm_group_cd desc
--ORDER BY Est12MoSales desc

 
-- a) Move Focus 1
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO1', comm_note_txt = 'model2021'
WHERE
(Supplier IN (
'ADEC'
 ,'SIRONC'
 ,'DENTZA'
 ,'MIDMAK'
 ,'SCICAN'
 ,'CAIRTE'
 -- remove belmont as per Bill, 26 Oct 20
 --,'BELTAK'
  ,'DCI'
 ,'MCC'
 ,'DENSCH'
 ,'BAINTE'
 ,'TRIAFS'
 ,'AIRTEC'
 ,'SIRONG'
 ,'SDSINY'
	-- add to Foc1 as per Prashant, 2 Nov 20
 ,'D4DTEC'
 ,'PLANME'

)) AND 
(comm_group_cd like 'ITMF%' )
GO

-- b) Move Focus 2
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE
(Supplier not IN (
'ADEC'
 ,'SIRONC'
 ,'DENTZA'
 ,'MIDMAK'
 ,'SCICAN'
 ,'CAIRTE'
 -- remove belmont as per Bill, 26 Oct 20
 -- ,'BELTAK'
 ,'DCI'
 ,'MCC'
 ,'DENSCH'
 ,'BAINTE'
 ,'TRIAFS'
 ,'AIRTEC'
 ,'SIRONG'
 ,'SDSINY'
	-- add to Foc1 as per Prashant, 2 Nov 20
 ,'D4DTEC'
 ,'PLANME'
)) AND 
(comm_group_cd like 'ITMF%' )
GO

-- c) Move Focus 3->2
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE
(comm_group_cd = 'ITMFO3' )
GO

 /*
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
*/
/*
-- d) Eliminate Special category for iCAT. Now Pay  Focus 2
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMFO2', comm_note_txt = 'model2021'
WHERE        
((BRS_Item.comm_group_cd) in ('ITMISC'))
GO

-- undo this
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMISC', comm_note_txt = 'model2021'
WHERE        (Item IN ('1706373', '5821024', '5832408', '5832853', '5843698', '5890026', '5890479', '5822083', '5822136', '5822137', '5822239', '5822625', '5830822', '5836683', '5844888', '5845613', '5845660', '5849520', '5849988', 
                         '5892981', '5893514', '5893540', '7179624', '7211745', '7219579', '8117559', '8221338', '5810871', '5810872', '5825594', '5826534', '5826921', '5833854', '5833961', '5834754', '5839211', '5839521', '5839624', '5871301', 
                         '5891982', '5892169', '8113194', '8115910', '8116271', '9390136', '5505483', '5827327', '5827441', '5828019', '5828474', '5828655', '5839660', '5839981', '5894695', '5894888', '5895241', '5895859', '7730112', '7730113', 
                         '7730114', '7730115', '7730117', '7730331', '7730376', '7730965', '7732583', '7733511', '7735669', '7736018', '7737242', '7737354', '7738983', '7739169', '5813684', '5814522', '5814523', '5823989', '5824688', '5825378', 
                         '5835331', '5835639', '5835710', '5846647', '5847250', '5889268', '5889280', '5889281', '5889390', '5889571', '7170374', '7172928', '7174109', '9399427', '1358735', '5774836', '5828957', '5828975', '5896146', '5896169', 
                         '5897379'))
GO
*/

/*
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
*/

-- update 2019 history
SELECT
-- TOP (100) 
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

UPDATE       comm.[group]
SET                comm_group_desc = 'Teeth, economy'
WHERE        (comm_group_cd = 'itmtee')
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

--were looking at 18/21%, 17/20% & 16/19% for focus 1-3 respectively

UPDATE comm.plan_group_rate
SET [comm_rt] = 18
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEP') AND ([comm_plan_id] = 'FSCGP02'   ) AND ([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 21
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEP') AND ([comm_plan_id] = 'FSCGP03'   ) AND ([comm_rt] <> 0)
GO


UPDATE comm.plan_group_rate
SET [comm_rt] = 17
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEM') AND ([comm_plan_id] = 'FSCGP02'   ) AND ([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 20
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEM') AND ([comm_plan_id] = 'FSCGP03'   ) AND ([comm_rt] <> 0)
GO


UPDATE comm.plan_group_rate
SET [comm_rt] = 16
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEE') AND ([comm_plan_id] = 'FSCGP02'   ) AND ([comm_rt] <> 0)
GO

UPDATE comm.plan_group_rate
SET [comm_rt] = 19
FROM comm.plan_group_rate 
WHERE (item_comm_group_cd LIKE 'ITMTEE') AND ([comm_plan_id] = 'FSCGP03'   ) AND ([comm_rt] <> 0)
GO


-- set current items
UPDATE       BRS_Item
SET                comm_group_cd = 'ITMTEE'
WHERE        (Item IN ('1671450', '1672540', '1672583', '1676434', '1676594', '5441450', '5445743', '5820370', '5820682', '5821324', '5821933', '5822060', '5824559', '5826383', '5827294', '5828302', '5828313', '5828531', '5829551', 
                         '5834239', '5835974', '5838393', '5838638', '5838699', '5839986', '5850813', '5852333', '5855411', '5855412', '5855417', '5855418', '5855419', '5855420', '5855421', '5855422', '5855423', '5855424', '5855467', '5855468', 
                         '5855469', '5855470', '5855471', '5855479', '5884566', '5884567', '5884569', '5884570', '5884594', '5884999', '5885646', '5886425', '5887135', '5888923', '6528956', '6528959', '8096775', '8099123', '9490170', '9496591', 
                         '9496592', '9497429', '9497430', '9497466', '9497467', '9498526', '9498529', '9498881', '9498887'))
GO

UPDATE       BRS_Item
SET                comm_group_cd = 'ITMTEM'
WHERE        (Item IN ('1670442', '1670444', '1671240', '1671470', '1672460', '1672767', '1674691', '1674692', '1674694', '1674695', '5440517', '5444501', '5444513', '5445298', '5445723', '5445732', '5445759', '5445782', '5445791', 
                         '5445794', '5445844', '5445859', '5852328', '5852329', '5852331', '5852332', '5852334', '5852335', '5852336', '5855413', '5855425', '5855426', '5855427', '5855445', '5855446', '5855456', '5855457', '5855458', '5855459', 
                         '5855460', '5855461', '5855462', '5855463', '5855464', '5855465', '5855466', '5855472', '5855475', '5877105', '5877106', '5884362', '5884363', '5884775', '5885096', '5885349', '5888052', '5888141', '5889544', '6650516', 
                         '6650517', '6650518', '6650519', '9491245', '9492403', '9497442', '9497443', '9498536', '9498537', '9498897', '9498898', '9498906'))
GO

UPDATE       BRS_Item
SET                comm_group_cd = 'ITMTEP'
WHERE        (Item IN ('1670114', '1670573', '1670951', '1671001', '1671451', '1671509', '1671510', '1671530', '1671589', '1672239', '1672520', '1672830', '1673962', '1674082', '1674163', '1674326', '1675612', '1675679', '1675969', 
                         '1676701', '1678205', '2283013', '2283533', '2284506', '2286569', '2288490', '3334275', '3339436', '5831513', '5832110', '5832244', '5832641', '5834987', '5838146', '5838660', '5839196', '5839792', '5848192', '5848500', 
                         '5850770', '5850812', '5850814', '5850815', '5850818', '5850819', '5854180', '5854198', '5854199', '5854201', '5854202', '5854203', '5855405', '5855406', '5855408', '5855409', '5855410', '5855414', '5855431', '5855434', 
                         '5855435', '5855436', '5855437', '5855438', '5855439', '5855440', '5855455', '5855476', '5855477', '5857390', '5857391', '5857523', '5857524', '5857525', '5857526', '5872015', '5875329', '5875330', '5875339', '5875341', 
                         '5876028', '5877073', '5877114', '5878391', '5878517', '5884832', '5886136', '5886364', '5888634', '5888822', '5888823', '5888825', '5888899', '5891989', '5892124', '5893704', '5894152', '6522936', '6523685', '6525202', 
                         '6528693', '8091249', '8092069', '9491269', '9491270', '9496968', '9497427', '9498725', '9498726', '9498727', '9498728', '9498733', '9498734', '9498735', '9498736'))
						 
						 GO

-- set history items, run '-- update 2019 history' above
-- re-run calc above & dev model 

--- ISR model
--
BEGIN TRANSACTION
GO
ALTER TABLE comm.transaction_F555115 ADD
	isr_comm_group_cd char(6) NULL
GO
ALTER TABLE comm.transaction_F555115 ADD CONSTRAINT
	FK_transaction_F555115_group6 FOREIGN KEY
	(
	item_comm_group_cd
	) REFERENCES comm.[group]
	(
	comm_group_cd
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

--
BEGIN TRANSACTION
GO
CREATE NONCLUSTERED INDEX transaction_F555115_idx_16 ON comm.transaction_F555115
	(
	isr_comm_group_cd
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON USERDATA
GO
ALTER TABLE comm.transaction_F555115 SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

-- update new group

SELECT
d.comm_plan_id, d.item_comm_group_cd, d.cust_comm_group_cd, d.source_cd, d.disp_comm_group_cd, d.comm_rt, d.active_ind, d.note_txt, d.show_ind
FROM
comm.plan_group_rate AS d 
INNER JOIN comm.plan_group_rate AS s 
ON d.comm_plan_id like 'ISR%' AND
s.comm_plan_id = 'FSCGP02' AND 
d.cust_comm_group_cd = s.cust_comm_group_cd AND 
d.source_cd = s.source_cd AND 
d.item_comm_group_cd = s.item_comm_group_cd

-- clone FSC params to ISR
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
ON comm.plan_group_rate.comm_plan_id like 'ISR%' AND
s.comm_plan_id = 'FSCGP02' AND 
comm.plan_group_rate.cust_comm_group_cd = s.cust_comm_group_cd AND 
comm.plan_group_rate.source_cd = s.source_cd AND 
comm.plan_group_rate.item_comm_group_cd = s.item_comm_group_cd
GO

SELECT
distinct d.disp_comm_group_cd
--d.comm_plan_id, d.item_comm_group_cd, d.cust_comm_group_cd, d.source_cd, d.disp_comm_group_cd, d.comm_rt, d.active_ind, d.note_txt, d.show_ind
FROM
comm.plan_group_rate AS d 
WHERE 
([comm_plan_id] like 'ISRGP0[2 3]' ) AND
-- merch & small eq
not d.disp_comm_group_cd in('ITMEPS', 'ITMSND', 'SPMSND', 'STMPBA', 'SALD30') AND
(1=1)
GO

-- full list, for ref.  FG & REB will not work currently
SELECT [item_comm_group_cd], disp_comm_group_cd, active_ind
  FROM [comm].[plan_group_rate]
  where 
	comm_plan_id like 'ISR%' AND
	item_comm_group_cd in('FRESEQ', 'FRESND', 'ITMEPS', 'ITMSND', 'REBSND', 'REBTEE', 'SPMFGE', 'SPMFGS', 'SPMREB', 'SPMSND', 'STMPBA', 'SALD30') AND
	(1 = 1)
GO

-- set ISR comm group - active
UPDATE
	comm.plan_group_rate
SET
	active_ind = 1
	,disp_comm_group_cd = item_comm_group_cd

WHERE
	(comm_plan_id LIKE 'ISR%') AND 
	(item_comm_group_cd in('ITMEPS', 'ITMSND', 'SPMSND', 'STMPBA', 'SALD30') ) AND 
	(1 = 1)
GO

-- set ISR comm group - NOT active
UPDATE
	comm.plan_group_rate
SET
	active_ind = 0
	,disp_comm_group_cd = ''
WHERE
	(comm_plan_id LIKE 'ISR%') AND 
	(item_comm_group_cd NOT in('ITMEPS', 'ITMSND', 'SPMSND', 'STMPBA', 'SALD30') ) AND 
	(1 = 1)
GO

-- No comm - Zero Plan
UPDATE comm.plan_group_rate
SET [comm_rt] = 0
FROM comm.plan_group_rate 
WHERE ([comm_plan_id] = 'ISRGP00'   ) AND ([comm_rt] <> 0)
GO

-- No comm - non Merch and Small EQ
UPDATE comm.plan_group_rate
SET [comm_rt] = 0
FROM comm.plan_group_rate 
WHERE 
([comm_plan_id] like 'ISRGP0[2 3]' ) AND
-- merch & small eq
not disp_comm_group_cd in('ITMEPS', 'ITMSND', 'SPMSND', 'STMPBA', 'SALD30') AND
(1=1)
GO

-- Set Merch and Small EQ
UPDATE comm.plan_group_rate
SET [comm_rt] = 1.5
FROM comm.plan_group_rate 
WHERE 
([comm_plan_id] like 'ISRGP0[2 3]' ) AND
-- merch & small eq
disp_comm_group_cd in('ITMEPS', 'ITMSND') AND
(1=1)
GO

-- Set Merch and Small EQ - special Markets
UPDATE comm.plan_group_rate
SET [comm_rt] = 0.75
FROM comm.plan_group_rate 
WHERE 
([comm_plan_id] like 'ISRGP0[2 3]' ) AND
-- merch & small eq
disp_comm_group_cd in('SPMSND') AND
(1=1)
GO

-- setup ISR users
-- manually populate integration.comm_salesperson_master_Staging
/*
202009	4354	DTSAR	Amanda.Russell	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Amanda.Russell
202009	4486	MTSAY	Amanda.Yip	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Amanda.Yip
202009	4252	DTSAV	Angela.Valerio	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Angela.Valerio
202009	4398	DTSEB	Emilia.Bronowicki	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Emilia.Bronowicki
202009	1545	ZTSED	Eric.Dorfman	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Eric.Dorfman
202009	6235	DTSFP	Franca.Parente	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Franca.Parente
202009	1527	DTSJD	Janet.Dunphy	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Janet.Dunphy
202009	1259	ZTSJE	Julie.Emery	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Julie.Emery
202009	3334	ZTSMK	Madeleine.Khodaverdi	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Madeleine.Khodaverdi
202009	4371	DTSMT	Maya.Thibodeau	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Maya.Thibodeau
202009	4307	DTSMC	Meaghan.Collins	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Meaghan.Collins
202009	1723	DTSNX	Nadia.Xavier	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Nadia.Xavier
202009	3384	DTSNS	Natasha.Singh	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Natasha.Singh
202009	4083	DTSNT	Noah.Thompson	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Noah.Thompson
202009	3255	MTSSJ	Shenila.Jaffer	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Shenila.Jaffer
202009	3414	MTSWS	Willen.Sun	ISRGP02	16-Oct	CC020001050115	0	0	model2021	N	Willen.Sun
*/

EXEC comm.comm_stage_update_proc @bDebug=0

delete from [dbo].[zzzItem]

/*
TerritoryCd	comm_salesperson_key_id
DTSAR	Amanda.Russell
MTSAY	Amanda.Yip
DTSAV	Angela.Valerio
DTSEB	Emilia.Bronowicki
ZTSED	Eric.Dorfman
MTSFP	Franca.Parente
DTSFP	Franca.Parente
DTSJD	Janet.Dunphy
MTSJD	Janet.Dunphy
ZTSJ2	Julie.Emery
ZTSJE	Julie.Emery
ZTSMK	Madeleine.Khodaverdi
DTSMT	Maya.Thibodeau
DTSMC	Meaghan.Collins
DTSNX	Nadia.Xavier
DTSNS	Natasha.Singh
DTSNT	Noah.Thompson
DTSN2	Noah.Thompson
MTSSJ	Shenila.Jaffer
MTSWS	Willen.Sun
*/

UPDATE       BRS_FSC_Rollup
SET                comm_salesperson_key_id = zzzItem.Note1
FROM            zzzItem INNER JOIN
                         BRS_FSC_Rollup ON zzzItem.Item = BRS_FSC_Rollup.TerritoryCd

-- set history

SELECT        TOP (1000) BRS_CustomerFSC_History.Shipto, BRS_CustomerFSC_History.FiscalMonth, BRS_CustomerFSC_History.HIST_TsTerritoryCd, BRS_CustomerFSC_History.HIST_isr_salesperson_key_id, 
                         BRS_CustomerFSC_History.HIST_isr_comm_plan_id, BRS_FSC_Rollup.comm_salesperson_key_id, comm.salesperson_master.comm_plan_id
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_FSC_Rollup ON BRS_CustomerFSC_History.HIST_TsTerritoryCd = BRS_FSC_Rollup.TerritoryCd INNER JOIN
                         comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
WHERE
(BRS_CustomerFSC_History.FiscalMonth >= 201901) and 
(comm_plan_id like 'ISR%')


UPDATE
	BRS_CustomerFSC_History
SET
	HIST_isr_salesperson_key_id = comm_salesperson_key_id, 
	HIST_isr_comm_plan_id = comm_plan_id
FROM            BRS_CustomerFSC_History INNER JOIN
                         BRS_FSC_Rollup ON BRS_CustomerFSC_History.HIST_TsTerritoryCd = BRS_FSC_Rollup.TerritoryCd INNER JOIN
                         comm.salesperson_master ON BRS_FSC_Rollup.comm_salesperson_key_id = comm.salesperson_master.salesperson_key_id
WHERE        (BRS_CustomerFSC_History.FiscalMonth >= 201901) AND (comm.salesperson_master.comm_plan_id LIKE 'ISR%')


-- set ISR plan for Adjustments.  in prod, this is set manually.  We need to fake it
UPDATE
	comm.transaction_F555115
SET
	isr_code = s.HIST_TsTerritoryCd
	,isr_salesperson_key_id = s.HIST_isr_salesperson_key_id
	,isr_comm_plan_id = s.HIST_isr_comm_plan_id
	,[isr_calc_key]=NULL
-- Select s.FiscalMonth, d.[WSLITM_item_number], isr_code, fsc_code, isr_salesperson_key_id, fsc_salesperson_key_id, isr_comm_plan_id, fsc_comm_plan_id, [isr_calc_key], [fsc_calc_key], fsc_comm_group_cd
-- Select s.*	
FROM
	[dbo].[BRS_CustomerFSC_History] AS s 

	INNER JOIN comm.transaction_F555115 d
	ON (d.WSSHAN_shipto = s.Shipto) AND
	(d.FiscalMonth = s.FiscalMonth) AND
	(d.source_cd = 'IMP')
WHERE
	(s.HIST_isr_comm_plan_id <> '') AND
	(s.FiscalMonth between 201901 and 201912) AND
	(1=1)

-- set ISR comm rate for Adjustments.  in prod, this is set manually.  We need to fake it
UPDATE
	comm.transaction_F555115
SET
	isr_comm_group_cd = fsc_comm_group_cd
-- Select FiscalMonth, [WSLITM_item_number], isr_code, fsc_code, isr_salesperson_key_id, fsc_salesperson_key_id, isr_comm_plan_id, fsc_comm_plan_id, [isr_calc_key], [fsc_calc_key], isr_comm_group_cd, fsc_comm_group_cd
FROM
	comm.transaction_F555115 
WHERE
	(source_cd = 'IMP') AND
	(isr_comm_plan_id <> '') AND
	([WSLITM_item_number]='') AND
	fsc_comm_group_cd in('ITMEPS', 'ITMSND', 'SPMSND') AND
	(FiscalMonth between 201901 and 201912) AND
	(1=1)


-- test
Select FiscalMonth, [WSLITM_item_number], [WSSHAN_shipto], isr_code, fsc_code, isr_salesperson_key_id, fsc_salesperson_key_id, isr_comm_plan_id, fsc_comm_plan_id, [isr_calc_key], [fsc_calc_key], isr_comm_group_cd, fsc_comm_group_cd
FROM
comm.transaction_F555115
where 
(FiscalMonth = 201912) and
(source_cd = 'imp') and
(isr_comm_plan_id <> '') AND
--(fsc_comm_group_cd like 'reb%') and
(1=1)
order by 
fsc_comm_group_cd
