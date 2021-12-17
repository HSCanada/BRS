Operation =1
Option =0
Where ="(((comm_plan_group_rate.comm_plan_id) In (\"ESSGP\")) AND ((comm_plan_group_rate"
    ".cust_comm_group_cd)=\"\") AND ((comm_plan_group_rate.source_cd)=\"JDE\") AND (("
    "comm_plan_group_rate.active_ind)=True))"
Begin InputTables
    Name ="comm_plan_group_rate"
End
Begin OutputColumns
    Expression ="comm_plan_group_rate.item_comm_group_cd"
    Expression ="comm_plan_group_rate.comm_rt"
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
        dbText "Name" ="comm_plan_group_rate.comm_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_plan_group_rate.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1560
    Bottom =938
    Left =-1
    Top =-1
    Right =1536
    Bottom =584
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =50
        Top =35
        Right =332
        Bottom =291
        Top =0
        Name ="comm_plan_group_rate"
        Name =""
    End
End
