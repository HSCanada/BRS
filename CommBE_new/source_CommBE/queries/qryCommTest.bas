Operation =1
Option =0
Begin InputTables
    Name ="BRS_Item"
    Name ="BRS_ItemCategory"
    Name ="hfm_global_product"
    Name ="comm_item_group_rule"
    Name ="zzzItem"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.MinorProductClass"
    Expression ="BRS_Item.Est12MoSales"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.comm_note_txt"
    Expression ="BRS_ItemCategory.global_product_class"
    Expression ="hfm_global_product.global_product_class_descr"
    Expression ="comm_item_group_rule.comm_group_cd"
    Expression ="comm_item_group_rule.comm_note_txt"
End
Begin Joins
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemCategory"
    Expression ="BRS_Item.MinorProductClass = BRS_ItemCategory.MinorProductClass"
    Flag =1
    LeftTable ="BRS_ItemCategory"
    RightTable ="hfm_global_product"
    Expression ="BRS_ItemCategory.global_product_class = hfm_global_product.global_product_class"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="comm_item_group_rule"
    Expression ="BRS_Item.MinorProductClass = comm_item_group_rule.MinorProductClass"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="comm_item_group_rule"
    Expression ="BRS_Item.Supplier = comm_item_group_rule.Supplier"
    Flag =1
    LeftTable ="zzzItem"
    RightTable ="BRS_Item"
    Expression ="zzzItem.Item = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[BRS_Item].[comm_group_cd]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_note_txt"
        dbInteger "ColumnWidth" ="3495"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemHistory.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemHistory.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemHistory.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.global_product_class"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="hfm_global_product.global_product_class_descr"
        dbInteger "ColumnWidth" ="2955"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_group_cd"
        dbInteger "ColumnWidth" ="4245"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1638
    Bottom =946
    Left =-1
    Top =-1
    Right =1344
    Bottom =373
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =210
        Top =12
        Right =741
        Bottom =359
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =778
        Top =43
        Right =922
        Bottom =187
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
    Begin
        Left =909
        Top =66
        Right =1053
        Bottom =210
        Top =0
        Name ="hfm_global_product"
        Name =""
    End
    Begin
        Left =678
        Top =61
        Right =822
        Bottom =205
        Top =0
        Name ="comm_item_group_rule"
        Name =""
    End
    Begin
        Left =12
        Top =62
        Right =156
        Bottom =206
        Top =0
        Name ="zzzItem"
        Name =""
    End
End
