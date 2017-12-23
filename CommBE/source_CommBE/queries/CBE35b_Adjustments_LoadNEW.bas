Operation =1
Option =0
Begin InputTables
    Name ="comm_transaction_external_stage"
End
Begin OutputColumns
    Expression ="comm_transaction_external_stage.fiscal_yearmo_num"
    Expression ="comm_transaction_external_stage.reference_order_txt"
    Expression ="comm_transaction_external_stage.line_num"
    Expression ="comm_transaction_external_stage.salesperson_cd"
    Expression ="comm_transaction_external_stage.hsi_shipto_id"
    Expression ="comm_transaction_external_stage.customer_nm"
    Expression ="comm_transaction_external_stage.invoice_id"
    Expression ="comm_transaction_external_stage.item_id"
    Expression ="comm_transaction_external_stage.transaction_txt"
    Expression ="comm_transaction_external_stage.transaction_dt"
    Expression ="comm_transaction_external_stage.transaction_amt"
    Expression ="comm_transaction_external_stage.manufact_cd"
    Expression ="comm_transaction_external_stage.comm_group_cd"
    Expression ="comm_transaction_external_stage.gp_ext_amt"
    Expression ="comm_transaction_external_stage.comm_amt"
    Expression ="comm_transaction_external_stage.record_id"
    Expression ="comm_transaction_external_stage.salesperson_key_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE35b_Adjustments_LoadNEW].[line_num] DESC, [CBE35b_Adjustments_LoadNEW].[refe"
    "rence_order_txt]"
Begin
    Begin
        dbText "Name" ="comm_transaction_external_stage.customer_nm"
        dbInteger "ColumnWidth" ="3705"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.transaction_txt"
        dbInteger "ColumnWidth" ="3795"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.invoice_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.line_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.transaction_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.comm_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.gp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1560"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.reference_order_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_external_stage.manufact_cd"
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
    Bottom =76
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =355
        Bottom =300
        Top =0
        Name ="comm_transaction_external_stage"
        Name =""
    End
End
