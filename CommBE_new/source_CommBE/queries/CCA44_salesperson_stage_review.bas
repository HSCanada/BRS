Operation =1
Option =0
Begin InputTables
    Name ="Integration_comm_salesperson_master_Staging"
    Name ="comm_salesperson_master"
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
    Expression ="comm_salesperson_master.salary_draw_amt"
    Expression ="Integration_comm_salesperson_master_Staging.deficit_amt"
    Expression ="comm_salesperson_master.deficit_amt"
    Expression ="Integration_comm_salesperson_master_Staging.email_ind"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_key_id"
    Expression ="comm_salesperson_master.FiscalMonth"
End
Begin Joins
    LeftTable ="Integration_comm_salesperson_master_Staging"
    RightTable ="comm_salesperson_master"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_key_id = comm_salesperso"
        "n_master.salesperson_key_id"
    Flag =1
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
dbMemo "OrderBy" ="[CCA44_salesperson_stage_review].[comm_plan_id], [CCA44_salesperson_stage_review"
    "].[salesperson_nm], [CCA44_salesperson_stage_review].[salesperson_key_id], [comm"
    "_salesperson_master].[FiscalMonth]"
Begin
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.territory_start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.comm_plan_id"
        dbLong "AggregateType" ="-1"
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
        dbInteger "ColumnWidth" ="2580"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.CostCenter"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.salary_draw_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.deficit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.email_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salary_draw_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.deficit_amt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1550
    Bottom =946
    Left =-1
    Top =-1
    Right =1368
    Bottom =144
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
    Begin
        Left =747
        Top =44
        Right =1057
        Bottom =351
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
