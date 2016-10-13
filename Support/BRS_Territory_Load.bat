@ECHO OFF

ECHO LOAD STAGE_BRS_Territory...
bcp BRSales..STAGE_BRS_Territory in BRS_Territory.txt -c -T -S CAHSIONNLSQL1 -e BRS_Territory_ERR.txt -F 2

pause
