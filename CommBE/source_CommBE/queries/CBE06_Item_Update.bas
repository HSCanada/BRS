Operation =1
Option =0
Where ="(((comm_item_master.comm_group_cd)<>[STAGE_comm_item_master_import]![Comm_group]"
    " Or (comm_item_master.comm_group_cd)=\"\"))"
Begin InputTables
    Name ="comm_item_master"
    Name ="STAGE_comm_item_master_import"
End
Begin OutputColumns
    Expression ="comm_item_master.item_id"
    Expression ="comm_item_master.item_master_desc"
    Expression ="comm_item_master.hsi_manuf_cd"
    Expression ="comm_item_master.note_txt"
    Alias ="NEW_Comm_group"
    Expression ="STAGE_comm_item_master_import.Comm_group"
    Alias ="OLD_Comm_group"
    Expression ="comm_item_master.comm_group_cd"
    Alias ="New_Note"
    Expression ="STAGE_comm_item_master_import.Note"
    Expression ="STAGE_comm_item_master_import.Desc"
End
Begin Joins
    LeftTable ="comm_item_master"
    RightTable ="STAGE_comm_item_master_import"
    Expression ="comm_item_master.item_id = STAGE_comm_item_master_import.ItemSchein"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
dbMemo "OrderBy" ="[CBE06_Item_Update].[note_txt] DESC, [CBE06_Item_Update].[OLD_Comm_group]"
Begin
    Begin
        dbText "Name" ="comm_item_master.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_master_desc"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3585"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_item_master.note_txt"
        dbInteger "ColumnWidth" ="3735"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="New_Note"
        dbInteger "ColumnWidth" ="3645"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.hsi_manuf_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="OLD_Comm_group"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="NEW_Comm_group"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_master_import.Desc"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1460
    Bottom =960
    Left =-1
    Top =-1
    Right =1428
    Bottom =436
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =50
        Top =52
        Right =586
        Bottom =426
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =664
        Top =41
        Right =1123
        Bottom =377
        Top =0
        Name ="STAGE_comm_item_master_import"
        Name =""
    End
End
