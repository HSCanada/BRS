
-- clone code

SELECT 'EPSDEL' as [comm_group_cd]
      ,'DenMat Laser & tips' AS [comm_group_desc]
      ,[source_cd]
      ,[active_ind]
      ,'TC Dan req 12 Jun 24' as [note_txt]
      ,[booking_rt]
      ,[show_ind]
      ,[sort_id]
      ,[comm_group_scorecard_cd]
      ,[SalesCategory]
      ,[comm_bonus1_cd]
      ,[comm_bonus2_cd]
      ,[comm_bonus3_cd]
  FROM [comm].[group]
  where [comm_group_cd] = 'EPSDEN'


INSERT INTO comm.[group]
                         (comm_group_cd, comm_group_desc, source_cd, active_ind, note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd)
SELECT        'EPSDEL' AS comm_group_cd, 'DenMat Laser & tips' AS comm_group_desc, source_cd, active_ind, 'TC Dan req 12 Jun 24' AS note_txt, booking_rt, show_ind, sort_id, comm_group_scorecard_cd, SalesCategory, 
                         comm_bonus1_cd, comm_bonus2_cd, comm_bonus3_cd
FROM            comm.[group] AS s
WHERE        (comm_group_cd = 'EPSDEN')


-- clone rates

SELECT [comm_plan_id]
      ,'EPSDEL' AS [item_comm_group_cd]
      ,[cust_comm_group_cd]
      ,[source_cd]
      ,'EPSDEL' AS [disp_comm_group_cd]
      ,[comm_rt]
      ,[active_ind]
      ,'TC Dan req 12 Jun 24' AS [note_txt]
      ,[show_ind]
      ,[fg_comm_group_cd]
  FROM [comm].[plan_group_rate] where item_comm_group_cd = 'EPSDEN' and [comm_plan_id] = 'EPSGP'
  GO

INSERT INTO comm.plan_group_rate
                         (comm_plan_id, item_comm_group_cd, cust_comm_group_cd, source_cd, disp_comm_group_cd, comm_rt, active_ind, note_txt, show_ind, fg_comm_group_cd)
SELECT        comm_plan_id, 'EPSDEL' AS item_comm_group_cd, cust_comm_group_cd, source_cd, 'EPSDEL' AS disp_comm_group_cd, comm_rt, active_ind, 'TC Dan req 12 Jun 24' AS note_txt, show_ind, fg_comm_group_cd
FROM            comm.plan_group_rate AS s
WHERE        (item_comm_group_cd = 'EPSDEN') AND (comm_plan_id = 'EPSGP')



-- update current

SELECT        Item, comm_group_eps_cd
FROM            BRS_Item
where item in (
	'1314673'
	,'1314675'
	,'1900162'
	,'1900329'
	,'1900426'
	,'1900431'
	,'1900433'
	,'9393754'
	)

UPDATE       BRS_Item
SET                comm_group_eps_cd = 'EPSDEL'
WHERE        (Item IN ('1314673', '1314675', '1900162', '1900329', '1900426', '1900431', '1900433', '9393754'))


-- update history

SELECT        Item,[FiscalMonth], HIST_comm_group_eps_cd
FROM            [dbo].[BRS_ItemHistory]
where 
[FiscalMonth]>=202301 and
item in (
	'1314673'
	,'1314675'
	,'1900162'
	,'1900329'
	,'1900426'
	,'1900431'
	,'1900433'
	,'9393754'
	)



UPDATE       BRS_ItemHistory
SET                HIST_comm_group_eps_cd = 'EPSDEL'
WHERE        (FiscalMonth >= 202301) AND (Item IN ('1314673', '1314675', '1900162', '1900329', '1900426', '1900431', '1900433', '9393754'))
GO

-- run this to prod, eta 20min ->>>

print 202301
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202301
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202302
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202302
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202303
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202303
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202304
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202304
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202305
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202305
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202306
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202306
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202307
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202307
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202308
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202308
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202309
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202309
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202310
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202310
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202311
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202311
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202312
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202312
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

print 202401
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202401
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202402
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202402
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202403
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202403
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202404
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202404
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202405
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202405
Exec comm.transaction_commission_calc_proc @bDebug=0
GO

-- test

SELECT        s.FiscalMonth, s.WSCO___company, s.WSDOCO_salesorder_number, s.WSDCTO_order_type, s.WSLNTY_line_type, s.WSLNID_line_number, s.WS$OSC_order_source_code, s.WSAN8__billto, s.WSSHAN_shipto, 
                         s.WSDGL__gl_date, s.eps_calc_key, d.eps_calc_key AS Expr1, s.eps_code, d.eps_code AS Expr2, s.eps_comm_group_cd, d.eps_comm_group_cd, d.gp_ext_amt
FROM            comm.transaction_F555115 AS s INNER JOIN
                         BRSales.comm.transaction_F555115 AS d ON s.ID = d.ID AND s.eps_calc_key <> d.eps_calc_key
WHERE        (s.FiscalMonth >= 202301)
GO
