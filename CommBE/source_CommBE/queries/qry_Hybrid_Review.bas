Operation =1
Option =0
Where ="(((comm_salesperson_master.ess_accpac_cd) Like \"ESS*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.branch_cd"
    Expression ="comm_salesperson_master.salesperson_category_cd"
    Expression ="comm_salesperson_master.ess_accpac_cd"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_code_map.salesperson_nm"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_salesperson_master.ess_accpac_cd = comm_salesperson_code_map.salesperson_cd"
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
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_category_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.ess_accpac_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1740"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3330"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2790"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1634
    Bottom =1005
    Left =-1
    Top =-1
    Right =1610
    Bottom =398
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =180
        Top =31
        Right =498
        Bottom =391
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =756
        Top =67
        Right =1022
        Bottom =342
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
