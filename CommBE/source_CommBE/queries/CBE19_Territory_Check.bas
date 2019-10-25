Operation =1
Option =0
Where ="(((comm_salesperson_code_map.salesperson_cd) Is Null))"
Begin InputTables
    Name ="comm_transaction_hsi_stage"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Expression ="comm_transaction_hsi_stage.key_id"
    Expression ="comm_transaction_hsi_stage.[WK$L04]"
    Expression ="comm_salesperson_code_map.salesperson_cd"
End
Begin Joins
    LeftTable ="comm_transaction_hsi_stage"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction_hsi_stage.[WK$L04] = comm_salesperson_code_map.salesperson_cd"
    Flag =2
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_transaction_hsi_stage.key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_hsi_stage.[WK$L04]"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =709
    Bottom =635
    Left =-1
    Top =-1
    Right =686
    Bottom =358
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =47
        Top =20
        Right =323
        Bottom =292
        Top =0
        Name ="comm_transaction_hsi_stage"
        Name =""
    End
    Begin
        Left =430
        Top =55
        Right =851
        Bottom =306
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
