dbMemo "SQL" ="SELECT GetCurrentFSC() AS salesperson_key_id, qsubCommStatementDetailReportSumma"
    "ry.comm_group_cd, qsubCommStatementDetailReportSummary.comm_group_desc, CDbl(Nz("
    "[pre_total_transaction_amt],0)) AS total_transaction_amt, CDbl(Nz([pre_total_gp_"
    "ext_amt],0)) AS total_gp_ext_amt, CDbl(Nz([pre_total_comm_amt],0)) AS total_comm"
    "_amt, qsubCommStatementDetailReportSummary.sort_id\015\012FROM qsubCommStatement"
    "DetailReportSummary LEFT JOIN [qryCommStatementDetailReport-Summary] ON qsubComm"
    "StatementDetailReportSummary.comm_group_cd=[qryCommStatementDetailReport-Summary"
    "].item_comm_group_cd;\015\012"
dbMemo "Connect" =""
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
        dbText "Name" ="qsubCommStatementDetailReportSummary.sort_id"
        dbLong "AggregateType" ="-1"
    End
End
