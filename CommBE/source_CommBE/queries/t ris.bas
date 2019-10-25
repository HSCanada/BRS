Operation =1
Option =0
Begin InputTables
    Name ="comm_salesperson_RIS_map"
End
Begin OutputColumns
    Expression ="comm_salesperson_RIS_map.hsi_shipto_id"
    Expression ="comm_salesperson_RIS_map.PC3"
    Expression ="comm_salesperson_RIS_map.RIS_nm"
End
Begin OrderBy
    Expression ="comm_salesperson_RIS_map.hsi_shipto_id"
    Flag =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_RIS_map.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_RIS_map.PC3"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_RIS_map.RIS_nm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1511
    Bottom =991
    Left =-1
    Top =-1
    Right =1479
    Bottom =651
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =129
        Top =79
        Right =503
        Bottom =436
        Top =0
        Name ="comm_salesperson_RIS_map"
        Name =""
    End
End
