Operation =1
Option =0
Where ="(((flex_customer_xref.ACCOUNT) Is Null))"
Begin InputTables
    Name ="zzzShipto"
    Name ="flex_customer_xref"
End
Begin OutputColumns
    Alias ="acct"
    Expression ="zzzShipto.ST"
    Alias ="shipto"
    Expression ="CLng([zzzShipto]![Note])"
    Alias ="name"
    Expression ="zzzShipto.Note2"
End
Begin Joins
    LeftTable ="zzzShipto"
    RightTable ="flex_customer_xref"
    Expression ="zzzShipto.ST = flex_customer_xref.ACCOUNT"
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
        dbText "Name" ="flex_customer_xref.note"
        dbInteger "ColumnWidth" ="2730"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.Note"
        dbInteger "ColumnWidth" ="5100"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.ST"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1001"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ShipTo_Suggest"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbInteger "ColumnWidth" ="5100"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="acct"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="shipto"
        dbInteger "ColumnWidth" ="5100"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzShipto.Note2"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1582
    Bottom =918
    Left =-1
    Top =-1
    Right =1296
    Bottom =656
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =61
        Top =35
        Right =205
        Bottom =179
        Top =0
        Name ="zzzShipto"
        Name =""
    End
    Begin
        Left =410
        Top =252
        Right =669
        Bottom =497
        Top =0
        Name ="flex_customer_xref"
        Name =""
    End
End
