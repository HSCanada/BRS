Option Compare Database

'dev
'Const OUTPUTPATH = "S:\BR\zDev\BRS\FlexOrder\upload\download\"
'qa
Const OUTPUTPATH = "M:\FOE Data QA\"
'prod
'Const OUTPUTPATH = "M:\FOE Data\"


'------------------------------------------------------------
' gsp_export
'
'------------------------------------------------------------
Function gsp_export()
On Error GoTo gsp_export_Err

    file_suffix = Format(Now(), "_yyyymmddThhmm")
   
    ' note:  ignore header not working, tmc, 24 Mar 21
    DoCmd.TransferSpreadsheet acExport, acSpreadsheetTypeExcel12Xml, "qryHSC_HSCGSP", OUTPUTPATH & "HSC_HSCGSP" & file_suffix & ".xlsx", False
    DoCmd.TransferSpreadsheet acExport, acSpreadsheetTypeExcel12Xml, "qryHSC_BILLONLY", OUTPUTPATH & "HSC_BILLONLY" & file_suffix & ".xlsx", False
   
'    DoCmd.OutputTo acOutputQuery, "FFB11_GSP_review", "ExcelWorkbook(*.xlsx)", OUTPUTPATH & "HSC_HSCGSP" & file_suffix & ".xlsx", False, "", , acExportQualityPrint
'    DoCmd.OutputTo acOutputQuery, "FFB12_IMP_review", "ExcelWorkbook(*.xlsx)", OUTPUTPATH & "HSC_BILLONLY" & file_suffix & ".xlsx", False, "", , acExportQualityPrint
    
    MsgBox "GSP files saved to:" & vbCrLf & OUTPUTPATH

gsp_export_Exit:
    Exit Function

gsp_export_Err:
    MsgBox Error$
    Resume gsp_export_Exit

End Function