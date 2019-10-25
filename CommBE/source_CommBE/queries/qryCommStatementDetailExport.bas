Operation =1
Option =0
Where ="(((comm_statement_detail.salesperson_key_id)=GetCurrentFSC()))"
Begin InputTables
    Name ="comm_statement_detail"
End
Begin OutputColumns
    Expression ="comm_statement_detail.salesperson_key_id"
    Expression ="comm_statement_detail.salesperson_cd"
    Expression ="comm_statement_detail.comm_plan_id"
    Expression ="comm_statement_detail.transaction_dt"
    Expression ="comm_statement_detail.transaction_amt"
    Expression ="comm_statement_detail.gp_ext_amt"
    Expression ="comm_statement_detail.item_comm_group_cd"
    Expression ="comm_statement_detail.comm_rt"
    Expression ="comm_statement_detail.comm_amt"
    Expression ="comm_statement_detail.report_group_txt"
    Expression ="comm_statement_detail.master_report_group_txt"
    Expression ="comm_statement_detail.hsi_item_id"
    Expression ="comm_statement_detail.doc_key_id"
    Expression ="comm_statement_detail.line_id"
    Expression ="comm_statement_detail.hsi_shipto_id"
    Expression ="comm_statement_detail.transaction_txt"
    Expression ="comm_statement_detail.record_id"
    Expression ="comm_statement_detail.fiscal_yearmo_num"
    Expression ="comm_statement_detail.division_cd"
    Expression ="comm_statement_detail.master_report_sort_id"
    Expression ="comm_statement_detail.report_sort_id"
    Alias ="Expr1"
    Expression ="comm_statement_detail.order_source_cd"
    Alias ="Expr2"
    Expression ="comm_statement_detail.item_label_cd"
    Alias ="Expr3"
    Expression ="comm_statement_detail.tagable_item_ind"
    Alias ="Expr4"
    Expression ="comm_statement_detail.IMCLMJ"
    Alias ="Expr5"
    Expression ="comm_statement_detail.marketing_adjustment_rt"
    Alias ="Expr6"
    Expression ="comm_statement_detail.cost_unit_amt"
    Alias ="Expr7"
    Expression ="comm_statement_detail.shipped_qty"
    Alias ="Expr8"
    Expression ="comm_statement_detail.avg_cost_unit_amt"
    Alias ="Expr9"
    Expression ="comm_statement_detail.comm_cost_unit_amt"
    Expression ="comm_statement_detail.ess_salesperson_cd"
    Expression ="comm_statement_detail.ess_salesperson_key_id"
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
        dbText "Name" ="comm_statement_detail.report_group_txt"
        dbInteger "ColumnWidth" ="2685"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.division_cd"
        dbInteger "ColumnWidth" ="1125"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
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
        dbText "Name" ="comm_statement_detail.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.transaction_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.master_report_group_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1695"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_statement_detail.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.master_report_sort_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.report_sort_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_statement_detail.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr2"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr4"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr5"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr6"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr7"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr8"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr9"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1588
    Bottom =984
    Left =-1
    Top =-1
    Right =1565
    Bottom =453
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =413
        Bottom =361
        Top =0
        Name ="comm_statement_detail"
        Name =""
    End
End
