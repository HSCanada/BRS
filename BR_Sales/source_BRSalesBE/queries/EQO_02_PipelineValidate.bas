Operation =1
Option =0
Having ="(((IsNumeric([Quantity]))=True))"
Begin InputTables
    Name ="lnkEQProj"
End
Begin OutputColumns
    Alias ="ExpPrice"
    Expression ="Sum([Quantity]*[Price])"
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
Begin
    Begin
        dbText "Name" ="ExpPrice"
        dbText "Format" ="$#,##0.00;($#,##0.00)"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =29
    Top =15
    Right =695
    Bottom =454
    Left =-1
    Top =-1
    Right =1419
    Bottom =460
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =102
        Top =56
        Right =565
        Bottom =454
        Top =0
        Name ="lnkEQProj"
        Name =""
    End
End
