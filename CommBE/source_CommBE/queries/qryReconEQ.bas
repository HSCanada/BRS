Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)=\"201011\") AND ((comm_transaction.comm_p"
    "lan_id) Like \"fsc*\") AND ((comm_transaction.IMCLMJ)=\"855\")) OR (((comm_trans"
    "action.fiscal_yearmo_num)=\"201011\") AND ((comm_transaction.comm_plan_id) Like "
    "\"fsc*\") AND ((comm_transaction.item_comm_group_cd)=\"ITMCPU\" Or (comm_transac"
    "tion.item_comm_group_cd)=\"ITMSOF\"))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.comm_plan_id"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
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
        dbText "Name" ="comm_transaction.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLMJ"
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
End
Begin
    State =0
    Left =0
    Top =40
    Right =1557
    Bottom =1004
    Left =-1
    Top =-1
    Right =1534
    Bottom =694
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =524
        Bottom =400
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
