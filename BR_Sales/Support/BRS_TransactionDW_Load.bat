@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO Load BRS_BE_Transaction_DW_load_proc to %BRS_SQLSERVER%.%DB_DST% 
PAUSE

ECHO CLEAR STAGE_BRS_Promotion...
SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec BRS_BE_Transaction_DW_load_proc @bClearStage=1, @bDebug=0"

ECHO LOAD STAGE_BRS_Promotion...
:::BCP %DB_DST%..STAGE_BRS_Promotion in ../Upload/BRS_Promotion.txt -w -T -S %BRS_SQLSERVER% -e BRS_Promotion_ERR.txt -F 2

ECHO LOAD Integration.BRS_CreditInfo...
:::BCP %DB_DST%.Integration.BRS_CreditInfo in ../Upload/BRSCreditInfo.txt -w -T -S %BRS_SQLSERVER% -e BRSCreditInfo_ERR.txt -F 2

ECHO LOAD STAGE_BRS_TransactionDW...
BCP %DB_DST%..STAGE_BRS_TransactionDW2 in ../Upload/BRS_TransactionDW.txt -w -T -S %BRS_SQLSERVER% -e BRS_TransactionDW_ERR.txt -F 2 -t"|"
:::BCP %DB_DST%..STAGE_BRS_TransactionDW in ../Upload/BRS_TransactionDW.txt -w -T -S %BRS_SQLSERVER% -e BRS_TransactionDW_ERR.txt -F 2 -t"|"

ECHO LOAD Prod...
::PAUSE
SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec BRS_BE_Transaction_DW_load_proc @bClearStage=0, @bDebug=0; SELECT SalesDateLastWeekly FROM BRS_Config"

ECHO Update ISR consolidator...
::PAUSE
:::sqlcmd -S %BRS_SQLSERVER% -E -d MSDB -Q "sp_start_job 'SSIS_br_inside_sales_update'"


PAUSE
