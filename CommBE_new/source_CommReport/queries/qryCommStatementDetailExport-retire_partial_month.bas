Operation =1
Option =0
Begin InputTables
    Name ="comm_statement_detail"
    Name ="comm_customer_master_retire"
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
    Expression ="comm_statement_detail.transaction_amt"
    Expression ="comm_statement_detail.gp_ext_amt"
    Expression ="comm_statement_detail.shipped_qty"
    Expression ="comm_statement_detail.IMCLMJ"
    Expression ="comm_statement_detail.item_comm_rt"
    Expression ="comm_statement_detail.comm_amt"
    Expression ="comm_statement_detail.ess_salesperson_cd"
    Expression ="comm_statement_detail.SPM_StatusCd"
    Expression ="comm_statement_detail.customer_po_num"
    Alias ="ID"
    Expression ="comm_statement_detail.record_id"
    Expression ="comm_statement_detail.item_label_cd"
    Expression ="comm_statement_detail.source_cd"
    Expression ="comm_statement_detail.order_source_cd"
    Expression ="comm_customer_master_retire.Retiree"
    Expression ="comm_customer_master_retire.TerritoryCd_New"
    Expression ="comm_customer_master_retire.Territory_New"
End
Begin Joins
    LeftTable ="comm_statement_detail"
    RightTable ="comm_customer_master_retire"
    Expression ="comm_statement_detail.hsi_shipto_id = comm_customer_master_retire.ShipTo"
    Flag =1
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
        dbText "Name" ="comm_statement_detail.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3225"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1185"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
        dbText "Format" ="Standard"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_amt"
        dbLong "AggregateType" ="-1"
        dbText "Format" ="Standard"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.gp_ext_amt"
        dbLong "AggregateType" ="-1"
        dbText "Format" ="Standard"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.customer_po_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1935"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.doc_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.SPM_StatusCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master_retire.Retiree"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master_retire.TerritoryCd_New"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master_retire.Territory_New"
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
    Right =1500
    Bottom =546
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =624
        Bottom =391
        Top =0
        Name ="comm_statement_detail"
        Name =""
    End
    Begin
        Left =711
        Top =37
        Right =855
        Bottom =181
        Top =0
        Name ="comm_customer_master_retire"
        Name =""
    End
End
