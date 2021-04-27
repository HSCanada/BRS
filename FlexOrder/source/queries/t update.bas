Operation =1
Option =0
Where ="(((flex_order_header.ACCOUNT) Is Null))"
Begin InputTables
    Name ="flex_customer_xref"
    Name ="flex_order_header"
End
Begin OutputColumns
    Expression ="flex_customer_xref.Supplier"
    Expression ="flex_customer_xref.ACCOUNT"
    Expression ="flex_customer_xref.COMPANY"
    Expression ="flex_customer_xref.POSTALCODE"
    Expression ="flex_customer_xref.PHONE"
    Expression ="flex_customer_xref.status_code"
    Expression ="flex_customer_xref.ShipTo"
    Expression ="flex_customer_xref.note"
    Expression ="flex_order_header.ACCOUNT"
End
Begin Joins
    LeftTable ="flex_customer_xref"
    RightTable ="flex_order_header"
    Expression ="flex_customer_xref.ACCOUNT = flex_order_header.ACCOUNT"
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
        dbText "Name" ="flex_customer_xref.COMPANY"
        dbInteger "ColumnWidth" ="3915"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_header.ACCOUNT"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.note"
        dbInteger "ColumnWidth" ="2760"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.ACCOUNT"
        dbInteger "ColumnWidth" ="1335"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.POSTALCODE"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_customer_xref.PHONE"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1474
    Bottom =918
    Left =-1
    Top =-1
    Right =1188
    Bottom =673
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =57
        Top =53
        Right =201
        Bottom =197
        Top =0
        Name ="flex_customer_xref"
        Name =""
    End
    Begin
        Left =314
        Top =55
        Right =458
        Bottom =199
        Top =0
        Name ="flex_order_header"
        Name =""
    End
End
