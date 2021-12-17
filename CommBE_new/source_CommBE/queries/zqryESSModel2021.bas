Operation =1
Option =0
Having ="(((BRS_ItemCategory.CategoryRollup) In (\"3DDIMG\",\"CHAIRS\",\"DELVRY\",\"DENLA"
    "H\",\"DENLAS\",\"EQUCOR\",\"EQUOTH\",\"EQUPKG\")))"
Begin InputTables
    Name ="BRS_ItemCategory"
    Name ="zzzItem"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_ItemCategory.CategoryRollup"
    Expression ="BRS_Item.SubMajorProdClass"
    Expression ="BRS_ItemCategory.MinorProductClass"
    Alias ="BevList"
    Expression ="IIf([zzzItem]![Item] Is Null,\"N\",\"Y\")"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.comm_group_cd"
    Alias ="SumOfEst12MoSales"
    Expression ="Sum(BRS_Item.Est12MoSales)"
    Alias ="CountOfItem"
    Expression ="Count(BRS_Item.Item)"
End
Begin Joins
    LeftTable ="BRS_ItemCategory"
    RightTable ="BRS_Item"
    Expression ="BRS_ItemCategory.MinorProductClass = BRS_Item.MinorProductClass"
    Flag =1
    LeftTable ="zzzItem"
    RightTable ="BRS_Item"
    Expression ="zzzItem.Item = BRS_Item.Item"
    Flag =3
End
Begin Groups
    Expression ="BRS_ItemCategory.CategoryRollup"
    GroupLevel =0
    Expression ="BRS_Item.SubMajorProdClass"
    GroupLevel =0
    Expression ="BRS_ItemCategory.MinorProductClass"
    GroupLevel =0
    Expression ="IIf([zzzItem]![Item] Is Null,\"N\",\"Y\")"
    GroupLevel =0
    Expression ="BRS_Item.Supplier"
    GroupLevel =0
    Expression ="BRS_Item.comm_group_cd"
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
        dbText "Name" ="CountOfItem"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfEst12MoSales"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.CategoryRollup"
        dbInteger "ColumnWidth" ="1845"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemCategory.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BevList"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-1
    Top =6
    Right =1523
    Bottom =904
    Left =-1
    Top =-1
    Right =1500
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =534
        Top =59
        Right =880
        Bottom =460
        Top =0
        Name ="BRS_ItemCategory"
        Name =""
    End
    Begin
        Left =36
        Top =48
        Right =180
        Bottom =192
        Top =0
        Name ="zzzItem"
        Name =""
    End
    Begin
        Left =246
        Top =75
        Right =452
        Bottom =403
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
