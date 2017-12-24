Operation =1
Option =0
Where ="(((comm_ess_statement_detail.salesperson_key_id)=GetCurrentFSC()) AND ((comm_ess"
    "_statement_detail.item_comm_group_cd) In (\"ITMFO1\",\"ITMFO2\",\"ITMFO3\",\"ITM"
    "FRT\",\"ITMCNX\",\"ITMDET\",\"ITMBTI\",\"ITMISC\",\"ITMCPU\",\"ITMSOF\",\"ITMMID"
    "\")))"
Begin InputTables
    Name ="comm_ess_statement_detail"
End
Begin OutputColumns
    Expression ="comm_ess_statement_detail.salesperson_key_id"
    Expression ="comm_ess_statement_detail.item_comm_group_cd"
    Alias ="pre_total_transaction_amt"
    Expression ="Sum(comm_ess_statement_detail.transaction_amt)"
    Alias ="pre_total_gp_ext_amt"
    Expression ="Sum(comm_ess_statement_detail.gp_ext_amt)"
    Alias ="pre_total_comm_amt"
    Expression ="Sum(comm_ess_statement_detail.comm_amt)"
End
Begin Groups
    Expression ="comm_ess_statement_detail.salesperson_key_id"
    GroupLevel =0
    Expression ="comm_ess_statement_detail.item_comm_group_cd"
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
        dbText "Name" ="comm_ess_statement_detail.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="pre_total_transaction_amt"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="pre_total_gp_ext_amt"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="pre_total_comm_amt"
        dbInteger "ColumnWidth" ="2070"
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
    Bottom =168
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =456
        Top =12
        Right =755
        Bottom =268
        Top =0
        Name ="comm_ess_statement_detail"
        Name =""
    End
End
