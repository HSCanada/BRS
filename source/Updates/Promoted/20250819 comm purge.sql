select distinct fiscalmonth from  comm.transaction_F555115
order by 1

/*
--2021 15m
delete from comm.transaction_F555115 where fiscalmonth = 202101
GO
delete from comm.transaction_F555115 where fiscalmonth = 202102
GO
delete from comm.transaction_F555115 where fiscalmonth = 202103
GO
delete from comm.transaction_F555115 where fiscalmonth = 202104
GO
delete from comm.transaction_F555115 where fiscalmonth = 202105
GO
delete from comm.transaction_F555115 where fiscalmonth = 202106
GO
delete from comm.transaction_F555115 where fiscalmonth = 202107
GO
delete from comm.transaction_F555115 where fiscalmonth = 202108
GO
delete from comm.transaction_F555115 where fiscalmonth = 202109
GO
delete from comm.transaction_F555115 where fiscalmonth = 202110
GO
delete from comm.transaction_F555115 where fiscalmonth = 202111
GO
delete from comm.transaction_F555115 where fiscalmonth = 202112
GO


*/

select distinct [CalMonthRedeem] FROM fg.transaction_F5554240 order by 1
select distinct [CalMonthRedeem] FROM comm.freegoods order by 1
select distinct [FiscalMonth] from comm.freegoods

delete from comm.freegoods where [FiscalMonth] <= 202112
GO

delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202101
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202102
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202103
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202104
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202105
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202106
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202107
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202108
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202109
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202110
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202111
GO
delete from fg.transaction_F5554240 where [CalMonthRedeem] = 202112
GO

delete from BRS_transactionDW where calmonth = 202101
GO
delete from BRS_transactionDW where calmonth = 202102
GO
delete from BRS_transactionDW where calmonth = 202103
GO
delete from BRS_transactionDW where calmonth = 202104
GO
delete from BRS_transactionDW where calmonth = 202105
GO
delete from BRS_transactionDW where calmonth = 202106
GO
delete from BRS_transactionDW where calmonth = 202107
GO
delete from BRS_transactionDW where calmonth = 202108
GO
delete from BRS_transactionDW where calmonth = 202109
GO
delete from BRS_transactionDW where calmonth = 202110
GO
delete from BRS_transactionDW where calmonth = 202111
GO
delete from BRS_transactionDW where calmonth = 202112
GO


--2021 15m

drop table hfm.gps_fix_temp

UPDATE   BRS_TransactionDW_Ext
SET        ID_DS_xref = null
FROM     BRS_TransactionDW_Ext INNER JOIN
             BRS_Transaction ON BRS_TransactionDW_Ext.ID_DS_xref = BRS_Transaction.ID
WHERE BRS_Transaction.FiscalMonth <= 202112


delete from BRS_transaction where fiscalmonth = 202101
GO
delete from BRS_transaction where fiscalmonth = 202102
GO
delete from BRS_transaction where fiscalmonth = 202103
GO
delete from BRS_transaction where fiscalmonth = 202104
GO
delete from BRS_transaction where fiscalmonth = 202105
GO
delete from BRS_transaction where fiscalmonth = 202106
GO
delete from BRS_transaction where fiscalmonth = 202107
GO
delete from BRS_transaction where fiscalmonth = 202108
GO
delete from BRS_transaction where fiscalmonth = 202109
GO
delete from BRS_transaction where fiscalmonth = 202110
GO
delete from BRS_transaction where fiscalmonth = 202111
GO
delete from BRS_transaction where fiscalmonth = 202112
GO

truncate table pricing.order_header_note_F5503

delete from Integration.F5503_canned_message_file_parameters_Staging where id = 868927

select * from Integration.F5503_canned_message_file_parameters_Staging where Q3DOCO_salesorder_number = 1469774

EXECUTE pricing.order_note_post_proc @bDebug=1

EXECUTE pricing.order_note_post_proc @bDebug=0

/*
-- ORG 
-- TableName / NumberOfRows / SizeinKB
transaction_F555115         14733870             26 357 816
BRS_TransactionDW           14194863             18 047 352
BRS_Transaction             14568078             15 859 608
order_header_note_F5503     13199848             10 703 488


-- POST purge
transaction_F555115                                                                                                              11528067             21 893 376
BRS_TransactionDW                                                                                                                11267675             15 168 056
BRS_Transaction                                                                                                                  11479725             13 335 128
BRS_ItemBaseHistoryDayLNK                                                                                                        72677951             8 692 352

*/
