Operation =4
Option =0
Begin InputTables
    Name ="STAGE_salesperson_master"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Name ="comm_salesperson_code_map.salesperson_key_id"
    Expression ="[STAGE_salesperson_master]![salesperson_key_id]"
End
Begin Joins
    LeftTable ="STAGE_salesperson_master"
    RightTable ="comm_salesperson_code_map"
    Expression ="STAGE_salesperson_master.salesperson_cd = comm_salesperson_code_map.salesperson_"
        "cd"
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
        dbText "Name" ="STAGE_salesperson_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2295"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="5280"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.email_address_nm"
        dbInteger "ColumnWidth" ="3960"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_category_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_branch.salesperson_territory_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FIX_salesperson_key_id"
        dbInteger "ColumnWidth" ="3750"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FIX_email_address_nm"
        dbInteger "ColumnWidth" ="4140"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FIX_salesperson_category_cd"
        dbInteger "ColumnWidth" ="4830"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_branch.division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1006"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="master_division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="esend_setup_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_nm"
        dbInteger "ColumnWidth" ="2295"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbInteger "ColumnWidth" ="3360"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =17
    Top =16
    Right =1556
    Bottom =980
    Left =-1
    Top =-1
    Right =1516
    Bottom =550
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =78
        Top =88
        Right =547
        Bottom =367
        Top =0
        Name ="STAGE_salesperson_master"
        Name =""
    End
    Begin
        Left =608
        Top =72
        Right =985
        Bottom =326
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
