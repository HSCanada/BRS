@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO Load BRS_BE_Dimension_load_proc to %BRS_SQLSERVER%.%DB_DST% 

PAUSE

ECHO CLEAR STAGE CUST, ITEM DIMENSION...

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec BRS_BE_Dimension_load_proc @bClearStage=1, @bDebug=0"


ECHO LOAD STAGE_BRS_CustomerFull...
bcp %DB_DST%..STAGE_BRS_CustomerFull in ../Upload/BRSCustomerFull.txt -w -T -S %BRS_SQLSERVER% -e BRSCustomerFull_ERR.txt  -F 2
PAUSE

ECHO LOAD STAGE_BRS_ItemFull...
bcp %DB_DST%..STAGE_BRS_ItemFull in ../Upload/BRSItemFull.txt -w -T -S %BRS_SQLSERVER% -e BRSItemFull_ERR.txt -F 2 -m 40
PAUSE

ECHO LOAD Prod...
::PAUSE

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=0; Exec BRS_BE_Transaction_post_proc 0"


PAUSE
