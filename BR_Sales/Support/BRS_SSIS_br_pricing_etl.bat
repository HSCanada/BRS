@ECHO OFF

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO Update Pricing Backend ...
PAUSE

sqlcmd -S %BRS_SQLSERVER% -E -d MSDB -Q "sp_start_job 'SSIS_br_pkg_pricing_etl'"

PAUSE
