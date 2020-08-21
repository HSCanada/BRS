Operation =1
Option =0
Where ="(((comm_salesperson_master.salesperson_nm) Like \"*sul*\" Or (comm_salesperson_m"
    "aster.salesperson_nm) Like \"*cron*\")) OR (((comm_salesperson_master.salesperso"
    "n_key_id) Like \"*JAIME.SULLIVAN*\")) OR (((comm_salesperson_master.salesperson_"
    "key_id) Like \"*p*ch*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.flag_ind"
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
End
Begin
    State =0
    Left =0
    Top =0
    Right =1599
    Bottom =917
    Left =-1
    Top =-1
    Right =1184
    Bottom =565
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =230
        Top =121
        Right =568
        Bottom =474
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
