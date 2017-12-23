Operation =4
Option =0
Where ="(((comm_transaction.ess_comm_group_cd)=\"ITMPAR\") AND ((comm_transaction.ess_co"
    "mm_plan_id) Like \"ESS*\" Or (comm_transaction.ess_comm_plan_id) Like \"CCS*\") "
    "AND ((comm_transaction.source_cd) In (\"JDE\")) AND ((comm_transaction.order_sou"
    "rce_cd) In (\"A\",\"L\")))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
End
Begin OutputColumns
    Name ="comm_transaction.ess_comm_group_cd"
    Expression ="IIf([manufact_cd]=\"PELTON\",\"ITMFO1\",\"ITMFO3\")"
End
Begin Joins
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
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
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
        dbText "Name" ="comm_transaction.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1531
    Bottom =991
    Left =-1
    Top =-1
    Right =1499
    Bottom =262
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
End
