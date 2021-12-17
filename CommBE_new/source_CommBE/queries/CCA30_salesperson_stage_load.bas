Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_salesperson_master_Staging"
End
Begin OutputColumns
    Expression ="Integration_comm_salesperson_master_Staging.FiscalMonth"
    Expression ="Integration_comm_salesperson_master_Staging.employee_num"
    Expression ="Integration_comm_salesperson_master_Staging.CostCenter"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_nm"
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
    Expression ="Integration_comm_salesperson_master_Staging.territory_start_dt"
    Expression ="Integration_comm_salesperson_master_Staging.comm_plan_id"
    Expression ="Integration_comm_salesperson_master_Staging.salary_draw_amt"
    Expression ="Integration_comm_salesperson_master_Staging.deficit_amt"
    Expression ="Integration_comm_salesperson_master_Staging.email_ind"
    Expression ="Integration_comm_salesperson_master_Staging.comm_note_txt"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_key_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CCA30_salesperson_stage_load].[salesperson_key_id], [CCA30_salesperson_stage_lo"
    "ad].[employee_num] DESC, [CCA30_salesperson_stage_load].[comm_plan_id], [CCA30_s"
    "alesperson_stage_load].[deficit_amt], [CCA30_salesperson_stage_load].[email_ind]"
    " DESC, [CCA30_salesperson_stage_load].[salesperson_nm], [CCA30_salesperson_stage"
    "_load].[CostCenter]"
Begin
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.territory_start_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2025"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1785"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2250"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1935"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1545"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.employee_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2595"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.CostCenter"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.salary_draw_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1995"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.deficit_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1485"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.email_ind"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1350"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.comm_note_txt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1602
    Bottom =938
    Left =-1
    Top =-1
    Right =1578
    Bottom =221
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =88
        Top =24
        Right =597
        Bottom =370
        Top =0
        Name ="Integration_comm_salesperson_master_Staging"
        Name =""
    End
End
