@ECHO OFF

:: created 14 Jan 20, tmc

SET DB_DST=DEV_BRSales
IF %BRS_MODE% EQU PROD SET DB_DST=BRSales

ECHO RUN SSIS_br_pkg_com_trans_etl on %BRS_SQLSERVER%.%DB_DST% 

::SQLCMD -S %BRS_SQLSERVER% -E -Q "USE %DB_DST%; SELECT Max(sales_date) AS [Last Prorepair Loaded] FROM nes.order_open_prorepr_current"
PAUSE

osql -S %BRS_SQLSERVER% -E -r -p -Q"exec msdb.dbo.sp_start_job 'SSIS_br_pkg_com_trans_etl'"


PAUSE

