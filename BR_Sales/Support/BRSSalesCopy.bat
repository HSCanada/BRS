Xcopy S:\DW_Distribution_Services\BRS\BRS*.TXT "..\Upload" /Y

:: clear manual load files so that dup data not loaded

del "..\Upload\prorepr.csv"

PAUSE
