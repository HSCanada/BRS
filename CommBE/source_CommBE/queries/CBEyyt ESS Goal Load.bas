Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"ess*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.hsi_salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.note_txt"
End
Begin OrderBy
    Expression ="comm_salesperson_master.comm_plan_id"
    Flag =0
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
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbInteger "ColumnWidth" ="3225"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbInteger "ColumnWidth" ="2850"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.hsi_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.note_txt"
        dbInteger "ColumnWidth" ="7695"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =16
    Top =-15
    Right =1604
    Bottom =949
    Left =-1
    Top =-1
    Right =1565
    Bottom =285
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =415
        Bottom =308
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
