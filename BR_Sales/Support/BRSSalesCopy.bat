Xcopy \\usnymeazfs1\DropZone\MicroStrategy\Canada_Subscriptions\DW_Distribution_Services\BRS\BRS*.TXT "..\Upload" /Y
::Xcopy S:\DW_Distribution_Services\BRS\BRS*.TXT "..\Upload" /Y

:: clear manual load files so that dup data not loaded

del "..\Upload\prorepr.csv"
del \\usnymeazfs1\DropZone\MicroStrategy\Canada_Subscriptions\DW_Distribution_Services\BRS\BRS*.TXT
::del S:\DW_Distribution_Services\BRS\BRS*.TXT 

PAUSE
