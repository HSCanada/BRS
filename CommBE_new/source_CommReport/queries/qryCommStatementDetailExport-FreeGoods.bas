Operation =1
Option =0
Where ="(((comm_statement_detail.item_comm_group_cd) In (\"FRESEQ\",\"FRESND\",\"SPMFGE\""
    ",\"SPMFGS\")) AND ((comm_statement_detail.salesperson_key_id)=GetCurrentFSC()))"
Begin InputTables
    Name ="comm_statement_detail"
End
Begin OutputColumns
    Expression ="comm_statement_detail.fiscal_yearmo_num"
    Expression ="comm_statement_detail.salesperson_nm"
    Expression ="comm_statement_detail.salesperson_cd"
    Expression ="comm_statement_detail.hsi_shipto_id"
    Expression ="comm_statement_detail.customer_nm"
    Expression ="comm_statement_detail.transaction_dt"
    Expression ="comm_statement_detail.doc_key_id"
    Expression ="comm_statement_detail.doc_type"
    Expression ="comm_statement_detail.item_id"
    Expression ="comm_statement_detail.transaction_txt"
    Expression ="comm_statement_detail.item_comm_group_cd"
    Expression ="comm_statement_detail.comm_group_desc"
    Expression ="comm_statement_detail.SPM_StatusCd"
    Alias ="adj_type"
    Expression ="comm_statement_detail.manufact_cd"
    Expression ="comm_statement_detail.gp_ext_amt"
    Expression ="comm_statement_detail.item_comm_rt"
    Expression ="comm_statement_detail.comm_amt"
    Expression ="comm_statement_detail.customer_po_num"
    Alias ="ID"
    Expression ="comm_statement_detail.record_id"
    Expression ="comm_statement_detail.source_cd"
End
Begin OrderBy
    Expression ="comm_statement_detail.hsi_shipto_id"
    Flag =0
    Expression ="comm_statement_detail.doc_key_id"
    Flag =0
    Expression ="comm_statement_detail.item_id"
    Flag =0
    Expression ="comm_statement_detail.manufact_cd"
    Flag =0
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
Begin
    Begin
        dbText "Name" ="comm_statement_detail.customer_po_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.customer_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2700"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.doc_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3060"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2490"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_group_desc"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2970"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="adj_type"
        dbInteger "ColumnWidth" ="1605"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.ess_salesperson_cd"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.manufact_cd"
        dbInteger "ColumnWidth" ="1605"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.IMCLMJ"
        dbInteger "ColumnWidth" ="1125"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_label_cd"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.order_source_cd"
        dbInteger "ColumnWidth" ="1965"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1014"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1516
    Bottom =918
    Left =-1
    Top =-1
    Right =1230
    Bottom =588
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =347
        Bottom =581
        Top =0
        Name ="comm_statement_detail"
        Name =""
    End
End
