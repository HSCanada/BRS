﻿Operation =1
Option =0
Where ="(((comm_ess_statement_detail.salesperson_key_id)=GetCurrentFSC()))"
Begin InputTables
    Name ="comm_ess_statement_detail"
    Name ="comm_customer_master"
End
Begin OutputColumns
    Expression ="comm_ess_statement_detail.fiscal_yearmo_num"
    Expression ="comm_ess_statement_detail.salesperson_nm"
    Expression ="comm_ess_statement_detail.salesperson_cd"
    Expression ="comm_ess_statement_detail.hsi_shipto_id"
    Expression ="comm_ess_statement_detail.customer_nm"
    Expression ="comm_ess_statement_detail.transaction_dt"
    Expression ="comm_ess_statement_detail.doc_key_id"
    Expression ="comm_ess_statement_detail.doc_type"
    Expression ="comm_ess_statement_detail.item_id"
    Expression ="comm_ess_statement_detail.transaction_txt"
    Expression ="comm_ess_statement_detail.item_comm_group_cd"
    Expression ="comm_ess_statement_detail.comm_group_desc"
    Expression ="comm_ess_statement_detail.transaction_amt"
    Expression ="comm_ess_statement_detail.gp_ext_amt"
    Expression ="comm_ess_statement_detail.shipped_qty"
    Expression ="comm_ess_statement_detail.IMCLMJ"
    Expression ="comm_ess_statement_detail.item_comm_rt"
    Expression ="comm_ess_statement_detail.comm_amt"
    Expression ="comm_ess_statement_detail.fsc_salesperson_cd"
    Expression ="comm_ess_statement_detail.SPM_StatusCd"
    Expression ="comm_ess_statement_detail.customer_po_num"
    Alias ="ID"
    Expression ="comm_ess_statement_detail.record_id"
    Expression ="comm_ess_statement_detail.item_label_cd"
    Expression ="comm_ess_statement_detail.source_cd"
    Expression ="comm_ess_statement_detail.order_source_cd"
End
Begin Joins
    LeftTable ="comm_ess_statement_detail"
    RightTable ="comm_customer_master"
    Expression ="comm_ess_statement_detail.hsi_shipto_id = comm_customer_master.ShipTo"
    Flag =2
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
        dbText "Name" ="comm_ess_statement_detail.transaction_txt"
        dbInteger "ColumnWidth" ="3120"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.customer_nm"
        dbInteger "ColumnWidth" ="2535"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2310"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbText "Format" ="Standard"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.gp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbText "Format" ="Standard"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.comm_amt"
        dbLong "AggregateType" ="-1"
        dbText "Format" ="Standard"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.manufact_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1605"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.item_comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.comm_group_desc"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3000"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.fsc_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.customer_po_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.ID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.doc_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.fsc_salesperson_key_id"
        dbInteger "ColumnWidth" ="2025"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_ess_statement_detail.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ID"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1018
    Bottom =549
    Left =-1
    Top =-1
    Right =1002
    Bottom =370
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =374
        Bottom =339
        Top =0
        Name ="comm_ess_statement_detail"
        Name =""
    End
    Begin
        Left =486
        Top =37
        Right =805
        Bottom =292
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
End
