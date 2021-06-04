Operation =1
Option =0
Where ="(((flex_item_xref.Item)=\"5892078\")) OR (((flex_item_xref.Item)=\"5890457\"))"
Begin InputTables
    Name ="flex_item_xref"
End
Begin OutputColumns
    Expression ="flex_item_xref.Supplier"
    Expression ="flex_item_xref.ITEMNO"
    Expression ="flex_item_xref.ITEMDESC"
    Expression ="flex_item_xref.Item"
    Expression ="flex_item_xref.Item_Suggest"
    Expression ="flex_item_xref.note"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[Item], [Query1].[Supplier], [Query1].[ITEMNO], [Query1].[ITEMDESC], [Q"
    "uery1].[Item_Suggest], [Query1].[note]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="flex_item_xref.note"
        dbInteger "ColumnWidth" ="3195"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.Item_Suggest"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.ITEMDESC"
        dbInteger "ColumnWidth" ="3855"
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
        dbText "Name" ="flex_item_xref.Supplier"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1518
    Bottom =918
    Left =-1
    Top =-1
    Right =499
    Bottom =597
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =68
        Top =53
        Right =396
        Bottom =441
        Top =0
        Name ="flex_item_xref"
        Name =""
    End
End
