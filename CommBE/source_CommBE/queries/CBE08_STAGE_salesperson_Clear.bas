Operation =5
Option =0
Begin InputTables
    Name ="STAGE_salesperson_master"
End
Begin OutputColumns
    Expression ="STAGE_salesperson_master.*"
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_nm"
        dbInteger "ColumnWidth" ="2295"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.salesperson_category_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_salesperson_master.email_address_nm"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-48
    Top =-9
    Right =1491
    Bottom =955
    Left =-1
    Top =-1
    Right =1516
    Bottom =646
    Left =0
    Top =0
    ColumnsShown =771
    Begin
        Left =198
        Top =142
        Right =342
        Bottom =286
        Top =0
        Name ="STAGE_salesperson_master"
        Name =""
    End
End
