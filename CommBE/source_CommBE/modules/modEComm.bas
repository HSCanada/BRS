Option Compare Database

Function get_order_type(vOrd As Variant, vContact As Variant, vRef As Variant, Optional old_ord As Boolean = False) As String
' will return a field with an order type.
Dim strReturn As String, bot As String, top As String
 
'check for types
If old_ord Then
    bot = "9600000"
    top = "9700000"
Else
    bot = "88000000"
    top = "93000000"
End If
 
If Left(vOrd, 2) = "IQ" Then    ' einstein handheld
    strReturn = "HH"
ElseIf Left(vOrd, 2) = "WE" And Left(vContact, 2) <> "EO" Then  ' aruba web
    strReturn = "AWEB"
ElseIf Left(vOrd, 2) <> "WE" And Left(vContact, 2) = "EO" Then  ' aruba fax
    strReturn = "AFAX"
ElseIf Left(vContact, 3) = "FAX" Or IsNull(vContact) Then ' fax
    strReturn = "FAX"
ElseIf (vOrd < bot Or vOrd > top) And (vRef Like "REP*" Or IsNull(vRef)) Then ' laptop
    strReturn = "LAPTOP"
ElseIf Left(vRef, 3) = "REP" Then   ' repphone
    strReturn = "REPPHONE"
Else
    strReturn = "PHONE"
End If
 
    get_order_type = strReturn
 
End Function