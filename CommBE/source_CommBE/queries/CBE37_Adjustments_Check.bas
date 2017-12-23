Operation =1
Option =0
Where ="(((comm_transaction_external_stage.salesperson_key_id)=\"\"))"
Begin InputTables
    Name ="comm_transaction_external_stage"
End
Begin OutputColumns
    Expression ="comm_transaction_external_stage.line_num"
    Expression ="comm_transaction_external_stage.comm_group_cd"
    Expression ="comm_transaction_external_stage.transaction_txt"
    Expression ="comm_transaction_external_stage.hsi_shipto_id"
    Expression ="comm_transaction_external_stage.customer_nm"
    Expression ="comm_transaction_external_stage.comm_amt"
    Expression ="comm_transaction_external_stage.invoice_id"
    Alias ="FIX_salesperson_cd"
    Expression ="comm_transaction_external_stage.salesperson_cd"
    Expression ="comm_transaction_external_stage.salesperson_key_id"
End
Begin OrderBy
    Expression ="comm_transaction_external_stage.line_num"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="New or missing FSC data?"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transaction_external_stage.comm_group_cd"
        dbInteger "ColumnWidth" ="1620"
        dbBoolean "ColumnHidden" ="0"
        dbInteger "ColumnOrder" ="2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.line_num"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
        dbInteger "ColumnOrder" ="1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.salesperson_key_id"
        dbInteger "ColumnWidth" ="2580"
        dbBoolean "ColumnHidden" ="0"
        dbInteger "ColumnOrder" ="6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.comm_amt"
        dbInteger "ColumnWidth" ="1995"
        dbInteger "ColumnOrder" ="4"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.transaction_txt"
        dbInteger "ColumnWidth" ="3285"
        dbInteger "ColumnOrder" ="3"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FIX_salesperson_cd"
        dbInteger "ColumnWidth" ="3615"
        dbInteger "ColumnOrder" ="5"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.customer_nm"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.invoice_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1581
    Bottom =991
    Left =-1
    Top =-1
    Right =1549
    Bottom =315
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =483
        Top =6
        Right =804
        Bottom =203
        Top =0
        Name ="comm_transaction_external_stage"
        Name =""
    End
End
