Operation =1
Option =0
Begin InputTables
    Name ="qryCommStatementDetailReport-Summary"
    Name ="qsubCommStatementDetailReportSummary"
End
Begin OutputColumns
    Alias ="salesperson_key_id"
    Expression ="GetCurrentFSC()"
    Expression ="qsubCommStatementDetailReportSummary.comm_group_cd"
    Expression ="qsubCommStatementDetailReportSummary.comm_group_desc"
    Alias ="total_transaction_amt"
    Expression ="CDbl(Nz([pre_total_transaction_amt],0))"
    Alias ="total_gp_ext_amt"
    Expression ="CDbl(Nz([pre_total_gp_ext_amt],0))"
    Alias ="total_comm_amt"
    Expression ="CDbl(Nz([pre_total_comm_amt],0))"
    Expression ="qsubCommStatementDetailReportSummary.sort_id"
End
Begin Joins
    LeftTable ="qsubCommStatementDetailReportSummary"
    RightTable ="qryCommStatementDetailReport-Summary"
    Expression ="qsubCommStatementDetailReportSummary.comm_group_cd = [qryCommStatementDetailRepo"
        "rt-Summary].item_comm_group_cd"
    Flag =2
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
        dbText "Name" ="salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommStatementDetailReportSummary.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommStatementDetailReportSummary.comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[qryCommStatementDetailReport-Summary].salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommStatementDetailReportSummary_1.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommStatementDetailReportSummary_1.comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommStatementDetailReportSummary_1.sort_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommStatementDetailReportSummary.report_sort_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommStatementDetailReportSummary.sort_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1560
    Bottom =971
    Left =-1
    Top =-1
    Right =1094
    Bottom =263
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =514
        Top =10
        Right =817
        Bottom =154
        Top =0
        Name ="qryCommStatementDetailReport-Summary"
        Name =""
    End
    Begin
        Left =40
        Top =23
        Right =325
        Bottom =213
        Top =0
        Name ="qsubCommStatementDetailReportSummary"
        Name =""
    End
End
