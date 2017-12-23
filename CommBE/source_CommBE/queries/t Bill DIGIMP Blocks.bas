Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201601\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="zzzItemList"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_salesperson_code_map.branch_cd"
    Expression ="comm_transaction.hsi_shipto_div_cd"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
    Alias ="SumOfess_comm_amt"
    Expression ="Sum(comm_transaction.ess_comm_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="zzzItemList"
    Expression ="comm_transaction.item_id = zzzItemList.item_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction.salesperson_cd = comm_salesperson_code_map.salesperson_cd"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_salesperson_code_map.branch_cd"
    GroupLevel =0
    Expression ="comm_transaction.hsi_shipto_div_cd"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
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
        dbText "Name" ="comm_transaction.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =16
    Top =8
    Right =1547
    Bottom =959
    Left =-1
    Top =-1
    Right =1499
    Bottom =646
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =584
        Bottom =611
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =707
        Top =44
        Right =851
        Bottom =188
        Top =0
        Name ="zzzItemList"
        Name =""
    End
    Begin
        Left =810
        Top =195
        Right =954
        Bottom =339
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
