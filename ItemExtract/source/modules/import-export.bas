Option Compare Database
Option Explicit

' ***************************************************************************
' **  File: ItemExtract.accdb
' **  Name: ItemExtract
' **  Desc: JDE ItemDump to excel backend
' **
' **
' **  Return values: none
' **
' **  Called by:   cmdline
' **
' **  Parameters:
' **  Input                   Output
' **  ----------              -----------
' **
' **
' **  Auth: JenLi
' **  Date: 10 Aug 05
' ***************************************************************************
' **  Change History
' ***************************************************************************
' **  Date:   Author:     Description:
' **  -----   ----------  --------------------------------------------
' **    17 Aug 23   tmc     add logging and cost fixing
' **
' ***************************************************************************

Const msApplicationName As String = "ItemExtract"
Const msApplicationVersionNum As String = "2.00"
Const mnODBCTimeout As Integer = 120

' ***************************************************************************
Const mbDebug As Boolean = True
' ***************************************************************************

Dim msConnectionString As String
Dim msInputPath As String
Dim msOutputPath As String
Dim msEventFile As String
Dim mnInputFileCount As Integer
Dim sLogMsg As String
' ***************************************************************************
' ** User adjustable parameters
' ***************************************************************************

'DEV Params
Const CONNECTIONSTRING_DEV As String = "ODBC;DRIVER=SQL Server;SERVER=CAHSIONNLSQL1;DATABASE=DEV_BRSales"
Const INPUT_PATH_DEV As String = "S:\BR\zDev\BRS\ItemExtract\Data\"
Const OUTPUT_PATH_DEV As String = "S:\BR\zDev\BRS\ItemExtract\Export\"
Const EVENT_FILE_WITHPATH_DEV As String = "S:\BR\zDev\BRS\ItemExtract\ItemExtractLog.log"
Const INPUT_FILE_COUNT_DEV = 4

'S:\Shared_Everyone\Business Reporting\Shared\Item Extract\Export\

' ***************************************************************************
' ** Params loaded from SQL backend
' ***************************************************************************


Public Function InitParams() As Boolean
On Error GoTo eh:

    If mbDebug Then
        msConnectionString = CONNECTIONSTRING_DEV
        msInputPath = INPUT_PATH_DEV
        msOutputPath = OUTPUT_PATH_DEV
        msEventFile = EVENT_FILE_WITHPATH_DEV
        mnInputFileCount = INPUT_FILE_COUNT_DEV
    Else
        ' TBD
        Debug.Assert False
    End If


    sLogMsg = Now() & ":  Starting ItemExtract, User=" & CurrentUser() & vbCrLf
    LogEventToFile (sLogMsg)

err_cleanup:
    
    InitParams = True
    
      
    Exit Function
    
eh:
    Dim sError As String
    sError = "Error " & Err.Number & ":  " & Err.Description
    MsgBox sError, , "InitParams()"
    Resume err_cleanup
    
End Function


' ***************************************************************************
' ** Event logging to file
' ***************************************************************************
Private Sub LogEventToFile(sEventMsg As String)
    On Error Resume Next
    
    Debug.Print sEventMsg
    
    Open msEventFile For Append Access Write Lock Write As #1
    
    Print #1, sEventMsg  ' Print text to file.
    Close #1

End Sub


Function GetOutputPath() As String
    GetOutputPath = msOutputPath
End Function


Private Function ExportExcel(sReportName As String, sFileName As String) As Boolean
On Error GoTo eh:
    Dim bSuccess As Boolean
    
    Dim sOutputFilePath As String
    
    bSuccess = True
    
    sOutputFilePath = GetOutputPath() & Trim(sFileName) & "_" & Trim(Format(Now, "YYYYMMDDThhnnss")) & ".XLSX"
    
    'Debug.Print sOutputFilePath
    
'    Call DoCmd.TransferSpreadsheet(acExport, acSpreadsheetTypeExcel3, sReportName, sOutputFilePath, True)
    Call DoCmd.TransferSpreadsheet(acExport, , sReportName, sOutputFilePath, True)
    
'    .OutputTo(acOutputQuery, sReportName, "Snapshot Format", sOutputFilePath)
    

err_cleanup:
    ExportExcel = bSuccess

    Exit Function
eh:
    bSuccess = False

    Dim sError As String
    sError = "Error " & Err.Number & ":  " & Err.Description
    MsgBox sError, , "ExportSummaryReport()"
    Resume err_cleanup

End Function



'------------------------------------------------------------
' Cleaning_Warning_Update_Export
'
'------------------------------------------------------------
Function Cleaning_Warning_Update_Export_Fnc()
On Error GoTo Cleaning_Warning_Update_Export_Err

    Dim i As Integer
    Dim sFile As String

    DoCmd.SetWarnings False
    
    ' MUST run first to set params for logs, etc
    InitParams
    
    sLogMsg = Now() & ":  Begin Import"
    LogEventToFile (sLogMsg)
    
    ' clear stage
    sLogMsg = Now() & "..:  run " & "0-DelItems"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "0-DelItems", acViewNormal, acEdit
    
    ' clear costprice
    sLogMsg = Now() & "..:  run " & "qdel_STAGE_BRS_ItemBaseHistory_"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "qdel_STAGE_BRS_ItemBaseHistory_", acViewNormal, acEdit
    
    ' load costprice
    sLogMsg = Now() & "..:  run " & "qapp_STAGE_BRS_ItemBaseHistory_ ..."
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "qapp_STAGE_BRS_ItemBaseHistory_", acViewNormal, acEdit
    
    sLogMsg = Now() & "..:  load Items"
    LogEventToFile (sLogMsg)
    
    ' load files
    For i = 1 To mnInputFileCount
        sFile = msInputPath & "ITEM0" & i & ".CSV"
        
        sLogMsg = Now() & "....:  Import " & sFile
        LogEventToFile (sLogMsg)
        
        DoCmd.TransferText acImportDelim, "ITEM Import Specification New", "Item Master", sFile, True, ""
        
    Next
   
    If Not mbDebug Then
        Beep
    End If
    
    ' scrub data
    sLogMsg = Now() & "....:  Begin Scrub"
    LogEventToFile (sLogMsg)
    
    sLogMsg = Now() & "......:  Warning-QryItem-NoBaseCost"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "Warning-QryItem-NoBaseCost", acViewNormal, acEdit

    sLogMsg = Now() & "......:  warning-QryItem-NoBasePrice"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "warning-QryItem-NoBasePrice", acViewNormal, acEdit

    sLogMsg = Now() & "......:  warning-QrySel-ItemLeaderNotSet-Wholesales"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "warning-QrySel-ItemLeaderNotSet-Wholesales", acViewNormal, acEdit

    sLogMsg = Now() & "......:  0-DelExport"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "0-DelExport", acViewNormal, acEdit
    
    sLogMsg = Now() & "......:  2-Update&AppendExportTable"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "2-Update&AppendExportTable", acViewNormal, acEdit

    sLogMsg = Now() & "......:  qupdCostFix"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "qupdCostFix", acViewNormal, acEdit

    sLogMsg = Now() & "......:  qupdPriceFix"
    LogEventToFile (sLogMsg)
    DoCmd.OpenQuery "qupdPriceFix", acViewNormal, acEdit

    sLogMsg = Now() & "....:  End Scrub"
    LogEventToFile (sLogMsg)
    
    sLogMsg = Now() & ":  End Import"
    LogEventToFile (sLogMsg)

    If Not mbDebug Then
        Beep
    End If
    
    ' export file
    
    sLogMsg = Now() & ":  Begin Export"
    LogEventToFile (sLogMsg)
    
    sFile = msOutputPath & "ITEM0" & i & ".CSV"
        
    sLogMsg = Now() & "..:  Export " & "ItemDump"
    LogEventToFile (sLogMsg)
    
    'NEW
    ExportExcel "Item Master Export", "ItemDump ..."
    'ORG
    'DoCmd.TransferSpreadsheet acExport, 10, "Item Master Export", msOutputPath & "ItemDump.xlsx", True, ""
    
    sLogMsg = Now() & ":  End Export"
    LogEventToFile (sLogMsg)

    ' exit app if production (run from CMD in batch mode)
    If Not mbDebug Then
        DoCmd.Quit acExit
    End If


Cleaning_Warning_Update_Export_Exit:
    Exit Function

Cleaning_Warning_Update_Export_Err:
    MsgBox Error$
    Resume Cleaning_Warning_Update_Export_Exit

End Function