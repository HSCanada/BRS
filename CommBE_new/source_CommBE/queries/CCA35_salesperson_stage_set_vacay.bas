Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.Branch) In (\"MNTRL\",\"QUEBC\")) AND ((Integration_comm_sales"
    "person_master_Staging.comm_plan_id)<>\"FSCGP00\"))"
Begin InputTables
    Name ="Integration_comm_salesperson_master_Staging"
    Name ="BRS_FSC_Rollup"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="Integration_comm_salesperson_master_Staging.FiscalMonth"
    Expression ="Integration_comm_salesperson_master_Staging.employee_num"
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd"
    Expression ="Integration_comm_salesperson_master_Staging.salesperson_nm"
    Expression ="BRS_FSC_Rollup.Branch"
    Expression ="Integration_comm_salesperson_master_Staging.comm_plan_id"
    Alias ="comm_plan_id_NEW"
    Expression ="comm_salesperson_master.comm_plan_id"
End
Begin Joins
    LeftTable ="Integration_comm_salesperson_master_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_comm_salesperson_master_Staging.master_salesperson_cd = BRS_FSC_Roll"
        "up.TerritoryCd"
    Flag =1
    LeftTable ="BRS_FSC_Rollup"
    RightTable ="comm_salesperson_master"
    Expression ="BRS_FSC_Rollup.comm_salesperson_key_id = comm_salesperson_master.salesperson_key"
        "_id"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbBoolean "FailOnError" ="0"
dbMemo "OrderBy" ="[CCA35_salesperson_stage_set_vacay].[comm_plan_id]"
Begin
    Begin
        dbText "Name" ="Integration_comm_salesperson_master_Staging.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2565"
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
        dbText "Name" ="Integration_comm_salesperson_master_Staging.comm_plan_id"
        dbInteger "ColumnWidth" ="2700"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.Branch"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_id_NEW"
        dbInteger "ColumnWidth" ="4380"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-163
    Top =32
    Right =1441
    Bottom =930
    Left =-1
    Top =-1
    Right =1580
    Bottom =184
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
        Left =455
        Top =86
        Right =662
        Bottom =276
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =738
        Top =102
        Right =991
        Bottom =307
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
