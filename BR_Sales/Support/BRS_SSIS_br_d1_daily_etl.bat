@ECHO OFF

:: updated 02 Jun 23, tmc, port legacy osql to sqlcmd for job agent

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO RUN SSIS_br_d1_daily_etl on %BRS_SQLSERVER%.%DB_DST% 


SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; SELECT CONVERT(date,MAX([SalesDate]))  FROM nes.order_open_prorepr"

sqlcmd -S %BRS_SQLSERVER% -E -d MSDB -Q "sp_start_job 'SSIS_br_d1_daily_etl'"

timeout /t 15

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; SELECT CONVERT(date,MAX([SalesDate]))  FROM nes.order_open_prorepr"

PAUSE


