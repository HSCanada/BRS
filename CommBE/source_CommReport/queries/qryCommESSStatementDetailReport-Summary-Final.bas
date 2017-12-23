Operation =1
Option =0
Begin InputTables
    Name ="qsubCommESSStatementDetailReportSummary"
    Name ="qryCommESSStatementDetailReport-Summary"
End
Begin OutputColumns
    Alias ="salesperson_key_id"
    Expression ="GetCurrentFSC()"
    Expression ="qsubCommESSStatementDetailReportSummary.comm_group_cd"
    Expression ="qsubCommESSStatementDetailReportSummary.comm_group_desc"
    Expression ="qsubCommESSStatementDetailReportSummary.report_sort_id"
    Alias ="total_transaction_amt"
    Expression ="CDbl(nz([pre_total_transaction_amt],0))"
    Alias ="total_gp_ext_amt"
    Expression ="CDbl(nz([pre_total_gp_ext_amt],0))"
    Alias ="total_comm_amt"
    Expression ="CDbl(nz([pre_total_comm_amt],0))"
End
Begin Joins
    LeftTable ="qsubCommESSStatementDetailReportSummary"
    RightTable ="qryCommESSStatementDetailReport-Summary"
    Expression ="qsubCommESSStatementDetailReportSummary.comm_group_cd=[qryCommESSStatementDetail"
        "Report-Summary].item_comm_group_cd"
    Flag =2
End
Begin OrderBy
    Expression ="qsubCommESSStatementDetailReportSummary.report_sort_id"
    Flag =0
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
        dbText "Name" ="qsubCommESSStatementDetailReportSummary.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommESSStatementDetailReportSummary.comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommESSStatementDetailReportSummary.report_sort_id"
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
End
Begin
    State =0
    Left =0
    Top =0
    Right =1484
    Bottom =984
    Left =-1
    Top =-1
    Right =1469
    Bottom =283
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =720
        Top =12
        Right =864
        Bottom =156
        Top =0
        Name ="qsubCommESSStatementDetailReportSummary"
        Name =""
    End
    Begin
        Left =912
        Top =12
        Right =1056
        Bottom =156
        Top =0
        Name ="qryCommESSStatementDetailReport-Summary"
        Name =""
    End
End
