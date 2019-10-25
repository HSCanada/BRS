Operation =1
Option =0
Where ="(((comm_group.source_cd)=\"JDE\") AND ((comm_group.comm_group_desc) Not Like \"*"
    "Obsolete*\"))"
Having ="(((comm_salesperson_master.employee_num)<>\"\") AND ((comm_summary.comm_group_cd"
    ")<>\"\"))"
Begin InputTables
    Name ="comm_summary"
    Name ="comm_salesperson_master"
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_summary.comm_group_cd"
    Alias ="SumOfsales_curr_amt"
    Expression ="Sum(comm_summary.sales_curr_amt)"
    Alias ="FirstOfcomm_group_desc"
    Expression ="First(comm_group.comm_group_desc)"
End
Begin Joins
    LeftTable ="comm_summary"
    RightTable ="comm_salesperson_master"
    Expression ="comm_summary.salesperson_key_id=comm_salesperson_master.salesperson_key_id"
    Flag =1
    LeftTable ="comm_summary"
    RightTable ="comm_group"
    Expression ="comm_summary.comm_group_cd=comm_group.comm_group_cd"
    Flag =1
End
Begin Groups
    Expression ="comm_salesperson_master.employee_num"
    GroupLevel =0
    Expression ="comm_summary.comm_group_cd"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_summary.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOfsales_curr_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfcomm_group_desc"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1548
    Bottom =1008
    Left =-1
    Top =-1
    Right =1529
    Bottom =694
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =593
        Bottom =484
        Top =0
        Name ="comm_summary"
        Name =""
    End
    Begin
        Left =712
        Top =64
        Right =856
        Bottom =208
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =678
        Top =287
        Right =981
        Bottom =431
        Top =0
        Name ="comm_group"
        Name =""
    End
End
