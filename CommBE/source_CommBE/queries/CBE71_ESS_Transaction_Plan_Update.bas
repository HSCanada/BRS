Operation =4
Option =0
Where ="(((comm_transaction.ess_salesperson_cd) Like \"ESS*\" Or (comm_transaction.ess_s"
    "alesperson_cd) Like \"DTS*\") AND ((comm_transaction.source_cd) In (\"JDE\",\"IM"
    "PORT\")))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Name ="comm_transaction.ess_salesperson_key_id"
    Expression ="[comm_salesperson_code_map]![salesperson_key_id]"
    Name ="comm_transaction.ess_comm_plan_id"
    Expression ="\"ESSGP\""
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction.ess_salesperson_cd = comm_salesperson_code_map.salesperson_cd"
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
        dbInteger "ColumnWidth" ="2010"
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
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1563
    Bottom =976
    Left =-1
    Top =-1
    Right =1545
    Bottom =339
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
        Left =713
        Top =37
        Right =995
        Bottom =204
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
