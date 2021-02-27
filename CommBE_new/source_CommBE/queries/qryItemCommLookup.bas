Operation =1
Option =0
Where ="(((BRS_Item.SubMajorProdClass)=\"373-01\"))"
Begin InputTables
    Name ="BRS_Item"
    Name ="BRS_ItemCategory"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_ItemCategory.CategoryRollup"
    Expression ="BRS_Item.comm_group_cd"
    Expression ="BRS_Item.comm_group_eps_cd"
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
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1466
    Bottom =748
    Left =-1
    Top =-1
    Right =1442
    Bottom =290
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
        Left =562
        Top =95
        Right =706
        Bottom =239
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
End
