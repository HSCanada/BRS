Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.TerritoryCd) Is Null)) OR (((comm_plan.comm_plan_id) Is Null))"
Begin InputTables
    Name ="Integration_comm_salesperson_master_Staging"
    Name ="BRS_FSC_Rollup"
    Name ="comm_plan"
End
Begin OutputColumns
    Expression ="Integration_comm_salesperson_master_Staging.FiscalMonth"
    Expression ="Integration_comm_salesperson_master_Staging.employee_num"
    Expression ="Integration_comm_salesperson_master_Staging.CostCenter"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_nm"
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="Integration_comm_salesperson_master_Staging.territory_start_dt"
    Expression ="Integration_comm_salesperson_master_Staging.comm_plan_id"
    Expression ="comm_plan.comm_plan_id"
    Expression ="Integration_comm_salesperson_master_Staging.salary_draw_amt"
    Expression ="Integration_comm_salesperson_master_Staging.deficit_amt"
    Expression ="Integration_comm_salesperson_master_Staging.email_ind"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_key_id"
End
Begin Joins
    LeftTable ="Integration_comm_salesperson_master_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd = BRS_FSC_Roll"
        "up.TerritoryCd"
    Flag =2
    LeftTable ="Integration_comm_salesperson_master_Staging"
    RightTable ="comm_plan"
    Expression ="Integration_comm_salesperson_master_Staging.comm_plan_id = comm_plan.comm_plan_i"
        "d"
    Flag =2
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
        dbText "Name" ="comm_plan.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1412
    Bottom =817
    Left =-1
    Top =-1
    Right =1388
    Bottom =433
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
        Left =675
        Top =56
        Right =819
        Bottom =200
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =748
        Top =216
        Right =892
        Bottom =360
        Top =0
        Name ="comm_plan"
        Name =""
    End
End
