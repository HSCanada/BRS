Operation =3
Name ="comm_adjustment_import"
Option =0
Begin InputTables
    Name ="comm_customer_rebate_export"
End
Begin OutputColumns
    Name ="ID_legacy"
    Expression ="comm_customer_rebate_export.ID"
    Name ="FiscalMonth"
    Expression ="comm_customer_rebate_export.FiscalMonth"
    Name ="owner_code"
    Expression ="comm_customer_rebate_export.owner_code"
    Name ="original_line_number"
    Expression ="comm_customer_rebate_export.original_line_number"
    Name ="fsc_code"
    Expression ="comm_customer_rebate_export.fsc_code"
    Name ="fsc_comm_group_cd"
    Expression ="comm_customer_rebate_export.fsc_comm_group_cd"
    Name ="fsc_salesperson_key_id"
    Expression ="comm_customer_rebate_export.fsc_salesperson_key_id"
    Name ="ess_code"
    Expression ="comm_customer_rebate_export.ess_code"
    Name ="ess_comm_group_cd"
    Expression ="comm_customer_rebate_export.ess_comm_group_cd"
    Name ="ess_salesperson_key_id"
    Expression ="comm_customer_rebate_export.ess_salesperson_key_id"
    Name ="ShipTo"
    Expression ="comm_customer_rebate_export.ShipTo"
    Name ="customer_name"
    Expression ="comm_customer_rebate_export.customer_name"
    Name ="salesorder_num"
    Expression ="comm_customer_rebate_export.salesorder_num"
    Name ="order_type"
    Expression ="comm_customer_rebate_export.order_type"
    Name ="item_id"
    Expression ="comm_customer_rebate_export.item_id"
    Name ="details"
    Expression ="comm_customer_rebate_export.details"
    Name ="transaction_date"
    Expression ="comm_customer_rebate_export.transaction_date"
    Name ="transaction_amt"
    Expression ="comm_customer_rebate_export.transaction_amt"
    Name ="gp_ext_amt"
    Expression ="comm_customer_rebate_export.gp_ext_amt"
    Name ="file_cost_amt"
    Expression ="comm_customer_rebate_export.file_cost_amt"
    Name ="fsc_comm_amt"
    Expression ="comm_customer_rebate_export.fsc_comm_amt"
    Name ="status_code"
    Expression ="comm_customer_rebate_export.status_code"
    Name ="source_cd"
    Expression ="comm_customer_rebate_export.source_cd"
    Name ="adj_type_code"
    Expression ="comm_customer_rebate_export.adj_type_code"
    Name ="cust_comm_group_cd"
    Expression ="comm_customer_rebate_export.cust_comm_group_cd"
    Name ="item_comm_group_cd"
    Expression ="comm_customer_rebate_export.item_comm_group_cd"
    Name ="gp_code"
    Expression ="comm_customer_rebate_export.gp_code"
    Name ="ma_estimate_factor"
    Expression ="comm_customer_rebate_export.ma_estimate_factor"
    Name ="comm_note_txt"
    Expression ="comm_customer_rebate_export.comm_note_txt"
    Name ="isr_code"
    Expression ="comm_customer_rebate_export.isr_code"
    Name ="isr_comm_group_cd"
    Expression ="comm_customer_rebate_export.isr_comm_group_cd"
    Name ="isr_salesperson_key_id"
    Expression ="comm_customer_rebate_export.isr_salesperson_key_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_export.est_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.cps_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.eps_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.owner_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.customer_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.salesorder_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.details"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.transaction_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.file_cost_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.fsc_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.eps_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.adj_type_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.gp_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.ma_estimate_factor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.isr_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.eps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.est_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.est_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.cps_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_export.cps_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.fsc_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.isr_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.adj_type_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.status_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.fsc_comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.owner_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.original_line_number"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.fsc_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.ess_salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.salesorder_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.customer_name"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.order_type"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.details"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.transaction_date"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.file_cost_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.cust_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.gp_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.ma_estimate_factor"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.comm_note_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_export.isr_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1324
    Bottom =946
    Left =-1
    Top =-1
    Right =1300
    Bottom =233
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =75
        Top =30
        Right =529
        Bottom =241
        Top =0
        Name ="comm_customer_rebate_export"
        Name =""
    End
End
