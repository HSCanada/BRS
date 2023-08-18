Operation =4
Option =0
Where ="((([Item Master].[Wholesale Set Leader]) Is Null))"
Begin InputTables
    Name ="Item Master"
End
Begin OutputColumns
    Name ="[Item Master].[Exception Message]"
    Expression ="[Item Master]![Exception Message] & \"NO_SETLEADER \""
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbText "Description" ="tc"
Begin
    Begin
        dbText "Name" ="[Item Master].[HSI Item#]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Wholesale Set Leader]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[Item Master].[Exception Message]"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =63
    Top =160
    Right =1515
    Bottom =1004
    Left =-1
    Top =-1
    Right =1428
    Bottom =187
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =48
        Top =12
        Right =513
        Bottom =305
        Top =0
        Name ="Item Master"
        Name =""
    End
End
