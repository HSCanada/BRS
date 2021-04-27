Operation =1
Option =0
Where ="(((flex_order_file.batch_id) Is Null) AND ((flex_order_file.status_code)=0))"
Begin InputTables
    Name ="flex_order_file"
End
Begin OutputColumns
    Expression ="flex_order_file.order_file_name"
    Expression ="flex_order_file.flex_code"
    Expression ="flex_order_file.Supplier"
    Expression ="flex_order_file.batch_id"
    Expression ="flex_order_file.note"
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
        dbText "Name" ="flex_order_file.note"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1725"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="flex_order_file.order_file_name"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="flex_order_file.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_file.flex_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_order_file.batch_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1215"
        dbBoolean "ColumnHidden" ="0"
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
    Right =1458
    Bottom =588
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =84
        Top =103
        Right =429
        Bottom =364
        Top =0
        Name ="flex_order_file"
        Name =""
    End
End
