Operation =3
Name ="comm_freegoods"
Option =0
Begin InputTables
    Name ="Integration_comm_freegoods_Staging"
End
Begin OutputColumns
    Name ="FiscalMonth"
    Expression ="Integration_comm_freegoods_Staging.FiscalMonth"
    Name ="SalesOrderNumber"
    Expression ="Integration_comm_freegoods_Staging.SalesOrderNumber"
    Name ="original_line_number"
    Expression ="Integration_comm_freegoods_Staging.original_line_number"
    Name ="SourceCode"
    Expression ="Integration_comm_freegoods_Staging.SourceCode"
    Name ="ShipTo"
    Expression ="Integration_comm_freegoods_Staging.ShipTo"
    Name ="PracticeName"
    Expression ="Integration_comm_freegoods_Staging.PracticeName"
    Name ="Item"
    Expression ="Integration_comm_freegoods_Staging.Item"
    Name ="ItemDescription"
    Expression ="Integration_comm_freegoods_Staging.ItemDescription"
    Name ="Supplier"
    Expression ="Integration_comm_freegoods_Staging.Supplier"
    Name ="ExtFileCostCadAmt"
    Expression ="Integration_comm_freegoods_Staging.ExtFileCostCadAmt"
    Name ="comm_note_txt"
    Expression ="Integration_comm_freegoods_Staging.comm_note_txt"
    Name ="ma_estimate_factor"
    Expression ="Integration_comm_freegoods_Staging.ma_estimate_factor"
    Name ="DocType"
    Expression ="Integration_comm_freegoods_Staging.DocType"
    Name ="cust_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.cust_comm_group_cd"
    Name ="item_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.item_comm_group_cd"
    Name ="fsc_salesperson_key_id"
    Expression ="Integration_comm_freegoods_Staging.fsc_salesperson_key_id"
    Name ="ess_salesperson_key_id"
    Expression ="Integration_comm_freegoods_Staging.ess_salesperson_key_id"
    Name ="eps_salesperson_key_id"
    Expression ="Integration_comm_freegoods_Staging.eps_salesperson_key_id"
    Name ="isr_salesperson_key_id"
    Expression ="Integration_comm_freegoods_Staging.isr_salesperson_key_id"
    Name ="fsc_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.fsc_comm_group_cd"
    Name ="ess_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.ess_comm_group_cd"
    Name ="eps_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.eps_comm_group_cd"
    Name ="isr_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.isr_comm_group_cd"
    Name ="status_code"
    Expression ="Integration_comm_freegoods_Staging.status_code"
    Name ="fsc_code"
    Expression ="Integration_comm_freegoods_Staging.fsc_code"
    Name ="ess_code"
    Expression ="Integration_comm_freegoods_Staging.ess_code"
    Name ="eps_code"
    Expression ="Integration_comm_freegoods_Staging.eps_code"
    Name ="isr_code"
    Expression ="Integration_comm_freegoods_Staging.isr_code"
    Name ="fg_fsc_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.fg_fsc_comm_group_cd"
    Name ="fg_ess_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.fg_ess_comm_group_cd"
    Name ="fg_eps_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.fg_eps_comm_group_cd"
    Name ="fg_isr_comm_group_cd"
    Expression ="Integration_comm_freegoods_Staging.fg_isr_comm_group_cd"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.isr_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.eps_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.ess_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.fsc_code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_freegoods_Staging.isr_comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1121
    Bottom =547
    Left =-1
    Top =-1
    Right =1097
    Bottom =220
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =48
        Top =12
        Right =246
        Bottom =188
        Top =0
        Name ="Integration_comm_freegoods_Staging"
        Name =""
    End
End
