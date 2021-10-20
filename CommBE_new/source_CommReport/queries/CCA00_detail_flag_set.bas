Operation =4
Option =0
Where ="(((comm_salesperson_master.flag_ind)<>[active_ind]))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_plan"
End
Begin OutputColumns
    Name ="comm_salesperson_master.flag_ind"
    Expression ="[active_ind]"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_plan"
    Expression ="comm_salesperson_master.comm_plan_id = comm_plan.comm_plan_id"
    Flag =1
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_plan"
    Expression ="comm_salesperson_master.comm_plan_id = comm_plan.comm_plan_id"
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.flag_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2220"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan.active_ind"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1572
    Bottom =918
    Left =-1
    Top =-1
    Right =1556
    Bottom =489
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =88
        Top =67
        Right =426
        Bottom =420
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =521
        Top =53
        Right =838
        Bottom =313
        Top =0
        Name ="comm_plan"
        Name =""
    End
End
