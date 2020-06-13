Operation =1
Option =0
Where ="(((BRS_FSC_Rollup.comm_salesperson_key_id)<>\"\") AND ((comm_salesperson_master."
    "employee_num)<>[Integration_salesperson_master_Staging]![employee_num])) OR (((I"
    "ntegration_salesperson_master_Staging.salesperson_nm)<>[Integration_salesperson_"
    "master_Staging]![salesperson_nm])) OR (((Integration_salesperson_master_Staging."
    "comm_plan_id)<>[Integration_salesperson_master_Staging]![comm_plan_id])) OR (((I"
    "ntegration_salesperson_master_Staging.territory_start_dt)<>[Integration_salesper"
    "son_master_Staging]![territory_start_dt]))"
Begin InputTables
    Name ="Integration_salesperson_master_Staging"
    Name ="BRS_FSC_Rollup"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="Integration_salesperson_master_Staging.employee_num"
    Expression ="Integration_salesperson_master_Staging.salesperson_nm"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="Integration_salesperson_master_Staging.comm_plan_id"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="Integration_salesperson_master_Staging.territory_start_dt"
    Expression ="comm_salesperson_master.territory_start_dt"
End
Begin Joins
    LeftTable ="Integration_salesperson_master_Staging"
    RightTable ="BRS_FSC_Rollup"
    Expression ="Integration_salesperson_master_Staging.master_salesperson_cd = BRS_FSC_Rollup.Te"
        "rritoryCd"
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
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.territory_start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.comm_plan_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1785"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5775"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="Integration_salesperson_master_Staging.employee_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1890"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbInteger "ColumnWidth" ="4530"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.territory_start_dt"
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
        Left =613
        Top =31
        Right =826
        Bottom =175
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =914
        Top =36
        Right =1135
        Bottom =261
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
