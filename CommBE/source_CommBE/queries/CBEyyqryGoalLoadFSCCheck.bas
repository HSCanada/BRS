Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"FSC*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"FSCDP00\" And (comm_salesperson_master.comm_plan_id)<>\"FSC"
    "DPZZ\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.note_txt"
    Expression ="comm_salesperson_master.ITMSND_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMFO3_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.ITMFO1_GOAL_YTD_AMT"
    Expression ="comm_salesperson_master.comm_plan_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbMemo "OrderBy" ="[CBEyyqryGoalLoadFSCCheck].[ITMSND_GOAL_YTD_AMT], [CBEyyqryGoalLoadFSCCheck].[no"
    "te_txt]"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.note_txt"
        dbInteger "ColumnWidth" ="6405"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMFO1_GOAL_YTD_AMT"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMFO3_GOAL_YTD_AMT"
        dbInteger "ColumnWidth" ="3030"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ITMSND_GOAL_YTD_AMT"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1574
    Bottom =1005
    Left =-1
    Top =-1
    Right =1550
    Bottom =253
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =31
        Top =15
        Right =381
        Bottom =270
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
