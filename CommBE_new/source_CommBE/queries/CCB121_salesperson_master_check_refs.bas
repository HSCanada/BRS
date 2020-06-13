Operation =1
Option =0
Where ="(((comm_hr_employee.employee_num) Is Null)) OR (((BRS_FSC_Rollup.TerritoryCd) Is"
    " Null)) OR (((comm_plan.comm_plan_id) Is Null))"
Begin InputTables
    Name ="Integration_salesperson_master_Staging"
    Name ="comm_hr_employee"
    Name ="BRS_FSC_Rollup"
    Name ="comm_plan"
End
Begin OutputColumns
    Expression ="Integration_salesperson_master_Staging.FiscalMonth"
    Expression ="Integration_salesperson_master_Staging.employee_num"
    Expression ="comm_hr_employee.employee_num"
    Expression ="Integration_salesperson_master_Staging.master_salesperson_cd"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="Integration_salesperson_master_Staging.comm_plan_id"
    Expression ="comm_plan.comm_plan_id"
End
Begin Joins
    LeftTable ="Integration_salesperson_master_Staging"
    RightTable ="comm_hr_employee"
    Expression ="Integration_salesperson_master_Staging.employee_num = comm_hr_employee.employee_"
        "num"
    Flag =2
    LeftTable ="Integration_salesperson_master_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_salesperson_master_Staging.master_salesperson_cd = BRS_FSC_Rollup.Te"
        "rritoryCd"
    Flag =2
    LeftTable ="Integration_salesperson_master_Staging"
    RightTable ="comm_plan"
    Expression ="Integration_salesperson_master_Staging.comm_plan_id = comm_plan.comm_plan_id"
    Flag =2
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
dbMemo "OrderBy" ="[CCB121_salesperson_master_check_refs].[TerritoryCd], [Integration_salesperson_m"
    "aster_Staging].[comm_plan_id]"
Begin
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1785"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.employee_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_hr_employee.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1191
    Bottom =817
    Left =-1
    Top =-1
    Right =1167
    Bottom =447
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =494
        Bottom =265
        Top =0
        Name ="Integration_salesperson_master_Staging"
        Name =""
    End
    Begin
        Left =642
        Top =46
        Right =786
        Bottom =190
        Top =0
        Name ="comm_hr_employee"
        Name =""
    End
    Begin
        Left =642
        Top =223
        Right =786
        Bottom =367
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =862
        Top =114
        Right =1006
        Bottom =258
        Top =0
        Name ="comm_plan"
        Name =""
    End
End
