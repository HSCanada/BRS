

SELECT   
-- TOP (10) 
h.Shipto, h.FiscalMonth, h.HIST_SalesDivision, h.HIST_MarketClass, h.HIST_cust_comm_group_cd, hdev.HIST_cust_comm_group_cd AS HIST_cust_comm_group_cd_dev
FROM     BRS_CustomerFSC_History AS h INNER JOIN
             DEV_BRSales.dbo.BRS_CustomerFSC_History AS hdev ON h.Shipto = hdev.Shipto AND h.FiscalMonth = hdev.FiscalMonth
where 
	h.HIST_SalesDivision <> 'AAM' AND
	h.HIST_cust_comm_group_cd <> hdev.HIST_cust_comm_group_cd AND
	(h.FiscalMonth between 202601 and 202607) AND
--	(h.FiscalMonth = 202604) AND
--	(h.Shipto in( 4312655, 4115140)) AND
	(1=1)
order by 2 desc





UPDATE  BRS_CustomerFSC_History
SET        HIST_cust_comm_group_cd = hdev.HIST_cust_comm_group_cd
FROM     BRS_CustomerFSC_History INNER JOIN
             DEV_BRSales.dbo.BRS_CustomerFSC_History AS hdev ON BRS_CustomerFSC_History.Shipto = hdev.Shipto AND BRS_CustomerFSC_History.FiscalMonth = hdev.FiscalMonth AND BRS_CustomerFSC_History.HIST_cust_comm_group_cd <> hdev.HIST_cust_comm_group_cd
WHERE   (BRS_CustomerFSC_History.HIST_SalesDivision <> 'AAM') AND (BRS_CustomerFSC_History.FiscalMonth BETWEEN 202601 AND 202607) AND (1 = 1)


-- YTD testing
print ('recalc 2026, 10m')
print 202601
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202601
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202602
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202602
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202603
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202603
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202604
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202604
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202605
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202605
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202606
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202606
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
print 202607
UPDATE [dbo].[BRS_Config] SET [PriorFiscalMonth] = 202607
Exec comm.transaction_commission_calc_proc @bDebug=0
GO
