del  "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Export\ItemDump.xlsx"

if exist "C:\program files (x86)\Microsoft Office\root\Office16\MSACCESS.EXE" goto :X64
"C:\Program Files\Microsoft Office\root\Office16\MSACCESS.EXE" "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\ItemExtract.accdb" /excl /X Import-Export
goto :X86

:X64
"C:\Program Files (x86)\Microsoft Office\root\Office16\MSACCESS.EXE" "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\ItemExtract.accdb" /excl /X Import-Export
PAUSE

:X86
PAUSE