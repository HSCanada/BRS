Operation =1
Option =0
Where ="(((comm_backend_detail_ess.item_comm_group_cd) In (\"ITMFO1\",\"ITMFO2\",\"ITMFO"
    "3\",\"ITMFRT\",\"ITMCNX\",\"ITMDET\",\"ITMBTI\",\"ITMISC\",\"ITMCPU\",\"ITMSOF\""
    ",\"ITMMID\")) AND ((comm_backend_detail_ess.salesperson_key_id)=GetCurrentFSC())"
    ")"
Begin InputTables
    Name ="comm_backend_detail_ess"
End
Begin OutputColumns
    Expression ="comm_backend_detail_ess.salesperson_key_id"
    Alias ="total_comm_amt"
    Expression ="Sum(comm_backend_detail_ess.comm_amt)"
End
Begin Groups
    Expression ="comm_backend_detail_ess.salesperson_key_id"
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
        dbText "Name" ="total_comm_amt"
        dbInteger "ColumnWidth" ="2070"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_ess].salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.salesperson_key_id"
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
    Bottom =151
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="comm_backend_detail_ess"
        Name =""
    End
End
