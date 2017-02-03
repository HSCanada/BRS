@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO LOAD BRSItemCost.TXT to %DB_DST% 
PAUSE

bcp %DB_DST%..STAGE_BRS_ItemSupplierCost in BRSItemCost.TXT -c -T -S CAHSIONNLSQL2 -e BRSItemCost_ERR.txt -F 5

ECHO LOAD BRSItemSellPrice.TXT to %DB_DST% 
PAUSE

bcp %DB_DST%..STAGE_BRS_ItemSellPrice in BRSItemSellPrice.TXT -c -T -S CAHSIONNLSQL2 -e BRSItemSellPrice_ERR.txt -F 5

PAUSE

