@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO LOAD BRS_CustomerFull to %DB_DST% 
PAUSE

bcp %DB_DST%..STAGE_BRS_CustomerFull in BRSCustomerFull.txt -c -T -S CAHSIONNLSQL2 -e BRSCustomerFull_ERR.txt  -F 2

ECHO LOAD BRS_ItemFull to %DB_DST% 
PAUSE

bcp %DB_DST%..STAGE_BRS_ItemFull in BRSItemFull.txt -c -T -S CAHSIONNLSQL2 -e BRSItemFull_ERR.txt -F 2 -m 40

PAUSE
