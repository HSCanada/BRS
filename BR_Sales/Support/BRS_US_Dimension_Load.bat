@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO Load BRS_BE_Dimension_load_proc to %BRS_SQLSERVER%.%DB_DST% 

PAUSE

ECHO CLEAR STAGE US ITEM DIMENSION...

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec usd.BRS_BE_Dimension_load_proc @bClearStage=1, @bDebug=0"


ECHO LOAD STAGE_BRS_ItemFull...

bcp %DB_DST%..STAGE_BRS_ItemFull in ../Upload/BRSItemFull-US.txt -w -T -S %BRS_SQLSERVER% -e BRSItemFull-US_ERR.txt -F 4 -m 40


ECHO LOAD Prod...

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; Exec usd.BRS_BE_Dimension_load_proc @bClearStage=0, @bDebug=0"


PAUSE
