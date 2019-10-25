Operation =2
Name ="zzzFSCSales201209YTD"
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201201\" And \"201209\") AND (("
    "comm_transaction.salesperson_key_id)<>\"internal\") AND ((comm_transaction.sourc"
    "e_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.item_id"
    Alias ="Sep 2012 Qty"
    Expression ="Sum(comm_transaction.shipped_qty)"
    Alias ="Sep 2012 Sales"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Groups
    Expression ="comm_transaction.item_id"
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
dbBoolean "UseTransaction" ="-1"
Begin
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="2010 Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="2010 Sales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sept 2012 Sales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sep 2012 Qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sep 2012 Sales"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1584
    Bottom =1004
    Left =-1
    Top =-1
    Right =1561
    Bottom =662
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =565
        Bottom =412
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
