﻿Operation =1
Option =0
Begin InputTables
    Name ="comm_transaction_external_stage"
End
Begin OutputColumns
    Expression ="comm_transaction_external_stage.fiscal_yearmo_num"
    Expression ="comm_transaction_external_stage.comm_group_cd"
    Expression ="comm_transaction_external_stage.salesperson_cd"
    Expression ="comm_transaction_external_stage.customer_nm"
    Expression ="comm_transaction_external_stage.invoice_id"
    Expression ="comm_transaction_external_stage.line_num"
    Expression ="comm_transaction_external_stage.transaction_dt"
    Expression ="comm_transaction_external_stage.transaction_txt"
    Expression ="comm_transaction_external_stage.transaction_amt"
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
dbMemo "OrderBy" ="[CBE35_Adjustments_Load].[line_num] DESC, [CBE35_Adjustments_Load].[fiscal_yearm"
    "o_num]"
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
End
Begin
    State =0
    Left =-159
    Top =37
    Right =1408
    Bottom =988
    Left =-1
    Top =-1
    Right =1535
    Bottom =43
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =355
        Bottom =203
        Top =0
        Name ="comm_transaction_external_stage"
        Name =""
    End
End
