Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"ess*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"ESSP00\"))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_master_goal"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.note_txt"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_master_goal"
    Expression ="comm_salesperson_master.employee_num = comm_salesperson_master_goal.employee_num"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBEyyqryGoalLoadESSCheck].[note_txt]"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.note_txt"
        dbInteger "ColumnWidth" ="5220"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1623
    Bottom =1004
    Left =-1
    Top =-1
    Right =1600
    Bottom =298
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =31
        Top =15
        Right =381
        Bottom =257
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =419
        Top =6
        Right =758
        Bottom =218
        Top =0
        Name ="comm_salesperson_master_goal"
        Name =""
    End
End
