Operation =1
Option =0
Where ="((([Item Master].[HSI Item#]) Is Null))"
Begin InputTables
    Name ="0-QrySel-SetLeaders-Wholesales"
    Name ="Item Master"
End
Begin OutputColumns
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Wholesale Set Leader]"
    Expression ="[Item Master].[HSI Item#]"
End
Begin Joins
    LeftTable ="0-QrySel-SetLeaders-Wholesales"
    RightTable ="Item Master"
    Expression ="[0-QrySel-SetLeaders-Wholesales].[Wholesale Set Leader]=[Item Master].[HSI Item#"
        "]"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="[Item Master].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[0-QrySel-SetLeaders-Wholesales].[Wholesale Set Leader]"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1572
    Bottom =1008
    Left =-1
    Top =-1
    Right =1553
    Bottom =343
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =290
        Bottom =309
        Top =0
        Name ="0-QrySel-SetLeaders-Wholesales"
        Name =""
    End
    Begin
        Left =455
        Top =12
        Right =668
        Bottom =271
        Top =0
        Name ="Item Master"
        Name =""
    End
End
