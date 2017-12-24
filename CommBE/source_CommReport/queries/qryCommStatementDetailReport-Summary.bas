Operation =1
Option =0
Where ="((([comm_backend_detail_fsc].salesperson_key_id)=GetCurrentFSC()))"
Begin InputTables
    Name ="comm_backend_detail_fsc"
End
Begin OutputColumns
    Expression ="[comm_backend_detail_fsc].salesperson_key_id"
    Expression ="[comm_backend_detail_fsc].item_comm_group_cd"
    Alias ="pre_total_transaction_amt"
    Expression ="Sum([comm_backend_detail_fsc].transaction_amt)"
    Alias ="pre_total_gp_ext_amt"
    Expression ="Sum([comm_backend_detail_fsc].gp_ext_amt)"
    Alias ="pre_total_comm_amt"
    Expression ="Sum([comm_backend_detail_fsc].comm_amt)"
End
Begin Groups
    Expression ="[comm_backend_detail_fsc].salesperson_key_id"
    GroupLevel =0
    Expression ="[comm_backend_detail_fsc].item_comm_group_cd"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="pre_total_transaction_amt"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="pre_total_gp_ext_amt"
        dbInteger "ColumnWidth" ="2475"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="pre_total_comm_amt"
        dbInteger "ColumnWidth" ="2415"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1560
    Bottom =956
    Left =-1
    Top =-1
    Right =1544
    Bottom =301
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =58
        Top =6
        Right =408
        Bottom =232
        Top =0
        Name ="comm_statement_detail"
        Name =""
    End
End
