Operation =1
Option =0
Begin InputTables
    Name ="zzzItemList"
    Name ="comm_item_master"
End
Begin OutputColumns
    Expression ="zzzItemList.item_id"
    Expression ="comm_item_master.item_master_desc"
    Expression ="comm_item_master.hsi_manuf_cd"
    Expression ="comm_item_master.comm_group_cd"
    Expression ="comm_item_master.note_txt"
End
Begin Joins
    LeftTable ="zzzItemList"
    RightTable ="comm_item_master"
    Expression ="zzzItemList.item_id = comm_item_master.item_id"
    Flag =2
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
        dbText "Name" ="zzzItemList.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_master_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.hsi_manuf_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.note_txt"
        dbInteger "ColumnWidth" ="4140"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1511
    Bottom =974
    Left =-1
    Top =-1
    Right =1479
    Bottom =651
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="zzzItemList"
        Name =""
    End
    Begin
        Left =240
        Top =12
        Right =531
        Bottom =273
        Top =0
        Name ="comm_item_master"
        Name =""
    End
End
