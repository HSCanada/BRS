Option Compare Database
Option Explicit

' ***************************************************************************
' **  File: COMMISSIONADMIN.MDB
' **  Name: CommissionAdmin
' **  Desc: Administrate Commission backend
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
' **  Auth: tmc
' **  Date: 10 Aug 06
' ***************************************************************************
' **  Change History
' ***************************************************************************
' **  Date:   Author:     Description:
' **  -----   ----------  --------------------------------------------
'       25 Oct 19   tmc     swapped out new tables for old with a few cosmetic reductions
'                               CommBE -> DEV_BRSales
' **
' ***************************************************************************

' ***************************************************************************
' ** User adjustable parameters
' ***************************************************************************


' Ensure that connection string below is the same ODBC source used to link tables
'Development
'Const gCONNECTIONSTRING As String = "ODBC;DRIVER=SQL Server;SERVER=CAHSIONNLD3092\SQL2005;DATABASE=comm_dev"
'Production
Const gCONNECTIONSTRING As String = "ODBC;DRIVER=SQL Server;SERVER=CAHSIONNLSQL1;DATABASE=DEV_BRSales"

Const msApplicationName As String = "CommissionAdmin"
Const msApplicationVersionNum As String = "2.00"
Const mnODBCTimeout As Integer = 120


' ***************************************************************************
' ** Params loaded from SQL backend
' ***************************************************************************

Dim msConnectionString As String
Dim msOutputPath As String
Dim msEventFile As String
Dim msCurrentFiscalNum As String
Dim msCurrentBranchCd As String

Dim msCurrentReportID As String
Dim msCurrentFSC As String

Dim mbDebug As Boolean


' Invoice Batch record type
Type CommBatch
    sSalespersonKeyId As String * 30
    sReportId As String * 8
End Type

Public Function GetCurrentFSC() As String
    GetCurrentFSC = IIf(msCurrentFSC <> "", msCurrentFSC, "*")
'GetCurrentFSC = "TYLER.MCCLENDON "
'GetCurrentFSC = "CDynes"
'GetCurrentFSC = "KIM.OBLENIS"
'GetCurrentFSC = "dmonette"
'GetCurrentFSC = "RWong"
'GetCurrentFSC = "RPoch"
' Test
'GetCurrentFSC = "mgrant"
End Function

Public Function GetCurrentBranch() As String
    GetCurrentBranch = IIf(msCurrentBranchCd = "", "*", msCurrentBranchCd)
' Test
'GetCurrentBranch = "TORNT"

End Function

Function GetCurrentFiscalPeriod() As String
    GetCurrentFiscalPeriod = msCurrentFiscalNum
End Function

Function GetReportID() As String
    GetReportID = msCurrentReportID
End Function

Function GetOutputPath() As String
    GetOutputPath = msOutputPath
End Function


Public Function InitParams() As Boolean
On Error GoTo eh:

    Dim bSuccess
    Dim Db As Database, qd As QueryDef, rs As Recordset
    Dim sLogMsg As String
    
    bSuccess = False
    
    '
    ' Determine connection string
    '
    msConnectionString = gCONNECTIONSTRING

    '
    ' Load params from SQL Backend
    '
    Set Db = CurrentDb
    Set qd = Db.CreateQueryDef("")
  
    qd.connect = msConnectionString
    qd.ReturnsRecords = True
    qd.ODBCTimeout = mnODBCTimeout
    
    qd.sql = "SELECT PriorFiscalMonth AS current_fiscal_yearmo_num, comm_output_path_txt AS output_path_txt, comm_log_filepath_txt AS log_filepath_txt FROM dbo.BRS_Config"
'    qd.sql = "SELECT current_fiscal_yearmo_num, output_path_txt, log_filepath_txt FROM comm_configure"
    Debug.Print qd.sql
    Set rs = qd.OpenRecordset(dbOpenForwardOnly, dbSQLPassThrough)
    
    If Not (rs.EOF And rs.BOF) Then
        msEventFile = rs("log_filepath_txt")
        msOutputPath = rs("output_path_txt")
        msCurrentFiscalNum = rs("current_fiscal_yearmo_num")
        
       
        ' Init vars
        msCurrentFSC = ""
        msCurrentReportID = ""
        mbDebug = False
        
        bSuccess = True
    End If
    
    rs.Close
    qd.Close
    Db.Close

    sLogMsg = Now() & ":  Starting CommissionAdmin, User=" & CurrentUser() & vbCrLf
    LogEventToFile (sLogMsg)

err_cleanup:
    Set rs = Nothing
    Set qd = Nothing
    Set Db = Nothing
    
    InitParams = bSuccess
    
      
    Exit Function
    
eh:
    Dim sError As String
    sError = "Error " & Err.Number & ":  " & Err.Description
    MsgBox sError, , "InitParams()"
    Resume err_cleanup
    
End Function

Public Function UpdateSummary() As Boolean
On Error GoTo eh:

    Dim bSuccess
    Dim Db As Database, qd As QueryDef, rs As Recordset
    Dim sLogMsg As String
    
    bSuccess = False
    
    '
    ' Determine connection string
    '
    msConnectionString = gCONNECTIONSTRING

    '
    ' Load params from SQL Backend
    '
    Set Db = CurrentDb
    Set qd = Db.CreateQueryDef("")
  
    qd.connect = msConnectionString
    qd.ReturnsRecords = False
    qd.ODBCTimeout = mnODBCTimeout
    
    qd.sql = "EXECUTE comm_summary_update_proc 0"
    Debug.Print qd.sql
    qd.Execute
    
    
    qd.Close
    Db.Close

    sLogMsg = Now() & ":  Execute UpdateSummary" & CurrentUser() & vbCrLf
    LogEventToFile (sLogMsg)

err_cleanup:
    Set qd = Nothing
    Set Db = Nothing
    
    UpdateSummary = bSuccess
    
      
    Exit Function
    
eh:
    Dim sError As String
    sError = "Error " & Err.Number & ":  " & Err.Description
    MsgBox sError, , "UpdateSummary()"
    bSuccess = False
    Resume err_cleanup
    
End Function


Private Function LoadBatch(recBatch() As CommBatch) As Integer
On Error GoTo eh:
    Dim nBatchSize As Integer
    Dim i As Integer
    
    Dim Db As Database, qd As QueryDef, rs As Recordset
    
    nBatchSize = 0
    
    Set Db = CurrentDb
    Set qd = Db.CreateQueryDef("")
    
    qd.connect = msConnectionString
    qd.ReturnsRecords = True
    qd.ODBCTimeout = mnODBCTimeout
    
    qd.sql = "SELECT salesperson_key_id, RTRIM(master_salesperson_cd) AS report_id_txt"
    qd.sql = qd.sql & " FROM comm.salesperson_master WHERE (flag_ind = 1) and comm_plan_id Like 'FSC%' ORDER BY salesperson_key_id"
    
'    qd.sql = "SELECT salesperson_key_id, RTRIM(master_salesperson_cd) AS report_id_txt"
'    qd.sql = qd.sql & " FROM comm_salesperson_master WHERE (select_ind = 1) and comm_plan_id Like 'FSC%'ORDER BY salesperson_key_id"
    Debug.Print qd.sql
    Set rs = qd.OpenRecordset(dbOpenSnapshot, dbSQLPassThrough)
    
    If Not (rs.EOF And rs.BOF) Then
        rs.MoveLast
        rs.MoveFirst
        nBatchSize = rs.RecordCount
        ReDim recBatch(nBatchSize)
    
        For i = 1 To nBatchSize
            recBatch(i).sSalespersonKeyId = rs("salesperson_key_id")
            recBatch(i).sReportId = rs("report_id_txt")
         
            rs.MoveNext
        Next i
   
    End If

    rs.Close
    qd.Close
    Db.Close
    
err_cleanup:
    
    Set rs = Nothing
    Set qd = Nothing
    Set Db = Nothing
    
    LoadBatch = nBatchSize
    
    Exit Function

eh:
    Dim sError As String
    sError = "Error " & Err.Number & ":  " & Err.Description
    MsgBox sError, , "LoadBatch()"
    Resume err_cleanup
End Function

Private Function LoadESSBatch(recBatch() As CommBatch) As Integer
On Error GoTo eh:
    Dim nBatchSize As Integer
    Dim i As Integer
    
    Dim Db As Database, qd As QueryDef, rs As Recordset
    
    nBatchSize = 0
    
    Set Db = CurrentDb
    Set qd = Db.CreateQueryDef("")
    
    qd.connect = msConnectionString
    qd.ReturnsRecords = True
    qd.ODBCTimeout = mnODBCTimeout
    
    qd.sql = "SELECT salesperson_key_id, RTRIM(master_salesperson_cd) AS report_id_txt"
    qd.sql = qd.sql & " FROM comm.salesperson_master WHERE ([flag_ind] = 1) and ((comm_plan_id Like 'ESS%') or (comm_plan_id Like 'CCS%')) ORDER BY salesperson_key_id"
    
'    qd.sql = "SELECT salesperson_key_id, RTRIM(master_salesperson_cd) AS report_id_txt"
'    qd.sql = qd.sql & " FROM comm_salesperson_master WHERE (select_ind = 1) and ((comm_plan_id Like 'ESS%') or (comm_plan_id Like 'CCS%')) ORDER BY salesperson_key_id"
    
'    qd.SQL = "SELECT salesperson_key_id, RTRIM(master_salesperson_cd) AS report_id_txt"
'    qd.SQL = qd.SQL & " FROM comm_salesperson_master WHERE (select_ind = 1) and comm_plan_id Like 'ESS%' ORDER BY salesperson_key_id"
    

    Debug.Print qd.sql
    Set rs = qd.OpenRecordset(dbOpenSnapshot, dbSQLPassThrough)
    
    If Not (rs.EOF And rs.BOF) Then
        rs.MoveLast
        rs.MoveFirst
        nBatchSize = rs.RecordCount
        ReDim recBatch(nBatchSize)
    
        For i = 1 To nBatchSize
            recBatch(i).sSalespersonKeyId = rs("salesperson_key_id")
            recBatch(i).sReportId = rs("report_id_txt")
         
            rs.MoveNext
        Next i
   
    End If

    rs.Close
    qd.Close
    Db.Close
    
err_cleanup:
    
    Set rs = Nothing
    Set qd = Nothing
    Set Db = Nothing
    
    LoadESSBatch = nBatchSize
    
    Exit Function

eh:
    Dim sError As String
    sError = "Error " & Err.Number & ":  " & Err.Description
    MsgBox sError, , "LoadBatch()"
    Resume err_cleanup
End Function


Public Function ExportBatch() As Boolean

    Dim bSuccess As Boolean
    Dim nBatchSize As Integer, nGoodPrintCount As Integer
    Dim i As Integer, sLogMsg As String
    Dim recBatch() As CommBatch
    
    bSuccess = True
    
        
    ' Load Batch
    nBatchSize = LoadBatch(recBatch)

    ' Process Batch
    If nBatchSize > 0 Then
   
        sLogMsg = Now() & ":  Batch Begin. "
        LogEventToFile (sLogMsg)
        ' Print Invoice documents
        For i = 1 To nBatchSize
            sLogMsg = Now() & ":  #" & i & ", " & recBatch(i).sSalespersonKeyId & vbTab & " - " & recBatch(i).sReportId
           
                If ExportDocuments(recBatch(i).sSalespersonKeyId, recBatch(i).sReportId) Then
                    nGoodPrintCount = nGoodPrintCount + 1
                Else
                    ' note that error occurred
                    sLogMsg = sLogMsg & " EXPORT ERROR!!!"
                End If
            
            LogEventToFile (sLogMsg)
            
        Next i
        
        ' Log end of batch
        sLogMsg = Now() & ":  Batch End. "
        If nGoodPrintCount = nBatchSize Then
            sLogMsg = sLogMsg & "COMPLETE"
        Else
            sLogMsg = sLogMsg & "INCOMPLETE"
            bSuccess = False
        End If
        sLogMsg = sLogMsg & vbCrLf
        LogEventToFile (sLogMsg)
    End If
    
    
    ExportBatch = bSuccess
    
End Function


Public Function ExportBatchESS() As Boolean

    Dim bSuccess As Boolean
    Dim nBatchSize As Integer, nGoodPrintCount As Integer
    Dim i As Integer, sLogMsg As String
    Dim recBatch() As CommBatch
    
    bSuccess = True
    
        
    ' Load Batch
    nBatchSize = LoadESSBatch(recBatch)

    ' Process Batch
    If nBatchSize > 0 Then
   
        sLogMsg = Now() & ":  Batch Begin. "
        LogEventToFile (sLogMsg)
        ' Print Invoice documents
        For i = 1 To nBatchSize
            sLogMsg = Now() & ":  #" & i & ", " & recBatch(i).sSalespersonKeyId & vbTab & " - " & recBatch(i).sReportId
           
                If ExportDocumentsESS(recBatch(i).sSalespersonKeyId, recBatch(i).sReportId) Then
                    nGoodPrintCount = nGoodPrintCount + 1
                Else
                    ' note that error occurred
                    sLogMsg = sLogMsg & " EXPORT ERROR!!!"
                End If
            
            LogEventToFile (sLogMsg)
            
        Next i
        
        ' Log end of batch
        sLogMsg = Now() & ":  Batch End. "
        If nGoodPrintCount = nBatchSize Then
            sLogMsg = sLogMsg & "COMPLETE"
        Else
            sLogMsg = sLogMsg & "INCOMPLETE"
            bSuccess = False
        End If
        sLogMsg = sLogMsg & vbCrLf
        LogEventToFile (sLogMsg)
    End If
    
    
    ExportBatchESS = bSuccess
    
End Function


Public Function ExportFSCAgingBatch() As Boolean

    Dim bSuccess As Boolean
    Dim nBatchSize As Integer, nGoodPrintCount As Integer
    Dim i As Integer, sLogMsg As String
    Dim recBatch() As CommBatch
    
    bSuccess = True
    
        
    ' Load Batch
    nBatchSize = LoadBatch(recBatch)

    ' Process Batch
    If nBatchSize > 0 Then
   
        sLogMsg = Now() & ":  Batch Begin. "
        LogEventToFile (sLogMsg)
        ' Print Invoice documents
        For i = 1 To nBatchSize
            sLogMsg = Now() & ":  #" & i & ", " & recBatch(i).sSalespersonKeyId & vbTab & " - " & recBatch(i).sReportId
           
                If ExportFSCAgingDocuments(recBatch(i).sSalespersonKeyId, recBatch(i).sReportId) Then
                    nGoodPrintCount = nGoodPrintCount + 1
                Else
                    ' note that error occurred
                    sLogMsg = sLogMsg & " EXPORT ERROR!!!"
                End If
            
            LogEventToFile (sLogMsg)
            
        Next i
        
        ' Log end of batch
        sLogMsg = Now() & ":  Batch End. "
        If nGoodPrintCount = nBatchSize Then
            sLogMsg = sLogMsg & "COMPLETE"
        Else
            sLogMsg = sLogMsg & "INCOMPLETE"
            bSuccess = False
        End If
        sLogMsg = sLogMsg & vbCrLf
        LogEventToFile (sLogMsg)
    End If
    
    
    ExportFSCAgingBatch = bSuccess
    
End Function

Public Function ExportESSAgingBatch() As Boolean

    Dim bSuccess As Boolean
    Dim nBatchSize As Integer, nGoodPrintCount As Integer
    Dim i As Integer, sLogMsg As String
    Dim recBatch() As CommBatch
    
    bSuccess = True
    
        
    ' Load Batch
    nBatchSize = LoadESSBatch(recBatch)

    ' Process Batch
    If nBatchSize > 0 Then
   
        sLogMsg = Now() & ":  Batch Begin. "
        LogEventToFile (sLogMsg)
        ' Print Invoice documents
        For i = 1 To nBatchSize
            sLogMsg = Now() & ":  #" & i & ", " & recBatch(i).sSalespersonKeyId & vbTab & " - " & recBatch(i).sReportId
           
                If ExportESSAgingDocuments(recBatch(i).sSalespersonKeyId, recBatch(i).sReportId) Then
                    nGoodPrintCount = nGoodPrintCount + 1
                Else
                    ' note that error occurred
                    sLogMsg = sLogMsg & " EXPORT ERROR!!!"
                End If
            
            LogEventToFile (sLogMsg)
            
        Next i
        
        ' Log end of batch
        sLogMsg = Now() & ":  Batch End. "
        If nGoodPrintCount = nBatchSize Then
            sLogMsg = sLogMsg & "COMPLETE"
        Else
            sLogMsg = sLogMsg & "INCOMPLETE"
            bSuccess = False
        End If
        sLogMsg = sLogMsg & vbCrLf
        LogEventToFile (sLogMsg)
    End If
    
    
    ExportESSAgingBatch = bSuccess
    
End Function

Private Function ExportDocuments(sSalespersonKeyId As String, sReportId As String) As Boolean
    Dim bSuccess
    
    bSuccess = False
' work on pdf later
        If (ExportReport(sSalespersonKeyId, "", sReportId, "rptCommStatementDetailReport", "CommissionDetail_NEW")) Then
            If (ExportExcel(sSalespersonKeyId, sReportId, "qryCommStatementDetailExport", "CommissionDetail_NEW")) Then
                bSuccess = True
            End If
        End If
  
                
    ExportDocuments = bSuccess
    
End Function

Private Function ExportDocumentsESS(sSalespersonKeyId As String, sReportId As String) As Boolean
    Dim bSuccess
    
    bSuccess = False
        
' work on pdf later
    If (ExportReport(sSalespersonKeyId, "", sReportId, "rptCommESSStatementDetailReport", "CommissionDetail_NEW")) Then
        If (ExportExcel(sSalespersonKeyId, sReportId, "qryCommESSStatementDetailExport", "CommissionDetail_NEW")) Then
            bSuccess = True
        End If
    End If
    
                
    ExportDocumentsESS = bSuccess
    
End Function

Private Function ExportFSCAgingDocuments(sSalespersonKeyId As String, sReportId As String) As Boolean
    Dim bSuccess
    
    bSuccess = False
    ' rptCommFSCSummary
    If (ExportReport(sSalespersonKeyId, "", sReportId, "rptCommFSCAging", "CustomerAging")) Then
        bSuccess = True
    End If
    
                
    ExportFSCAgingDocuments = bSuccess
    
End Function

Private Function ExportESSAgingDocuments(sSalespersonKeyId As String, sReportId As String) As Boolean
    Dim bSuccess
    
    bSuccess = False
    ' rptCommFSCSummary
    If (ExportReport(sSalespersonKeyId, "", sReportId, "rptCommESSAging", "CustomerAging")) Then
        bSuccess = True
    End If
    
                
    ExportESSAgingDocuments = bSuccess
    
End Function


Private Function ExportReport(sSalespersonKeyId As String, sBranchCd As String, sReportId As String, sReportName As String, sReportExtension As String) As Boolean
On Error GoTo eh:
    Dim bSuccess As Boolean
    
    Dim sOutputFilePath As String
    
    bSuccess = True
    msCurrentFSC = sSalespersonKeyId
    msCurrentBranchCd = sBranchCd
       
'   Changed to PDF format, 15 Feb 12, tmc
    sOutputFilePath = GetOutputPath() & "\" & Trim(GetCurrentFiscalPeriod()) & "_" & Trim(sReportId) & "_" & sReportExtension & ".PDF"
'    sOutputFilePath = GetOutputPath() & "\" & Trim(GetCurrentFiscalPeriod()) & "_" & Trim(sReportId) & "_" & sReportExtension & ".SNP"
    
    Debug.Print sOutputFilePath
    
'   Changed to PDF format, 15 Feb 12, tmc
    Call DoCmd.OutputTo(acOutputReport, sReportName, "PDF Format", sOutputFilePath)
'    Call DoCmd.OutputTo(acOutputReport, sReportName, "Snapshot Format", sOutputFilePath)
    

err_cleanup:
    ExportReport = bSuccess

    Exit Function
eh:
    bSuccess = False

    Dim sError As String
    sError = "Error " & Err.Number & ":  " & Err.Description
    MsgBox sError, , "ExportSummaryReport()"
    Resume err_cleanup

End Function

Private Function ExportReportPDF(sSalespersonKeyId As String, sBranchCd As String, sReportId As String, sReportName As String, sReportExtension As String) As Boolean
On Error GoTo eh:
    Dim bSuccess As Boolean
    
    Dim sOutputFilePath As String
    
    bSuccess = True
    msCurrentFSC = sSalespersonKeyId
    msCurrentBranchCd = sBranchCd
    
    sOutputFilePath = GetOutputPath() & "\" & Trim(GetCurrentFiscalPeriod()) & "_" & Trim(sReportId) & "_" & sReportExtension & ".PDF"
    
    Debug.Print sOutputFilePath
    
    Call DoCmd.OutputTo(acOutputReport, sReportName, "PDF Format", sOutputFilePath)
    

err_cleanup:
    ExportReportPDF = bSuccess

    Exit Function
eh:
    bSuccess = False

    Dim sError As String
    sError = "Error " & Err.Number & ":  " & Err.Description
    MsgBox sError, , "ExportSummaryReportPDF()"
    Resume err_cleanup

End Function

Private Function ExportExcel(sSalespersonKeyId As String, sReportId As String, sReportName As String, sReportExtension As String) As Boolean
On Error GoTo eh:
    Dim bSuccess As Boolean
    
    Dim sOutputFilePath As String
    
    bSuccess = True
    msCurrentFSC = sSalespersonKeyId
    
    sOutputFilePath = GetOutputPath() & "\" & Trim(GetCurrentFiscalPeriod()) & "_" & Trim(sReportId) & "_" & sReportExtension & ".XLSX"
    
    Debug.Print sOutputFilePath
    
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




Function SmartDiv(vDenom, vRemain) As Variant
    If IsNull(vRemain) Or IsNull(vDenom) Or vRemain = 0 Then
        SmartDiv = 0
    Else
        SmartDiv = vDenom / vRemain
    End If

End Function

Function SmartPercent(vNew, vOld) As Variant
    If IsNull(vNew) Or IsNull(vOld) Or vOld = 0 Then
        SmartPercent = "N/A"
    Else
        SmartPercent = (vNew / vOld) - 1
    End If

End Function

Sub DoExportFSCAgingBatch()
    InitParams
    
    ExportReport "", "NAZA", "NAZA", "rptCommFSCAging", "CustomerAging"
    ExportReport "", "NAZM", "NAZM", "rptCommFSCAging", "CustomerAging"

    ExportReport "", "NCZD", "NCZD", "rptCommFSCAging", "CustomerAging"
    ExportReport "", "NCZE", "NCZE", "rptCommFSCAging", "CustomerAging"
    ExportReport "", "NCZF", "NCZF", "rptCommFSCAging", "CustomerAging"
    ExportReport "", "NCZH", "NCZH", "rptCommFSCAging", "CustomerAging"

    ExportReport "", "NQZB", "NQZB", "rptCommFSCAging", "CustomerAging"
    ExportReport "", "NQZC", "NQZC", "rptCommFSCAging", "CustomerAging"

'    ExportReport "", "NWZK", "NWZK", "rptCommFSCAging", "CustomerAging"
'    ExportReport "", "NWZO", "NWZO", "rptCommFSCAging", "CustomerAging"
'    ExportReport "", "NDZK", "NDZK", "rptCommFSCAging", "CustomerAging"
    
    ExportFSCAgingBatch
    MsgBox "Done!"
    
End Sub

Sub DoExportESSAgingBatch()
    InitParams
    
    ExportESSAgingBatch
    MsgBox "Done!"
    
End Sub


'   Export ESS reports
Sub ExportESSCommBatch()
    InitParams
    UpdateSummary
    
    ExportBatchESS
    
    MsgBox "ESS Details exported!"
    
End Sub



Sub test2()
Dim recBatch() As CommBatch

LoadESSBatch recBatch

End Sub

Sub ExportBatchESS_Summary()

    ExportReportPDF "", "CALGY", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "CALGY"
    ExportReportPDF "", "EDMON", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "EDMON"
    ExportReportPDF "", "HALFX", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "HALFX"
    ExportReportPDF "", "LONDN", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "LONDN"
    ExportReportPDF "", "MNTRL", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "MNTRL"
    ExportReportPDF "", "OTTWA", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "OTTWA"
    ExportReportPDF "", "QUEBC", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "QUEBC"
    ExportReportPDF "", "REGIN", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "REGIN"
    ExportReportPDF "", "SJOHN", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "SJOHN"
    ExportReportPDF "", "TORNT", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "TORNT"
    ExportReportPDF "", "VACVR", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "VACVR"
    ExportReportPDF "", "VICTR", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "VICTR"
    ExportReportPDF "", "WINPG", "BranchESS-Signoff_NEW", "rptCommESSStatementSummaryReport", "WINPG"

End Sub


'   Export FSC reports
Public Function ExportFSCCommBatch()
    InitParams
''    UpdateSummary
    
    ExportBatchESS
    ExportBatchESS_Summary

''    MsgBox "ESS Details exported!"
    
    ExportBatch
    MsgBox "FSC Details exported!"
    
End Function

Sub Test()
    InitParams
   
    
    MsgBox "Done!"
End Sub