Operation =1
Option =0
Where ="(((BRS_Item.ItemStatus)<>\"P\") AND ((comm_item_master.comm_group_cd) Like \"DIG"
    "*\"))"
Begin InputTables
    Name ="BRS_Item"
    Name ="comm_item_master"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="BRS_Item.ItemDescription"
    Expression ="BRS_Item.Size"
    Expression ="BRS_Item.Strength"
    Expression ="BRS_Item.ItemStatus"
    Expression ="BRS_Item.Supplier"
    Expression ="comm_item_master.comm_group_cd"
    Expression ="comm_item_master.note_txt"
    Expression ="BRS_Item.ItemCreationDate"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.SubMajorProdClass"
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
dbBoolean "OrderByOn" ="0"
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
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemDescription"
        dbInteger "ColumnWidth" ="3405"
        dbBoolean "ColumnHidden" ="0"
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
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
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
        dbText "Name" ="BRS_Item.ItemCreationDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Size"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Strength"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =-16
    Right =1511
    Bottom =935
    Left =-1
    Top =-1
    Right =1479
    Bottom =588
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =436
        Top =34
        Right =846
        Bottom =544
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =42
        Top =24
        Right =354
        Bottom =384
        Top =0
        Name ="comm_item_master"
        Name =""
    End
End
