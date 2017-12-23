Operation =4
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"FSC*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"FSCGPZZ\")) OR (((comm_salesperson_master.comm_plan_id) Lik"
    "e \"ESS*\" And (comm_salesperson_master.comm_plan_id)<>\"ESSGPZZ\")) OR (((comm_"
    "salesperson_master.comm_plan_id) Like \"CCS*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Name ="comm_salesperson_master.select_ind"
    Expression ="True"
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
    Left =2
    Top =60
    Right =1594
    Bottom =1024
    Left =-1
    Top =-1
    Right =1560
    Bottom =628
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
