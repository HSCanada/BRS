Option Compare Database

Public Function MapJDECust2AccPac(sAccPac, sJDE) As String
Dim sPref As String

    sPref = "J"
    
    If CLng(sJDE) >= 2000000 Then
        sPref = "T"
    ElseIf CLng(sJDE) >= 1900000 Then
        sPref = "R"
    ElseIf CLng(sJDE) >= 1800000 Then
        sPref = "Q"
    ElseIf CLng(sJDE) >= 1700000 Then
        sPref = "K"
    End If
    
    If IsNull(sAccPac) Then sAccPac = ""
    
    If sAccPac = "" Then
        MapJDECust2AccPac = sPref & Mid(CStr(sJDE), 3, 5)
    Else
        MapJDECust2AccPac = Right(Trim(sAccPac), 6)
    End If

End Function