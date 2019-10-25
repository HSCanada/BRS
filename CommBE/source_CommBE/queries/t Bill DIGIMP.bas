Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201601\"))"
Having ="(((comm_transaction.ess_comm_plan_id) Like \"ccs*\"))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.ess_comm_plan_id"
    Expression ="comm_transaction.ess_salesperson_key_id"
    Expression ="comm_transaction.ess_comm_group_cd"
    Expression ="comm_transaction.hsi_shipto_div_cd"
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.item_id"
    Alias ="FirstOftransaction_txt"
    Expression ="First(comm_transaction.transaction_txt)"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
    Alias ="SumOfess_comm_amt"
    Expression ="Sum(comm_transaction.ess_comm_amt)"
End
Begin Groups
    Expression ="comm_transaction.ess_comm_plan_id"
    GroupLevel =0
    Expression ="comm_transaction.ess_salesperson_key_id"
    GroupLevel =0
    Expression ="comm_transaction.ess_comm_group_cd"
    GroupLevel =0
    Expression ="comm_transaction.hsi_shipto_div_cd"
    GroupLevel =0
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.doc_key_id"
    GroupLevel =0
    Expression ="comm_transaction.hsi_shipto_id"
    GroupLevel =0
    Expression ="comm_transaction.item_id"
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
        dbInteger "ColumnWidth" ="2235"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2550"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1035"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SumOfess_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1665"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1320"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="FirstOftransaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3180"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2490"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1557
    Bottom =999
    Left =-1
    Top =-1
    Right =1533
    Bottom =634
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =607
        Bottom =611
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
