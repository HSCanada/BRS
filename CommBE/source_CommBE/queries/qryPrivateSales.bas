Operation =1
Option =0
Where ="(((BRS_Item.Label)=\"P\") AND ((comm_transaction.fiscal_yearmo_num)>=\"201601\")"
    " AND ((comm_transaction.comm_plan_id) In (\"FSCGP02\",\"FSCGP03\",\"FSCGPM\")))"
Begin InputTables
    Name ="BRS_Item"
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="BRS_Item.Item"
    Expression ="comm_transaction.fiscal_yearmo_num"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="SumOfcomm_amt"
    Expression ="Sum(comm_transaction.comm_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="BRS_Item"
    Expression ="comm_transaction.item_id = BRS_Item.Item"
    Flag =1
End
Begin Groups
    Expression ="BRS_Item.Item"
    GroupLevel =0
    Expression ="comm_transaction.fiscal_yearmo_num"
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
        dbText "Name" ="SumOftransaction_amt"
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
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1563
    Bottom =991
    Left =-1
    Top =-1
    Right =1531
    Bottom =634
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =425
        Bottom =397
        Top =0
        Name ="BRS_Item"
        Name =""
    End
    Begin
        Left =697
        Top =28
        Right =1079
        Bottom =593
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
