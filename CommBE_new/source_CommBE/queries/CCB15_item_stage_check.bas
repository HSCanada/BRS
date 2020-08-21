Operation =1
Option =0
Where ="(((comm_group.comm_group_cd) Is Null))"
Begin InputTables
    Name ="Integration_comm_item_Staging"
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="Integration_comm_item_Staging.Item"
    Expression ="Integration_comm_item_Staging.fsc_comm_group_cd"
    Expression ="Integration_comm_item_Staging.fsc_comm_note_txt"
    Expression ="comm_group.comm_group_cd"
End
Begin Joins
    LeftTable ="Integration_comm_item_Staging"
    RightTable ="comm_group"
    Expression ="Integration_comm_item_Staging.fsc_comm_group_cd = comm_group.comm_group_cd"
    Flag =2
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
        dbText "Name" ="Integration_comm_item_Staging.fsc_comm_note_txt"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_item_Staging.fsc_comm_group_cd"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_item_Staging.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_cd"
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
    Bottom =220
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =94
        Top =33
        Right =238
        Bottom =177
        Top =0
        Name ="Integration_comm_item_Staging"
        Name =""
    End
    Begin
        Left =356
        Top =51
        Right =500
        Bottom =195
        Top =0
        Name ="comm_group"
        Name =""
    End
End
