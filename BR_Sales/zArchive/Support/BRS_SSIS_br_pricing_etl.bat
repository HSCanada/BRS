@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO Update Pricing Backend ...
PAUSE

osql -S %BRS_SQLSERVER% -E -r -p -Q"exec msdb.dbo.sp_start_job 'SSIS_br_pkg_pricing_etl'"

PAUSE
