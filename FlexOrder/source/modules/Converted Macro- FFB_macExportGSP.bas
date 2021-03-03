Option Compare Database

'------------------------------------------------------------
' FFB_macExportGSP
'
'------------------------------------------------------------
Function FFB_macExportGSP()
On Error GoTo FFB_macExportGSP_Err

    DoCmd.OutputTo acOutputQuery, "FFB01_export_GSP", "ExcelWorkbook(*.xlsx)", "M:\FOE Data QA\HSC_HSCGSP.xlsx", False, "", , acExportQualityPrint


FFB_macExportGSP_Exit:
    Exit Function

FFB_macExportGSP_Err:
    MsgBox Error$
    Resume FFB_macExportGSP_Exit

End Function