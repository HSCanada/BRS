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
'       20 Oct 21   tmc     build in DEV and Testing modes
' **
' ***************************************************************************

' ***************************************************************************
' ** User adjustable parameters
' ***************************************************************************

Const msApplicationName As String = "CommissionAdmin"
Const msApplicationVersionNum As String = "2.01"
Const mnODBCTimeout As Integer = 120

Const bCONFIG_MODE_DEV = True

' Ensure that connection string below is the same ODBC source used to link tables
'Development
Const gCONNECTIONSTRING_DEV As String = "ODBC;DRIVER=SQL Server;SERVER=CAHSIONNLSQL1;DATABASE=DEV_BRSales"
'Production
Const gCONNECTIONSTRING_PROD As String = "ODBC;DRIVER=SQL Server;SERVER=CAHSIONNLSQL1;DATABASE=BRSales"


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


' Invoice Batch record type
Type CommBatch
    sSalespersonKeyId As String * 30
    sReportId As String * 8
End Type



Public Function GetCurrentFSC() As String
    GetCurrentFSC = IIf(msCurrentFSC <> "", msCurrentFSC, "*")
    
' Test
    If bCONFIG_MODE_DEV Then
        GetCurrentFSC = "GMaves"
'        GetCurrentFSC = "GMaves"
'        GetCurrentFSC = "RWong"

'        GetCurrentFSC = "RPoch"
'        GetCurrentFSC = "RUSSELL.BURTON"
'        GetCurrentFSC = "JENNA.AZARKO.CCS"
'        GetCurrentFSC = "MARTIN.KUREK"
    End If
    


End Function

Public Function GetCurrentBranch() As String
    GetCurrentBranch = IIf(msCurrentBranchCd = "", "*", msCurrentBranchCd)

' Test
    If bCONFIG_MODE_DEV Then
        GetCurrentBranch = "TORNT"
'        GetCurrentBranch = "HALFX"
    End If


End Function


Function GetConnectionStr() As String
    If bCONFIG_MODE_DEV Then
        GetConnectionStr = gCONNECTIONSTRING_DEV
    Else
        GetConnectionStr = gCONNECTIONSTRING_PROD
    End If
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
    
    ' Determine connection string
    msConnectionString = GetConnectionStr()

    ' Load params from SQL Backend
    Set Db = CurrentDb
    Set qd = Db.CreateQueryDef("")
  
    qd.connect = msConnectionString
    qd.ReturnsRecords = True
    qd.ODBCTimeout = mnODBCTimeout
    
    qd.sql = "SELECT PriorFiscalMonth AS current_fiscal_yearmo_num, comm_output_path_txt AS output_path_txt, comm_log_filepath_txt AS log_filepath_txt FROM dbo.BRS_Config"

    Debug.Print qd.sql
    Set rs = qd.OpenRecordset(dbOpenForwardOnly, dbSQLPassThrough)
    
    If Not (rs.EOF And rs.BOF) Then
        msEventFile = rs("log_filepath_txt")
        msOutputPath = rs("output_path_txt")
        msCurrentFiscalNum = rs("current_fiscal_yearmo_num")
           
        ' Init vars
        msCurrentFSC = ""
        msCurrentReportID = ""
        
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




Private Function ExportDocuments(sSalespersonKeyId As String, sReportId As String) As Boolean
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
    
    Call DoCmd.TransferSpreadsheet(acExport, , sReportName, sOutputFilePath, True)
    

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
    
    If bCONFIG_MODE_DEV Then
        Print #1, "DEV - " & sEventMsg  ' Print text to file.
    Else
        Print #1, sEventMsg  ' Print text to file.
    End If
    
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


Sub Test()
    InitParams
    
    MsgBox "Done!"
End Sub


'   Export reports
Public Function ExportFSCCommBatch()
    InitParams
    
    ExportBatchESS
    ExportBatchESS_Summary

''    MsgBox "ESS Details exported!"
    
    ExportBatch
    MsgBox "FSC Details exported!"
    
End Function