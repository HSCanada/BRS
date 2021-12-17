Operation =1
Option =0
Begin InputTables
    Name ="zzzSalesperson"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.comm_plan_id"
End
Begin Joins
    LeftTable ="zzzSalesperson"
    RightTable ="comm_salesperson_master"
    Expression ="zzzSalesperson.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[comm_plan_id], [Query1].[salesperson_key_id]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1493
    Bottom =938
    Left =-1
    Top =-1
    Right =1469
    Bottom =618
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =46
        Top =55
        Right =190
        Bottom =199
        Top =0
        Name ="zzzSalesperson"
        Name =""
    End
    Begin
        Left =300
        Top =80
        Right =595
        Bottom =312
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
