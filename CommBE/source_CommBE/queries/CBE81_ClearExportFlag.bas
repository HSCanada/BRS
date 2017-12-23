Operation =4
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"fsc*\" Or (comm_salesperson_mast"
    "er.comm_plan_id) Like \"ess*\" Or (comm_salesperson_master.comm_plan_id) Like \""
    "CCS*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Name ="comm_salesperson_master.select_ind"
    Expression ="False"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.select_ind"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1563
    Bottom =976
    Left =-1
    Top =-1
    Right =1545
    Bottom =349
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =48
        Top =12
        Right =545
        Bottom =371
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
