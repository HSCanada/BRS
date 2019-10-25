Operation =1
Option =0
Where ="(((comm_summary.salesperson_key_id)=\"JON.HOLLINK\") AND ((comm_summary.comm_gro"
    "up_cd)=\"FRESEQ\"))"
Begin InputTables
    Name ="comm_summary"
End
Begin OutputColumns
    Expression ="comm_summary.salesperson_key_id"
    Expression ="comm_summary.comm_group_cd"
    Expression ="comm_summary.gp_ly_amt"
    Expression ="comm_summary.gp_prior_amt"
    Expression ="comm_summary.gp_ref_amt"
    Alias ="Expr1"
    Expression ="[gp_ly_amt]+[gp_ref_amt]"
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
        dbText "Name" ="comm_summary.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.gp_ly_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.gp_ref_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.gp_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.[gp_ly_amt]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =143
    Top =47
    Right =1625
    Bottom =860
    Left =-1
    Top =-1
    Right =1458
    Bottom =534
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =72
        Top =39
        Right =608
        Bottom =387
        Top =0
        Name ="comm_summary"
        Name =""
    End
End
