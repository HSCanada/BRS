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
    Expression ="[sales_ytd_amt]+[sales_curr_amt]"
    Name ="comm_summary.costs_ytd_amt"
    Expression ="[costs_ytd_amt]+[costs_curr_amt]"
    Name ="comm_summary.comm_ytd_amt"
    Expression ="[comm_ytd_amt]+[comm_curr_amt]"
    Name ="comm_summary.gp_ytd_amt"
    Expression ="[gp_ytd_amt]+[gp_curr_amt]"
    Name ="comm_summary.sales_ly_amt"
    Expression ="[sales_ly_amt]+[sales_ref_amt]"
    Name ="comm_summary.sales_ref_amt"
    Expression ="0"
    Name ="comm_summary.costs_ref_amt"
    Expression ="0"
    Name ="comm_summary.comm_ref_amt"
    Expression ="0"
    Name ="comm_summary.gp_ref_amt"
    Expression ="0"
    Name ="comm_summary.costs_ly_amt"
    Expression ="[costs_ly_amt]+[costs_ref_amt]"
    Name ="comm_summary.comm_ly_amt"
    Expression ="[comm_ly_amt]+[comm_ref_amt]"
    Name ="comm_summary.gp_ly_amt"
    Expression ="[gp_ly_amt]+[gp_ref_amt]"
    Name ="comm_summary.sales_prior_amt"
    Expression ="[sales_curr_amt]"
    Name ="comm_summary.costs_prior_amt"
    Expression ="[costs_curr_amt]"
    Name ="comm_summary.comm_prior_amt"
    Expression ="[comm_curr_amt]"
    Name ="comm_summary.gp_prior_amt"
    Expression ="[gp_curr_amt]"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="180"
dbBoolean "UseTransaction" ="0"
dbBoolean "FailOnError" ="0"
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
        dbText "Name" ="comm_summary.costs_curr_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.costs_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.comm_curr_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.comm_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.gp_curr_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.gp_ref_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1482
    Bottom =997
    Left =-1
    Top =-1
    Right =1450
    Bottom =499
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =38
        Top =6
        Right =595
        Bottom =387
        Top =0
        Name ="comm_summary"
        Name =""
    End
End
