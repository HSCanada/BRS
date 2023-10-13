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
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_nm"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="comm_plan.comm_plan_id"
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2295"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2160"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.FiscalMonth"
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
    State =2
    Left =-8
    Top =-31
    Right =1332
    Bottom =589
    Left =-1
    Top =-1
    Right =1388
    Bottom =269
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =56
        Top =40
        Right =382
        Bottom =321
        Top =0
        Name ="Integration_comm_salesperson_master_Staging"
        Name =""
    End
    Begin
        Left =545
        Top =48
        Right =689
        Bottom =192
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =565
        Top =207
        Right =709
        Bottom =351
        Top =0
        Name ="comm_plan"
        Name =""
    End
End
