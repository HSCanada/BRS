Operation =1
Option =0
Begin InputTables
    Name ="comm_adjustment_export"
End
Begin OutputColumns
    Expression ="comm_adjustment_export.ID"
    Expression ="comm_adjustment_export.cps_code"
    Expression ="comm_adjustment_export.cps_salesperson_key_id"
    Expression ="comm_adjustment_export.cps_comm_plan_id"
    Expression ="comm_adjustment_export.cps_comm_group_cd"
    Expression ="comm_adjustment_export.fsc_comm_group_cd"
    Expression ="comm_adjustment_export.details"
    Expression ="comm_adjustment_export.transaction_amt"
    Expression ="comm_adjustment_export.gp_ext_amt"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[cps_code] DESC"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_adjustment_export.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.fsc_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.ID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.owner_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.ess_salesperson_key_id"
        dbInteger "ColumnWidth" ="2715"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.customer_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.salesorder_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.eps_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.eps_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.details"
        dbInteger "ColumnWidth" ="2925"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.cps_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.transaction_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.eps_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.file_cost_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.ess_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.fsc_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.adj_type_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.gp_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.ma_estimate_factor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.isr_comm_group_cd"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.eps_comm_group_cd"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.est_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.est_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.est_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.cps_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.cps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.cps_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.WSDOCO_salesorder_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.isr_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_adjustment_export.est_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1452
    Bottom =606
    Left =-1
    Top =-1
    Right =1428
    Bottom =286
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =66
        Top =44
        Right =299
        Bottom =273
        Top =0
        Name ="comm_adjustment_export"
        Name =""
    End
End
