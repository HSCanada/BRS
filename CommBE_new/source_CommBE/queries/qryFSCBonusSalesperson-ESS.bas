﻿Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"ess*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"ESSGPZZ\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Alias ="salesperson_key_id_"
    Expression ="Trim([salesperson_key_id])"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.comm_plan_id"
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
dbMemo "OrderBy" ="[qryFSCBonusSalesperson-ESS].[employee_num]"
Begin
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
        dbText "Name" ="salesperson_key_id_"
        dbInteger "ColumnWidth" ="2805"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1492
    Bottom =756
    Left =-1
    Top =-1
    Right =1500
    Bottom =550
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =214
        Top =11
        Right =645
        Bottom =328
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
