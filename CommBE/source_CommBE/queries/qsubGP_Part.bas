Operation =2
Name ="GPPartSales"
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)=\"201501\") AND ((comm_transaction.item_c"
    "omm_group_cd)=\"ITMPAR\") AND ((comm_transaction.source_cd)=\"JDE\"))"
Having ="(((Sum(comm_transaction.transaction_amt))<>0))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Alias ="DocPart"
    Expression ="comm_transaction.doc_key_id"
    Alias ="PartSales"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Groups
    Expression ="comm_transaction.doc_key_id"
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
dbBoolean "UseTransaction" ="-1"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DocPart"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="PartSalesAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="PartSales"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1519
    Bottom =997
    Left =-1
    Top =-1
    Right =1487
    Bottom =572
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =619
        Bottom =553
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
