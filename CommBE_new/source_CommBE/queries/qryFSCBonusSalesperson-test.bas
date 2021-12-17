Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) In (\"FSCGP02\",\"FSCGP03\",\"FSCGPM\")"
    "))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Alias ="salesperson_key_id_"
    Expression ="Trim([salesperson_key_id])"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.master_salesperson_cd"
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
End
Begin
    State =0
    Left =-111
    Top =155
    Right =1413
    Bottom =1053
    Left =-1
    Top =-1
    Right =1500
    Bottom =584
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =82
        Top =55
        Right =513
        Bottom =373
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
