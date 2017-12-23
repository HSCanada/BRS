Operation =1
Option =0
Where ="(((comm_statement_detail.salesperson_key_id)=GetCurrentFSC()) AND ((comm_stateme"
    "nt_detail.source_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_statement_detail"
End
Begin OutputColumns
    Expression ="comm_statement_detail.record_id"
    Expression ="comm_statement_detail.salesperson_key_id"
    Expression ="comm_statement_detail.source_cd"
    Expression ="comm_statement_detail.report_group_1_cd"
    Expression ="comm_statement_detail.report_group_2_cd"
    Expression ="comm_statement_detail.report_group_3_cd"
    Expression ="comm_statement_detail.salesperson_nm"
    Expression ="comm_statement_detail.division_cd"
    Expression ="comm_statement_detail.salesperson_cd"
    Expression ="comm_statement_detail.comm_plan_id"
    Expression ="comm_statement_detail.comm_plan_nm"
    Expression ="comm_statement_detail.fiscal_yearmo_num"
    Expression ="comm_statement_detail.fiscal_begin_dt"
    Expression ="comm_statement_detail.fiscal_end_dt"
    Expression ="comm_statement_detail.master_report_group_txt"
    Expression ="comm_statement_detail.master_report_sort_id"
    Expression ="comm_statement_detail.report_group_txt"
    Expression ="comm_statement_detail.report_sort_id"
    Expression ="comm_statement_detail.doc_key_id"
    Expression ="comm_statement_detail.line_id"
    Expression ="comm_statement_detail.doc_id"
    Expression ="comm_statement_detail.order_id"
    Expression ="comm_statement_detail.transaction_dt"
    Expression ="comm_statement_detail.customer_id"
    Expression ="comm_statement_detail.customer_nm"
    Expression ="comm_statement_detail.item_id"
    Expression ="comm_statement_detail.transaction_txt"
    Expression ="comm_statement_detail.comm_cd"
    Expression ="comm_statement_detail.comm_group_cd"
    Expression ="comm_statement_detail.comm_rt"
    Expression ="comm_statement_detail.transaction_amt"
    Expression ="comm_statement_detail.comm_amt"
    Expression ="comm_statement_detail.cost_ext_amt"
    Expression ="comm_statement_detail.hsi_shipto_id"
    Expression ="comm_statement_detail.hsi_item_id"
    Expression ="comm_statement_detail.gp_ext_amt"
    Expression ="comm_statement_detail.hsi_manuf_cd"
    Expression ="comm_statement_detail.order_source_cd"
    Expression ="comm_statement_detail.item_label_cd"
    Expression ="comm_statement_detail.tagable_item_ind"
    Expression ="comm_statement_detail.IMCLMJ"
    Expression ="comm_statement_detail.marketing_adjustment_rt"
    Expression ="comm_statement_detail.cost_unit_amt"
    Expression ="comm_statement_detail.shipped_qty"
    Expression ="comm_statement_detail.avg_cost_unit_amt"
    Expression ="comm_statement_detail.comm_cost_unit_amt"
End
Begin OrderBy
    Expression ="comm_statement_detail.record_id"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_statement_detail.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_group_1_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_group_2_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_group_3_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_plan_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.fiscal_begin_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.fiscal_end_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.master_report_group_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3555"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.master_report_sort_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_group_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5550"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_sort_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.order_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.customer_id"
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
        dbText "Name" ="comm_statement_detail.transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_manuf_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.avg_cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.tagable_item_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_label_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.IMCLMJ"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.marketing_adjustment_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.cost_unit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.order_source_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1050
    Bottom =977
    Left =-1
    Top =-1
    Right =1034
    Bottom =213
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =531
        Bottom =247
        Top =0
        Name ="comm_statement_detail"
        Name =""
    End
End
