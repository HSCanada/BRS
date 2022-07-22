@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO Load BRS_BE_Transaction_DW_load_proc to %BRS_SQLSERVER%.%DB_DST% 
PAUSE

ECHO CLEAR STAGE_BRS_ItemSupplierCost...

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec [BRS_ItemBaseHistory_load_proc] @bClearStage=1, @bDebug=0"

ECHO LOAD STAGE_BRS_ItemSupplierCost...

BCP %DB_DST%..STAGE_BRS_ItemSupplierCost in ../Upload/BRSItemCost.TXT -c -T -S %BRS_SQLSERVER% -e BRSItemCost_ERR.txt -F 5

ECHO LOAD STAGE_BRS_ItemSellPricet...

BCP %DB_DST%..STAGE_BRS_ItemSellPrice in ../Upload/BRSItemSellPrice.TXT -c -T -S %BRS_SQLSERVER% -e BRSItemSellPrice_ERR.txt -F 5

ECHO LOAD Prod...
::pause
SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec [BRS_ItemBaseHistory_load_proc] @bClearStage=0, @bDebug=0; select MAX([SalesDate]) from [BRS_ItemBaseHistoryDayLNK]"

PAUSE

