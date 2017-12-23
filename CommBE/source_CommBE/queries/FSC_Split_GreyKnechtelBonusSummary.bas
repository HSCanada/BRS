Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201101\" And \"201112\") AND (("
    "comm_transaction.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.item_"
    "comm_group_cd) Not In (\"ITMPAR\",\"ITMSER\",\"ITMEQ0\")) AND ((comm_transaction"
    ".hsi_billto_id) In (1528294,1528594,1529035,1531156,1617940)) AND ((comm_transac"
    "tion.sales_category_cd) In (\"MERCH\",\"SMEQU\")))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.hsi_billto_id"
    Alias ="2011 Sales $"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="2011 GP $"
    Expression ="Sum(comm_transaction.gp_ext_amt)"
End
Begin Groups
    Expression ="comm_transaction.hsi_billto_id"
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
        dbText "Name" ="comm_transaction.hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="2011 Sales $"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="2011 GP $"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =71
    Top =92
    Right =1616
    Bottom =1061
    Left =-1
    Top =-1
    Right =1522
    Bottom =250
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =38
        Top =6
        Right =336
        Bottom =233
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
