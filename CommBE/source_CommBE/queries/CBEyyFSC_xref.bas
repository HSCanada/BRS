Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"fsc*\" Or (comm_salesperson_mast"
    "er.comm_plan_id) Like \"ess*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_salesperson_code_map.salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.branch_cd"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.employee_num"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_salesperson_master.salesperson_key_id = comm_salesperson_code_map.salespers"
        "on_key_id"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="Send this list to Leslie for his Transport data"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBEyyFSC_xref].[employee_num], [CBEyyFSC_xref].[comm_plan_id], [CBEyyFSC_xref]."
    "[salesperson_cd]"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3675"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1920"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
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
    Right =1499
    Bottom =1004
    Left =-1
    Top =-1
    Right =1476
    Bottom =251
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =246
        Bottom =295
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =339
        Top =98
        Right =602
        Bottom =300
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
