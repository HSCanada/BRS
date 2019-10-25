Operation =4
Option =0
Where ="(((comm_transaction.ess_salesperson_cd) Like \"ESS*\" And (comm_transaction.ess_"
    "salesperson_cd)<>[ess_accpac_cd]) AND ((comm_transaction.source_cd) In (\"JDE\")"
    ") AND ((comm_salesperson_master.salesperson_category_cd)=\"FSCESS\") AND ((comm_"
    "salesperson_master.ess_accpac_cd) Like \"ess*\")) OR (((comm_transaction.ess_sal"
    "esperson_cd) Like \"CCS*\" And (comm_transaction.ess_salesperson_cd)<>[ess_accpa"
    "c_cd]) AND ((comm_transaction.source_cd) In (\"JDE\")) AND ((comm_salesperson_ma"
    "ster.salesperson_category_cd)=\"FSCCCS\") AND ((comm_salesperson_master.ess_accp"
    "ac_cd) Like \"ess*\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Name ="comm_transaction.ess_salesperson_cd"
    Expression ="[ess_accpac_cd]"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2340"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2985"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_category_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ess_accpac_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1980"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="ess_accpac_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1000"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1397
    Bottom =999
    Left =-1
    Top =-1
    Right =1373
    Bottom =449
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =62
        Top =126
        Right =206
        Bottom =270
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =294
        Top =80
        Right =567
        Bottom =351
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =643
        Top =107
        Right =961
        Bottom =467
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
