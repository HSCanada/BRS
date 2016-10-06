@ECHO OFF

ECHO LOAD BRS_ItemBase...

bcp BRSales..STAGE_BRS_ItemBaseHistory in ItemBaseHistory.txt -c -T -S CAHSIONNLSQL1 -e STAGE_BRS_ItemBase_ERR.txt -F 1

pause
