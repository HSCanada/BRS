Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num) Between \"201001\" And \"201102\") AND (("
    "comm_transaction.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.item_"
    "comm_group_cd) Not In (\"ITMPAR\",\"ITMSER\",\"ITMEQ0\")) AND ((comm_transaction"
    ".hsi_shipto_id) In (1660473,1661680,1672230,1822132,2396233)))"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.transaction_dt"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.IMITEM"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.hsi_billto_id"
    Expression ="comm_transaction.hsi_shipto_nm"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_transaction.manufact_cd"
End
Begin OrderBy
    Expression ="comm_transaction.hsi_billto_id"
    Flag =0
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
dbMemo "OrderBy" ="[FSC_Split_HupertJ].[fiscal_yearmo_num]"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2685"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMITEM"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.manufact_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="4575"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_billto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1515
    Bottom =1008
    Left =-1
    Top =-1
    Right =1496
    Bottom =266
    Left =0
    Top =0
    ColumnsShown =539
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
