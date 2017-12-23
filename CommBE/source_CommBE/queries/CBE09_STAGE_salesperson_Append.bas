Operation =3
Name ="STAGE_salesperson_master"
Option =0
Where ="(((comm_salesperson_code_map.salesperson_cd)<>\"\") AND ((comm_salesperson_code_"
    "map.salesperson_key_id)=\"\"))"
Begin InputTables
    Name ="comm_salesperson_code_map"
End
Begin OutputColumns
    Name ="salesperson_cd"
    Expression ="comm_salesperson_code_map.salesperson_cd"
    Name ="salesperson_nm"
    Expression ="comm_salesperson_code_map.salesperson_nm"
    Name ="salesperson_id"
    Expression ="comm_salesperson_code_map.salesperson_id"
    Name ="branch_cd"
    Expression ="comm_salesperson_code_map.branch_cd"
    Name ="salesperson_key_id"
    Expression ="comm_salesperson_code_map.salesperson_nm"
    Alias ="email"
    Name ="email_address_nm"
    Expression ="\"@henryschein.ca\""
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
        dbInteger "ColumnWidth" ="2055"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_code_map.salesperson_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="email"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =887
    Bottom =613
    Left =-1
    Top =-1
    Right =863
    Bottom =362
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =48
        Top =12
        Right =597
        Bottom =361
        Top =0
        Name ="comm_salesperson_code_map"
        Name =""
    End
End
