Operation =4
Option =0
Where ="(((comm_transaction.item_comm_group_cd)=\"SPMEQU\") AND ((comm_transaction.comm_"
    "plan_id) Not Like \"FSCG*\") AND ((comm_transaction.source_cd) In (\"JDE\")) AND"
    " ((comm_transaction.customer_comm_group_cd)=\"CUSINS\") AND ((comm_transaction.v"
    "pa_cd)<>\"RID01\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_plan_group_rate"
End
Begin OutputColumns
    Name ="comm_transaction.comm_rt"
    Expression ="[comm_base_rt]"
    Name ="comm_transaction.comm_amt"
    Expression ="[transaction_amt]*([comm_base_rt]/100)"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_plan_group_rate"
    Expression ="comm_transaction.comm_plan_id = comm_plan_group_rate.comm_plan_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_plan_group_rate"
    Expression ="comm_transaction.item_comm_group_cd = comm_plan_group_rate.comm_group_cd"
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
        dbText "Name" ="comm_transaction.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2490"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.comm_base_rt"
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
        dbText "Name" ="comm_transaction.comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2325"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.reference_order_txt"
        dbInteger "ColumnWidth" ="1845"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.contact_nm"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.vpa_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1547
    Bottom =1005
    Left =-1
    Top =-1
    Right =1523
    Bottom =344
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =85
        Top =87
        Right =349
        Bottom =406
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =583
        Top =51
        Right =898
        Bottom =379
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =951
        Top =38
        Right =1175
        Bottom =302
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
End
