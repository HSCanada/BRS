Operation =1
Option =0
Where ="(((comm_transaction.source_cd)=\"JDE\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
End
Begin OutputColumns
    Alias ="Sales Type"
    Expression ="IIf([salesperson_key_id]=\"internal\",\"INT\",IIf([salesperson_key_id]=\"\",\"UN"
        "ASSIGNED\",\"SALES\"))"
    Alias ="SumOftransaction_amt1"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="CountOfrecord_id"
    Expression ="Count(comm_transaction.record_id)"
    Expression ="comm_transaction.fiscal_yearmo_num"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
End
Begin Groups
    Expression ="IIf([salesperson_key_id]=\"internal\",\"INT\",IIf([salesperson_key_id]=\"\",\"UN"
        "ASSIGNED\",\"SALES\"))"
    GroupLevel =0
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="Run Commission Calc first"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="SumOftransaction_amt1"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Sales Type"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="CountOfrecord_id"
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
    Right =1141
    Bottom =207
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =38
        Top =6
        Right =213
        Bottom =143
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =268
        Top =5
        Right =576
        Bottom =247
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
