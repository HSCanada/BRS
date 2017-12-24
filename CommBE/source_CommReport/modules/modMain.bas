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
' **  23 Dec 17     tmc     ported to new backend
' **
' ***************************************************************************


' ***************************************************************************
' ** Globals
' ***************************************************************************

' static via InitParams()
Dim msEventFile As String
Dim msConnectionString As String

' dynamic
Dim msCurrentFiscalNum As String
Dim msCurrentBranchCd As String
Dim msCurrentReportID As String
Dim msCurrentFSC As String


' Invoice Batch record type
Type CommBatch
    sSalespersonKeyId As String * 30
    sReportId As String * 8
End Type

Public Function GetCurrentFSC() As String
Debug.Print "GetCurrentFSC"

    GetCurrentFSC = IIf(msCurrentFSC <> "", msCurrentFSC, "*")
'GetCurrentFSC = "TYLER.MCCLENDON "
'GetCurrentFSC = "Kcroney"
'GetCurrentFSC = "KIM.OBLENIS"
'GetCurrentFSC = "JGOULET"
'GetCurrentFSC = "RWong"
'GetCurrentFSC = "RPoch"
'GetCurrentFSC = "mgrant"
End Function

Public Function GetCurrentBranch() As String
Debug.Print "GetCurrentBranch"
    GetCurrentBranch = IIf(msCurrentBranchCd = "", "*", msCurrentBranchCd)
    
'GetCurrentBranch = "TORNT"

End Function

Function GetCurrentFiscalPeriod() As String
Debug.Print "GetCurrentFiscalPeriod"
    GetCurrentFiscalPeriod = msCurrentFiscalNum
End Function

Function GetReportID() As String
Debug.Print "GetReportID"
    GetReportID = msCurrentReportID
End Function

Function GetOutputPath() As String
Debug.Print "GetOutputPath"
    GetOutputPath = config("PATH_PUBLISH")
End Function


Public Function InitParams() As Boolean
Debug.Print "InitParams"
On Error GoTo eh:

    Dim bSuccess
    Dim Db As Database, qd As QueryDef, rs As Recordset
    Dim sLogMsg As String
    
    ' Init vars
    bSuccess = False
    msCurrentFSC = ""
    msCurrentReportID = ""
    
    config_init
    
    msConnectionString = config("CONNECTIONSTRING")
    msEventFile = config("FILEPATH_LOG")

    '
    ' Load params from SQL Backend
    '
    Set Db = CurrentDb
    Set qd = Db.CreateQueryDef("")
  
    qd.connect = msConnectionString
    qd.ReturnsRecords = True
'    qd.ODBCTimeout = mnODBCTimeout
    
    qd.sql = "SELECT PriorFiscalMonth FROM BRS_Config"
    Set rs = qd.OpenRecordset(dbOpenForwardOnly, dbSQLPassThrough)
    
    If Not (rs.EOF And rs.BOF) Then
        msCurrentFiscalNum = rs("PriorFiscalMonth")
        
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



Private Function LoadBatch(recBatch() As CommBatch) As Integer
Debug.Print "LoadBatch"

On Error GoTo eh:
    Dim nBatchSize As Integer
    Dim i As Integer
    
    Dim Db As Database, qd As QueryDef, rs As Recordset
    
    nBatchSize = 0
    
    Set Db = CurrentDb
    Set qd = Db.CreateQueryDef("")
    
    qd.connect = msConnectionString
    qd.ReturnsRecords = True
'    qd.ODBCTimeout = mnODBCTimeout
    
    qd.sql = "SELECT salesperson_key_id, RTRIM(master_salesperson_cd) AS report_id_txt"
    qd.sql = qd.sql & " FROM comm.salesperson_master WHERE ([flag_ind] = 1) and comm_plan_id Like 'FSC%'ORDER BY salesperson_key_id"
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
Debug.Print "LoadESSBatch"

On Error GoTo eh:
    Dim nBatchSize As Integer
    Dim i As Integer
    
    Dim Db As Database, qd As QueryDef, rs As Recordset
    
    nBatchSize = 0
    
    Set Db = CurrentDb
    Set qd = Db.CreateQueryDef("")
    
    qd.connect = msConnectionString
    
    qd.ReturnsRecords = True
'    qd.ODBCTimeout = mnODBCTimeout
    
    qd.sql = "SELECT salesperson_key_id, RTRIM(master_salesperson_cd) AS report_id_txt"
    qd.sql = qd.sql & " FROM comm.salesperson_master WHERE ([flag_ind] = 1) and ((comm_plan_id Like 'ESS%') or (comm_plan_id Like 'CCS%')) ORDER BY salesperson_key_id"
    
  

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
Debug.Print "ExportBatch"

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
Debug.Print "ExportBatchESS"

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



Private Function ExportDocuments(sSalespersonKeyId As String, sReportId As String) As Boolean
Debug.Print "ExportDocuments"

    Dim bSuccess
    
    bSuccess = False
' work on pdf later
        If (ExportReport(sSalespersonKeyId, "", sReportId, "rptCommStatementDetailReport", "CommissionDetail")) Then
            If (ExportExcel(sSalespersonKeyId, sReportId, "qryCommStatementDetailExport", "CommissionDetail")) Then
                bSuccess = True
            End If
        End If
  
                
    ExportDocuments = bSuccess
    
End Function

Private Function ExportDocumentsESS(sSalespersonKeyId As String, sReportId As String) As Boolean
Debug.Print "ExportDocumentsESS"

    Dim bSuccess
    
    bSuccess = False
        
' work on pdf later
    If (ExportReport(sSalespersonKeyId, "", sReportId, "rptCommESSStatementDetailReport", "CommissionDetail")) Then
        If (ExportExcel(sSalespersonKeyId, sReportId, "qryCommESSStatementDetailExport", "CommissionDetail")) Then
            bSuccess = True
        End If
    End If
    
                
    ExportDocumentsESS = bSuccess
    
End Function



Private Function ExportReport(sSalespersonKeyId As String, sBranchCd As String, sReportId As String, sReportName As String, sReportExtension As String) As Boolean
Debug.Print "ExportReport"

On Error GoTo eh:
    Dim bSuccess As Boolean
    
    Dim sOutputFilePath As String
    
    bSuccess = True
    msCurrentFSC = sSalespersonKeyId
    msCurrentBranchCd = sBranchCd
       
'   Changed to PDF format, 15 Feb 12, tmc
    sOutputFilePath = GetOutputPath() & Trim(GetCurrentFiscalPeriod()) & "_" & Trim(sReportId) & "_" & sReportExtension & ".PDF"
    
    Debug.Print sOutputFilePath
    
'   Changed to PDF format, 15 Feb 12, tmc
    Call DoCmd.OutputTo(acOutputReport, sReportName, "PDF Format", sOutputFilePath)
    

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
Debug.Print "ExportReportPDF"

On Error GoTo eh:
    Dim bSuccess As Boolean
    
    Dim sOutputFilePath As String
    
    bSuccess = True
    msCurrentFSC = sSalespersonKeyId
    msCurrentBranchCd = sBranchCd
    
    sOutputFilePath = GetOutputPath() & Trim(GetCurrentFiscalPeriod()) & "_" & Trim(sReportId) & "_" & sReportExtension & ".PDF"
    
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
Debug.Print "ExportExcel"

On Error GoTo eh:
    Dim bSuccess As Boolean
    
    Dim sOutputFilePath As String
    
    bSuccess = True
    msCurrentFSC = sSalespersonKeyId
    
    sOutputFilePath = GetOutputPath() & Trim(GetCurrentFiscalPeriod()) & "_" & Trim(sReportId) & "_" & sReportExtension & ".XLSX"
    
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
Debug.Print "LogEventToFile"

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





Sub ExportBatchESS_Summary()
Debug.Print "ExportBatchESS_Summary"

    ExportReportPDF "", "CALGY", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "CALGY"
    ExportReportPDF "", "EDMON", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "EDMON"
    ExportReportPDF "", "HALFX", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "HALFX"
    ExportReportPDF "", "LONDN", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "LONDN"
    ExportReportPDF "", "MNTRL", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "MNTRL"
    ExportReportPDF "", "OTTWA", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "OTTWA"
    ExportReportPDF "", "QUEBC", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "QUEBC"
    ExportReportPDF "", "REGIN", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "REGIN"
    ExportReportPDF "", "SJOHN", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "SJOHN"
    ExportReportPDF "", "TORNT", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "TORNT"
    ExportReportPDF "", "VACVR", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "VACVR"
    ExportReportPDF "", "VICTR", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "VICTR"
    ExportReportPDF "", "WINPG", "BranchESS-Signoff", "rptCommESSStatementSummaryReport", "WINPG"

End Sub


'   Main - Export FSC reports
Public Function ExportFSCCommBatch()
Debug.Print "ExportFSCCommBatch"
    InitParams
    
    ExportBatchESS
''    ExportBatchESS_Summary

''    MsgBox "ESS Details exported!"
    
    ExportBatch
    MsgBox "FSC Details exported!"
    
End Function