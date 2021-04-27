Operation =1
Option =0
Where ="(((BRS_Item.Supplier)=\"PROCGA\") AND ((flex_item_xref.Item) Is Null))"
Begin InputTables
    Name ="BRS_Item"
    Name ="flex_item_xref"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.ManufPartNumber"
    Expression ="BRS_Item.ItemStatus"
    Expression ="BRS_Item.Est12MoSales"
End
Begin Joins
    LeftTable ="BRS_Item"
    RightTable ="flex_item_xref"
    Expression ="BRS_Item.Item = flex_item_xref.Item"
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
        dbText "Name" ="BRS_Item.ManufPartNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3330"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemStatus"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="flex_item_xref.Item"
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
        Left =93
        Top =51
        Right =369
        Bottom =391
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =529
        Top =82
        Right =768
        Bottom =334
        Top =0
        Name ="flex_item_xref"
        Name =""
    End
End
