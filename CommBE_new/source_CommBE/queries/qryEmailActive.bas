Operation =1
Option =0
Where ="(((comm_salesperson_master.employee_num)<>0) AND ((comm_plan.active_ind)=True))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_plan"
    Name ="BRS_FSC_Rollup"
    Name ="BRS_Employee"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.creation_dt"
    Expression ="BRS_FSC_Rollup.SamAccountName"
    Expression ="BRS_FSC_Rollup.FSCName"
    Expression ="BRS_FSC_Rollup.order_taken_by"
    Expression ="BRS_FSC_Rollup.TerritoryCd"
    Expression ="BRS_Employee.EmailAddress"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_plan"
    Expression ="comm_salesperson_master.comm_plan_id = comm_plan.comm_plan_id"
    Flag =1
    LeftTable ="comm_salesperson_master"
    RightTable ="BRS_FSC_Rollup"
    Expression ="comm_salesperson_master.master_salesperson_cd = BRS_FSC_Rollup.TerritoryCd"
    Flag =1
    LeftTable ="BRS_FSC_Rollup"
    RightTable ="BRS_Employee"
    Expression ="BRS_FSC_Rollup.SamAccountName = BRS_Employee.SamAccountName"
    Flag =1
End
Begin OrderBy
    Expression ="comm_salesperson_master.creation_dt"
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
dbMemo "Filter" ="([qryEmailActive].[SamAccountName]=\"                    \")"
dbMemo "OrderBy" ="[qryEmailActive].[comm_plan_id], [qryEmailActive].[SamAccountName], [qryEmailAct"
    "ive].[creation_dt] DESC"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2970"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbInteger "ColumnWidth" ="3075"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.creation_dt"
        dbInteger "ColumnWidth" ="2145"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.FSCName"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.SamAccountName"
        dbInteger "ColumnWidth" ="2115"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.order_taken_by"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_FSC_Rollup.TerritoryCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Employee.EmailAddress"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1559
    Bottom =945
    Left =-1
    Top =-1
    Right =1535
    Bottom =391
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =86
        Top =51
        Right =404
        Bottom =278
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =480
        Top =52
        Right =624
        Bottom =196
        Top =0
        Name ="comm_plan"
        Name =""
    End
    Begin
        Left =467
        Top =210
        Right =681
        Bottom =354
        Top =0
        Name ="BRS_FSC_Rollup"
        Name =""
    End
    Begin
        Left =720
        Top =85
        Right =864
        Bottom =229
        Top =0
        Name ="BRS_Employee"
        Name =""
    End
End
