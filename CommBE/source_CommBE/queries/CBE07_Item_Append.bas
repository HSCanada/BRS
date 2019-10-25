Operation =3
Name ="comm_item_master"
Option =0
Where ="(((comm_item_master.item_id) Is Null))"
Begin InputTables
    Name ="comm_item_master"
    Name ="STAGE_comm_item_master_import"
End
Begin OutputColumns
    Name ="item_id"
    Expression ="STAGE_comm_item_master_import.ItemSchein"
    Name ="item_master_desc"
    Expression ="STAGE_comm_item_master_import.Desc"
    Name ="comm_group_cd"
    Expression ="STAGE_comm_item_master_import.Comm_group"
    Name ="hsi_manuf_cd"
    Expression ="STAGE_comm_item_master_import.Manufact"
    Name ="note_txt"
    Expression ="STAGE_comm_item_master_import.Note"
End
Begin Joins
    LeftTable ="comm_item_master"
    RightTable ="STAGE_comm_item_master_import"
    Expression ="comm_item_master.item_id=STAGE_comm_item_master_import.ItemSchein"
    Flag =3
End
Begin OrderBy
    Expression ="STAGE_comm_item_master_import.Comm_group"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="STAGE_comm_item_master_import.ItemSchein"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_master_import.Desc"
        dbInteger "ColumnWidth" ="3585"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_master_import.Comm_group"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_master_import.Manufact"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_comm_item_master_import.Note"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_master_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="NEW_Comm_group"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1539
    Bottom =1004
    Left =-1
    Top =-1
    Right =1516
    Bottom =534
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =845
        Top =30
        Right =1381
        Bottom =404
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =37
        Top =35
        Right =496
        Bottom =371
        Top =0
        Name ="STAGE_comm_item_master_import"
        Name =""
    End
End
