@ECHO OFF

:: updated 22 Nov 18, tmc, delete source file after load to avoid double run and catch missed days

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO RUN SSIS_br_d1_daily_etl on %BRS_SQLSERVER%.%DB_DST% 


SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; SELECT CONVERT(date,MAX([SalesDate]))  FROM nes.order_open_prorepr"

PAUSE

osql -S %BRS_SQLSERVER% -E -r -p -Q"exec msdb.dbo.sp_start_job 'SSIS_br_d1_daily_etl'"

timeout /t 15

SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; SELECT CONVERT(date,MAX([SalesDate]))  FROM nes.order_open_prorepr"

PAUSE


