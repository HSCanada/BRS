Operation =1
Option =0
Where ="(((comm_statement_detail.salesperson_key_id)=GetCurrentFSC()) AND ((comm_stateme"
    "nt_detail.source_cd)=\"IMPORT\") AND ((comm_statement_detail.comm_group_cd) Not "
    "In (\"REBSND\",\"REBTEE\",\"SFFFIN\")))"
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
        dbInteger "ColumnWidth" ="2265"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_group_2_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2265"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_group_3_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2265"
        dbBoolean "ColumnHidden" ="0"
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
        dbInteger "ColumnWidth" ="3480"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.master_report_sort_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_group_txt"
        dbInteger "ColumnWidth" ="3195"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
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
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
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
        dbText "Name" ="report_group_1_cd"
    End
    Begin
        dbText "Name" ="report_group_2_cd"
    End
    Begin
        dbText "Name" ="report_group_3_cd"
    End
    Begin
        dbText "Name" ="division_cd"
    End
    Begin
        dbText "Name" ="master_report_group_txt"
    End
    Begin
        dbText "Name" ="master_report_sort_id"
    End
    Begin
        dbText "Name" ="report_group_txt"
    End
    Begin
        dbText "Name" ="report_sort_id"
    End
    Begin
        dbText "Name" ="customer_id"
    End
    Begin
        dbText "Name" ="comm_cd"
    End
    Begin
        dbText "Name" ="comm_group_cd"
    End
    Begin
        dbText "Name" ="comm_rt"
    End
    Begin
        dbText "Name" ="cost_ext_amt"
    End
    Begin
        dbText "Name" ="hsi_item_id"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1484
    Bottom =984
    Left =-1
    Top =-1
    Right =1469
    Bottom =42
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =306
        Bottom =158
        Top =0
        Name ="comm_statement_detail"
        Name =""
    End
End
