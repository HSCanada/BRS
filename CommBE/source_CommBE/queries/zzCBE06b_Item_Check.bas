Operation =1
Option =0
Where ="(((comm_item_master.comm_group_cd)=\"ITMCAM\") AND ((BRS_Item.MajorProductClass)"
    " Not In (\"074\",\"076\"))) OR (((comm_item_master.comm_group_cd)<>\"ITMCAM\") A"
    "ND ((BRS_Item.MajorProductClass) In (\"074\",\"076\"))) OR (((comm_item_master.c"
    "omm_group_cd)<>\"ITMEQ0\") AND ((BRS_Item.MajorProductClass)=\"075\"))"
Begin InputTables
    Name ="comm_item_master"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="comm_item_master.item_id"
    Expression ="comm_item_master.item_master_desc"
    Expression ="comm_item_master.comm_group_cd"
    Expression ="comm_item_master.note_txt"
    Expression ="BRS_Item.MajorProductClass"
    Expression ="BRS_Item.ItemCreationDate"
    Expression ="BRS_Item.Supplier"
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
        dbText "Name" ="comm_item_master.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.note_txt"
        dbInteger "ColumnWidth" ="5250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1905"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_item_master.item_master_desc"
        dbInteger "ColumnWidth" ="3315"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.MajorProductClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.ItemCreationDate"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1680"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1563
    Bottom =991
    Left =-1
    Top =-1
    Right =1531
    Bottom =572
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =227
        Bottom =296
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =585
        Top =46
        Right =922
        Bottom =506
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
