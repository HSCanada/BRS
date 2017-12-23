Operation =1
Option =0
Where ="(((comm_salesperson_master.salesperson_nm)<>[comm_salesperson_master_stage]![sal"
    "esperson_nm] Or (comm_salesperson_master.salesperson_nm) Is Null)) OR (((comm_sa"
    "lesperson_master.comm_plan_id)<>[comm_salesperson_master_stage]![comm_plan_id] O"
    "r (comm_salesperson_master.comm_plan_id) Is Null)) OR (((comm_salesperson_master"
    ".employee_num)<>CLng([comm_salesperson_master_stage]![employee_num]) Or (comm_sa"
    "lesperson_master.employee_num) Is Null)) OR (((comm_salesperson_master.territory"
    "_start_dt)<>[comm_salesperson_master_stage]![territory_start_dt] Or (comm_salesp"
    "erson_master.territory_start_dt) Is Null))"
Begin InputTables
    Name ="comm_salesperson_master_stage"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master_stage.salesperson_key_id"
    Alias ="SRC_salesperson_nm"
    Expression ="comm_salesperson_master_stage.salesperson_nm"
    Alias ="DST_salesperson_nm"
    Expression ="comm_salesperson_master.salesperson_nm"
    Alias ="SRC_comm_plan_id"
    Expression ="comm_salesperson_master_stage.comm_plan_id"
    Alias ="DST_comm_plan_id"
    Expression ="comm_salesperson_master.comm_plan_id"
    Alias ="SRC_employee_num"
    Expression ="comm_salesperson_master_stage.employee_num"
    Alias ="DST_employee_num"
    Expression ="comm_salesperson_master.employee_num"
    Alias ="SRC_territory_start_dt"
    Expression ="comm_salesperson_master_stage.territory_start_dt"
    Alias ="DST_territory_start_dt"
    Expression ="comm_salesperson_master.territory_start_dt"
End
Begin Joins
    LeftTable ="comm_salesperson_master_stage"
    RightTable ="comm_salesperson_master"
    Expression ="comm_salesperson_master_stage.salesperson_key_id = comm_salesperson_master.sales"
        "person_key_id"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "DefaultView" ="2"
dbText "Description" ="Update FSC changes"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE26_Salesperson_Update].[DST_comm_plan_id]"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master_stage.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3045"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="SRC_comm_plan_id"
        dbInteger "ColumnWidth" ="2460"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DST_comm_plan_id"
        dbInteger "ColumnWidth" ="2430"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SRC_salesperson_nm"
        dbInteger "ColumnWidth" ="2880"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DST_salesperson_nm"
        dbInteger "ColumnWidth" ="3390"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SRC_employee_num"
        dbInteger "ColumnWidth" ="1455"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="DST_employee_num"
        dbInteger "ColumnWidth" ="1455"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SRC_territory_start_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2610"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="DST_territory_start_dt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2835"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1563
    Bottom =976
    Left =-1
    Top =-1
    Right =1545
    Bottom =2
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =53
        Top =62
        Right =482
        Bottom =385
        Top =0
        Name ="comm_salesperson_master_stage"
        Name =""
    End
    Begin
        Left =600
        Top =38
        Right =830
        Bottom =325
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
