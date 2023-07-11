Option Compare Database



'------------------------------------------------------------
' Cleaning_Warning_Update_Export
'
'------------------------------------------------------------
Function Cleaning_Warning_Update_Export_Fnc()
On Error GoTo Cleaning_Warning_Update_Export_Err

    DoCmd.SetWarnings False
    DoCmd.OpenQuery "0-DelItems", acViewNormal, acEdit
    DoCmd.TransferText acImportDelim, "ITEM Import Specification New", "Item Master", "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Data\ITEM01.CSV", True, ""
    DoCmd.TransferText acImportDelim, "ITEM Import Specification New", "Item Master", "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Data\ITEM02.CSV", True, ""
    DoCmd.TransferText acImportDelim, "ITEM Import Specification New", "Item Master", "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Data\ITEM03.CSV", True, ""
    DoCmd.TransferText acImportDelim, "ITEM Import Specification New", "Item Master", "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Data\ITEM04.CSV", True, ""
    Beep
    'MsgBox """import finished""", vbOKOnly, ""
    DoCmd.OpenQuery "Warning-QryItem-NoBaseCost", acViewNormal, acEdit
    DoCmd.OpenQuery "warning-QryItem-NoBasePrice", acViewNormal, acEdit
    DoCmd.OpenQuery "warning-QrySel-ItemLeaderNotSet-Wholesales", acViewNormal, acEdit
    DoCmd.OpenQuery "0-DelExport", acViewNormal, acEdit
    DoCmd.OpenQuery "2-Update&AppendExportTable", acViewNormal, acEdit
    Beep
    'MsgBox """update completed""", vbOKOnly, ""
    DoCmd.TransferSpreadsheet acExport, 10, "Item Master Export", "S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Export\ItemDump.xlsx", True, ""
    DoCmd.Quit acExit


Cleaning_Warning_Update_Export_Exit:
    Exit Function

Cleaning_Warning_Update_Export_Err:
    MsgBox Error$
    Resume Cleaning_Warning_Update_Export_Exit

End Function