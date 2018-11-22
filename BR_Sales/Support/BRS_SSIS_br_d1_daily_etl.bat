@ECHO OFF

:: updated 22 Nov 18, tmc, delete source file after load to avoid double run and catch missed days

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO RUN SSIS_br_d1_daily_etl on %BRS_SQLSERVER%.%DB_DST% 
PAUSE

:: PAUSE

osql -S %BRS_SQLSERVER% -E -r -p -Q"exec msdb.dbo.sp_start_job 'SSIS_br_d1_daily_etl'"


PAUSE

del "..\Upload\prorepr.csv"