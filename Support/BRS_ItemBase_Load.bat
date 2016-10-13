@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO LOAD BRS_ItemBase to %DB_DST% 

PAUSE


bcp %DB_DST%..STAGE_BRS_ItemBase in ITEM01.csv -f BRS_ItemBase.fmt -T -S CAHSIONNLSQL1 -e ITEM01_ERR.txt -F 5
bcp %DB_DST%..STAGE_BRS_ItemBase in ITEM02.csv -f BRS_ItemBase.fmt -T -S CAHSIONNLSQL1 -e ITEM02_ERR.txt -F 5
bcp %DB_DST%..STAGE_BRS_ItemBase in ITEM03.csv -f BRS_ItemBase.fmt -T -S CAHSIONNLSQL1 -e ITEM03_ERR.txt -F 5
bcp %DB_DST%..STAGE_BRS_ItemBase in ITEM04.csv -f BRS_ItemBase.fmt -T -S CAHSIONNLSQL1 -e ITEM04_ERR.txt -F 5

PAUSE

