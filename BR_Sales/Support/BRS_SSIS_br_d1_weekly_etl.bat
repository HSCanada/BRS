@ECHO OFF

:: updated 13 Mar 19, tmc, 

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO RUN SSIS_br_d1_weekly_etl on %BRS_SQLSERVER%.%DB_DST% 
PAUSE

:: PAUSE

osql -S %BRS_SQLSERVER% -E -r -p -Q"exec msdb.dbo.sp_start_job 'SSIS_br_d1_weekly_etl'"


PAUSE

