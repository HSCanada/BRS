@ECHO OFF
ECHO LOAD Customer...
bcp BRSales..STAGE_BRS_CustomerFull in BRSCustomerFull.txt -c -T -S CAHSIONNLSQL1 -e BRSCustomerFull_ERR.txt  -F 2

echo Load Item
bcp BRSales..STAGE_BRS_ItemFull in BRSItemFull.txt -c -T -S CAHSIONNLSQL1 -e BRSItemFull_ERR.txt -F 2 -m 40

pause
