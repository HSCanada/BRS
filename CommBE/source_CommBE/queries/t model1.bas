Operation =1
Option =0
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_customer_master"
    Name ="comm_item_master"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_customer_master.SPM_StatusCd"
    Expression ="comm_item_master.comm_group_cd"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="SumOfgp_ext_amt"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
    Alias ="SumOfcomm_amt"
    Expression ="Sum(comm_transaction.comm_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_customer_master"
    Expression ="comm_transaction.hsi_shipto_id = comm_customer_master.hsi_shipto_id"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="comm_item_master"
    Expression ="comm_transaction.item_id = comm_item_master.item_id"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_customer_master.SPM_StatusCd"
    GroupLevel =0
    Expression ="comm_item_master.comm_group_cd"
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
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfcomm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfgp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1537
    Bottom =991
    Left =-1
    Top =-1
    Right =1505
    Bottom =668
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =245
        Bottom =432
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =328
        Top =28
        Right =605
        Bottom =200
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
    Begin
        Left =321
        Top =252
        Right =793
        Bottom =545
        Top =0
        Name ="comm_item_master"
        Name =""
    End
End
