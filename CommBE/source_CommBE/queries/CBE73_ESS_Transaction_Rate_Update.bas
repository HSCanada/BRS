Operation =4
Option =0
Where ="(((comm_transaction.ess_comm_plan_id) Like \"ESS*\" Or (comm_transaction.ess_com"
    "m_plan_id) Like \"CCS*\") AND ((comm_transaction.source_cd) In (\"JDE\",\"IMPORT"
    "\")))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_plan_group_rate"
End
Begin OutputColumns
    Name ="comm_transaction.ess_comm_rt"
    Expression ="comm_plan_group_rate!comm_base_rt"
    Name ="comm_transaction.ess_comm_amt"
    Expression ="[gp_ext_amt]*([comm_plan_group_rate]![comm_base_rt]/100)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_plan_group_rate"
    Expression ="comm_transaction.ess_comm_plan_id = comm_plan_group_rate.comm_plan_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_plan_group_rate"
    Expression ="comm_transaction.ess_comm_group_cd = comm_plan_group_rate.comm_group_cd"
    Flag =1
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "DefaultView" ="2"
dbText "Description" ="Change Fiscal period in qry"
Begin
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
        dbText "Name" ="comm_transaction.ess_comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_amt"
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
        dbText "Name" ="comm_transaction.status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1365
    Bottom =999
    Left =-1
    Top =-1
    Right =1341
    Bottom =594
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =99
        Top =91
        Right =243
        Bottom =235
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =284
        Top =22
        Right =599
        Bottom =364
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =806
        Top =61
        Right =1036
        Bottom =213
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
End
