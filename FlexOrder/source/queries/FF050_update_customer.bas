Operation =4
Option =0
Begin InputTables
    Name ="flex_order_header"
    Name ="flex_customer_xref"
End
Begin OutputColumns
    Name ="flex_order_header.ShipTo"
    Expression ="[flex_customer_xref]![ShipTo]"
    Name ="flex_order_header.status_code"
    Expression ="0"
    Name ="flex_order_header.note"
    Expression ="\"Good, TC, 15 Dec 20\""
End
Begin Joins
    LeftTable ="flex_order_header"
    RightTable ="flex_customer_xref"
    Expression ="flex_order_header.Supplier = flex_customer_xref.Supplier"
    Flag =1
    LeftTable ="flex_order_header"
    RightTable ="flex_customer_xref"
    Expression ="flex_order_header.ACCOUNT = flex_customer_xref.ACCOUNT"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="flex_order_header.note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ShipTo"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.note"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1616
    Bottom =917
    Left =-1
    Top =-1
    Right =1600
    Bottom =672
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =53
        Top =46
        Right =462
        Bottom =426
        Top =0
        Name ="flex_order_header"
        Name =""
    End
    Begin
        Left =559
        Top =100
        Right =714
        Bottom =309
        Top =0
        Name ="flex_customer_xref"
        Name =""
    End
End
