Operation =1
Option =0
Where ="(((comm_backend_detail_fsc.salesperson_key_id)=GetCurrentFSC()))"
Begin InputTables
    Name ="comm_backend_detail_fsc"
End
Begin OutputColumns
    Expression ="comm_backend_detail_fsc.fiscal_yearmo_num"
    Expression ="comm_backend_detail_fsc.salesperson_key_id"
    Expression ="comm_backend_detail_fsc.salesperson_nm"
    Expression ="comm_backend_detail_fsc.hsi_shipto_id"
    Expression ="comm_backend_detail_fsc.customer_nm"
    Expression ="comm_backend_detail_fsc.transaction_dt"
    Expression ="comm_backend_detail_fsc.doc_key_id"
    Expression ="comm_backend_detail_fsc.item_id"
    Expression ="comm_backend_detail_fsc.transaction_txt"
    Expression ="comm_backend_detail_fsc.item_comm_group_cd"
    Expression ="comm_backend_detail_fsc.comm_group_desc"
    Expression ="comm_backend_detail_fsc.transaction_amt"
    Expression ="comm_backend_detail_fsc.gp_ext_amt"
    Expression ="comm_backend_detail_fsc.shipped_qty"
    Expression ="comm_backend_detail_fsc.IMCLMJ"
    Expression ="comm_backend_detail_fsc.item_label_cd"
    Expression ="comm_backend_detail_fsc.item_comm_rt"
    Expression ="comm_backend_detail_fsc.comm_amt"
    Expression ="comm_backend_detail_fsc.salesperson_cd"
    Expression ="comm_backend_detail_fsc.order_source_cd"
    Expression ="comm_backend_detail_fsc.ess_salesperson_cd"
    Expression ="comm_backend_detail_fsc.ess_salesperson_key_id"
    Expression ="comm_backend_detail_fsc.customer_po_num"
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
dbText "Description" ="x"
Begin
    Begin
        dbText "Name" ="comm_statement_detail.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_shipto_id"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.customer_po_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_amt"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_dt"
        dbInteger "ColumnWidth" ="1185"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_txt"
        dbInteger "ColumnWidth" ="3225"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].item_comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="[comm_backend_detail_fsc].customer_po_num"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1560
    Bottom =956
    Left =-1
    Top =-1
    Right =1544
    Bottom =484
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="comm_backend_detail_fsc"
        Name =""
    End
End
