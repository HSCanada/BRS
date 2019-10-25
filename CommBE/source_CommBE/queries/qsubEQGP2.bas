Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)=\"201101\") AND ((comm_transaction.item_c"
    "omm_group_cd) Not In (\"ITMPAR\",\"ITMSER\",\"ITMEQ0\",\"ITMFRT\")) AND ((comm_t"
    "ransaction.source_cd)=\"JDE\") AND ((comm_transaction.comm_plan_id) Like \"FSC*\""
    "))"
Begin InputTables
    Name ="comm_transaction"
    Name ="zzzSalespersonGrp"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.ess_salesperson_cd"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.hsi_shipto_id"
    Expression ="comm_transaction.customer_nm"
    Expression ="comm_transaction.doc_key_id"
    Expression ="comm_transaction.item_id"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.IMCLMJ"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.gp_ext_amt"
    Alias ="GP%"
    Expression ="IIf(([transaction_amt])<>0,([gp_ext_amt])/([transaction_amt]),0)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="zzzSalespersonGrp"
    Expression ="comm_transaction.item_comm_group_cd = zzzSalespersonGrp.commgrp"
    Flag =1
    LeftTable ="comm_transaction"
    RightTable ="zzzSalespersonGrp"
    Expression ="comm_transaction.salesperson_key_id = zzzSalespersonGrp.salesperson_cd"
    Flag =1
End
Begin OrderBy
    Expression ="comm_transaction.salesperson_key_id"
    Flag =0
    Expression ="comm_transaction.item_comm_group_cd"
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
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnOrder" ="1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnOrder" ="3"
    End
    Begin
        dbText "Name" ="GP%"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2235"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Percent"
        dbByte "DecimalPlaces" ="1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbInteger "ColumnOrder" ="2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2715"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
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
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1518
    Bottom =1004
    Left =-1
    Top =-1
    Right =1495
    Bottom =646
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =669
        Bottom =483
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =932
        Top =151
        Right =1076
        Bottom =295
        Top =0
        Name ="zzzSalespersonGrp"
        Name =""
    End
End
