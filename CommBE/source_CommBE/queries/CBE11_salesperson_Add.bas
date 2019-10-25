Operation =3
Name ="comm_salesperson_master"
Option =0
Where ="(((comm_salesperson_master.salesperson_key_id) Is Null))"
Begin InputTables
    Name ="STAGE_salesperson_master"
    Name ="comm_branch"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Name ="salesperson_key_id"
    Expression ="STAGE_salesperson_master.salesperson_key_id"
    Name ="salesperson_nm"
    Expression ="STAGE_salesperson_master.salesperson_nm"
    Name ="salesperson_category_cd"
    Expression ="STAGE_salesperson_master.salesperson_category_cd"
    Alias ="master_salesperson_cd"
    Name ="master_salesperson_cd"
    Expression ="STAGE_salesperson_master.salesperson_cd"
    Name ="branch_cd"
    Expression ="STAGE_salesperson_master.branch_cd"
    Alias ="esend_setup_ind"
    Name ="esend_setup_ind"
    Expression ="0"
    Name ="GETKBY03"
    Expression ="STAGE_salesperson_master.salesperson_id"
End
Begin Joins
    LeftTable ="STAGE_salesperson_master"
    RightTable ="comm_branch"
    Expression ="STAGE_salesperson_master.branch_cd = comm_branch.branch_cd"
    Flag =1
    LeftTable ="STAGE_salesperson_master"
    RightTable ="comm_salesperson_master"
    Expression ="STAGE_salesperson_master.salesperson_key_id = comm_salesperson_master.salesperso"
        "n_key_id"
    Flag =2
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
End
Begin
    State =0
    Left =-285
    Top =19
    Right =1254
    Bottom =983
    Left =-1
    Top =-1
    Right =1507
    Bottom =565
    Left =0
    Top =0
    ColumnsShown =651
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
        Left =632
        Top =91
        Right =933
        Bottom =322
        Top =0
        Name ="comm_branch"
        Name =""
    End
    Begin
        Left =645
        Top =352
        Right =883
        Bottom =540
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
