Operation =1
Option =0
Where ="(((comm_salesperson_master.flag_ind)=True))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CCA10_detail_flag_review].[salesperson_key_id]"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2895"
        dbBoolean "ColumnHidden" ="0"
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
    Right =1516
    Bottom =918
    Left =-1
    Top =-1
    Right =1500
    Bottom =421
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =131
        Top =63
        Right =469
        Bottom =416
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
