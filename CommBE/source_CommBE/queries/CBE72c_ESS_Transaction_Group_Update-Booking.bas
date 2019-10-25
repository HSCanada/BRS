Operation =4
Option =0
Where ="(((comm_group.booking_rt)>0) AND (([transaction_amt]*([booking_rt])/100)<>[gp_ex"
    "t_amt]))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_group"
End
Begin OutputColumns
    Name ="comm_transaction.gp_ext_amt"
    Expression ="[transaction_amt]*([booking_rt])/100"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_group"
    Expression ="comm_transaction.ess_comm_group_cd = comm_group.comm_group_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="Change Fiscal period in qry"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.booking_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="newGP"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =8
    Right =1519
    Bottom =965
    Left =-1
    Top =-1
    Right =1487
    Bottom =424
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =85
        Top =87
        Right =229
        Bottom =231
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =342
        Top =9
        Right =657
        Bottom =303
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =748
        Top =74
        Right =1089
        Bottom =344
        Top =0
        Name ="comm_group"
        Name =""
    End
End
