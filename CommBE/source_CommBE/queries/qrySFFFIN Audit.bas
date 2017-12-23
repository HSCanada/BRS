Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201001\") AND ((comm_transaction.sourc"
    "e_cd)=\"IMPORT\") AND ((comm_transaction.item_comm_group_cd)=\"SFFFIN\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_transaction.line_id"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.transaction_txt"
    Expression ="comm_transaction.transaction_amt"
    Expression ="comm_transaction.comm_amt"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
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
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbInteger "ColumnWidth" ="2940"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.line_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1579
    Bottom =1008
    Left =-1
    Top =-1
    Right =1560
    Bottom =694
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =577
        Bottom =494
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =738
        Top =76
        Right =1083
        Bottom =456
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
