Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201801\") AND ((comm_transaction.ess_s"
    "alesperson_cd) Like \"ESS*\" Or (comm_transaction.ess_salesperson_cd) Like \"CCS"
    "*\") AND ((comm_transaction.status_cd)<>20)) OR (((comm_transaction.fiscal_yearm"
    "o_num)>=\"201801\") AND ((comm_transaction.ess_salesperson_cd) Like \"ESS*\" Or "
    "(comm_transaction.ess_salesperson_cd) Like \"CCS*\") AND ((comm_transaction.ess_"
    "status_cd)<>20))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.comm_plan_id"
    Expression ="comm_transaction.ess_comm_plan_id"
    Expression ="comm_transaction.ess_salesperson_key_id"
    Expression ="comm_transaction.ess_salesperson_cd"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.ess_comm_group_cd"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.customer_nm"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.doc_id"
    Expression ="comm_transaction.line_id"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.comm_amt"
    Expression ="comm_transaction.status_cd"
    Expression ="comm_transaction.ess_status_cd"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbInteger "ColumnWidth" ="2370"
        dbBoolean "ColumnHidden" ="0"
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
        dbText "Name" ="comm_transaction.transaction_txt"
        dbInteger "ColumnWidth" ="4305"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2955"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2565"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_nm"
        dbInteger "ColumnWidth" ="2670"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_status_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1541
    Bottom =976
    Left =-1
    Top =-1
    Right =1523
    Bottom =96
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =341
        Bottom =419
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
