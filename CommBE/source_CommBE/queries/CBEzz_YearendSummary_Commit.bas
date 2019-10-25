Operation =4
Option =0
Begin InputTables
    Name ="comm_summary"
End
Begin OutputColumns
    Name ="comm_summary.sales_curr_amt"
    Expression ="0"
    Name ="comm_summary.costs_curr_amt"
    Expression ="0"
    Name ="comm_summary.comm_curr_amt"
    Expression ="0"
    Name ="comm_summary.gp_curr_amt"
    Expression ="0"
    Name ="comm_summary.sales_ytd_amt"
    Expression ="0"
    Name ="comm_summary.costs_ytd_amt"
    Expression ="0"
    Name ="comm_summary.comm_ytd_amt"
    Expression ="0"
    Name ="comm_summary.gp_ytd_amt"
    Expression ="0"
    Name ="comm_summary.sales_ly_amt"
    Expression ="0"
    Name ="comm_summary.costs_ly_amt"
    Expression ="0"
    Name ="comm_summary.comm_ly_amt"
    Expression ="0"
    Name ="comm_summary.gp_ly_amt"
    Expression ="0"
    Name ="comm_summary.sales_ref_amt"
    Expression ="0"
    Name ="comm_summary.costs_ref_amt"
    Expression ="0"
    Name ="comm_summary.comm_ref_amt"
    Expression ="0"
    Name ="comm_summary.gp_ref_amt"
    Expression ="0"
    Name ="comm_summary.sales_prior_amt"
    Expression ="0"
    Name ="comm_summary.costs_prior_amt"
    Expression ="0"
    Name ="comm_summary.comm_prior_amt"
    Expression ="0"
    Name ="comm_summary.gp_prior_amt"
    Expression ="0"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="0"
dbBoolean "FailOnError" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="comm_summary.sales_curr_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.gp_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.sales_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.costs_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.comm_prior_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1525
    Bottom =1004
    Left =-1
    Top =-1
    Right =1502
    Bottom =459
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =38
        Top =6
        Right =673
        Bottom =460
        Top =0
        Name ="comm_summary"
        Name =""
    End
End
