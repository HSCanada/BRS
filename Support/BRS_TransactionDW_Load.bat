@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO Load BRS_BE_Transaction_DW_load_proc to %BRS_SQLSERVER%.%DB_DST% 
PAUSE

ECHO LOAD STAGE_BRS_Promotion...

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; truncate table STAGE_BRS_Promotion; truncate table STAGE_BRS_TransactionDW"

BCP %DB_DST%..STAGE_BRS_Promotion in ../Upload/BRS_Promotion.txt -c -T -S %BRS_SQLSERVER% -e BRS_Promotion_ERR.txt -F 2

ECHO LOAD STAGE_BRS_TransactionDW...

BCP %DB_DST%..STAGE_BRS_TransactionDW in ../Upload/BRS_TransactionDW.txt -c -T -S %BRS_SQLSERVER% -e BRS_TransactionDW_ERR.txt -F 2

ECHO LOAD Prod...

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec BRS_BE_Transaction_DW_load_proc 0; SELECT SalesDateLastWeekly FROM BRS_Config"

PAUSE
