-- Purge 2019-20

select  count (*) from [comm].[transaction_F555115] where [FiscalMonth] <= 201912 group by FiscalMonth

delete from [comm].[transaction_F555115] where [FiscalMonth] <= 202012
GO

SELECT top 10 * FROM [BRSales].[fg].[transaction_F5554240] where [CalMonthRedeem]= 201901
delete FROM [fg].[transaction_F5554240] where [CalMonthRedeem]<= 202012
GO

SELECT top 10 * FROM [dbo].[BRS_TransactionDW] where [CalMonth] = 201901
delete FROM [dbo].[BRS_TransactionDW] where [CalMonth] <= 202010
--16m

select top 10 * from [dbo].[BRS_Transaction] where FiscalMonth = 202012

delete from [dbo].[BRS_Transaction] where FiscalMonth <= 202012

-- purge 2019/20

/*
[comm].[transaction_F555115]
[dbo].[BRS_TransactionDW]
[dbo].[BRS_Transaction]

pre
[comm].[transaction_F555115]	14033864	24469808
[dbo].[BRS_TransactionDW]		13853830	17424400
[dbo].[BRS_Transaction]			14114336	15010192

[comm].[transaction_F555115]	8264609		16086832
[dbo].[BRS_TransactionDW]		8169114		11488112
[dbo].[BRS_Transaction]			8072126		 9729616

*/