Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201501\" And \"201512\") AND (("
    "comm_salesperson_code_map.branch_cd)=\"HALFX\"))"
Having ="(((comm_transaction.order_source_cd)=\"a\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.doc_type_cd"
    Expression ="comm_transaction.ess_salesperson_cd"
    Alias ="FirstOfsalesperson_nm"
    Expression ="First(comm_salesperson_code_map.salesperson_nm)"
    Expression ="comm_transaction.ess_comm_group_cd"
    Expression ="comm_transaction.order_source_cd"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.source_cd"
    GroupLevel =0
    Expression ="comm_transaction.doc_type_cd"
    GroupLevel =0
    Expression ="comm_transaction.ess_salesperson_cd"
    GroupLevel =0
    Expression ="comm_transaction.ess_comm_group_cd"
    GroupLevel =0
    Expression ="comm_transaction.order_source_cd"
    GroupLevel =0
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
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfsalesperson_nm"
        dbInteger "ColumnWidth" ="2565"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_type_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1341
    Bottom =991
    Left =-1
    Top =-1
    Right =1309
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =605
        Bottom =550
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =694
        Top =52
        Right =948
        Bottom =367
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
