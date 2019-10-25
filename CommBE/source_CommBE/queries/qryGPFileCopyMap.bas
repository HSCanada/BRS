Operation =1
Option =0
Where ="(((comm_salesperson_master.master_salesperson_cd)<>\"\") AND (((comm_salesperson"
    "_master.comm_plan_id) Like \"fsc*\" Or (comm_salesperson_master.comm_plan_id) Li"
    "ke \"ess*\") And (comm_salesperson_master.comm_plan_id)<>\"ESSPZZ\" And (comm_sa"
    "lesperson_master.comm_plan_id)<>\"FSCDPZZ\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.branch_cd"
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
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
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
    Top =-30
    Right =1517
    Bottom =1005
    Left =-1
    Top =-1
    Right =1493
    Bottom =674
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =449
        Bottom =423
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
