Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_item_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_item_Staging.Item"
    Expression ="Integration_comm_item_Staging.fsc_comm_group_cd"
    Expression ="Integration_comm_item_Staging.fsc_comm_note_txt"
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
dbMemo "OrderBy" ="[CCA10_item_stage_load].[fsc_comm_group_cd]"
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
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1245
    Bottom =574
    Left =-1
    Top =-1
    Right =1195
    Bottom =237
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
End
