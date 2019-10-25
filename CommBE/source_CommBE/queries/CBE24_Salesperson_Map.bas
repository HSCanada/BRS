Operation =4
Option =0
Begin InputTables
    Name ="comm_salesperson_master"
    Name ="comm_salesperson_master_stage"
End
Begin OutputColumns
    Name ="comm_salesperson_master_stage.salesperson_key_id"
    Expression ="comm_salesperson_master!salesperson_key_id"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_salesperson_master_stage"
    Expression ="comm_salesperson_master.master_salesperson_cd=comm_salesperson_master_stage.mast"
        "er_salesperson_cd"
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
        dbText "Name" ="comm_salesperson_master_stage.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =18
    Top =40
    Right =1258
    Bottom =623
    Left =-1
    Top =-1
    Right =1217
    Bottom =351
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =38
        Top =6
        Right =268
        Bottom =293
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
    Begin
        Left =341
        Top =14
        Right =880
        Bottom =286
        Top =0
        Name ="comm_salesperson_master_stage"
        Name =""
    End
End
