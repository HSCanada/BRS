Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)=\"201106\") AND ((comm_transaction.source"
    "_cd)=\"jde\") AND ((comm_transaction.salesperson_key_id)<>\"internal\"))"
Begin InputTables
    Name ="comm_transaction"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_transaction.item_comm_group_cd"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Joins
    LeftTable ="comm_transaction"
    RightTable ="comm_salesperson_master"
    Expression ="comm_transaction.salesperson_key_id=comm_salesperson_master.salesperson_key_id"
    Flag =1
End
Begin Groups
    Expression ="comm_salesperson_master.employee_num"
    GroupLevel =0
    Expression ="comm_transaction.item_comm_group_cd"
    GroupLevel =0
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
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbInteger "ColumnWidth" ="2625"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbInteger "ColumnWidth" ="2700"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-4
    Top =-23
    Right =1548
    Bottom =1008
    Left =-1
    Top =-1
    Right =1529
    Bottom =694
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =48
        Top =12
        Right =658
        Bottom =486
        Top =0
        Name ="comm_transaction"
        Name =""
    End
    Begin
        Left =753
        Top =52
        Right =1073
        Bottom =360
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
