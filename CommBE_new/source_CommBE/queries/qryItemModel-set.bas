Operation =1
Option =0
Where ="(((BRS_Item.Item)=\"FREIGHT\") AND ((BRS_Item.comm_group_cd)=\"\"))"
Begin InputTables
    Name ="comm_item_group_rule"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="comm_item_group_rule.MinorProductClass"
    Expression ="comm_item_group_rule.Supplier"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="comm_item_group_rule.comm_group_cd"
    Expression ="comm_item_group_rule.comm_note_txt"
    Expression ="comm_item_group_rule.confidence_rt"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.Est12MoSales"
End
Begin Joins
    LeftTable ="BRS_Item"
    RightTable ="comm_item_group_rule"
    Expression ="BRS_Item.MinorProductClass = comm_item_group_rule.MinorProductClass"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="comm_item_group_rule"
    Expression ="BRS_Item.Supplier = comm_item_group_rule.Supplier"
    Flag =1
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
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3615"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_note_txt"
        dbInteger "ColumnWidth" ="3330"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_group_cd"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.confidence_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =937
    Left =-1
    Top =-1
    Right =1414
    Bottom =566
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =369
        Top =74
        Right =513
        Bottom =218
        Top =0
        Name ="comm_item_group_rule"
        Name =""
    End
    Begin
        Left =625
        Top =103
        Right =769
        Bottom =442
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
