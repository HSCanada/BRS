Operation =4
Option =0
Begin InputTables
    Name ="comm_transaction_external_stage"
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Name ="comm_transaction_external_stage.salesperson_key_id"
    Expression ="comm_salesperson_code_map!salesperson_key_id"
End
Begin Joins
    LeftTable ="comm_transaction_external_stage"
    RightTable ="comm_salesperson_code_map"
    Expression ="comm_transaction_external_stage.salesperson_cd=comm_salesperson_code_map.salespe"
        "rson_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbText "Description" ="Attach FSC stage to production"
dbBoolean "OrderByOn" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
Begin
    Begin
        dbText "Name" ="comm_transaction_external_stage.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1539
    Bottom =1004
    Left =-1
    Top =-1
    Right =1516
    Bottom =309
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =46
        Top =11
        Right =293
        Bottom =268
        Top =0
        Name ="comm_transaction_external_stage"
        Name =""
    End
    Begin
        Left =412
        Top =4
        Right =677
        Bottom =203
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
