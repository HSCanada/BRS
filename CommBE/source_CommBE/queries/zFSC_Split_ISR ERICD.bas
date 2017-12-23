Operation =1
Option =0
Where ="(((comm_transaction.reference_order_txt) Like \"*ERIC D*\") AND ((comm_transacti"
    "on.salesperson_key_id)<>\"Internal\") AND ((comm_transaction.item_comm_group_cd)"
    " Not In (\"ITMSER\",\"ITMPAR\",\"ITMEQ0\")) AND ((comm_transaction.source_cd)=\""
    "JDE\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.doc_id"
    Alias ="FirstOfreference_order_txt"
    Expression ="First(comm_transaction.reference_order_txt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_configure"
    Expression ="comm_transaction.fiscal_yearmo_num = comm_configure.current_fiscal_yearmo_num"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
    Expression ="comm_transaction.doc_id"
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
    End
    Begin
        dbText "Name" ="comm_transaction.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfreference_order_txt"
        dbInteger "ColumnWidth" ="2325"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.reference_order_txt"
        dbInteger "ColumnWidth" ="2325"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1575
    Bottom =997
    Left =-1
    Top =-1
    Right =1543
    Bottom =523
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =38
        Top =6
        Right =336
        Bottom =633
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =907
        Top =61
        Right =1051
        Bottom =205
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
