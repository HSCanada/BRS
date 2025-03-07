@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO Update Commission Model.
ECHO ARE YOU SURE? ...
PAUSE

sqlcmd -S %BRS_SQLSERVER% -E -d MSDB -Q "sp_start_job 'SSIS_br_commission_model_refresh'"

::sqlcmd -S %BRS_SQLSERVER% -E -d MSDB -Q "sp_start_job 'SSIS_br_inside_sales_update'"
::osql -S %BRS_SQLSERVER% -E -r -p -Q"exec msdb.dbo.sp_start_job 'SSIS_br_commission_model_refresh'"



PAUSE
