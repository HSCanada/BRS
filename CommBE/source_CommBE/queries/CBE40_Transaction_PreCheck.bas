Operation =1
Option =0
Begin InputTables
    Name ="comm_transaction_stage"
End
Begin OutputColumns
    Expression ="comm_transaction_stage.fiscal_yearmo_num"
    Expression ="comm_transaction_stage.source_cd"
    Alias ="LineCount"
    Expression ="Count(comm_transaction_stage.record_id)"
    Alias ="LastLineID"
    Expression ="Max(comm_transaction_stage.line_id)"
End
Begin Groups
    Expression ="comm_transaction_stage.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction_stage.source_cd"
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
        dbText "Name" ="comm_transaction_stage.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_stage.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="LineCount"
        dbInteger "ColumnWidth" ="2160"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="LastLineID"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1549
    Bottom =1004
    Left =-1
    Top =-1
    Right =1526
    Bottom =678
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =389
        Bottom =332
        Top =0
        Name ="comm_transaction_stage"
        Name =""
    End
End
