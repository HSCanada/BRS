Operation =1
Option =0
Where ="(((BRS_Item.MajorProductClass)=\"073\" Or (BRS_Item.MajorProductClass)=\"372\" O"
    "r (BRS_Item.MajorProductClass)=\"071\")) OR (((comm_item_master.comm_group_cd)=\""
    "DIGMAT\"))"
Begin InputTables
    Name ="comm_item_master"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.ItemStatus"
    Expression ="BRS_Item.Supplier"
    Expression ="comm_item_master.comm_group_cd"
    Expression ="comm_item_master.note_txt"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.SubMajorProdClass"
    Expression ="BRS_Item.MinorProductClass"
    Expression ="BRS_Item.Est12MoSales"
End
Begin Joins
    LeftTable ="comm_item_master"
    RightTable ="BRS_Item"
    Expression ="comm_item_master.item_id = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[t Zahn372_073].[MajorProductClass], [t Zahn372_073].[SubMajorProdClass]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3285"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1003"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MinorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.note_txt"
        dbInteger "ColumnWidth" ="2685"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemStatus"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1624
    Bottom =999
    Left =-1
    Top =-1
    Right =1456
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =462
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =667
        Bottom =483
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
