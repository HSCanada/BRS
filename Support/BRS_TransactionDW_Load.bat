@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO LOAD BRS_Promotion to %DB_DST% 
PAUSE

bcp %DB_DST%..STAGE_BRS_Promotion in BRS_Promotion.txt -c -T -S CAHSIONNLSQL1 -e BRS_Promotion_ERR.txt -F 2

ECHO LOAD BRS_TransactionDW to %DB_DST% 
PAUSE

bcp %DB_DST%..STAGE_BRS_TransactionDW in BRS_TransactionDW.txt -c -T -S CAHSIONNLSQL1 -e BRS_TransactionDW_ERR.txt -F 2

PAUSE
