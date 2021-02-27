Operation =1
Option =0
Where ="(((BRS_Item.Item)<>\"\"))"
Begin InputTables
    Name ="BRS_Item"
    Name ="BRS_ItemCategory"
    Name ="comm_item_group_rule"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_ItemCategory.CategoryRollup"
    Expression ="BRS_Item.comm_group_cd"
    Alias ="suggest_comm_group_cd"
    Expression ="comm_item_group_rule.comm_group_cd"
    Expression ="BRS_Item.comm_note_txt"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.MinorProductClass"
    Expression ="BRS_ItemCategory.major_desc"
    Expression ="BRS_Item.Est12MoSales"
    Expression ="BRS_Item.SubMajorProdClass"
End
Begin Joins
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemCategory"
    Expression ="BRS_Item.MinorProductClass = BRS_ItemCategory.MinorProductClass"
    Flag =1
    LeftTable ="BRS_Item"
    RightTable ="comm_item_group_rule"
    Expression ="BRS_Item.MinorProductClass = comm_item_group_rule.MinorProductClass"
    Flag =2
    LeftTable ="BRS_Item"
    RightTable ="comm_item_group_rule"
    Expression ="BRS_Item.Supplier = comm_item_group_rule.Supplier"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qryItemCommExport].[Item], [qryItemCommExport].[comm_group_cd]"
Begin
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3210"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_note_txt"
        dbInteger "ColumnWidth" ="4050"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.major_desc"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1755"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_eps_cd"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.CategoryRollup"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1845"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_group_rule.comm_group_cd"
        dbInteger "ColumnWidth" ="4245"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="suggest_comm_group_cd"
        dbInteger "ColumnWidth" ="2760"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1550
    Bottom =946
    Left =-1
    Top =-1
    Right =1103
    Bottom =468
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =60
        Top =44
        Right =500
        Bottom =491
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =657
        Top =65
        Right =801
        Bottom =209
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
    Begin
        Left =678
        Top =258
        Right =822
        Bottom =402
        Top =0
        Name ="comm_item_group_rule"
        Name =""
    End
End
