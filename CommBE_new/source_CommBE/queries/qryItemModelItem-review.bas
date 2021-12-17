Operation =1
Option =0
Where ="(((comm_item_group_rule.MinorProductClass) Like \"372-03*\") AND ((BRS_Item.Est1"
    "2MoSales)>1000))"
Begin InputTables
    Name ="comm_item_group_rule"
    Name ="BRS_Item"
    Name ="BRS_ItemCategory"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="comm_item_group_rule.MinorProductClass"
    Expression ="comm_item_group_rule.Supplier"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.comm_note_txt"
    Alias ="comm_rule"
    Expression ="comm_item_group_rule.comm_group_cd"
    Expression ="BRS_Item.comm_group_eps_cd"
    Expression ="BRS_Item.ItemStatus"
    Expression ="comm_item_group_rule.confidence_rt"
    Expression ="BRS_Item.Est12MoSales"
    Expression ="BRS_ItemCategory.CategoryRollup"
    Expression ="BRS_Item.comm_group_cps_cd"
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
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemCategory"
    Expression ="BRS_Item.MinorProductClass = BRS_ItemCategory.MinorProductClass"
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
        dbText "Name" ="comm_item_group_rule.confidence_rt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1710"
        dbBoolean "ColumnHidden" ="0"
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
        dbInteger "ColumnWidth" ="1680"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.CategoryRollup"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cps_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemStatus"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_eps_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_new"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_rule"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItem.Note3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_new_note"
        dbInteger "ColumnWidth" ="2040"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_note_txt"
        dbInteger "ColumnWidth" ="2760"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1550
    Bottom =938
    Left =-1
    Top =-1
    Right =1526
    Bottom =423
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =61
        Top =56
        Right =205
        Bottom =200
        Top =0
        Name ="comm_item_group_rule"
        Name =""
    End
    Begin
        Left =382
        Top =3
        Right =632
        Bottom =467
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =950
        Top =112
        Right =1264
        Bottom =432
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
End
