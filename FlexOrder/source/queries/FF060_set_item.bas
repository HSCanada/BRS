Operation =4
Option =0
Begin InputTables
    Name ="flex_order_detail"
    Name ="flex_item_xref"
End
Begin OutputColumns
    Name ="flex_order_detail.Item"
    Expression ="[flex_item_xref]![item]"
    Name ="flex_order_detail.status_code"
    Expression ="0"
    Name ="flex_order_detail.note"
    Expression ="\"Good TC, 15 Dec 20\""
End
Begin Joins
    LeftTable ="flex_order_detail"
    RightTable ="flex_item_xref"
    Expression ="flex_order_detail.Supplier = flex_item_xref.Supplier"
    Flag =1
    LeftTable ="flex_order_detail"
    RightTable ="flex_item_xref"
    Expression ="flex_order_detail.ITEMNO = flex_item_xref.ITEMNO"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="flex_order_detail.note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.ITEMNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.ORDERNO"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_detail.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.status_code"
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
        Left =76
        Top =66
        Right =399
        Bottom =382
        Top =0
        Name ="flex_order_detail"
        Name =""
    End
    Begin
        Left =523
        Top =95
        Right =820
        Bottom =413
        Top =0
        Name ="flex_item_xref"
        Name =""
    End
End
