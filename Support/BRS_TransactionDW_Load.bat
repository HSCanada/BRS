@ECHO OFF

ECHO LOAD BRS_Promotion...
bcp BRSales..STAGE_BRS_Promotion in BRS_Promotion.txt -c -T -S CAHSIONNLSQL1 -e BRS_Promotion_ERR.txt -F 2

ECHO LOAD BRS_TransactionDW...
bcp BRSales..STAGE_BRS_TransactionDW in BRS_TransactionDW.txt -c -T -S CAHSIONNLSQL1 -e BRS_TransactionDW_ERR.txt -F 2

pause
