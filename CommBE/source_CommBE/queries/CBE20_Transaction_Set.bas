Operation =1
Option =0
Begin InputTables
    Name ="comm_configure"
End
Begin OutputColumns
    Expression ="comm_configure.record_id"
    Expression ="comm_configure.current_fiscal_yearmo_num"
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
        dbText "Name" ="comm_configure.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_configure.current_fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1164
    Bottom =916
    Left =-1
    Top =-1
    Right =1140
    Bottom =661
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="comm_configure"
        Name =""
    End
End
