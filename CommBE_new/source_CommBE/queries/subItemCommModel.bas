Operation =1
Option =0
Where ="(((BRS_Item.Item)<>\"\") AND ((BRS_Item.SalesCategory)<>\"\" And (BRS_Item.Sales"
    "Category)<>\"UNDEF\") AND ((BRS_Item.ItemStatus)<>\"P\") AND ((BRS_Item.comm_gro"
    "up_cd)<>\"\"))"
Begin InputTables
    Name ="BRS_Item"
    Name ="BRS_ItemCategory"
End
Begin OutputColumns
    Expression ="BRS_Item.SalesCategory"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_ItemCategory.MinorProductClass"
    Expression ="BRS_ItemCategory.major_cd"
    Alias ="major_desc"
    Expression ="First(BRS_ItemCategory.major_desc)"
    Expression ="BRS_Item.SubMajorProdClass"
    Alias ="submajor_desc"
    Expression ="First(BRS_ItemCategory.submajor_desc)"
    Expression ="BRS_ItemCategory.CategoryRollup"
    Expression ="BRS_Item.comm_group_cd"
    Alias ="Est12MoSales"
    Expression ="Sum(BRS_Item.Est12MoSales)"
    Alias ="item_count"
    Expression ="Count(BRS_Item.Item)"
End
Begin Joins
    LeftTable ="BRS_Item"
    RightTable ="BRS_ItemCategory"
    Expression ="BRS_Item.MinorProductClass = BRS_ItemCategory.MinorProductClass"
    Flag =1
End
Begin Groups
    Expression ="BRS_Item.SalesCategory"
    GroupLevel =0
    Expression ="BRS_Item.Supplier"
    GroupLevel =0
    Expression ="BRS_ItemCategory.MinorProductClass"
    GroupLevel =0
    Expression ="BRS_ItemCategory.major_cd"
    GroupLevel =0
    Expression ="BRS_Item.SubMajorProdClass"
    GroupLevel =0
    Expression ="BRS_ItemCategory.CategoryRollup"
    GroupLevel =0
    Expression ="BRS_Item.comm_group_cd"
    GroupLevel =0
    Expression ="BRS_Item.Label"
    GroupLevel =0
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
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SalesCategory"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.CategoryRollup"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="major_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="submajor_desc"
        dbInteger "ColumnWidth" ="3840"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="item_count"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.major_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.MinorProductClass"
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
    Right =1388
    Bottom =583
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =72
        Right =488
        Bottom =443
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =670
        Top =131
        Right =938
        Bottom =458
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
End
