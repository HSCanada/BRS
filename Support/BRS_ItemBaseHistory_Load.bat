@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO LOAD BRS_ItemBaseHistory to %DB_DST% 
PAUSE

bcp %DB_DST%..STAGE_BRS_ItemBaseHistory in BRS_ItemBaseHistory.txt -c -T -S CAHSIONNLSQL1 -e BRS_ItemBaseHistory_ERR.txt -F 2

PAUSE
