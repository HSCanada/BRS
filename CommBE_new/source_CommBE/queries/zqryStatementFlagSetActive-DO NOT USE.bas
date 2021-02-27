Operation =1
Option =0
Where ="(((comm_salesperson_master.flag_ind)<>[active_ind]))"
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_plan"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.flag_ind"
    Expression ="comm_plan.active_ind"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_plan"
    Expression ="comm_salesperson_master.comm_plan_id = comm_plan.comm_plan_id"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[qryStatementFlagSetActive].[comm_plan_id], [qryStatementFlagSetActive].[salespe"
    "rson_key_id]"
Begin
    Begin
        dbText "Name" ="comm_plan.active_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.flag_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2865"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1524
    Bottom =938
    Left =-1
    Top =-1
    Right =1500
    Bottom =294
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =31
        Top =25
        Right =488
        Bottom =322
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =592
        Top =51
        Right =736
        Bottom =195
        Top =0
        Name ="comm_plan"
        Name =""
    End
End
