﻿Operation =1
Option =0
Where ="(((comm_salesperson_master.employee_num)=[Emp #]))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_key_id"
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
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1391
    Bottom =1009
    Left =-1
    Top =-1
    Right =1368
    Bottom =683
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =288
        Top =31
        Right =432
        Bottom =488
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
