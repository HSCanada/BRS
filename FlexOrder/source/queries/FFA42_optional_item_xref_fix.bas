Operation =1
Option =0
Where ="(((flex_item_xref.status_code)=0) AND (([ITEMNO] & [ITEMDESC] & [Item]) Like \"*"
    "\" & [item lookup] & \"*\"))"
Begin InputTables
    Name ="flex_item_xref"
End
Begin OutputColumns
    Expression ="flex_item_xref.Supplier"
    Expression ="flex_item_xref.ITEMNO"
    Expression ="flex_item_xref.ITEMDESC"
    Expression ="flex_item_xref.Item"
    Expression ="flex_item_xref.Item_Suggest"
    Expression ="flex_item_xref.status_code"
    Expression ="flex_item_xref.note"
    Expression ="flex_item_xref.create_date"
    Expression ="flex_item_xref.product_type"
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
        dbText "Name" ="flex_item_xref.product_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.ITEMDESC"
        dbInteger "ColumnWidth" ="4095"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.ITEMNO"
        dbInteger "ColumnWidth" ="1755"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.note"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3195"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="flex_item_xref.Item"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1050"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="flex_item_xref.create_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.Item_Suggest"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1582
    Bottom =833
    Left =-1
    Top =-1
    Right =1566
    Bottom =130
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =77
        Top =50
        Right =221
        Bottom =194
        Top =0
        Name ="flex_item_xref"
        Name =""
    End
End
